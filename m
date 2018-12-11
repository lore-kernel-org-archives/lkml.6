Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3780C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857A62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNuvTqPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857A62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLKKKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:10:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38478 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeLKKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:10:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so6709886plb.5;
        Tue, 11 Dec 2018 02:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6928BhEGd8jPYH/ounyGsetHOYIT+CWnx07C1NEq3Y=;
        b=TNuvTqPJ4UQ1Jo9FpgCoTF9tL6Qfzh9oYZBZ4PeE4ZNKftVhoX+V2T5cwkwqOo6mXN
         NZDFfkIUoF2Cs8ZcXMpkJ00yAuPvwSohaxWO1cW8pbK/xWPwEC4vqNMgXB/DrxiqkqLn
         rFbzlYA+RKrzuR/Q+kX/ZZdFFOTsPtr2pBscc966YYXaeUB4ztTd8AsHaZNWsk1Fo5BY
         PIURdPSm7WaIO/oQPrGZRppafTMqklH9ddtMsSRUw7axA9KjNzlwvuAXhUuDinDBn0ZN
         5TQ700YCd0tpJNEvQpA0JkLHAmpUNCIqttjRQ9TOQQBQ6bDzHzNsTRDqnvt8qBBVBLI5
         uSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6928BhEGd8jPYH/ounyGsetHOYIT+CWnx07C1NEq3Y=;
        b=slBgi08TP4dwBSEv+G5UFwg3aweNpgjgBGVkVa6ZFSkrtxETj+FC4jfEsvFxBOh6yo
         q9rS2LPc39ZPdR+YqIdQ08ZH3EcjneWrm3QTyA2/b5TJ+j8Ap9Ti6QYs/ibno31BbHk7
         1Xl4HAxKLCLQmH1mpw3wUETvZ1pKf7cBui7yOJUxc6w4YXsqD2DMh9JqmRo5I6N+Uip9
         l2CoWjwfblhUpTaO3+CWxbgkNTBHp2OZq07Di6Bn1VoaHbmo6qXMs/t1rkHCu+UdSPhL
         F02UOdhY8Tk+IGFpBynfS3paDHBOUlKJAUWMtwdvE2kEVbJZMFgNYi7RIh74vCxh778T
         xfUQ==
X-Gm-Message-State: AA+aEWZUzYkJudy4lcflKDUeR9eY9mqkkIEXMKMexfQuEWubOVn9a77+
        A3XDMqSQeyK3Om2oGEdJS1DgRCqtjwaM9NzBM5bzEccb
X-Google-Smtp-Source: AFSGD/WnNA7y9cq/A5VZSVVIJGhc78xAjm+AT/5lcvnCSuoeiKzRqZ8ozVyH7fc+oMFEm55yjfmv+x0ErLxujm9VDWg=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr15496156plg.314.1544523011577;
 Tue, 11 Dec 2018 02:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20181211060125.28671-1-ayman.bagabas@gmail.com> <20181211060125.28671-4-ayman.bagabas@gmail.com>
In-Reply-To: <20181211060125.28671-4-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Dec 2018 12:09:59 +0200
Message-ID: <CAHp75VeLKGA0jwe9eqfSAisrQZB65Yvt3Kse1Cy7=Zkqqp02hQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] ALSA: hda: add support for Huawei WMI micmute LED
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 8:02 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> Some of Huawei laptops come with a LED in the micmute key. This patch
> enables the use of micmute LED for these devices:
> 1. Matebook X (19e5:3200), (19e5:3201)
> 2. Matebook X Pro (19e5:3204)
>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 1326f32f4574..9766fd249bdf 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5776,7 +5776,9 @@ static const struct hda_fixup alc269_fixups[] = {
>                         {0x1e, 0x411111f0},
>                         {0x21, 0x04211020},
>                         { }

> -               }
> +               },

This is not related change, but we may fix it when applying.

> +               .chained = true,
> +               .chain_id = ALC255_FIXUP_MIC_MUTE_LED
>         },
>         [ALC269_FIXUP_ASUS_X101_FUNC] = {
>                 .type = HDA_FIXUP_FUNC,
> @@ -6608,6 +6610,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>         SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>         SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
>         SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
> +       SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
> +       SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
>         SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
>         SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
>
> --
> 2.19.2
>


-- 
With Best Regards,
Andy Shevchenko
