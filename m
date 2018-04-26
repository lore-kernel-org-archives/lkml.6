Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827469-1524760948-2-3546333425182892092
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524760946; b=DFrmPQ5vtnAFhPV81OqHK3CmHVsb61pvvGnCpV3MfEF8JHgLjH
    wsfnzoyTWiN9gKg/K/Dzu6fOf7aOSg8RuHC61MVDl56sJ2JIxOvMqfZINGiME1Zs
    2HCG4PNDF+b0fDZbwvDtRk+++peapjy+Dj7jSVVHMmXs+QWsUk6zbf0SA0/RK/cj
    u9Ij4v/6dzCEuQ6VrgUAqTirjouCXE4tEah96S4ZpNkmrw42jNF9vS7RPC0tPAV7
    atdPVxjrVtFwQLalL4ij78yoR/qA2Gynet+OAmaYXDZC4hm7W9T28h/i0Jnz3X36
    PR9/ap/86Cy7zfOHVZ7ClO+L2wB8+vt+7U7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524760946; bh=rKckH8EeSPVp+01s0RzBQQ9nlr+U1+
    7fREAL5X0K7t8=; b=hF2zk1idL/VJIKV14lnJG4FRRtYZxMnbzfPCOEmvq577/M
    oxSMa/1UM5HUaZQbkBI16Naij/lR724eqMWL6AZHzDXLFKHnM5xniK+c9UGHmMK0
    2coZejQJiY9eFIflJSdSs265DylyjdwUVLVuTcMQwo3iTJaEKcoUAbSkTEev/ifE
    bhXm1k8H0YYIsmbrj9lrFkc1+qB4Ubl9veOpezK1IgRXe49CTXW/ajEZB6WaHdsk
    qGOWE0kQEadjs3tiU/DGhrIFeP8C8Be8OFkqXmhLtdBTAKc4AH/vJGOP4uCNFZ0r
    waS7K+iek11VeBoxjYQbzlwt+R3mgyigU9BQ/f0Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kXRWuKBM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oEx8FqPU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kXRWuKBM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oEx8FqPU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOzcog17tHJFyQT4XKPwUAt055fpMXURzfi0JxAXHGEiL3Quzspqz08gOzwOoEJRyTXIEWsdRwSugIvd57hKQPBsc2Saffx+AY4sa88EmjeBTVuHgSc5
    262s2Sz6ZrZxg6Zg2Phh1XlNq0xAIM3xPxy6FUeGJ0PXzKteODf/cVzwbf8xZd+sYIZEy/IxPRO7n6v/ALLFXy5kJJIXukfpORMQhd1Yrg8BSpKU1jHtG7CC
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=uNphubBhQK8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=rEqvwrX8AAAA:8
    a=VwQbUJbxAAAA:8 a=nx57h0buAAAA:8 a=Hnm2Hy9fAAAA:8 a=9GsWZIgIXkKqmLFYPnkA:9
    a=CjuIK1q_8ugA:10 a=2B8fXRCmRxTqFPaLtVU6:22 a=AjGcO6oz07-iQ99wixmX:22
    a=YtO9EDU9lxz8Tya6zqt4:22 a=qByqzKpv1oajCkFmDuv_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756431AbeDZQmY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 12:42:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38064 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeDZQmW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 12:42:22 -0400
X-Google-Smtp-Source: AIpwx4/8Ou8h0rddVM9SY+2uaO49P97dq/60zWUl0xS/QbxEl1nkPqS2Nsxox8/Y65HExh/LiR87kg==
Date: Thu, 26 Apr 2018 09:42:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guenter Roeck <groeck@google.com>
Cc: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, "# v4 . 10+" <stable@vger.kernel.org>,
        nick@shmanahar.org, Benson Leung <bleung@chromium.org>,
        Salvatore Bellizzi <lkml@seppia.net>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad
 button mapping for the Caroline Chromebook.
Message-ID: <20180426164218.GA162443@dtor-ws>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
 <20180425222650.GC200812@dtor-ws>
 <20180425225734.GD200812@dtor-ws>
 <ff623f6afb4e7910f3bb6d211f0f187f@vittgam.net>
 <CABXOdTeh3yLtsWxUCWFdpQNQReAmVDnuJh+T07X=YB3dq=uG1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTeh3yLtsWxUCWFdpQNQReAmVDnuJh+T07X=YB3dq=uG1Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 06:45:32AM -0700, Guenter Roeck wrote:
