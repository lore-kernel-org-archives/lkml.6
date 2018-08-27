Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C214C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC735208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRhSayuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC735208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH0RO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:14:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36908 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeH0RO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:14:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so12352681ljk.4;
        Mon, 27 Aug 2018 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=STeny4papD9J8QVXm0sMEfiIam3kpb9dFMOWyPKtg/c=;
        b=VRhSayuRVHgC4kXYIC9nr2l7cdjTd+0sO0yvs3cAyqe0DXXJxdt/kNT86FWdWhtDCt
         vsYFowkmdYhZg/wAhcpob3oJrAEmnYcORNwRMkgG1fz+Ba2fAWVdRQ049hA3cTbkGcwy
         wH4rGyYZMcligGheKqLYY/ZCzmRdj92FoYPvul97yBl7PAftU8Sa08vdGhyO+Z4VlqAE
         sEUmvzQBh1clIpeSRmeu6TjxvxFHZFdIoeeEI6wz6EhAlyYpgwqc8wKL5pFurrTuO+lD
         O80KQOz6/Fgi8cVrkRJhXBpT6RVyelyIUlXTwuyFvsBBNKHyYQH+88TKneG4yRJ8+cD2
         Cb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=STeny4papD9J8QVXm0sMEfiIam3kpb9dFMOWyPKtg/c=;
        b=Xfz9XJqjysEi6K12blwCSVgGvnB6EuVHEunfFvW4dlkaZAHRtluy/2PvPXGuSLLPRH
         YLfx295Cd6/9nEFMPFETK2/EHORL7BMl/Du2OYl0S6xjGhq1omWE/v0Lmwb7lhuB26QG
         no8wETb8Q2nbH83cniFkVsdi71NRZEEIhUqTsi29x7KEP9h4bOdnpr35hPSHIij6Kbn6
         2jUN/hNUcJy8XdOuGhEr/Bof1FqUDIeIoGKS1F40mNg9UdW++sY0A0KB8BhHxS0x3QIr
         t6ZkoLhLB9vo/CUyyWTwdJ8ZOlETlwGmgR7X2e8jl0vooi4Dd5RHRY2ENgERSlEyUBOd
         lGlg==
X-Gm-Message-State: APzg51AFDYlWmeBI34q2NkZBKf9G+0y5aaJDPooYT49/0VfENCTlhRXl
        awNey0Ru6kU9icUB80binIM=
X-Google-Smtp-Source: ANB0VdbGiMANCTGkG03e/mzXNlQ4Pm0S0prjvTVhr7is0+hY6OYxjLQX8lLK/407t/ZxbPvx+IKfvg==
X-Received: by 2002:a2e:2d2:: with SMTP id y79-v6mr8318389lje.100.1535376496136;
        Mon, 27 Aug 2018 06:28:16 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v62-v6sm2859287lfa.51.2018.08.27.06.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 06:28:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuHZ1-0001eP-2m; Mon, 27 Aug 2018 15:28:15 +0200
Date:   Mon, 27 Aug 2018 15:28:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Lars Melin <larsm17@gmail.com>
Subject: Re: [PATCH] option: Do not try to bind to ADB interfaces
Message-ID: <20180827132815.GD14967@localhost>
References: <20180723140220.7166-1-romain.izard.pro@gmail.com>
 <20180723140801.GA4835@kroah.com>
 <CAGkQfmPbuK7-f=9GcvQPH6mkHXwsaGpjqv40DLgFUJmbOCpbgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGkQfmPbuK7-f=9GcvQPH6mkHXwsaGpjqv40DLgFUJmbOCpbgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 06:45:22PM +0200, Romain Izard wrote:
> 2018-07-23 16:08 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > On Mon, Jul 23, 2018 at 04:02:20PM +0200, Romain Izard wrote:
> >> Some modems now use the Android Debug Bridge to provide a debugging
> >> interface, and some phones can also export serial ports managed by the
> >> "option" driver.
> >>
> >> The ADB daemon running in userspace tries to use USB interfaces with
> >> bDeviceClass=0xFF, bDeviceSubClass=0x42, bDeviceProtocol=1
> >>
> >> Prevent the option driver from binding to those interfaces, as they
> >> will not be serial ports.
> >>
> >> This can fix issues like:
> >> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=781256
> >>
> >> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> >> Cc: stable <stable@vger.kernel.org>
> >> ---
> >>  drivers/usb/serial/option.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> >> index 664e61f16b6a..f98943a57ff0 100644
> >> --- a/drivers/usb/serial/option.c
> >> +++ b/drivers/usb/serial/option.c
> >> @@ -1987,6 +1987,12 @@ static int option_probe(struct usb_serial *serial,
> >>       if (iface_desc->bInterfaceClass == USB_CLASS_MASS_STORAGE)
> >>               return -ENODEV;
> >>
> >> +     /* Do not bind Android Debug Bridge interfaces */
> >> +     if (iface_desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
> >> +             iface_desc->bInterfaceSubClass == 0x42 &&
> >> +             iface_desc->bInterfaceProtocol == 1)
> >> +             return -ENODEV;
> >
> > Shouldn't you also check the vendor/product id as well?  Otherwise this
> > has the potential to match random devices that are not really adb
> > devices.
> 
> The only random devices are those that already match with the option driver,
> either with the whole device or the whole reserved class. It reduces the
> amount of potentially affected devices.
> 
> Among those, I do not expect any of them to use 0xff,0x42,0x01 for a
> serial port. But if it occurred, it would be necessary to revert this change as
> no userspace hack would allow to rebind the interface.

Yeah, but by that time we may have added (or enabled) devices that rely
on this general rule so we'd need to start adding exceptions to this
negative matching rule instead...

> As this is only an intuition, please discard this patch if you have any doubt
> about this.

Bjørn also suggested that we at least consider adding a rule like this a
few months ago (when I changed the blacklist implementation). I just
never got around to look into it.

It would allow for simpler device-id entries, at least when ADB is the
only blacklisted interface, and may enable ADB for some older entries.

On the other hand, interface class 0xff is indeed supposed to be vendor
specific as Lars and Greg pointed out, and with status quo we don't
cause any regressions. If ADB isn't currently available for some device
due to option binding to that interface, we'll just blacklist it as soon
we get a report.

So personally I'm not sure it's worth it, but I don't have a strong
opinion on the matter either.

Johan
