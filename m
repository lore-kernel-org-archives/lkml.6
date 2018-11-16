Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3FEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D7F2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8N6sMh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D7F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbeKPUhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:37:03 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33948 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbeKPUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:37:02 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so5455142ywb.1;
        Fri, 16 Nov 2018 02:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GnDP/VfCfl19GiZL+I408WfbNedBME9lnHb/teOa7fM=;
        b=D8N6sMh5DA88msZny0CY5uzKvcA4mYYFlY5hUew5HLKcPtCKnj5CfRfLcrdFCjM+9i
         wUuz9amAHlI/ouvMqCfnQ3YmOL4n1BwZO79Div09rzq1LwMwZrqB5yC9zkcXsVLD0aT0
         qA1bOdX2SGF9uEcC2kJjx5FdVIEbdZ5o3D9a4b2S/C3uB1KDRM1YqzzgioZs078ssQkI
         fw5IDStByIVke2V1K14JWPwUQcxmhSIHEPRRIYqU4EXu3aOGwNX8aJt8xGTSizXN0VDU
         rMo5BO6kyuPbe2i63A5FgYwYTLf4WRpMhpeQHwu6pCnnTXYAqb8HgkfCnkjPEDEU5bN1
         /0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GnDP/VfCfl19GiZL+I408WfbNedBME9lnHb/teOa7fM=;
        b=hVPGzutImLtK1NgLfUmuobL8m1iHpUpi8f6m5kJ2OGDVmODSZQdMvKYMcVyktyXhIn
         4mVl96+VbncU3P61J4LqCEO2LV/MpRUAT0JaO/oYd6+Slu2UyU5wx4umeth/B5F32WfZ
         3w60buknzlmSeWnts/tbL0wxHBlxzkt4w/+kUH+I59AwlGfLA1Oj1f6RQdyhpil+NoQN
         LWOtJCVF3U4r+LCxloIbJxuYBxBju8e4eZOeIto9Q4w4VH55J+VpuVgYW+nE6HGUpXsd
         LEGtfbOH6w46b9e0hXEgYs5t7TwXCJyyZCh7fKXFrTE6oxJWKl+Xp4eer51wdq0Y0H41
         K1Cw==
X-Gm-Message-State: AGRZ1gJWZlWfaymvPpGRS/czAeKR++jSUz8RUWYKBewVsfS8bwQPsVMa
        dOt9TcdP0wcVUqJ06/cTPiL04UJ/NU/4BUzMNx0=
X-Google-Smtp-Source: AJdET5cLTSdVbTHVh1BGtOIfO16k5UhCEr+VXxWmK8w8V5pdnmIgjNTLueAHhi6EUacZBKiPXOTDjpoqF0AZFIzjGO8=
X-Received: by 2002:a81:a552:: with SMTP id c79-v6mr9539167ywh.264.1542363918924;
 Fri, 16 Nov 2018 02:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20181105135802.30486-1-peron.clem@gmail.com> <20181116025938.GH5829@dragon>
In-Reply-To: <20181116025938.GH5829@dragon>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 16 Nov 2018 11:25:07 +0100
Message-ID: <CAJiuCcerEanEobbi8zPb1-eb=zCJsDAbM=p6T64+wtuXjtaMTA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-audmux: complete dt-bindings for imx6
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Colin Didier <colin.didier@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Fri, 16 Nov 2018 at 03:59, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Nov 05, 2018 at 02:58:02PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Colin Didier <colin.didier@devialet.com>
> >
> > The MX6 Audmux differs from MX51.
> >
> > This patch adds the audmux for i.MX6 family.
> >
> > Signed-off-by: Colin Didier <colin.didier@devialet.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> I think you should send it to ASoC maintainer and list for applying.

It's still quite new for me to submit patch, but if this patch should
be sent to ASoC maintainer maybe there is a line missing in the
MAINTAINERS file no ?

SOUND
M:      Jaroslav Kysela <perex@perex.cz>
M:      Takashi Iwai <tiwai@suse.com>
L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
W:      http://www.alsa-project.org/
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
T:      git git://git.alsa-project.org/alsa-kernel.git
Q:      http://patchwork.kernel.org/project/alsa-devel/list/
S:      Maintained
F:      Documentation/sound/
+ F:      include/dt-bindings/sound/
F:      include/sound/
F:      include/uapi/sound/
F:      sound/

Regards,
Clement

>
> Shawn
>
> > ---
> >  include/dt-bindings/sound/fsl-imx-audmux.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bi=
ndings/sound/fsl-imx-audmux.h
> > index 15f138bebe16..a1d0741d9ed1 100644
> > --- a/include/dt-bindings/sound/fsl-imx-audmux.h
> > +++ b/include/dt-bindings/sound/fsl-imx-audmux.h
> > @@ -25,6 +25,14 @@
> >  #define MX51_AUDMUX_PORT6            5
> >  #define MX51_AUDMUX_PORT7            6
> >
> > +#define MX6_AUDMUX_PORT1_SSI1                0
> > +#define MX6_AUDMUX_PORT2_SSI2                1
> > +#define MX6_AUDMUX_PORT3             2
> > +#define MX6_AUDMUX_PORT4             3
> > +#define MX6_AUDMUX_PORT5             4
> > +#define MX6_AUDMUX_PORT6             5
> > +#define MX6_AUDMUX_PORT7_SSI3                6
> > +
> >  /*
> >   * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
> >   * can be sourced from Rx/Tx.
> > --
> > 2.19.1
> >
