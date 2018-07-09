Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DF8C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBBE20849
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CudhMX3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBBE20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbeGIWDG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:03:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40896 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeGIWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:03:04 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so38813224oie.7;
        Mon, 09 Jul 2018 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Cjxr5G5Y1GIBpOUfNW+gT1ntZISUPWUTZfcc9q89cs=;
        b=CudhMX3cM7mRIl9cD/A70tq1c+wrxdLpYI8D4IqUDUo82jK/7KWjvky/3DyqiRwzJc
         46QaiVRsK4ogLbKd+LJAhlD6hRJHpe3ZKlH2JoNgBHF9KAHoIZvkmXXlbRUWipqIr4bA
         dBc85i9A30cT6JX9K9plLRP12LsFVUaXFhxogPKp+PNQRwRGywPATMetGWlG2m0bYBaL
         t+19nyppjzfS5q4w7EcM5WmPhARmxiYgdQpGTFhRoEQQnfbDvvHPhK5KvQDMfP2q3CxX
         OvO/RjeccBuirCR5jYB9FwRgXUaqtKgVoP3Q2j+B2h0VE2gWBvN8mn7ILIklRtIzS4fq
         r09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Cjxr5G5Y1GIBpOUfNW+gT1ntZISUPWUTZfcc9q89cs=;
        b=uUQyEvtFPNxZJMRYeyxLMpv8KZK0XXnSLUZ2JepELY0r3d/0G5JE4TV3HKqDmoeS72
         kY/9DHcXtHWDN3bhyrg6Z1nwOMOsPge640JS9An7rJSgCfc/ynjOhTbPoINTZgDYTyZi
         7Z4ZBEJAtnvDCFlozxSeqmBNFTiyGhF/paRq9olpG4o4um9ifMhVu0e1Gk23bkQSWpxw
         iotjkLwkrwYVgGOZ2IglPJWNxpinJQWwVtSQJiwhINWLFCYujd7qUsXHfNQlnEf8T0BA
         5fDchvd33QbUwz4Lt6O+aOWIfoOOeEKhJu+lxwkN/JODtKoSpeLfkZfc766HdqFBOTax
         Uerg==
X-Gm-Message-State: APt69E2dmckTx3XGmKk/asZmhg/Kd0wes2Joo4rahbKw9WCgXWk5E/K0
        OBWHeDxvMAZKyV1TaGpXWTbbSyvl9phRbaVs1ec=
X-Google-Smtp-Source: AAOMgpdvbS3hvB0F8kk54AuVaG2Njk9lxuvx8PUUAwoymqS3xixj4MKCTO3yVfTh1IHTanldcqB7JWafksq7Ko3Mw1Q=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr992336oih.65.1531173783675;
 Mon, 09 Jul 2018 15:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180704224511.29350-1-yixun.lan@amlogic.com> <78da7e13-e80b-d714-86d0-7c5f6fc0d9f5@baylibre.com>
 <886462fa-1833-a99a-a2fa-5b7dd58341fd@amlogic.com>
In-Reply-To: <886462fa-1833-a99a-a2fa-5b7dd58341fd@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 10 Jul 2018 00:02:52 +0200
Message-ID: <CAFBinCCZzvn5XNiPHhYK+BxGw6J7KJxEuSXF9ZeT8cFi84FjRQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
To:     yixun.lan@amlogic.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        xingyu.chen@amlogic.com, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

On Thu, Jul 5, 2018 at 4:53 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> HI Neil
>
> On 07/04/18 22:57, Neil Armstrong wrote:
> > Hi Yixun,
> >
> > On 05/07/2018 00:45, Yixun Lan wrote:
> >> This patch series try to add pinctrl driver support for
> >> the Meson-G12A SoC.
> >
> > Thanks for submitting these patches.
> >
> > Can you explicit this patchset with more details on the G12A SoC family ?
> > It's relationship with AXG and the differences in term of pinmuxing with the other SoC families ?
> >
> I thought this was already discussed while we doing pinctrl driver for
> Meson-AXG SoC.
>
> Anyway, here it is:
>
> Starting from Meson-AXG SoC, the pinctrl controller block using 4
> continues bit to specific pin mux function, while comparing to old
> generation SoC which kind of using various length bits for the pin mux
> definition. The new design would greatly simplify the software model..
>
> for detail example, one 32bit register can describe 8 pins, and each of
> them has 0-7 value to set, start from value 0 to 7.
>
> partition the register into 8 parts:
> bit[3:0]
> bit[7:4]
> bit[11:8]
> bit[15:12]
> bit[19:16]
> bit[23:20]
> bit[27:24]
> bit[31:28]
>
>
> for each value:
> value == 0, means the pin is GPIO
> value = {1, 2, ... 7 } is one of specific PIN function
OK, so AXG and G12A use the same register layout -> thus the same
pinmux ops are re-used



> I could put this info into cover-letter or commit message?
if you have to resend this series anyways then it would be great if
you could add it to the commit description

> > Why is there a GPIOE bank within the AO controller ?
> >
>
> It actually sit in the AO domain, although it's sounds strange from the
> naming..
>
> I'm not sure if it's good idea to append a AO suffix? since the
> documentation just use the plain GPIOE
I am fine with plain GPIOE if that's what your internal documentation uses
it would be great if you could add a comment (or at least a note in
the commit message) indicating that this is how the hardware is
designed (initially I thought this was a bug since I have no
documentation for the G12A chipset)

Regards
Martin
