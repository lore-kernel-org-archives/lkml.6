Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D6C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A93253B3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c64dJryD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A93253B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeF3S5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 14:57:47 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42698 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeF3S5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 14:57:44 -0400
Received: by mail-ot0-f194.google.com with SMTP id n24-v6so13361709otl.9;
        Sat, 30 Jun 2018 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NyAzggpzbYh6HhJum+oGGf/yAYexqN3eGRv16aR2WVc=;
        b=c64dJryDs7r263jtvbrl2aVfb8KCoryG27PL1KPFYOrR8BWyj37y9nQiPdIdxRRCDV
         CDXIiZ0ItfTEDTH5DoWpvyl2sMMBGKWbfgJHDzDjAlt6E6d/7ZoV1hwoTUe0G/AMWhNQ
         mqa3cmMUj32JIjQVLWiM9hmwu21Jw+jZ0+nhofYN7Mn9AcWxbD0Nop/wDgnWOcJnFWTY
         9e1Zago6oiIZbDoiPSbxst5LE/Nhr/cWE61iO/L6Y7HnelKR9iYUPGZYls1HmIKf2X8I
         Bqt/IVRoJT94OpDR0fNgYz2AHwymiqAeLRVU7HrPXcvMEEQCSPQPrCYcukfhXJvxWjXE
         Lflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NyAzggpzbYh6HhJum+oGGf/yAYexqN3eGRv16aR2WVc=;
        b=R+3K/GMs16wcOqEZlKnTU4A938INDRA7+Ye4TYiTBPmJCvctteG2IaLzrSbH2Q3wuq
         q4dzep/URDqourJ5Ep3v1noewObIp5YaiRZuOZSNzpAboDjcjwYGGS1iurUa67UnGz1M
         KR+hiF+e/vl/JAyiIWgnrg3zCoxQWNOV0Q4HLS9FF/FHX2D/NDBjuv8dPTC2iuDtneZF
         miRnkUBGPi2BCjXAHc5he0o2KNEV1B0+8YwGOYhDTL0P5jXKDgLDdw/ohNuEwwqiKLRP
         QBmUv0YolRvgA1+aFakCNZppchjzvrUQgpZuX6qeLnwb+gjkFsEsDtM6AuLbWsnaWUtz
         YJfw==
X-Gm-Message-State: APt69E19DmJd7AAz+1xiTTdWElsIPKpHbeBZjXY+TyXEAzOYSduDnDZB
        oZW7zMDsfbcExxp9Ne5KMR6Obnx701qiYZBGJUY=
X-Google-Smtp-Source: AAOMgpcnpi8EMkCjuXJRoxzY2PyP++MmE4q5wTDXq2wLLlul8SEvhgo72CrirWRi8g5gew1nsh0+wHYIjA7wlP67DBE=
X-Received: by 2002:a9d:61c1:: with SMTP id h1-v6mr10889314otk.4.1530385063720;
 Sat, 30 Jun 2018 11:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180617014216.4043-1-rosenp@gmail.com> <20180624.150445.1006140718276550233.teika@gmx.com>
In-Reply-To: <20180624.150445.1006140718276550233.teika@gmx.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Sat, 30 Jun 2018 11:57:32 -0700
Message-ID: <CAKxU2N8HGcJer5v3vDHMnHH1gAeAhHDdNDZS-yL+a2Ung_PiNg@mail.gmail.com>
Subject: Re: [PATCH] synaptics: Enable RMI4 for Clevo P870DM laptops
To:     teika@gmx.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        jan.steffens@gmail.com, waltercool@slash.cl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 11:05 PM Teika Kazura <teika@gmx.com> wrote:
>
> Hi, Rosen. Thank you for your patch. (@Jan Steffens and @Pablo Cholaky: T=
hanks for your reports.) But I'm afraid some more work is necessary. Let me=
 propose some points.
Too much work for me. I'll just use the kernel pareameter.
>
> I'm not a kernel developer, but have been working on this issue to help t=
hem. (See https://www.spinics.net/lists/linux-input/msg55950.html )
>
> 0.
> Could you resend it, cc-ing to the relevant developers. (Use the one of m=
y reply here. You can use <kernel src tree>/scripts/get_maintainer.pl next =
time.) Otherwise, it is unlikely to be noticed by them.
>
> 1.
> You added your device to forcepad_pnp_ids[], but I guess it should be smb=
us_pnp_ids[].
>
> When making the patch again, please use the kernel 4.17 or newer, because=
 smbus_pnp_ids was changed recently.
>
> If it works by using smbus_pnp_ids, please test it for a week or so, espe=
cially making sure that suspend/resume works without any problem.
>
> 2.
> Though it's my personal impression, the change description looked somewha=
t personal. At the same time, it's important, guaranteeing the stability of=
 the patch.- I know you originally reported it last August [1]. Furthermore=
, there have been two other users [2] who reported SMBus worked for the sam=
e device, namely SYN1219. (They two are cc-ed to in this reply.)
>
> You can use "$ git format-patch --cover-letter"; it will generate a "cove=
r-letter", the introductory part of the patch, explaining the acceptability=
 of the patch to kernel developers. (For an example, see https://www.spinic=
s.net/lists/linux-input/msg57041.html)
>
> So the full description can be given in the cover letter, and the real pa=
tch description can be something like "This enables SMBus for xxx", being a=
lmost identical to the email subject.
>
> 3. This is not essential, but the style of the email subject that the dev=
ice maintainer prefers might be:
> ------------------------------------------------------------------------
> [PATCH v2] Input: synaptics - Enable RMI4 for Clevo P870DM laptops
> ------------------------------------------------------------------------
> after looking at this tree [3]. ("v2" meaning version 2, due to the above=
 change.) You can feed "--subject-prefix=3D'PATCH v2'" to "$ git format-pat=
ch".
>
> 4. If you want to give the credit for my reply, you can add
> ------------------------------------------------------------------------
> Suggested-by: Teika Kazura <teika@gmx.com>
> ------------------------------------------------------------------------
> after Signed-off-by. It's completely ok without it. :-)
>
> [1] https://marc.info/?l=3Dlinux-input&m=3D150284057602358&w=3D2
> [2] https://marc.info/?l=3Dlinux-input&m=3D150049625613055&w=3D2
>     https://marc.info/?l=3Dlinux-input&m=3D150094561111026&w=3D2
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/
>
> Best regards,
> Teika (Teika kazura)
>
>
> From: Rosen Penev <rosenp@gmail.com>
> Subject: [PATCH] synaptics: Enable RMI4 for Clevo P870DM laptops
> Date: Sat, 16 Jun 2018 18:42:16 -0700
>
> > I have been testing this for half a year with no issues to report.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/syna=
ptics.c
> > index 55d33500d55e..23f5bb2cf9da 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -183,6 +183,7 @@ static const char * const smbus_pnp_ids[] =3D {
> >  };
> >
> >  static const char * const forcepad_pnp_ids[] =3D {
> > +     "SYN1219",
> >       "SYN300D",
> >       "SYN3014",
> >       NULL
> > --
> > 2.17.1
> >
