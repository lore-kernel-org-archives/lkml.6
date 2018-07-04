Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5254BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0807023D3D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0807023D3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbeGDKms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:42:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57180 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbeGDKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:42:46 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id fd696afe2ef2c390; Wed, 4 Jul 2018 12:42:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 08/12] cpufreq: Add stub for cpufreq_update_policy()
Date:   Wed, 04 Jul 2018 12:41:21 +0200
Message-ID: <2392356.ug1cyb9g3O@aspire.rjw.lan>
In-Reply-To: <20180703234705.227473-9-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org> <20180703234705.227473-9-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 4, 2018 1:47:01 AM CEST Matthias Kaehlcke wrote:
> cpufreq stubs out some functions when CONFIG_CPU_FREQ=n , but
> cpufreq_update_policy() is not among them. The throttler driver
> (https://patchwork.kernel.org/patch/10453351/) uses cpufreq as one
> possible throttling mechanism, but it can still be useful without
> cpufreq. Stubbing out cpufreq_update_policy() allows the throttler
> driver to be built without ugly #ifdef'ery when cpufreq is disabled.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - patch added to series
> ---
>  include/linux/cpufreq.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 882a9b9e34bc..dba8c4951e2e 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -210,6 +210,7 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
>  	return 0;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline void cpufreq_update_policy(unsigned int cpu) { }
>  #endif
>  
>  #ifdef CONFIG_CPU_FREQ_STAT
> 

I can take this patch if you want me to.

Thanks,
Rafael


