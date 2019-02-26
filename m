Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96629C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3892146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H50v/i1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfBZKlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:41:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59528 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBZKlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:41:39 -0500
Received: from zn.tnic (p200300EC2BCDB2001DA4ECEFA9208567.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:1da4:ecef:a920:8567])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 767161EC023E;
        Tue, 26 Feb 2019 11:41:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551177697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H8DriVtZp5e11WeYTT623scrD55rQpcKF6XDNycDhqk=;
        b=H50v/i1JHGOay8FJ4OZWomO/LxLjVA0YVcgv/XkWRRNh6QNd7H7FtZi/vdv7G3/HEjxREh
        A1qwsIFbX5qgyAoxAAVkdALlMvh6kpJ79B7b0jnoVTu3rWqegqDs5c/5RXczti5mibZ9lD
        OnINtoqMsInNU/BwsWcjBYkkGSNjDeg=
Date:   Tue, 26 Feb 2019 11:41:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] EDAC/amd64: Add Fam17hMod30h PCI IDs
Message-ID: <20190226104129.GA14836@zn.tnic>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just nitpicks:

On Tue, Feb 19, 2019 at 08:25:51PM +0000, Ghannam, Yazen wrote:

> Subject: Re: [PATCH 1/5] EDAC/amd64: Add Fam17hMod30h PCI IDs

Write that "Fam17hMod30h" in a human readable form pls. Especially in
the subject: "family 0x17, models 0x30..."

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Add the new Family 17h Model 30h PCI IDs to the AMD64 EDAC module.
> 
> This also fixes a probe failure that appeared when some other PCI IDs
> for Fam17hMod30h were added to the AMD NB code.
> 
> Fixes: be3518a16ef2 (x86/amd_nb: Add PCI device IDs for family 17h, model 30h)
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 15 ++++++++++++++-
>  drivers/edac/amd64_edac.h |  3 +++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 6ea98575a402..9947437d9574 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2211,6 +2211,15 @@ static struct amd64_family_type family_types[] = {
>  			.dbam_to_cs		= f17_base_addr_to_cs_size,
>  		}
>  	},
> +	[F17_M30H_CPUS] = {
> +		.ctl_name = "F17h_M30h",
> +		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
> +		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
> +		.ops = {
> +			.early_channel_count	= f17_early_channel_count,
> +			.dbam_to_cs		= f17_base_addr_to_cs_size,
> +		}
> +	},
>  };
>  
>  /*
> @@ -3199,7 +3208,11 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  		break;
>  
>  	case 0x17:
> -		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
> +		if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
> +			fam_type = &family_types[F17_M30H_CPUS];
> +			pvt->ops = &family_types[F17_M30H_CPUS].ops;
> +			break;
> +		} else if (pvt->model >= 0x10 && pvt->model <= 0x2f) {

Sort the checks in increasing models so that it is easier to follow.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
