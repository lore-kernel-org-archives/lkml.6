Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B08C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B213820881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FXaLgCSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B213820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeGIWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:08:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38077 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbeGIWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:08:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so38860359oie.5;
        Mon, 09 Jul 2018 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/niSlCth5FghZbg9hcQawgapHVokC65lwSiBnmBvnzg=;
        b=FXaLgCSEBsR0iDdVTdj8Fb7ykBljbPPl8M6eEjWARkHBJ8BGKQ5NEs1nUY01UI2DVH
         CfO5tvi6VF0E3V+AL7DQ/2XsojvsKpjzQboeyAUToOWuBf2dVe3NoATHpaktw5gOun0K
         PRBbGqX2TIRuk4/woS6M9mGTB33Rw1MjlyvYXkwWqlMX25vlsWFzKKYX4SsDUgj+awAt
         sdrX/Xojzm5coxyJkdgt3wPWDkCOBYs6E9PyeGIFNxLp+lsldtHvfni19vNHlm0Rf3xY
         JE4aLTSrpDdJ0iCZt8URlTGiDQPzFAIQFp/5BIHu/JucDSQ+qfBi8NMPYb0hteqgCoek
         Vh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/niSlCth5FghZbg9hcQawgapHVokC65lwSiBnmBvnzg=;
        b=YVQYfQLDa75/rJZZVn7UxPVCaz3w9WHZsFljRXkv9vgV5SAwO+ZW/pe0IhfcfpgLF4
         8GYPNNVidO8OW1yRpK5bb8sBIf33Q0BpbhjifB6zsbfDO2dF2pBW8752Ob5Vsrue5I/M
         MxmKBQQHOK99RkaRX4fYATTlR8RSQ+/sWczIy3okhlp15KDbrFSHfthLmef4AQpWK2iU
         ECKPX6+3JXuTCbezzNlWLqAbNGLOSrzJ1fAAXivfAXkC3hyEkbzjsCfchJhVCmBmf3Y4
         IhgNJVXPYRgh+puV6ki6D6qs8X7QQJF/9/aj42orwgC7aVXAwqg8DeqgMkFlb/ES+g6J
         iMMg==
X-Gm-Message-State: APt69E038IQ2kTjYDJaBe1pWE59KCWim7CHslI+hO5cQfZX0KPvbIxRb
        rYZwvSbpS+rwJ5v5p+lXvez1Bc5+tpG0ZZyxdLM=
X-Google-Smtp-Source: AAOMgpd8I25/wcG9T1gD8AfMIQGKd/NoQ/EIan1HiHIGJcQiCqOmNudGyyIXLm8M7AM2FF0N222FrpN9JTy7vYq/4kU=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr1008942oih.65.1531174084758;
 Mon, 09 Jul 2018 15:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180704224511.29350-1-yixun.lan@amlogic.com> <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
In-Reply-To: <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 10 Jul 2018 00:07:53 +0200
Message-ID: <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
To:     linus.walleij@linaro.org
Cc:     yixun.lan@amlogic.com, carlo@caione.org, b.galvani@gmail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, robh@kernel.org, xingyu.chen@amlogic.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Jul 9, 2018 at 3:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jul 4, 2018 at 4:48 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
> >
> > This patch series try to add pinctrl driver support for
> > the Meson-G12A SoC.
> >
> >
> > Yixun Lan (3):
> >   documentation: Add compatibles for Amlogic Meson G12A pin controllers
> >   dt-bindings: pinctrl: meson-g12a: document pin name
> >   pinctrl: meson-g12a: add pinctrl driver support
>
> Overall this looks good to me, could we get some review or ACKs
> from Beniamino, Martin and/or Carlo as an indication that everything
> seems all right before I apply the series?
I do not have any documentation for this hardware (I'm not even sure
if this is the successor to AXG/"the Audio SoCs" or rather a successor
of GXL or GXM/"the OTT/STB SoCs" - I assume it's their new OTT/STB
SoCs since G12A is mentioned here and it seems to have a GPU: [0])

I will try to have a look in the next few days and see if I can spot
anything obvious
not sure if Neil or Kevin have access to the documentation, so it'd be
great if they could give feedback as well


Regards
Martin


[0] http://openlinux.amlogic.com:8000/download/doc/Linux_BSP_Kernel4.9_Buildroot_OpenLinux_Release_Notes_V20180330.pdf
