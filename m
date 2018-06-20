Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51BCC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605742083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhRDbTXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605742083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933730AbeFTWW6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:22:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43243 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeFTWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:22:56 -0400
Received: by mail-oi0-f68.google.com with SMTP id t133-v6so1063136oif.10;
        Wed, 20 Jun 2018 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wPQ6rw8QbQsZVkjYwUhnh4MmKBTegAQscmezDVbzZME=;
        b=JhRDbTXC9o6mIJzPz0uRmih0RGWIXPctwXM02aZyqc+ang21eq6rwbYJLwFECVDqPE
         JsZhraKs8D1zdAyeDl+3wd6soNzqsNIZ3uEtxcI6xVfhgC7T8AVL5GxN1GWmXNiqLpzA
         IxkJm4CHcnJgWWaXUbssui06jl4kzbUlfTpV0r2x3tkiTqgjbavA/le/0pGbTvPS/so7
         BsxR8MuuQsYpHsvV8ZB9E5n33bHFLBdazafi/GxVbuKkwMtv3R/PHIZaPRGlrWmbMUDm
         gooWXK3Z+6LX/hywV2hf7ug1qf0nLY1bjszST1J2KXlwd8SmHl0n38wbQ1NdtWvvbAzh
         +gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wPQ6rw8QbQsZVkjYwUhnh4MmKBTegAQscmezDVbzZME=;
        b=c2Cu9OyYkb+HHEHuF5xelZtVavCdyKmts2Tycra8SCpv+1MuYCp9rXXsEdDRe/UolJ
         9vhBmWVKViGXQco9BnpGZph3njLCR8rIN453Jmhujubc5SNleeYO7E9tSxbk0qc5EBsa
         +OZGQ42kdwkvAOqHxjikBu60frXc7e2kD+iFdq5wAdnCg1C1YYCuTjauXHzYROvDep4z
         QqsLvSbQX7j1GZuV2Dnssr5yOsXpMkrZKInb2q8eu6zEL8E0YBBGm4N8YKXpUxaoH5K8
         F9w56UqKw+CEBYZINb0MdCxP/lx+X01FsVC00unb3Zo8/RUR/gmVDD8C5lbICQ/ICzJC
         43mg==
X-Gm-Message-State: APt69E2l9RNjpEnNFCVXMoQRugV8dAAidO5kVd+Gkfrm6j3ZANihVPGF
        OffiBj6tPN5bSJ3uKu6xzq0D8hKMn/EVRGqDvWI=
X-Google-Smtp-Source: ADUXVKIIc1Ad16Xrd12mE/FAwWqQX4cBrPn6rinx/c/0iN9Q3M8KNFUFy0bgF7lJs+vFgYXFv/VhaHFR14Y6rQxrPxc=
X-Received: by 2002:aca:f244:: with SMTP id q65-v6mr13889516oih.71.1529533375660;
 Wed, 20 Jun 2018 15:22:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 15:22:55
 -0700 (PDT)
In-Reply-To: <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com> <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Jun 2018 19:22:55 -0300
Message-ID: <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 7:07 PM, Fabio Estevam <festevam@gmail.com> wrote:

> This patches causes a regression on a imx51-babbage running 4.18-rc1:
> I get a kernel hang.
>
> If I revert it on top of 4.18-rc1, then it boots fine and USB host is
> functional.
>
> I understand this patch fixes a kernel hang for you, so which commit
> is responsible for the hang you observe?
>
> It seems this commit fixes a hang for you and causes another hang for me :-)
>
> Any ideas?

I am able to boot again if I skip passing the CI_HDRC_OVERRIDE_PHY_CONTROL flag:

--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -294,7 +294,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
        if ((of_device_is_compatible(np, "fsl,imx53-usb") ||
             of_device_is_compatible(np, "fsl,imx51-usb")) && pdata.usb_phy &&
            of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
-               pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
                data->override_phy_control = true;
                usb_phy_init(pdata.usb_phy);
        }
