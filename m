Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F5FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98DD2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98DD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeIXPXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:23:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45018 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeIXPXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:23:32 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xbi-rkakho9P; Mon, 24 Sep 2018 11:22:23 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC69500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:9500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CAE51EC037D;
        Mon, 24 Sep 2018 11:22:23 +0200 (CEST)
Date:   Mon, 24 Sep 2018 11:22:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        michal.simek@xilinx.com, leoyang.li@nxp.com, sudeep.holla@arm.com,
        amit.kucheria@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 4/7] edac: synopsys: Add macro defines for ZynqMP DDRC
Message-ID: <20180924092226.GA20187@zn.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-5-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1537194305-9243-5-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:55:02PM +0530, Manish Narani wrote:
> Add macro defines for ZynqMP DDR controller. These macros will be used
> for ZyqnMP ECC operations.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 168 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 168 insertions(+)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index eb458e5..6bf7959 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -97,6 +97,174 @@
>  #define SCRUB_MODE_MASK		0x7
>  #define SCRUB_MODE_SECDED	0x4
>  
> +/* DDR ECC Quirks */
> +#define DDR_ECC_INTR_SUPPORT		BIT(0)
> +#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)

All those new additions are one column further to the left than the old
ones. Why?

Is there some significance here or can they all be vertically aligned?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
