Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3C8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4DE2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550088758;
	bh=5HR2C3e4hJr1yVsmV0xaF+8a/dJVoOCrXShZHRHacic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HvkGdrQn0zr8pj0Kx/VApAYQkxl0h7oCpTb2eyNSHhbpwZymSH6tMf9v7dwnkg6B1
	 jLccPHdqYucCd98W1RR/z+I3ZpLkez31bJrHX3WtkmATYLd4pCRJyIaoZdwTPofean
	 aDAsVTe6z7EyKP3ljHsQmBQk6as4TFCARPmj1bho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436595AbfBMUMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfBMUMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:12:36 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A1512147C;
        Wed, 13 Feb 2019 20:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550088755;
        bh=5HR2C3e4hJr1yVsmV0xaF+8a/dJVoOCrXShZHRHacic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KJnVjA9YDqFccKxwrgRwI04Fr4yhhT1Qz0csqysttuFelq6p4qTDPekwxKek1jmiw
         6h5UUC871VqkCklWp2ivarl/Gd16t1ICGXI/NyFwyWMojAwvFbI5OIWjo6m9J5aS1q
         iM7/qOummP94tyBa9sPhSFb8kj7VqXSxSBHFyzcA=
Received: by mail-qt1-f175.google.com with SMTP id w4so4236964qtc.1;
        Wed, 13 Feb 2019 12:12:35 -0800 (PST)
X-Gm-Message-State: AHQUAuZqjf/nxXMJK22y8YSTOc8FcaaV4mpoICgCIDVIu1GsHQgCUG5q
        /ZcUho1QZBLpc8RYO9hSxqoTAzgNgzY6egDp9w==
X-Google-Smtp-Source: AHgI3IZJB0f7syeg+bjn05P781cDIn989qaoNJ0kBC+GwvszhBYfp+QvjHTDY/vgj2xyzNS/VEk/iactrgayroblrwI=
X-Received: by 2002:a0c:91bb:: with SMTP id n56mr1908599qvn.77.1550088754747;
 Wed, 13 Feb 2019 12:12:34 -0800 (PST)
MIME-Version: 1.0
References: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
 <1421bc57f9f4d5f3e087a1fd38c5fa9ef087dd1b.1548735271.git.ryder.lee@mediatek.com>
In-Reply-To: <1421bc57f9f4d5f3e087a1fd38c5fa9ef087dd1b.1548735271.git.ryder.lee@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Feb 2019 14:12:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLan+-p661a=p2Ss7tsQHdu7YGqwe3OmYkwAKE=LeqT=w@mail.gmail.com>
Message-ID: <CAL_JsqLan+-p661a=p2Ss7tsQHdu7YGqwe3OmYkwAKE=LeqT=w@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: arm: mediatek: add support for MT7622
 BPI-R64 and MT7629 RFB
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <roychl666@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:31 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> Update binding document for MT7622 BPI-R64 and MT7629 reference board.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Do you plan to apply my patch converting Mediatek to DT schema[1]? I'm
not planning to rebase it now that this one is applied and resend it.

Rob

[1] https://patchwork.ozlabs.org/patch/1007257/
