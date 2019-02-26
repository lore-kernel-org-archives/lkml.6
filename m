Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3097D206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203904;
	bh=m6mHCPsQQZC8jTP1o4TOZRKOZ9xUmuI55O4V3gjdiiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=awiDGZTRK/7+jvT8Y33JJWS3/B1k2gdAvkwhNRuxFlB5zsEaextPfKQHFFn7Y+1K7
	 G7WBib3w/vR+qy5tWhOVLw/t3Kl4BfahmPr3mFb32zVPTPPFLY9wEGdbZYgDzi3+op
	 60emLkKMheEFHtc3gDwoSTrwK1kFzkoZPGjgtPKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfBZR6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfBZR6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:58:22 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD57921872;
        Tue, 26 Feb 2019 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551203901;
        bh=m6mHCPsQQZC8jTP1o4TOZRKOZ9xUmuI55O4V3gjdiiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RaJr0HfjehRTPbm+n9i0SK7AxsVAaKSJA6yIsH6PJoYPmh7ildBPV7bLfi+F4OklT
         7Pdiles7+DiYl5sB0qSYwZOTjW2U6aY8RKvJ6H0coifNwxtQSzWVBlZmLnBh09ljWR
         LAAJWPDbDNmmOUxJXH8TANagrln6zPD6SCQLeu0Y=
Received: by mail-qt1-f182.google.com with SMTP id j36so15921258qta.7;
        Tue, 26 Feb 2019 09:58:21 -0800 (PST)
X-Gm-Message-State: AHQUAuYtM1pU50fm5JgyZfQe/UomSWlfsLeXOI8r7+dG4WT/fZqrBCYU
        RUVCWJXdM9OGCAHxTu5APt0S/vA7Oi7/1UEEFQ==
X-Google-Smtp-Source: AHgI3IaIlxux6ndNLycxLYskECfc+KHXlgfc63Ia3E6tsy4xkUOwCE/jx8HpjJKNehCCHK6VNaJJjmS7HkPTnT8xgwg=
X-Received: by 2002:ac8:25d1:: with SMTP id f17mr18495684qtf.38.1551203900827;
 Tue, 26 Feb 2019 09:58:20 -0800 (PST)
MIME-Version: 1.0
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
 <20190225165307.GA26260@bogus> <d2473029-76a7-de2c-8ff5-9d065577f0b1@st.com>
In-Reply-To: <d2473029-76a7-de2c-8ff5-9d065577f0b1@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Feb 2019 11:58:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLKcJiZCUp1FW4E7-5uC8v1Af0TZsiPympX9HsYE1N_dQ@mail.gmail.com>
Message-ID: <CAL_JsqLKcJiZCUp1FW4E7-5uC8v1Af0TZsiPympX9HsYE1N_dQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add STM32 factory-programmed romem
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 3:14 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 2/25/19 5:53 PM, Rob Herring wrote:
> > On Wed, Jan 30, 2019 at 05:38:53PM +0100, Fabrice Gasnier wrote:
> >> Add documentation for STMicroelectronics STM32 Factory-programmed
> >> read only memory area.
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> >> new file mode 100644
> >> index 0000000..fbff52e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> >> @@ -0,0 +1,31 @@
> >> +STMicroelectronics STM32 Factory-programmed data device tree bindings
> >> +
> >> +This represents STM32 Factory-programmed read only non-volatile area: locked
> >> +flash, OTP, read-only HW regs... This contains various information such as:
> >
> > Several distinct types here. Does s/w need to know the difference
> > rather than just one generic-ish compatible? Access size restrictions
> > maybe? Ability to unlock and program?
>
> Hi Rob,
>
> The reading part is represented here as "st,stm32-romem" compatible, to
> simply handle read only access. I agree this could be a generic-ish.
>
> BUT the specifics are regarding the ability to unlock/lock and program.
> Access size can vary from one part to another (e.g. on stm32f4,
> reference manual sates: OTP area is divided into 16 OTP data blocks of
> 32 bytes. on stm32f7, OTP area is divided into 16 OTP data blocks of 64
> bytes.)
>
> In STM32MP15, both the read & write access through the BSEC are
> specific, represented by dedicated compatible.
>
> Do you wish I update the compatible to something like:
> "st,stm32f4-otp"
> "st,stm32mp15-bsec"
> ?

Yes, I think given the above that makes sense. We can always map
specific bindings to generic drivers, but not the reverse.

Rob
