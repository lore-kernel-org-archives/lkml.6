Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2785C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAC821A1C
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAC821A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeHLOAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 10:00:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58848 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeHLOAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 10:00:16 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id b85d0e4a9f6b21dd; Sun, 12 Aug 2018 13:22:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / hibernate: Mark expected switch fall-through
Date:   Sun, 12 Aug 2018 13:20:25 +0200
Message-ID: <3172480.Efgj8VWSCo@aspire.rjw.lan>
In-Reply-To: <20180805021200.GA10911@embeddedor.com>
References: <20180805021200.GA10911@embeddedor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 5, 2018 4:12:00 AM CEST Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 114713 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/power/hibernate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 9c85c78..38f3f96 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -638,6 +638,7 @@ static void power_down(void)
>  		break;
>  	case HIBERNATION_PLATFORM:
>  		hibernation_platform_enter();
> +		/* Fall through */
>  	case HIBERNATION_SHUTDOWN:
>  		if (pm_power_off)
>  			kernel_power_off();
> 

Applied, thanks!

