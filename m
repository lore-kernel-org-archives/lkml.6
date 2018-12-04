Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F974C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BEE20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="08zx+ehi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BEE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLDUTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeLDUTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:19:30 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F72D20878;
        Tue,  4 Dec 2018 20:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543954769;
        bh=tdWArpzf5E384cMrfAnA7weHncrHAl4lTC/f9jLjPLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=08zx+ehiQDLHvV7fEIH99YWNJ6saBCYEY+idbcZNuah6cNlQBbGSiBCrq5RJwjIi5
         Bkhcu2eshrV1IvomusOSRHsYfdrkddf0F+yklItqPdxvQaS7t739gD/ILEOVAL2DNL
         R6CFIglCRLEPXh4pH9/SO+LrHfhNfOemqd7eA3Cw=
Received: by mail-wr1-f54.google.com with SMTP id t27so17333499wra.6;
        Tue, 04 Dec 2018 12:19:29 -0800 (PST)
X-Gm-Message-State: AA+aEWbyjSgAtj8AbfClT+Xrgc8P5g7iIfq7VVuemUC0saJ0ElANqJsO
        K9ItXroMyZxx7xEGdbg8INJxvsGIgYXNMj5SOz4=
X-Google-Smtp-Source: AFSGD/Uy81UBEbhfc5Pr63iFQYkIneUWDxseGld5uAvo21auk6OBNEWkh9ueTugPbgzRwgN3X2LXQlMnjxGJZwCNokU=
X-Received: by 2002:adf:b243:: with SMTP id y3mr4779410wra.184.1543954767639;
 Tue, 04 Dec 2018 12:19:27 -0800 (PST)
MIME-Version: 1.0
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com> <1543843974-4054-2-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1543843974-4054-2-git-send-email-qii.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 4 Dec 2018 12:19:16 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
Message-ID: <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
To:     qii.wang@mediatek.com
Cc:     wsa@the-dreams.de, devicetree@vger.kernel.org,
        ryder.lee@mediatek.com, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<qii.wang@mediatek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=883=E6=97=A5 =E9=80=
=B1=E4=B8=80 =E4=B8=8A=E5=8D=885:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: qii wang <qii.wang@mediatek.com>
>
> Add MT7629 i2c binding to i2c-mt2712.txt and there is no need to

where's i2c-mt2712.txt mentioned here?

> modify i2c driver.

suggest not to mention driver in any dt-binding, dt-binding self
should be os-agnostic

>
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Document=
ation/devicetree/bindings/i2c/i2c-mtk.txt
> index e199695..7729e57 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> @@ -10,6 +10,7 @@ Required properties:
>        "mediatek,mt6589-i2c": for MediaTek MT6589
>        "mediatek,mt7622-i2c": for MediaTek MT7622
>        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
> +      "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek mt7629

change mt7629 to MT7629 to align to the others

>        "mediatek,mt8173-i2c": for MediaTek MT8173
>    - reg: physical base address of the controller and dma base, length of=
 memory
>      mapped region.
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
