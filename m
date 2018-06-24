Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C39C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 18:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F3B252C5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 18:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xyy/BWi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F3B252C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeFXSAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 14:00:15 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41445 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeFXSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 14:00:12 -0400
Received: by mail-ot0-f193.google.com with SMTP id d19-v6so12677174oti.8;
        Sun, 24 Jun 2018 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sc/3OGXdeH7CMykaS3k5y7VrCSDs1GfWuQNQaPbJ3Os=;
        b=Xyy/BWi88IZrd78vFesrBfsAUeZroNBe1ZlBUXjm5ATA7I8rr+vCNDJ5gRMAZ8w5wO
         J46h+h2IU+fH4KzCe3ALOJrwbGnTne2O8VKM30tLDewKKeOfdB0e+JzGpqKlJi/Zcdsh
         a/8tzdbnCYt6ooqiY20TWfx0zJs2UMXYvAeY1aP8oU4vXfzTATxDsV8ncxv9MrLkpnCg
         +vFyXKXasiltu25O4w+lhMQiSm1aKkuH17SkCWrzxtbUbmLXwkeJ5GvjiRR/gIYIjmvj
         IXz+IyTcw483Le21SWIHm48pn/dd8hJuMUPlOUxd3+mA2l6Bj1XnToaD2ON6WNFjL1Qv
         ENAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sc/3OGXdeH7CMykaS3k5y7VrCSDs1GfWuQNQaPbJ3Os=;
        b=ZHhnmxiDJ/o6AQeowej9mSzXjmnSVrlQrUfavpI2V2SRgSQRFMg+X6XTjzl0ydAbfK
         gej4HJ1l3B6ecViNB5z/qVCh/2HSQiMGa4Iq4tLQlmGH2TMgmObVdEzcLvs0JBOFSr9A
         l0STHZ1tQQmKuimgsyjaERm+lBlei5jUv0GiXrNHurY8Pj+Uxphotk7o3Y/7r6B+fulg
         13DZkUpoTPEV9MESARlLmr9UVvZGr8SDl8eN1EFEJ70V2HUTm8aI+39jB80V5D9Coy47
         dNuwIJaLHHJenAW+i/4TD1WBthIEjus6nBJBW/sCBbqsGukjfC8RWPAKjk/vn/xkZn2l
         x0cw==
X-Gm-Message-State: APt69E0zk2zJvW5hcKD6sDl2DEnWKHqmk73HGI0JtpbrtundAaBBPGe/
        MgY0MW2za+bP7nvtTPC1spHQHVRVBVuX/H6PicU=
X-Google-Smtp-Source: ADUXVKJSYzrztBifRsLZvIIWqhq2Mfwod+j/gk/pDDZ+VCYTqRamlSClBft/gnwinMxKiVtGcP1W/DxvfdCR/evNVVQ=
X-Received: by 2002:a9d:2909:: with SMTP id d9-v6mr5372760otb.258.1529863211984;
 Sun, 24 Jun 2018 11:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
 <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
In-Reply-To: <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 24 Jun 2018 20:00:01 +0200
Message-ID: <CAFBinCBS+fpfx6jaaqD=kqFuMF6ko8GikbV1ZVwgbDh-Sn8T8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: core: phy: fix return value checking about devm_of_phy_get_by_index()
To:     chunfeng.yun@mediatek.com, johan@kernel.org
Cc:     gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com,
        matthias.bgg@gmail.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chunfeng,

thank you for the patch!

On Fri, Jun 22, 2018 at 8:33 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> 1. use IS_ERR() but not IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
>     never return NULL value;
ACK - good catch!

> 2. devm_of_phy_get_by_index() should not fail for a valid index
I have learned that the PHY framework can return -ENODEV if the PHY is:
1. supposed to be handled by the legacy USB PHY framework
2. the PHY node is disabled in devicetree

see [0] for the code in the PHY framework and [1] for the discussion
with Johan (who informed me of case #1, I added him on this mail)

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/core/phy.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 9879767..0f972e1 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
>                                    struct list_head *list)
>  {
>         struct usb_phy_roothub *roothub_entry;
> -       struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +       struct phy *phy;
>
> -       if (IS_ERR_OR_NULL(phy)) {
> -               if (!phy || PTR_ERR(phy) == -ENODEV)
> -                       return 0;
> -               else
> -                       return PTR_ERR(phy);
> -       }
> +       phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +       if (IS_ERR(phy))
> +               return PTR_ERR(phy);
@Johan can you please review this as well? maybe we need to keep the
-ENODEV check


Regards
Martin


[0] https://elixir.bootlin.com/linux/v4.18-rc2/source/drivers/phy/phy-core.c#L421
[1] https://lkml.org/lkml/2018/4/19/88
