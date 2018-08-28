Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924FFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCA02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCA02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeH1MVp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:21:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:35680 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeH1MVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:21:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 01:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="85088975"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.82])
  by fmsmga001.fm.intel.com with SMTP; 28 Aug 2018 01:31:03 -0700
Received: by ubuntu (sSMTP sendmail emulation); Tue, 28 Aug 2018 23:47:05 +0800
Message-ID: <1535471225.5357.0.camel@intel.com>
Subject: Re: [PATCH] nios2: Convert to using %pOFn instead of
 device_node.name
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Date:   Tue, 28 Aug 2018 23:47:05 +0800
In-Reply-To: <20180828015252.28511-5-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
         <20180828015252.28511-5-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 20:52 -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct
> device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: nios2-dev@lists.rocketboards.org
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

> ---
>  arch/nios2/kernel/time.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
> index ab88b6dd4679..54467d0085a1 100644
> --- a/arch/nios2/kernel/time.c
> +++ b/arch/nios2/kernel/time.c
> @@ -214,12 +214,12 @@ static int __init
> nios2_timer_get_base_and_freq(struct device_node *np,
>  {
>         *base = of_iomap(np, 0);
>         if (!*base) {
> -               pr_crit("Unable to map reg for %s\n", np->name);
> +               pr_crit("Unable to map reg for %pOFn\n", np);
>                 return -ENXIO;
>         }
> 
>         if (of_property_read_u32(np, "clock-frequency", freq)) {
> -               pr_crit("Unable to get %s clock frequency\n", np-
> >name);
> +               pr_crit("Unable to get %pOFn clock frequency\n", np);
>                 return -EINVAL;
>         }
> 
> --
> 2.17.1
> 
> 
> ________________________________
> 
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.
