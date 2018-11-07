Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4CEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5E52089F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cohkukXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5E52089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeKHGz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:55:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33767 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKHGz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:55:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id u9-v6so8623903wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1awO9QdJYRVfVNpZGuoVe2ArPOTahTprkf32MZf2Qw=;
        b=cohkukXJnOdxiI2MPIA4Ig9i3E+jv5LjOJ0ffYtm2hY0DjXijiBIb5UIQ0zZwSTLNW
         n2CmjJ4C3Pen61/y0CdpfpaG14Osj88dYzWnU8H7CPutn8DQaDFjI6hT3mtskw9Cl/Es
         2nPq3ATxsU7cSBIrECxHvmfMbIzXFPHLGtMm7gKXF1+GS924TQ39Sx6Tkftuhz432mUr
         ukFYUNfcZ1J3SqieqRryDKIYm03NTRSwDnejTH8VinpkV5ZDdFExNDnNck0Ro6R5qt4p
         v73K0anfG2hBNjGrXd98yeMc7KzxZLqalllBJVAZIzY6H3IUoEFyPp9HuzC5g5K9khxp
         rLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1awO9QdJYRVfVNpZGuoVe2ArPOTahTprkf32MZf2Qw=;
        b=OC3EVO9tbZWNsE+FfXdgHOuckSVQdiy6P1lcTjyPpztXyo6MP8cykEldajq/YMbaEG
         vUxUiucvXSB81p1PVWcc5vlj+k9QKtlB2Dryl3OaOw9GAfv2yMrfsBncs4Owj6N/ohTs
         szviWohNefSGuE7eGxWc0rg2WzxuDZ+45mW+X7GKQI6qEwUXPDexQ4Rjs8yfcW3UxvAr
         PNxGajhs3z1VtOI7qgdY3vCJvEEyqv22fL5kN8l6QeXZT8kqdOXG6BJLtzcyb3CMt1zX
         cAdMSZP94wrtFyGFbwbMLX43fkOKS8kutZGw091KBOlmn5fZVTr42uIGTfHdu8/ExW3S
         V6jg==
X-Gm-Message-State: AGRZ1gLqzj4tNlNOVO185X/NZ2EZJMy3gTGqquizEo90kmgmita4CbjI
        kA4S/MvSVtCDCRxx8DgvECjNUwAoZDdheVHPXBM=
X-Google-Smtp-Source: AJdET5d3WGnYZ0ox9GqA5yrPQr+CjddwCpP/gFmQHc76D3NQi+DW/sL9VkcDuv2xC9rcx4PgiYww2XtZhJZevLhdONY=
X-Received: by 2002:adf:dcd1:: with SMTP id x17-v6mr1694353wrm.212.1541625822847;
 Wed, 07 Nov 2018 13:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20181105082540.21205-1-geert@linux-m68k.org> <20181107080733.ojderb7dkvwtpl2i@pengutronix.de>
In-Reply-To: <20181107080733.ojderb7dkvwtpl2i@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 7 Nov 2018 22:23:31 +0100
Message-ID: <CAFLxGvy_Tg88bufFn7VXT-N64U_pem3ocPYbWSqiBsxAb_iSvw@mail.gmail.com>
Subject: Re: [PATCH] ubifs: CONFIG_UBIFS_FS_AUTHENTICATION should depend on UBIFS_FS
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:07 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Mon, Nov 05, 2018 at 09:25:40AM +0100, Geert Uytterhoeven wrote:
> > Instead of adding yet another dependency on UBIFS_FS, wrap the whole
> > block of ubifs config options in a single "if UBIFS_FS".
> >
> > Fixes: d8a22773a12c6d78 ("ubifs: Enable authentication support")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  fs/ubifs/Kconfig | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
>
> I would have sent a similar patch with taking the easier way out of just
> adding another "depends on UBIFS_FS". This one is nicer though.
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied.

-- 
Thanks,
//richard