> On Wed, Apr 25, 2018 at 10:37 PM, Vittorio Gambaletta (VittGam) <
> linuxbugs@vittgam.net> wrote:
> 
> > Hello,
> >
> > On 26/04/2018 00:57:34 CEST, Dmitry Torokhov wrote:
> > > On Wed, Apr 25, 2018 at 03:26:50PM -0700, Dmitry Torokhov wrote:
> > >> On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam)
> > wrote:
> > >> > This patch adds the correct platform data information for the Caroline
> > >> > Chromebook, so that the mouse button does not get stuck in pressed
> > state
> > >> > after the first click.
> > >> >
> > >> > The Samus button keymap and platform data definition are the correct
> > >> > ones for Caroline, so they have been reused here.
> > >> >
> > >> > v2: updated patch offset after 20180409 changes.
> > >> >
> > >> > Cc: stable@vger.kernel.org
> > >> > Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
> > >> > Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
> > >> >
> > >>
> > >> Applied, thank you.
> > >>
> > >> > ---
> > >> >
> > >> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > >> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > >> > @@ -3035,6 +3035,15 @@
> > >> >            .driver_data = samus_platform_data,
> > >> >    },
> > >> >    {
> > >> > +          /* Samsung Chromebook Pro */
> > >> > +          .ident = "Samsung Chromebook Pro",
> > >> > +          .matches = {
> > >> > +                  DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> > >
> > > I've been alerted that shipping BIOS has vendor not capitalized; where
> > > did you get the firmware that has vendor all capitals?
> >
> > Upstream coreboot and mrchromebox's coreboot, which do support loading
> > Linux
> > natively or with UEFI, both use capitalized GOOGLE as DMI System Vendor
> > as far as I know.
> >
> > By the way, the shipping BIOS (coreboot customized by Google) does not
> > support
> > mainline Linux natively (eg. without seabios and nasty tricks), but only
> > Chromium OS, which for Caroline is an old 3.something fork of Linux, so
> > this
> > patch does not really apply to Chromium OS or to Linux running on shipping
> > BIOS.
> >
> > Can you provide details or a pointer to it ? The mainline kernel boots
> fine for me (with a ChromeOS distribution), with the exception of the
> Google/GOOGLE problem.
> 
> 
> > Anyway if I recall correctly, the DMI System Vendor should be GOOGLE in
> > Google's coreboot for Caroline too, but I'm not 100% sure and cannot check
> > right now.
> >
> >
> FWIW, the DMI system vendor is "Google"  in my Caroline. I'll dig up
> configuration files later today - maybe it was changed to "GOOGLE" at some
> point and I have an old Bios in my system.

I believe all shipping BIOSes use "Google" as vendor, as it is what is
specified in src/mainboard/google/Kconfig::MAINBOARD_VENDOR and our
configs/build scripts do not override it.

I do not know why we have this difference.

> 
> Thanks,
> Guenter
> 
> By the way please note that this is the DMI System Vendor and not the DMI
> > BIOS version string, which indeed starts with "Google_" in the shipping
> > BIOS
> > (but not in coreboot, see f56db262e46d3368ee4e5c9e19797853cab382cd).

Hmm, I just tried checking out tree from
https://review.coreboot.org/coreboot.git and do not see this commit:

dtor@dtor-ws:~/coreboot $ git show f56db262e46d3368ee4e5c9e19797853cab382cd
fatal: bad object f56db262e46d3368ee4e5c9e19797853cab382cd
dtor@dtor-ws:~/coreboot $ git log --oneline -1 HEAD
82d0f91420 (HEAD -> master, origin/master, origin/HEAD) soc/intel/apollolake: enable exception handling in every stage for glk      

Anyway, if you are overriding the shipping BIOS, then please adjust
coreboot to use device-tree compatible bindings (via PRP0001 HID and
_DSD properties - you can check out bindings for PENH device in Caroline
to see how they can be used). This way we would not need to breed DMI
quirks.

Thanks.

-- 
Dmitry
