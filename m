Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B94FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA742170A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFtrefy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA742170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeHHJFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:05:14 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45567 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeHHJFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:05:14 -0400
Received: by mail-ua0-f195.google.com with SMTP id k8-v6so1190231uaq.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NnG9z4/Ss+iJVNL/2OZjxcLLFu/shCdS2eQk/7LkwXs=;
        b=FFtrefy7kuU6IQafo3yuFHBB1KMNDJLehLlbPARFtpBGeSf62f1PKIe+301X2faRlP
         +r0cMg4PN0chCZENG8Xd6cDHcjZo64E0Hj0/R/p56FS4dWFlq8yjszVIvVx2y/ZXmekg
         oILRpCI3Bu73BrRJU0C2nQDEPkNRFKQNqQ4uoU1daHKb9CEaJwooswVYbvMi0Xxm2+EY
         l2HApR6D2Qq0MwICnK1tT6uP4I7fCWBEvosxc4j3VhQfvl8N0TmWeec/vLEfl9ac1uso
         Yl3//aUG0r2XSOJ9vbqqaQuR+B4Vpb1zWaWIDBgtbFZWLGQmHxVjIOS2wRNpnmmAsZzK
         Q3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NnG9z4/Ss+iJVNL/2OZjxcLLFu/shCdS2eQk/7LkwXs=;
        b=uijkVrbMMwwR/EtnsHyt+c8x8A7zBuMmUn389IBALpMw0Typq7ZiWFmk9DrGFsMLIZ
         Lo42T/ZfOcmrC1n7Fo82W1VNWs5w3VWVAWadZcmiHPU+HxzOfeTbWwH2Mk3iAntnuh11
         wKskyvFx77taBEko+YzO7k5heAHHphlUZh6JlbpQsWCtipZiQNoHQOPJ/BtFD6EnHyLm
         hArkh4peiuHt6xZ0WDpaSpWQw7IryCxIXRsoiGXKRov6Mj5ct5GLshKqNiqxq5ou5N6S
         WZIThfQqDRYuUFmNE04HovamEBAdFZ+YBqWG+XUhwGKA3S5kF7u8XWu42JN9MhHAKjex
         y6hA==
X-Gm-Message-State: AOUpUlHuPS6McNzzXP+MGlcBr3O41tba5afnaby/C6hk2ZRtb0nWlnBx
        BRa3ZditXTbnRF28fmFFLY0FuG+1vdTP4ywaMkk=
X-Google-Smtp-Source: AA+uWPyz0EXfkcbSsSA+gemMxirde20PPubGNbOIbRv5K26t3pDDTtBNcOaRKhkGkSnsVyv65ytu2l3Ng0djP5QkP0o=
X-Received: by 2002:a1f:f44f:: with SMTP id s76-v6mr954203vkh.125.1533710818803;
 Tue, 07 Aug 2018 23:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180807040313.6944-1-yuehaibing@huawei.com>
In-Reply-To: <20180807040313.6944-1-yuehaibing@huawei.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 8 Aug 2018 14:46:22 +0800
Message-ID: <CAEbi=3fhs585_TmhZ1Q-7rDj_DsSOsCTKaKFQYPsvT73=y-g8g@mail.gmail.com>
Subject: Re: [PATCH] nds32: add NULL entry to the end of_device_id array
To:     yuehaibing@huawei.com
Cc:     Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> =E6=96=BC 2018=E5=B9=B48=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Make sure of_device_id tables are NULL terminated.
> Found by coccinelle spatch "misc/of_table.cocci"
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/nds32/kernel/atl2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/nds32/kernel/atl2c.c b/arch/nds32/kernel/atl2c.c
> index 0c6d031..0c5386e 100644
> --- a/arch/nds32/kernel/atl2c.c
> +++ b/arch/nds32/kernel/atl2c.c
> @@ -9,7 +9,8 @@
>
>  void __iomem *atl2c_base;
>  static const struct of_device_id atl2c_ids[] __initconst =3D {
> -       {.compatible =3D "andestech,atl2c",}
> +       {.compatible =3D "andestech,atl2c",},
> +       {}
>  };
>
>  static int __init atl2c_of_init(void)

Hi Yuehaibing,

Thank you for your patch.
Acked-by: Greentime Hu <greentime@andestech.com>
