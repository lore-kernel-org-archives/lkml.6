Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E58C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F22213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVLPjWJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F22213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeK3FMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:12:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39316 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeK3FMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:12:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so1403080pfc.6;
        Thu, 29 Nov 2018 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9tXFqDLjynNFoS5OR7+CMzGfrrpY6Zj70kGIzn3Efqw=;
        b=CVLPjWJu4Rqkq3aaScVKmGMi9h8vZgXbb+bJUtYRLIVvqYNB7dCysb+iO4qbZrPCa1
         LJ+ggNcyDg2Of0hgT2i2bxzmChCV/Mu65Lbme4fHNB5YQHqXCUbgcyYA5N6aN1IjTW9c
         Leg9/zHVPnS3hffSGMxlTKGKh7BCLPme2xj25+92LX7KzDGOwj5lMV6N2/tfg7jwnsJQ
         83yP86cgJrGNmLM8hTbF/BgtuUYzz76jQM1MYnH2XAH2BYuI4N2zoBuIav0HSoujUmd5
         GFvnbZKoraFoRwrxPxvwSIEjgp0PDZ8XofBzSynAnVXBS7F2AaNEHZuGup4Ir/dWuHlF
         XBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9tXFqDLjynNFoS5OR7+CMzGfrrpY6Zj70kGIzn3Efqw=;
        b=iylxXjMrKVCRAM61r+ypqB1Zsi2mKrNsn2lJ8DwZE8LapTLQQKzV4VpIkVjGkVDv3d
         Q6ZnbOV7ALg7zhRHqqz99vrMfX+H5Zgw3ic6Q+rCQL+Vd7eQACk61XsenMqbFIA+h0wN
         lQMMjxpqsj/lVqY93yScD52OWUx4zFPeapMkVpwgIT53S3Fqwcg9zoru74kXRrxdFU16
         bcBCWpuMl5DSmZXKue+5O7oaG7jGVeBanU98RnZVhBDifV9Uok4qixbpvPwm/VlAsyvG
         oCavxlHAdk2xZ2bAxDlLqQ32IiRyuW3A2aUHxDqBUX8T6ibEH0GoaiPUV4hT7fhMYO5U
         7ZVw==
X-Gm-Message-State: AA+aEWYnp9wyxughoQXlEAP5NhRhK1VOezXGxScKimy34KQMWBZRfI+0
        47q6tvgIABgWNqAV2ijq+rGv/Ik+
X-Google-Smtp-Source: AFSGD/X+uPMZLTtMMgD1gun7BciESqfLpekZKos1ot6LGaFeW22O0fh7z2Cr+xZFRCzQ34d98Y5g0A==
X-Received: by 2002:a62:d0c1:: with SMTP id p184mr2323882pfg.245.1543514791660;
        Thu, 29 Nov 2018 10:06:31 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y1sm3637571pfe.9.2018.11.29.10.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 10:06:30 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:06:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     adam@adamwong.me
Cc:     benjamin.tissoires@redhat.com, kt.liao@emc.com.tw,
        dshanty@protonmail.com, robh@kernel.org, jackxviichaos@gmail.com,
        ben.hutchings@codethink.co.uk, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mouse: elan_i2c_core: Added support for ELAN0621
 touchpad.
Message-ID: <20181129180627.GA54791@dtor-ws>
References: <20181129173824.7980-1-adam@adamwong.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129173824.7980-1-adam@adamwong.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:38:24PM -0500, adam@adamwong.me wrote:
> From: Adam Wong <adam@adamwong.me>
> 
> Added the ability to detect the ELAN0621 touchpad found in some Lenovo
> laptops.
> 
> Signed-off-by: Adam Wong <adam@adamwong.me>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index b0f9d19b3410..a84362d0c99d 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1348,6 +1348,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0618", 0 },
>  	{ "ELAN061C", 0 },
>  	{ "ELAN061D", 0 },
> +	{ "ELAN0621", 0 },
>  	{ "ELAN0622", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
> -- 
> 2.17.1
> 

-- 
Dmitry
