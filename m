Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA5EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953E72075A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953E72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeIJKtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:49:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36726 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeIJKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:49:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so37930188oie.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 22:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMLeQyYq3nOtSqnEgbJ2gMUK6DQuQ5f6G2vHTxmpMmg=;
        b=Sc6X4oOJv1GnrRXO9cIb9OoRhK/NtW13SNVPdbykNb/ACMzk6d2QiHTTcIOLeoe+bJ
         VMdif5Beb/sQFHeYFOoBjFT4+CskguRk0QXCZaMQs2UAnZ8dO3Jly8ZAtMPfj3S3B2H1
         KczMSioDKMJbIRTgg0WBp4TXAB0YQBVYyG37N/5ylwvll/H4n2u7Skdt5/kYZ3ts7/ic
         H9XLy0G910mnTwlZwiL4fjgNsde3xqGkdY78sweNy7AMVaRdVrsiwricnScUEbi/24gf
         FRtK3XrTteq3nZJYOwai5Eadaiyuu+NBksoAhUGjgGz7XWpDnwDLqiuUKhqF0rEs/Nry
         6rQA==
X-Gm-Message-State: APzg51DELbSSoS0t0Qlhim7whM/0zDw7muT9S+mShUSzJeP/sNDAfaN2
        7pmzMkUpzwpUkVFGLS9Ci8hCUAQG
X-Google-Smtp-Source: ANB0VdbdQrrgGBRiH0n7F1O+bPJthXyJaBgyjYYFU3BrcSgqqPv3zBEXYh21i0UXRwJ2J8hkBxGV6g==
X-Received: by 2002:aca:6087:: with SMTP id u129-v6mr18614576oib.99.1536559012082;
        Sun, 09 Sep 2018 22:56:52 -0700 (PDT)
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id n84-v6sm15591753oif.23.2018.09.09.22.56.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 22:56:51 -0700 (PDT)
Received: by mail-oi0-f46.google.com with SMTP id l82-v6so37879572oih.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 22:56:51 -0700 (PDT)
X-Received: by 2002:aca:601:: with SMTP id 1-v6mr2397310oig.291.1536559011577;
 Sun, 09 Sep 2018 22:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180903140840.23648-1-alexandre.belloni@bootlin.com> <20180910003946.GE21218@dragon>
In-Reply-To: <20180910003946.GE21218@dragon>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 10 Sep 2018 00:56:40 -0500
X-Gmail-Original-Message-ID: <CADRPPNS1N7J_F4ApqSKPrOJ4JuPwgV8srsGsS9DSSURvyhhM9A@mail.gmail.com>
Message-ID: <CADRPPNS1N7J_F4ApqSKPrOJ4JuPwgV8srsGsS9DSSURvyhhM9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: dts: fsl: use a generic node name for
 m25p80 flashes
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     alexandre.belloni@bootlin.com, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 10:11 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> The series looks good to me.  @Leo, what about you?

Looks fine to me too.

Acked-by: Li Yang <leoyang.li@nxp.com>

>
> Shawn
>
> On Mon, Sep 03, 2018 at 04:08:36PM +0200, Alexandre Belloni wrote:
> > Use a generic node name for the m25p80 flashes on ls1043 and ls1046 boards.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 2 +-
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 +-
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > index c7b8d2c009cd..af972e91d6bc 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > @@ -136,7 +136,7 @@
> >       bus-num = <0>;
> >       status = "okay";
> >
> > -     qflash0: s25fl128s@0 {
> > +     qflash0: flash@0 {
> >               compatible = "spansion,m25p80";
> >               #address-cells = <1>;
> >               #size-cells = <1>;
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> > index e69306e6b0b1..219068220b84 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> > @@ -165,7 +165,7 @@
> >       bus-num = <0>;
> >       status = "okay";
> >
> > -     qflash0: s25fl128s@0 {
> > +     qflash0: flash@0 {
> >               compatible = "spansion,m25p80";
> >               #address-cells = <1>;
> >               #size-cells = <1>;
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > index 440e111651d5..df676b30357b 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > @@ -103,7 +103,7 @@
> >       bus-num = <0>;
> >       status = "okay";
> >
> > -     qflash0: s25fs512s@0 {
> > +     qflash0: flash@0 {
> >               compatible = "spansion,m25p80";
> >               #address-cells = <1>;
> >               #size-cells = <1>;
> > @@ -111,7 +111,7 @@
> >               reg = <0>;
> >       };
> >
> > -     qflash1: s25fs512s@1 {
> > +     qflash1: flash@1 {
> >               compatible = "spansion,m25p80";
> >               #address-cells = <1>;
> >               #size-cells = <1>;
> > --
> > 2.19.0.rc1
> >
