Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E4AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30F720843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z95q5cXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30F720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeICOQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:16:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40885 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbeICOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:16:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so17191493wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsZn7GLVgQ5TWDzsRzLxw4hzpMMeb7iKpanmGVrSbhw=;
        b=Z95q5cXa4yi3Tpa8nO5I9jm5BtzT16e/Hn04YxYFEY2JNi7NJC401yeSM1hCez/zEb
         9XkrpmnRDD8ijbbb/0t23xW5CyWWthyeHyyv7nFTcoILuFcdDbnZjZuA2ympTEi+uLeJ
         hqtViRr2vOYkB7unNYX181EVK7TxgpkfNt8xJGtQLCZ1jsfTaLXrhbHmkkLYIqa7q8i/
         85esHzz8Bx9l1faQTUnbI7DtWo6zrf4RRMX3z/thOTw200TvaO9KZSA9w8U+rNUQzJxw
         KBcuwiY4RHm8LY/kp2vLZYvawVhXjWrpy7FYrAAdJoAhbdbMsZ+NnV+U5ZhqfnJMlbDP
         WFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsZn7GLVgQ5TWDzsRzLxw4hzpMMeb7iKpanmGVrSbhw=;
        b=CIfP8xfnSk42k3Z5MOdgNz5xNmSzsJ3qJSflwr+K+Gq68EZkx+8m+cXSselqu71bxr
         4nYOCC1rAfajWK8i9mrMNCBaDY4h3w+Mk9L4nO55CkChcpNdWK8rRrbsXxpgxlodCLVw
         +76nzqAyviUL75IDV3ucQGUB2CaH8sdFkdWb9Z4XN1TkNtRnmYl6eGdBTlAQL1QU6A6+
         h3j3N5z+i7eMl6UQrpu7gkfk71+6Idcx3samoC37qlsKhX4ZycoX7InYDgwlG8BOxklh
         zjESCPe6/qM+bLBB6CUIc+Z45OrXAVWeaQMFHBo9isLPz3FuKzTkFdzYXKRsCUo80svw
         S6bA==
X-Gm-Message-State: APzg51AWlZszlJyXXfBYgXHXxjUhyzTO9Jp1CUyqObGcAmor6DDlAu3R
        90UFcWrriB4cGsKQrSuu6ylKog==
X-Google-Smtp-Source: ANB0Vdb4Q9jJ+z7quktIxKzIYdk1Qj2FQtA4692jqN6AjvmDcmBOBLb8rQgKVWJgatmi8vqpzUq2wA==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr8797692wrd.67.1535968647975;
        Mon, 03 Sep 2018 02:57:27 -0700 (PDT)
Received: from boomer (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id c8-v6sm23368264wrp.33.2018.09.03.02.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 02:57:27 -0700 (PDT)
Message-ID: <b0efc5cf9cf4f7e05097fcd0ea6fd61ba8ff3476.camel@baylibre.com>
Subject: Re: [PATCH 2/3] arm64: dts: meson-axg: s400: add dmic codec
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree <devicetree@vger.kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 03 Sep 2018 11:57:25 +0200
In-Reply-To: <CAOMZO5BOMOB6LaRs1fnmm-Ghu7pMkXW=sH_NOEWK3pqHAbUMCg@mail.gmail.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
         <20180831150218.8307-3-jbrunet@baylibre.com>
         <CAOMZO5BOMOB6LaRs1fnmm-Ghu7pMkXW=sH_NOEWK3pqHAbUMCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-09-01 at 18:24 -0300, Fabio Estevam wrote:
> Hi Jerome,
> 
> On Fri, Aug 31, 2018 at 12:02 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > There are 7 digital mics on the MIC daughter board attached
> > to the s400 board, so add the digital microphone codec to
> > its DTS
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > index ff64c429d432..f3e16cbbc61e 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > @@ -86,6 +86,15 @@
> >                 sound-name-prefix = "DIT";
> >         };
> > 
> > +       dmics: audio-codec@3 {
> 
> You pass @3 without a corresponding reg = <3>, which causes dtc
> warnings with W=1.

Hi Fabio,

Thanks for pointing this out.
Martin also raised concerns about this but, unfortunately, we did not get to the
bottom of it:

https://lkml.kernel.org/r/
90780f5a6b974ee9a4f9f9f2580fc83ef6bdd805.camel@baylibre.com

In a nutshell, I numbered nodes (w/o a reg prop) to keep generic names as
suggested in the DT spec.

The idea came after working on sound cards, if you check
Documentation/devicetree/bindings/sound/simple-card.txt, you'll see this kind of
numbering is even in documentation examples.

This is used by arch/arm/boot/dts/armada-370-db.dts. This is just an example I
picked randomly, I'm not trying to single out the marvell folks here (or ASoC
simple card). I'm actually doing exactly the same kind of multi link stuff on
the amlogic cards.

This looks to be a wide spread practice. Running `make dtbs W=1` on ARM and
ARM64 arch, I've seen dozen of 'node has a unit name, but no reg property'
examples, on things like clocks, buttons, leds, pinctrl, etc ...

that being said, section 2.2.1 of the DT specs says:

" If the node has no reg property, the @unit-address must be omitted and the
node-name alone differentiates the node from other nodes at the same level in
the tree "

So apparently, this is used but not ok ?
Maybe we should simply replace the '@' with a '-' everywhere this occurs ?

If possible, I'd like to get the opinion of the DT gurus about this issue.
Cheers

Jerome


