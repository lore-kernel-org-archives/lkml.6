Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24109C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BE820665
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O+P3S3jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BE820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeK1Kxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:53:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35947 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeK1Kxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:53:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so9205704pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 15:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TO4sExyxv6acTTPZL3vzEWLckjCWVxWXgD9YGLjR0cE=;
        b=O+P3S3jQTX49LUFvNhedEOyCBgVXTg7htYNET1JxN74PfUyzqIlaJUcGCzsHlJi346
         4h8KfTKaSLyPQTYXIC7VmFjgik5qpAlxhgHVlLAbyZ4hbTq60AYnKpT1rRAJulmszkDn
         0hfrIOAq3ho0hsWXJe6PSCLDSONBII7V+j1Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TO4sExyxv6acTTPZL3vzEWLckjCWVxWXgD9YGLjR0cE=;
        b=M2VBc8J1co03JYOph3aA+kO/N7djgZjfvH+uL/6HgVQ4J1E7l38qyls+HrtTjFOEcR
         fDXQA1IjLnyAyiDOQFK/1NCw06nZJIpmK1Cfr1fnYLP1wDk/579tjEF5f31Q8uQoISUG
         iyrLtF6/tUrg9G950o+a0EaW1Xn6D/yusi+ewomQ5FN23/891MpEjsL7LaTSIYkqPMK/
         K6JStMdXTGtKG4I5pFmvgg0VG49Vki5KD2EzgBRlIYHqDseiVyGSXPkSwZxQNFyonir3
         6wQP6GHJTk5GGQ/Pxdr1mwM67RazllQ1hvGhlYodcpHfo/B1q06asaG/hKMSIcSifvr9
         So9w==
X-Gm-Message-State: AGRZ1gKra1V2gU5DFl7YCUHWbKW92IMFBlkuBWjGvhLXGZtwSsDyY1Zp
        zev+d1MeA29fsPYt9QTecaTeLrgW3ZGDUPUeDaxvIA==
X-Google-Smtp-Source: AJdET5cs+Hq7Cv7rFTZ33b0+huaAGZldfhHxbhUcVEJVPZd3m5zVfjqVC7qHBqKc88bbGVxwGaRpjPReqdxsN0Kh4ZI=
X-Received: by 2002:a62:938f:: with SMTP id r15mr34967910pfk.27.1543362851560;
 Tue, 27 Nov 2018 15:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20181127034254.24721-1-weiyi.lu@mediatek.com> <20181127034254.24721-5-weiyi.lu@mediatek.com>
 <CAGp9Lzro5YHCYqzOWFJJa4g75odf6yK52cean_aS3p2STOtJYg@mail.gmail.com>
In-Reply-To: <CAGp9Lzro5YHCYqzOWFJJa4g75odf6yK52cean_aS3p2STOtJYg@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 28 Nov 2018 07:54:00 +0800
Message-ID: <CANMq1KB4tt9jdmE+LJXfji=QXC9-6wuhXWjJPkpNfo6hEMXH=A@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] clk: mediatek: Disable tuner_en before change
 PLL rate
To:     sean.wang@kernel.org
Cc:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        sboyd@codeaurora.org, Rob Herring <robh@kernel.org>,
        jamesjj.liao@mediatek.com, srv_heupstream@mediatek.com,
        lkml <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, owen.chen@mediatek.com,
        linux-clk@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 4:37 AM Sean Wang <sean.wang@kernel.org> wrote:
>
> Weiyi Lu <weiyi.lu@mediatek.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > From: Owen Chen <owen.chen@mediatek.com>
> >
> > PLLs with tuner_en bit, such as APLL1, need to disable
> > tuner_en before apply new frequency settings, or the new frequency
> > settings (pcw) will not be applied.
> > The tuner_en bit will be disabled during changing PLL rate
> > and be restored after new settings applied.
>
> It looks like a bug fix. If so, you should add a fixes tag and even cc
> stable tree
>
> >
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-pll.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-=
pll.c
> > index 1db161aced31..81400601f107 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -27,7 +27,7 @@
> >  #define CON0_BASE_EN           BIT(0)
> >  #define CON0_PWR_ON            BIT(0)
> >  #define CON0_ISO_EN            BIT(1)
> > -#define CON0_PCW_CHG           BIT(31)
> > +#define CON1_PCW_CHG           BIT(31)
>
> it seems like an unnecessary change

Below, you have:
con1 |=3D CON1_PCW_CHG;

Presumably PCW_CHG is on BIT(31) of CON1(?), so I think this is a good
change. Maybe this needs to be a separate patch, though?

> >
> >  #define AUDPLL_TUNER_EN                BIT(31)
> >
> > @@ -97,9 +97,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll=
 *pll, u32 pcw,
> >  {
> >         u32 con1, val;
> >         int pll_en;
> > +       u32 tuner_en =3D 0;
> > +       u32 tuner_en_mask;
> > +       void __iomem *tuner_en_addr =3D NULL;
> >
> >         pll_en =3D readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> >
> > +       /* disable tuner */
>
> similar code pieces are ready on mtk_pll_[un]prepare. maybe we can add
> common tuner operations for them to reuse.
>
> > +       if (pll->tuner_en_addr) {
> > +               tuner_en_addr =3D pll->tuner_en_addr;
> > +               tuner_en_mask =3D BIT(pll->data->tuner_en_bit);
> > +       } else if (pll->tuner_addr) {
> > +               tuner_en_addr =3D pll->tuner_addr;
> > +               tuner_en_mask =3D AUDPLL_TUNER_EN;
> > +       }
> > +
> > +       if (tuner_en_addr) {
> > +               val =3D readl(tuner_en_addr);
> > +               tuner_en =3D val & tuner_en_mask;
> > +
> > +               if (tuner_en) {
> > +                       val &=3D ~tuner_en_mask;
> > +                       writel(val, tuner_en_addr);
> > +               }
> > +       }
> > +
> >         /* set postdiv */
> >         val =3D readl(pll->pd_addr);
> >         val &=3D ~(POSTDIV_MASK << pll->data->pd_shift);
> > @@ -120,12 +142,19 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_=
pll *pll, u32 pcw,
> >         con1 =3D readl(pll->base_addr + REG_CON1);
> >
> >         if (pll_en)
> > -               con1 |=3D CON0_PCW_CHG;
> > +               con1 |=3D CON1_PCW_CHG;
> >
> >         writel(con1, pll->base_addr + REG_CON1);
> >         if (pll->tuner_addr)
> >                 writel(con1 + 1, pll->tuner_addr);
> >
> > +       /* restore tuner_en */
> > +       if (tuner_en_addr && tuner_en) {
>
> if (tuner_en) is sufficient
>
> > +               val =3D readl(tuner_en_addr);
> > +               val |=3D tuner_en_mask;
> > +               writel(val, tuner_en_addr);
> > +       }
> > +
> >         if (pll_en)
> >                 udelay(20);
> >  }
> > --
> > 2.18.0
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
