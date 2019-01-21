Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF140C3713A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E38720879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548107515;
	bh=EYnu5Ya9+3gsvdH1dq7fitEQBtHarMlkYjmX7LMZ3/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ti5VwsEcAmw1zUc3Yq2EDQ/Oh6LYzk3sgUwtecOa1wJsggoA654vAZg2rGAHLmyZc
	 2lXWei5HcjbD1aZ6CJrNJlEa8c3+++PUWEwfmidWROGY4vMD58fS16zpgBLklkLY06
	 npUsP7DSIr2/a0iX0Shh6jAPWm9UA5XyzTkcMp14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfAUVvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfAUVvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:51:50 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514F321019;
        Mon, 21 Jan 2019 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548107509;
        bh=EYnu5Ya9+3gsvdH1dq7fitEQBtHarMlkYjmX7LMZ3/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O6VMhZIhLfDeVFP72y7FkhLB4qKHj2j6I/ALrayaz4j2lDD7wKgt1vBGJY/lKs5F0
         Zh4o2eeuEBgVdEi0io0A5asapHWFOMMsGSLva8tRj6U09GZ8dGtj0dTiePXdHZIW5L
         Vix0pZeX/oBrUd4KU+rD36LpWcLgTdu1RAOtBM3c=
Received: by mail-qt1-f182.google.com with SMTP id n32so25217736qte.11;
        Mon, 21 Jan 2019 13:51:49 -0800 (PST)
X-Gm-Message-State: AJcUukdVl1PMtKl8u8fLpivWx/va2QISuxBuns3X7FgNDRHtoe9Lz4nd
        HOqls+Jh4l0iFMg4WX3eYu54iIxWTS+eHj4BYQ==
X-Google-Smtp-Source: ALg8bN6EBqsaeflp+H/csdQAqWjRU2u4c+CcQP92fuKOMmM1SXdKzG4O9RbnmwCTTJfWC0Hp0W8Lae9DIQraa6Dah3s=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr28740398qtf.26.1548107508543;
 Mon, 21 Jan 2019 13:51:48 -0800 (PST)
MIME-Version: 1.0
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190121171019.GA2903@bogus> <86imyhapl9.fsf@baylibre.com>
In-Reply-To: <86imyhapl9.fsf@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Jan 2019 15:51:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKVgWnLXGWxydj5HKiKeZ5Vf7HAgyr8+PkvrviUAwNW8w@mail.gmail.com>
Message-ID: <CAL_JsqKVgWnLXGWxydj5HKiKeZ5Vf7HAgyr8+PkvrviUAwNW8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:29 AM Loys Ollivier <lollivier@baylibre.com> wrote:
>
>
> On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:
>
> > On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
> >> Add binding for Mediatek-based GNSS receivers.
> >>
> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >> ---
> >>
> >> v2:
> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> >> Moved current-speed as an optional propertie.
> >> Removed the status line in the example.
> >> Added "mediatek,mt3339" compatible.
> >>
> >>  .../devicetree/bindings/gnss/mediatek.txt          | 39
> >>  ++++++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> >>
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks Rob,
> If there are no objections by others, I'll stop sending these two patch
> (1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
> on those two.

Generally, you should just resend the whole series unless the
maintainer has applied some of the patches. I could apply this but
usually the whole series goes in together.

Rob
