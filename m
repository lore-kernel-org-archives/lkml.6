Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509E6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0146520837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="GC0rqMO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0146520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGDsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:48:47 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40365 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGDsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 22:48:47 -0500
Received: by mail-vs1-f65.google.com with SMTP id z3so1681711vsf.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 19:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mje8yeM+IKWT/rJe2HtO4QHciU9m7otXlYZ1MuNAtRU=;
        b=GC0rqMO9639yjXcz03mJS98E7uXn1HR1sWLxJHA7fILsUlLVpjVcEHvwdMFxCw3b8I
         bRmX/47GeW2p64NdML46Tf3sb6TI/o0cedX2qDc7KefBU54GFV5p8pThDB0prqA3m3h4
         +vnAFnciwNwGfyupb0rSg0+Jmt1Xnli9igdKRLWy+PQuI7TK/4e63iKRlmRMJKC1DOBy
         jI3/ZNXRdVvF2ipPegldneTYN7/3D8qAGtzH8ScMKygnMJob1XT6FhByb5BOavl5Szis
         KWEaZgbJ+UoWvOJeeFKMMTaOzPgogZui65ucRlr9XsSVoTObgbwYPaHwSgLM4oH1K9l7
         APAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mje8yeM+IKWT/rJe2HtO4QHciU9m7otXlYZ1MuNAtRU=;
        b=Xb7j/UTPPL5LRoMx2NlnZVtYx6Qw3bGcC5dYKVi50uqyW/qmWtc3OcsS4h3vIcHHI5
         1i/H+Lz0uzZfq3VmIFOEQVcu1T0ad+QQ6RfluXV4LVKpBh9kl8HJoUJjR1a1IXKStwIk
         SswvPmiN/899h1QCRFHzTVv2Rh9GILKBB8K6abpUszLWRNXSz5jNRFVSkvKZRBhdirFm
         b16ri87VM3wUPd9iWzXTHXpbKMdNCoGrZ/4/V4fEgyRVWTCeO+HxiN76VX2so0FxrWuS
         bMLo8+eIoktFHPGhkpOzxh8MtHsghxN0atCZ8Q84YWUhTj3nBy9Epwi+YPfM3F7GDfLM
         6CQw==
X-Gm-Message-State: AA+aEWaY8zMx6lyvPs5fFRgSazd5PkJMx0qIsvU0rFyKHxwL5rjKvdBn
        /AbqhpDG9jUrFZMSrogQFkxxx04b7mrYN3P+W0LCkg==
X-Google-Smtp-Source: AFSGD/VOLcMRsT8cPfE2y1vhC4suIyNnd7YD71+M7voJvgHpBKeWcSRxfuzFjt4bcP1ZwVqO1eaBBkk/TZ5Zmd/5wYk=
X-Received: by 2002:a67:8a81:: with SMTP id m123mr239810vsd.206.1544154525551;
 Thu, 06 Dec 2018 19:48:45 -0800 (PST)
MIME-Version: 1.0
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
 <20181206084554.4728-1-jian-hong@endlessm.com> <20181206084554.4728-3-jian-hong@endlessm.com>
 <6FAB7C47BCF00940BB0999A99BE3547A18420211@RTITMBSV02.realtek.com.tw>
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A18420211@RTITMBSV02.realtek.com.tw>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Fri, 7 Dec 2018 11:48:08 +0800
Message-ID: <CAPpJ_ed36NyopArw98qhkstAm=L9A4=xiLPaa2ju0+qMR0tE9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS
 UX533FD with ALC294
To:     Kailang Yang <kailang@realtek.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kailang <kailang@realtek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=887=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8811:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Jian Hong,
>
> Could I know who give you the value as below?
>
> +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
> +                       { 0x20, 0x4c4, 0x20 },
> +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
> +                       { 0x20, 0x488, 0x00 },

A module maker.

Regards,
Jian-Hong Pan

> -----Original Message-----
> From: Jian-Hong Pan <jian-hong@endlessm.com>
> Sent: Thursday, December 6, 2018 4:46 PM
> To: Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Kail=
ang <kailang@realtek.com>
> Cc: Hui Wang <hui.wang@canonical.com>; alsa-devel@alsa-project.org; linux=
-kernel@vger.kernel.org; linux@endlessm.com; Jian-Hong Pan <jian-hong@endle=
ssm.com>; Daniel Drake <drake@endlessm.com>
> Subject: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX5=
33FD with ALC294
>
> The ASUS UX533FD with ALC294 cannot detect the headset MIC and output thr=
ough the internal speaker and the headphone until ALC294_FIXUP_ASUS_SPK_NOI=
SE quirk applied.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
> v2:
> - Modify the HDA verbs for UX333FA support
> - Make a new ALC294_FIXUP_ASUS_HEADSET_MIC quirk for ALC294 chain
> - .chain_id =3D ALC256_FIXUP_ASUS_HEADSET_MODE  =3D=3D> change to ALC269_=
FIXUP_HEADSET_MODE_NO_HP_MIC
>
>  sound/pci/hda/patch_realtek.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c index d32e50b1ed60..1525bcdf96e8 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5518,6 +5518,8 @@ enum {
>         ALC295_FIXUP_HP_AUTO_MUTE,
>         ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
>         ALC294_FIXUP_ASUS_MIC,
> +       ALC294_FIXUP_ASUS_HEADSET_MIC,
> +       ALC294_FIXUP_ASUS_SPK_NOISE,
>  };
>
>  static const struct hda_fixup alc269_fixups[] =3D { @@ -6414,6 +6416,28 =
@@ static const struct hda_fixup alc269_fixups[] =3D {
>                 .chained =3D true,
>                 .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
>         },
> +       [ALC294_FIXUP_ASUS_HEADSET_MIC] =3D {
> +               .type =3D HDA_FIXUP_PINS,
> +               .v.pins =3D (const struct hda_pintbl[]) {
> +                       { 0x19, 0x01a1113c }, /* use as headset mic, with=
out its own jack detect */
> +                       { }
> +               },
> +               .chained =3D true,
> +               .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> +       },
> +       [ALC294_FIXUP_ASUS_SPK_NOISE] =3D {
> +               .type =3D HDA_FIXUP_VERBS,
> +               .v.verbs =3D (const struct hda_verb[]) {
> +                       /* Set EAPD high */
> +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
> +                       { 0x20, 0x4c4, 0x20 },
> +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
> +                       { 0x20, 0x488, 0x00 },
> +                       { }
> +               },
> +               .chained =3D true,
> +               .chain_id =3D ALC294_FIXUP_ASUS_HEADSET_MIC
> +       },
>  };
>
>  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D { @@ -6556,6 +6=
580,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
>         SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MI=
C),
>         SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MI=
C),
>         SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXU=
P_ASUS_ZENBOOK),
> +       SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD",
> +ALC294_FIXUP_ASUS_SPK_NOISE),
>         SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXU=
P_ASUS_ZENBOOK_UX31A),
>         SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DM=
IC),
>         SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73=
JW),
> --
> 2.11.0
>
