Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63493C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B03C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550081279;
	bh=rvTkxM2pJJrdLPA4N1SdM/Jn9teubk/E72psCNHDpgY=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=RpUAzFZ/AKospqD113om+XQbAzMRtj+7L/U0OfQFTYxCy5bsFr12x7k4kXRHbVG/z
	 hmd1NbpW58fUTYJ7Nm1CKhwoGgcTlWz6zgRUVSICGTqtyPklPWxOHeuMiyGJ+ehFwd
	 RMSDayEheaJwskgN0h+WwxgleoA0Jace6vf1nYCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404786AbfBMSH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfBMSH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:07:57 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39FA6222C9;
        Wed, 13 Feb 2019 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550081276;
        bh=rvTkxM2pJJrdLPA4N1SdM/Jn9teubk/E72psCNHDpgY=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=tjzrMEG0Zz7GF+bkG11xxCc6fcFdwHQQhnSqb10bkv0NujhWnQNyLW1m6xSRrnP5b
         vJR8LYAir+iQh27N6ADVMhCXpg75fUdHyiYGrdhumUGHjRU3xIaw9JCQB7m2vwYAlE
         wWfbAQuTKfZ12mkO0gmtatcLAkV92FSN/7JAGP9k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <155008053444.115909.15767350529461671558@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 07/15] ndings: clock: milbeaut: add Milbeaut clock description
Message-ID: <155008127539.115909.8938099989804942@swboyd.mtv.corp.google.com>
References: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com> <155008053444.115909.15767350529461671558@swboyd.mtv.corp.google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 13 Feb 2019 10:07:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-02-13 09:55:34)
> The subject seems to have been cut off? "ndings"?
>=20
> Quoting Sugaya Taichi (2019-02-08 04:27:03)
> > diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt=
 b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> > new file mode 100644
> > index 0000000..bcfc5df
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> > @@ -0,0 +1,49 @@
> > +Milbeaut SoCs Clock Controller Binding
> > +----------------------------------------
> > +Milbeaut SoCs Clock controller is an integrated clock controller, which
> > +generates and supplies to all modules.
> > +
> > +This binding uses common clock bindings
> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +Required properties:
> > +- compatible: should be one of the following:
> > +    "socionext,milbeaut-m10v-ccu" - for M10V SoC
> > +- reg: shall contain base address and length of clock registers
> > +- #clock-cells: shall be 1
> > +- clocks: shall be an external clock
> > +
> > +Example: Clock controller node:
> > +
> > +       clk: m10v-clk-ctrl@1d021000 {
> > +               compatible =3D "socionext,milbeaut-m10v-clk-ccu";
>=20
> I thought there was some length limit on compatible string names. 32
> bytes? Just barely under!
>=20

Ah I'm wrong. Compatible is 128. Good.

Seems I was thinking of DT property names.

