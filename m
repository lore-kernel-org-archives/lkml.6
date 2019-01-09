Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85822C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A815206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547050357;
	bh=0ewnFeC4FHEcj3A7zvP6jyGEqueFxUiBiflRWniyQXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XJT9pXU7A0luOY3LAcULbCjUlFU1BRpB/qgSC2WQElujYyU6AmrYnxDXIQdc2ttUT
	 deBPHdhP77IAhAekkWJ5Ot2obnlVY5UQN2oDY8Klw9LjlvUW2CsLYO5x4lb/XtFf8e
	 EeQL7P6uBWmKa04eNNUlVpcZnhuvITBz5pnVya7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbfAIQMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730263AbfAIQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:12:36 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0183206BB;
        Wed,  9 Jan 2019 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547050355;
        bh=0ewnFeC4FHEcj3A7zvP6jyGEqueFxUiBiflRWniyQXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PaaHvC5SP+i6GMQmpw0obVdFYkjcvV2PeHjc001a+JP9ks+YhfO8/KmWDAxJ8pEJV
         3mkqgCmls74Qet9z2bsIVInWzuB/x5g7MsItPYiO57nHx6NiL6So6HifJmpc8JK5hJ
         ZpSLn6d0p6yV/jTyD7m7xnXZ3qlwbVk5/wx4jdc8=
Received: by mail-qt1-f172.google.com with SMTP id k12so8874824qtf.7;
        Wed, 09 Jan 2019 08:12:34 -0800 (PST)
X-Gm-Message-State: AJcUukeqj5F24qiKCmCff2XNkfVZqNKXE+5FWy4d/HHndQ02DwrejcLD
        U+KHiFpfV4EJmzNqf/K1BzszMsJkTJ0EZqVtLg==
X-Google-Smtp-Source: ALg8bN4pu0jO5c5wx1wRb8Wdh/XxBNbWH/RA4JA1FVu26NTXWub+M5FQs5XxXlnpfvGYzWG+9gQUlDCyV6XWzoSBpIg=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr6044903qta.38.1547050354186;
 Wed, 09 Jan 2019 08:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-14-robh@kernel.org>
 <7hr2ewbxd4.fsf@baylibre.com> <CAL_Jsq+hZRJZZ1ZcOxZVXtsUs0013cP0fyf3A=_9J15WbzuUhw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+hZRJZZ1ZcOxZVXtsUs0013cP0fyf3A=_9J15WbzuUhw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Jan 2019 10:12:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2yN_h0FUJ_F79OBMNkpOH=ou-o4iBHffoRt4XRP8mYA@mail.gmail.com>
Message-ID: <CAL_JsqJ2yN_h0FUJ_F79OBMNkpOH=ou-o4iBHffoRt4XRP8mYA@mail.gmail.com>
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move
 'amlogic,meson-gx-ao-secure' binding to its own file
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 10:18 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 7:01 PM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Rob Herring <robh@kernel.org> writes:
> >
> > > It is best practice to have 1 binding per file, so board level bindings
> > > should be separate for various misc SoC bindings.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Carlo Caione <carlo@caione.org>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-amlogic@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
> > >  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
> > >  2 files changed, 28 insertions(+), 29 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
> >
> > Acked-by: Kevin Hilman <khilman@baylibre.com>
> >
> > But this isn't really related to the schema series is it?  If you
> > prefer, I can just queue this one separately via my tree.
>
> Yes, you can take it.

Hey Kevin, doesn't look like this got applied.

Rob
