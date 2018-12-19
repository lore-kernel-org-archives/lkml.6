Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059222084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpFFzkaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeLSOKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:10:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35146 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeLSOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:10:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so15151334lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 06:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VA98hHAI2VVKlf91qrIg1B+oW4hafFZKadnv26WyUig=;
        b=cpFFzkaNt05F3OWVwa0Ic4yYXDbeuu8/IKLP2L8yj6SjFVf+8p6ATBln8O0ElynhD3
         0I/Q1FyMqtj0RH+70v9RIAZ7F52KsaRfWPD/kAvTBFhrQCJBlbp4MCsSitV62A4dHJgt
         ItHdEr/2dMXrGQ1IgHA53TteQl4au2pdgf1p2b0FyjVrIK1ulAadlw6AdD0QiqrCOhR+
         WrhC2rKsTspxw69MRxFA4F2Nmn26azbrqM+QYnV6Ic/+p8mtnLxaHCLUSE3jdyOFf5Q/
         q5u9YJnChz+n0gQXv2gE+XU9KTk1Fiy8858W7+Qv6NPs5Ubj42KA+vsIhtJ6blxmYWup
         YECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VA98hHAI2VVKlf91qrIg1B+oW4hafFZKadnv26WyUig=;
        b=GaBEfm+O5yMCDKyfa4HvBSPSqeR2EW1eNS8rnk8Yel1nRWRqWQVnqQorh0Smiln1EX
         g+7uT+UdNL0RGpiUZrIPQbfDy720sPNLy84tqQQjjwEBl2fT5nZ4/4dY40JeL5xf99Ok
         lcBMSJKFqs2owPNXaHPCE+rYAgBOaSJsAqGGZ0KBxNPKAmZ7qm+ymdD8+C4t6cSjGKb/
         g4skrP7uMDAilUBINQrdcB9NQqjJl1pndPFa1dHfIaGH6PHYAStdNl9LON2gm6aXTGuI
         trDOmD2+iYPk70M/8TOEBniMTXgdpvnUmq1Qh+RHcC58ihqtRO13bOnD3xNeQ6dALRIo
         +GPQ==
X-Gm-Message-State: AA+aEWZDBN/e+VNmaJMiao5SowSTbnbxrh1oKI3zRdKjnqzF8vi+4aWT
        XFg9Wb2M8C4vFjOQTT8cSVQ=
X-Google-Smtp-Source: AFSGD/WqKU4vextfBOrNF57mZ8EcCPypDuPvuS0VBBRjtk0fwJfm5NAFj7wRYa086FuNxQpbs5Zt5A==
X-Received: by 2002:a19:5349:: with SMTP id h70mr12313225lfb.50.1545228617954;
        Wed, 19 Dec 2018 06:10:17 -0800 (PST)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id b69sm3909428lfl.28.2018.12.19.06.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 06:10:17 -0800 (PST)
Subject: Re: [PATCH] drm/bochs: add edid present check
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181218073339.12160-1-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <93d72578-9567-9694-dbc7-62618b217f8f@gmail.com>
Date:   Wed, 19 Dec 2018 16:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218073339.12160-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Gerd!

On 12/18/18 9:33 AM, Gerd Hoffmann wrote:
> Check first two header bytes before trying to read the edid blob,
> to avoid the log being spammed in case qemu has no edid support (old
> qemu or edid turned off).
>
> Fixes: 01f23459cf drm/bochs: add edid support.
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/bochs/bochs_hw.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index c90a0d492f..f91e049625 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -89,6 +89,10 @@ int bochs_hw_load_edid(struct bochs_device *bochs)
>   	if (!bochs->mmio)
>   		return -1;
>   

You could probably have a comment here explaining the magic below

(just like in the commit message to ease the task of understanding

while reading the code why 2 of 8 bytes of the EDID header is checked

and why it is all needed). Of course one can use git blame... Up to you

> +	if (readb(bochs->mmio + 0) != 0x00 ||
> +	    readb(bochs->mmio + 1) != 0xff)

bochs->mmio is defined as "void __iomem   *mmio;". Can we please avoid

void pointer arithmetic here?

> +		return -1;
> +
>   	kfree(bochs->edid);
>   	bochs->edid = drm_do_get_edid(&bochs->connector,
>   				      bochs_get_edid_block, bochs);

With the above fixed:

Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

