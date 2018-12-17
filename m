Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7887EC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487D12133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="W9bvLI5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbeLQOsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:48:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42080 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732892AbeLQOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:48:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so11198152lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=65fbDHNoNifEP8OsDGmWB581GXczsjSo/TrfBHKoV/E=;
        b=W9bvLI5bRAZ/ktbNGavd965eVAymVNcsynWif38W3UgAQg09bb1ncZ9/Rd0T4b97tF
         0tQ3rkGmytLfyOBpoOLrDlOqhLJjPbscpDZ9gOxuFFAkoMmlJr//Wo/U7uELxm9InWAf
         u4ypsAbzQzgvB6MDdj9wkkh548NRiW7+00r0uAhLrsBd2TNaQF/aDjIA+5a4kt6/RdlF
         z8MExGQj/X3r/fUPJF94tJDr7AYGUStOiyNyczqv5mIh907RKZjTshV+WAxmOFLkDqB6
         PJxyn3hN9LWpGZP15/y3v93G7ml8Fbrw64zJ60D2311H709nr7M/BIbyVaAieGoju5nG
         IaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=65fbDHNoNifEP8OsDGmWB581GXczsjSo/TrfBHKoV/E=;
        b=BHZchyT8EDMYTXXZt8cVwZpcc4LfZ8e9Qt5wbbwH1Tp6SKMMS8NmukINHuK9WLUqgA
         tXt0KPrw09/4FdaDGOzwpC4eRwyQNafn+yYd4hUIoMBRryy/QCdZr4BEF9Lps3oYS+8C
         5DbYSFBzzeeB9XlkD5ia3UWbsn0czcVY5JDzdM4niRuhJgWHyeZ2WqBs0wErW+o1QE6H
         +Kp0xCSdZdcPEH6Bj4LllElSyMQPIFkPl/G4GjbN0SMet0uXItEySTS9K2iSqs1wSIxG
         1OhBzaJqJ+HqdCMslGgRS2PBlDoagbkjLL8zSl/Kn8K0O66fnOE8Qa8UHx26zto3SE7w
         n5eA==
X-Gm-Message-State: AA+aEWaHy/jGPVgiavBYORHSX++vjkitP1Twy3MTu/lHPRPqPVhDnQKI
        qtMiUzQz4w4IV4tASlzK71Gj3A==
X-Google-Smtp-Source: AFSGD/WtMFBj8h28+EsyWpARZozdmrnSinSkTmFTDg3RyzDBdYNR9GoUonz2ZwKaqYpDIXAyoxAETQ==
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr7426156ljf.5.1545058080330;
        Mon, 17 Dec 2018 06:48:00 -0800 (PST)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id g17sm3042009lfj.36.2018.12.17.06.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 06:47:59 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:47:59 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] media: rcar-vin: Add support for RZ/G2E
Message-ID: <20181217144759.GS17972@bigcity.dyn.berto.se>
References: <1544732644-7414-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544732644-7414-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thanks for your work.

On 2018-12-13 20:24:04 +0000, Fabrizio Castro wrote:
> According to the RZ/G2 User's manual, RZ/G2E and R-Car E3 VIN
> blocks are identical, therefore use R-Car E3 definitions to add
> RZ/G2E support.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/rcar-vin/rcar-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
> index cae2166..137edad 100644
> --- a/drivers/media/platform/rcar-vin/rcar-core.c
> +++ b/drivers/media/platform/rcar-vin/rcar-core.c
> @@ -1118,6 +1118,10 @@ static const struct rvin_info rcar_info_r8a77995 = {
>  
>  static const struct of_device_id rvin_of_id_table[] = {
>  	{
> +		.compatible = "renesas,vin-r8a774c0",
> +		.data = &rcar_info_r8a77990,
> +	},
> +	{
>  		.compatible = "renesas,vin-r8a7778",
>  		.data = &rcar_info_m1,
>  	},
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
