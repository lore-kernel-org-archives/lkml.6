Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799A7C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D98123E8D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yKBw/L9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D98123E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeFVIAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbeFVH76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:59:58 -0400
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DBBA23E8F;
        Fri, 22 Jun 2018 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529654398;
        bh=ML5VXJG5L1GQFRcJNXddxbi0HbDDTvL/+5hwHMVip0Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yKBw/L9Bw2ZR20yEDyfPmSvbzxD+TyXeVMgaNN3MfdfDvR1SlxP/+GA9Dg8vgc17U
         hhRj5jzE6DAykKwm4Fud6sedZ0XsIkKiaJyfNT0Jl4EDhoz/3BBMkEWccZ6zO1qijs
         DQa7TkWxx/ev8FjIv3jE8SM0vhQuMZv6MbY8C36U=
Received: by mail-wm0-f52.google.com with SMTP id l15-v6so5547546wmc.1;
        Fri, 22 Jun 2018 00:59:58 -0700 (PDT)
X-Gm-Message-State: APt69E3gdQK5ZLf0STyJ3DpJzfcrT4HF3iBJ+YhgsE+iWbyovYdkcvap
        XTyux2u+KyPORj6wXA9IqC7GPU2zBZ13+Fh3w0Y=
X-Google-Smtp-Source: AAOMgpeTO34aZJoeZF4d1q7f0HEwpq2g/2nCxH/+mHn6IRVhQynFTFKCpSSzqgGv4bNihoqIBR9idWqpfJkpqFzWONQ=
X-Received: by 2002:a1c:e6d9:: with SMTP id e86-v6mr743252wmi.135.1529654396676;
 Fri, 22 Jun 2018 00:59:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:59:56
 -0700 (PDT)
In-Reply-To: <1529608199-5583-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1529608199-5583-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Jun 2018 09:59:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPffUmnms72vLDU9pEQCtpUCHir=5ae-vTPpS0wfmNut4g@mail.gmail.com>
Message-ID: <CAJKOXPffUmnms72vLDU9pEQCtpUCHir=5ae-vTPpS0wfmNut4g@mail.gmail.com>
Subject: Re: [PATCH 7/7] dt-bindings: samsung: Document binding for SGH-T959P board
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 June 2018 at 21:09, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com=
> wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
>

Commit msg.

Best regards,
Krzysztof

> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards=
.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index edce6602de50..8a9358336aab 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -3,6 +3,7 @@
>  Required root node properties:
>      - compatible =3D should be one or more of the following.
>         - "samsung,aries"       - for S5PV210-based Samsung Aries board.
> +       - "samsung,fascinate4g" - for S5PV210-based Samsung Galaxy S Fasc=
inate 4G (SGH-T959P) board.
>         - "samsung,galaxys"     - for S5PV210-based Samsung Galaxy S (i90=
00)  board.
>         - "samsung,artik5"      - for Exynos3250-based Samsung ARTIK5 mod=
ule.
>         - "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eva=
l board.
> --
> 2.7.4
>
