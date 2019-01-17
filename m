Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3253C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99ABC20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gomQyUPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfAQWme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:42:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47091 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfAQWme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:42:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so7484465oif.13;
        Thu, 17 Jan 2019 14:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oA/l91TG8ETDak797MOk1KTEdnhvwZuqadQ+xYGHSb8=;
        b=gomQyUPNQqGZ9dH4ylz4ZA4h+lyFageSXjzbbxNey062bSTs4jGBPwPRIL7RqnQrox
         Bg/M+w3hgeWWP7O0WJNESi8fEy+kLHOnCibttWx6yP8515MaqH73FD3xQzqDvMuRuNQE
         YLQA7wlbEKkoyPwbOtikIzoRXo3TqZD4lyXhmJjc1nBA0N2l9WAjOg3c9O/XLK0omeM9
         BnF7LPSSob+W2FwYulNi2gGA8mUzPQNrEwz/Y1LEuGWknfzqcga6cE7hvXwjFUpnflS9
         YvdudD/vog+5ogCjAMiTvG/6Ilwn0cmNx9nWOnJjWWDgjnik4bmunG2UectNdRLcSWaR
         oZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oA/l91TG8ETDak797MOk1KTEdnhvwZuqadQ+xYGHSb8=;
        b=HfdMscqS45OZRG8Q/buYscZIwD8Wul17dFKZQSmA0o1B9z2N63cVQiR5rC4XoTIOuY
         5CKiukFZG0ySBkTMxXvQBvlM2ncRCpQYS/5gh13VtwZPVFZVqfbntjSrkwRRfj7wKvlB
         7n5es1Z/fFsndtY8iVkQQLo/qp9e3AZZMu0/roxV6YIJOUfOa18Ze3/S/eEE0h88Qagp
         jHoNff5xeRv6Cz45tj8oWlyD33+wO3I4HvOEA7MIs0uwgac3SyzHhIl71Rz1ZOhwtxmj
         sK7Yw9p8QP3G7sopyVmqCY498mJ4xmUObdqfv95OlpbCGa2NrG/pIN+1EB0cGNmelaTZ
         37pA==
X-Gm-Message-State: AJcUukfwP6kNUZq59EVrTFfK11ddHhexsRE9jXEN+KfcH82hO2u2kUyt
        oHo5HzIX1PVz1qOXrQvLV/wxayRBbz6s+NtTXbnSs/LC
X-Google-Smtp-Source: ALg8bN4ce1GOYhgH8RZqMF0zH5Yw7nq+HwvXdPGiR1D/KxE0wvI5mn37r8aUXJw+ipKHdYnaKgxPMIhkSXX8hH3VjzY=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr4583642oib.41.1547764952828;
 Thu, 17 Jan 2019 14:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20190116165236.8330-1-jbrunet@baylibre.com> <CAFBinCBFge2tir-MXw+ojTxzW+7n9Uf4FzCahrw0MDzAYV2SSg@mail.gmail.com>
 <f7289814e316ad5879848fb8c379db396f615828.camel@baylibre.com>
 <CAFBinCDhryOWHmRKp7GhWp2O+NpJziEgHoUE4HKVitTPDMrrBQ@mail.gmail.com>
 <ba1f56258e7873041a0f75996e376170563c9e6e.camel@baylibre.com>
 <CAFBinCAdJu2C-LWspiHR4vVr=PUD2HGNi4zz+CSJP96ZE4GoJw@mail.gmail.com> <0dcd4c655bd9477d7adf2c6e32a1f0ebab18cee0.camel@baylibre.com>
In-Reply-To: <0dcd4c655bd9477d7adf2c6e32a1f0ebab18cee0.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 17 Jan 2019 23:42:22 +0100
Message-ID: <CAFBinCBSxCMqhF+Tvw3DfBeXQzthT9U+QtWxmPA+1X+SwivFmA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:45 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Thu, 2019-01-17 at 22:20 +0100, Martin Blumenstingl wrote:
> > On Thu, Jan 17, 2019 at 9:39 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > On Thu, 2019-01-17 at 21:27 +0100, Martin Blumenstingl wrote:
> > > > OK, but we had incorrect documentation in the past. did you check this
> > > > with someone from Amlogic?
> > > >
> > > > I'm curious because there seem to be two different approaches here:
> > > > 1) hiubus name and offsets are being fixed within this patch
> > > > 2) aobus is being dropped here and re-introduced with a different name
> > > > later
> > > > on
> > > >
> > >
> > > because hiu exist and aobus does not, for which both the name and size was
> > > wrong
> > >
> > > > approach 1) can also be used for the "rti" region (at least in my
> > > > opinion, the patch doesn't explain why it can't be done):
> > >
> > > THe patch remove aobus (instead of fixing name and size) because, of the
> > > multiple region documented covered by this 'made region', I did not
> > > anticipate
> > > which one will be required and I did not want to add them all.
> > >
> > > Better to add them as needed, which is want I done for pinctrl as you
> > > pointed
> > > out
> > >
> > > > rename "aobus" to "rti" and change the size to either 0x1000 or 0xb000
> > > > (both values can be found in mesong12a.dtsi from
> > > > buildroot_openlinux_kernel_4.9_fbdev_20180706)
> > >
> > > RTI is added here:
> > > https://lkml.kernel.org/r/20190117103151.3349-1-jbrunet@baylibre.com
> > >
> > > I don't really understand the problem ? result is the same
> > the actual problem is "me" as I have conflicting information:
> > - Amlogic's buildroot kernel (for G12A) uses similar bus definitions
> > as the GX SoCs (for which there are public datasheets) - this is how
> > Jianxin added it to meson-g12a.dtsi originally
>
> And it was the same for the GX family. AOBUS in the DT while there nothing
> about this in the memory map. Keep wrong patterns does not make them right.
>
> I'm merely reading the memory map here
can you explain which "memory map" you are reading exactly?

my source is the "memory map" section in the public S905X and S912 datasheets:
- "S912_Datasheet_V0.220170314publicversion-Wesion.pdf" page 48
- "S905X_Datasheet V0.3 20170314publicversion-Wesion.pdf" page 43

> > - this patch does it different - but cannot check if this is correct
> > (no public datasheet is available for G12A or AXG) nor do I have a
> > "big picture" of upcoming changes
>
> Yes it does it differently. We should have picked up on this a while ago,
> since gxbb at least, and we did not. There reason to create bus that don't
> exist in the memory map of any recent SoC.
in the GXL and GXM datasheets from above there is:
range: 0xC8100000 - 0xC81FFFFF
name: RTI

thus in my opinion, based on the two datasheets from above:
- the bus definition (start, size) in meson-gx.dtsi is fine
- probably have the wrong name for this bus in meson-gx.dtsi
- (assuming that GXBB, GXL and GXM are all the same - I only compared
the last two)

> Creating bus should at least require a start and end offset explained
> somewhere. Copying vendor DT is not enough
I fully agree on this one!


Regards
Martin
