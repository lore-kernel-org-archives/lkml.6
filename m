Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FCFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A562098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A562098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJPRBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:01:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57773 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeJPRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:01:22 -0400
Received: from 79.184.253.168.ipv4.supernova.orange.pl (79.184.253.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 4c4ecb150456e60b; Tue, 16 Oct 2018 11:11:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: dt-platdev: allow RK3399 to have separate tunables per cluster
Date:   Tue, 16 Oct 2018 11:08:40 +0200
Message-ID: <6240057.8QT59a4nGB@aspire.rjw.lan>
In-Reply-To: <20181008055547.umpyi4zcmcmjlxn2@vireshk-i7>
References: <20181005190058.GA234868@dtor-ws> <20181008055547.umpyi4zcmcmjlxn2@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 8, 2018 7:55:47 AM CEST Viresh Kumar wrote:
> On 05-10-18, 12:00, Dmitry Torokhov wrote:
> > RK3899 has one cluster with 4 small cores, and another one with 2 big
> > cores, with cores in different clusters having different OPPs and thus
> > needing separate set of tunables. Let's enable this via
> > "have_governor_per_policy" platform data.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > v2 changes: commit message updated.
> > 
> > Not tested, but we had a patch unconditionally enabling
> > CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag in tree we used to ship devices
> > based on RK3399 platform.
> > 
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index fe14c57de6ca..040ec0f711f9 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -78,7 +78,10 @@ static const struct of_device_id whitelist[] __initconst = {
> >  	{ .compatible = "rockchip,rk3328", },
> >  	{ .compatible = "rockchip,rk3366", },
> >  	{ .compatible = "rockchip,rk3368", },
> > -	{ .compatible = "rockchip,rk3399", },
> > +	{ .compatible = "rockchip,rk3399",
> > +	  .data = &(struct cpufreq_dt_platform_data)
> > +		{ .have_governor_per_policy = true, },
> > +	},
> >  
> >  	{ .compatible = "st-ericsson,u8500", },
> >  	{ .compatible = "st-ericsson,u8540", },
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!

