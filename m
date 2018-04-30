Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732904-1525109947-2-18286457030065044324
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
    1525109946; b=PbcHXesLAkRZAULWngBbXs1gxaiom78En4j+2umxQFdcd8g8yo
    Jtmo6uUeycHixt8rWYu7n1RQgPjlb74m1XaH3ryzy1deBdHFKH/JpUSDjbeHAOBk
    c5FwSgDhxDm/ftRxokzj3enYxMaGz7KF0LsYyewy69C1xBOSUaZnaScSTkQgGwkY
    GGpFdv4fKTEgBDWJ3uSk34ULZ4aAGah+ybsy00KyF2yNZivzzMQWgsyCsyHTRHsH
    aC4StY9F+HMCS0e+OSGgZVIDjxb+UoBrOA3J8/Wg8YHcOWCd0WRlkFPINDhIgRu/
    bb1Av3kl+GTRokl/NJrxqLvuSarCKaRHJixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525109946; bh=gQRzXSSs8Z1FSRkZrQTaBqTYXjxgsm
    HHKtslcAwy6Ts=; b=MzyLgheRvN49Ub1vaoT4iAMw/1zMkF2l7ZyUitBSb4UMB0
    yi1LCNGVqrjtVOR8hdq2PKMtaZ725d6OmAmZMU1veFnjvsK4UC6torORUOY6WSZ7
    Rqf20sgwsijfKSIK2amISDFwrmoVBIXAFtqIifZN2sDbvYSNTNTm3oar8zZKzpCz
    NYzliwGHvApggxE3NMT4evjC8l3JuO7V55VnajKs4gqMWgsggB8niQZQw1dOFLu5
    mFCUYWieK2OXc239k0TO4vNnQ28pedF8KYSvSzK2YLjslTnmfQRZV3xgw8sdBagP
    XH67A5VVwxxuwC8JR2Q9eZnebGE3fGjSMowpqA+g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lP/CA8ZS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NaMZhFQS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lP/CA8ZS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NaMZhFQS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOK+N86kiRjxDuzEH71R0ax1+WZEAsmKaiuINL0BBRZoEvtJDh/6Gmwr94gq3PwjxXEYWbWerBYSFZoTt6NlF/jqPAf+ibPHTYcDfWNOj9b2MY3p8eez
    pJwk4kt8BzFyHQs/tnbr3zGBgaIe1QhVJbuCzlWWDhYfqF0BhrNfAUrUyYAzp5kzaQFitljGlLkYqU0D4uyckpi187hv90mc/1E3+SnsLRX71dwMHhO/SaPh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=uNphubBhQK8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=rEqvwrX8AAAA:8
    a=VwQbUJbxAAAA:8 a=nx57h0buAAAA:8 a=Oh2cFVv5AAAA:8 a=Hnm2Hy9fAAAA:8
    a=g5PMGtGlqAObSojLS5IA:9 a=CjuIK1q_8ugA:10 a=2B8fXRCmRxTqFPaLtVU6:22
    a=AjGcO6oz07-iQ99wixmX:22 a=YtO9EDU9lxz8Tya6zqt4:22 a=7KeoIwV6GZqOttXkcoxL:22
    a=qByqzKpv1oajCkFmDuv_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeD3RjE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 13:39:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40248 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeD3RjD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 13:39:03 -0400
X-Google-Smtp-Source: AB8JxZoPxW0smboHN4jo+ctcFbSw1iqGHhsxgEiEDjdzW5BsU/UfFy5tUANPFgziCVRDl2AK03zMmQ==
Date: Mon, 30 Apr 2018 10:38:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Cc: mrchromebox@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, "# v4 . 10+" <stable@vger.kernel.org>,
        nick@shmanahar.org, Benson Leung <bleung@chromium.org>,
        Salvatore Bellizzi <lkml@seppia.net>,
        Guenter Roeck <groeck@chromium.org>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad
 button mapping for the Caroline Chromebook.
Message-ID: <20180430173859.GA54182@dtor-ws>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
 <20180425222650.GC200812@dtor-ws>
 <20180425225734.GD200812@dtor-ws>
 <ff623f6afb4e7910f3bb6d211f0f187f@vittgam.net>
 <CABXOdTeh3yLtsWxUCWFdpQNQReAmVDnuJh+T07X=YB3dq=uG1Q@mail.gmail.com>
 <20180426164218.GA162443@dtor-ws>
 <843bf017fd211cd97ffab30e0d5a4e73@vittgam.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843bf017fd211cd97ffab30e0d5a4e73@vittgam.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 01:44:07AM +0200, Vittorio Gambaletta (VittGam) wrote:
> Hello,
> 
> On 26/04/2018 18:42:18 CEST, Dmitry Torokhov wrote:
> > On Thu, Apr 26, 2018 at 06:45:32AM -0700, Guenter Roeck wrote:
> >> On Wed, Apr 25, 2018 at 10:37 PM, Vittorio Gambaletta (VittGam) <
> >> linuxbugs@vittgam.net> wrote:
> >>
> >> > Hello,
> >> >
> >> > On 26/04/2018 00:57:34 CEST, Dmitry Torokhov wrote:
> >> > > On Wed, Apr 25, 2018 at 03:26:50PM -0700, Dmitry Torokhov wrote:
> >> > >> On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam)
> >> > wrote:
> >> > >> > This patch adds the correct platform data information for the Caroline
> >> > >> > Chromebook, so that the mouse button does not get stuck in pressed
> >> > state
> >> > >> > after the first click.
> >> > >> >
> >> > >> > The Samus button keymap and platform data definition are the correct
> >> > >> > ones for Caroline, so they have been reused here.
> >> > >> >
> >> > >> > v2: updated patch offset after 20180409 changes.
> >> > >> >
> >> > >> > Cc: stable@vger.kernel.org
> >> > >> > Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
> >> > >> > Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
> >> > >> >
> >> > >>
> >> > >> Applied, thank you.
> >> > >>
> >> > >> > ---
> >> > >> >
> >> > >> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> >> > >> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> >> > >> > @@ -3035,6 +3035,15 @@
> >> > >> >            .driver_data = samus_platform_data,
> >> > >> >    },
> >> > >> >    {
> >> > >> > +          /* Samsung Chromebook Pro */
> >> > >> > +          .ident = "Samsung Chromebook Pro",
> >> > >> > +          .matches = {
> >> > >> > +                  DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> >> > >
> >> > > I've been alerted that shipping BIOS has vendor not capitalized; where
> >> > > did you get the firmware that has vendor all capitals?
> >> >
> >> > Upstream coreboot and mrchromebox's coreboot, which do support loading
> >> > Linux
> >> > natively or with UEFI, both use capitalized GOOGLE as DMI System Vendor
> >> > as far as I know.
> >> >
> >> > By the way, the shipping BIOS (coreboot customized by Google) does not
> >> > support
> >> > mainline Linux natively (eg. without seabios and nasty tricks), but only
> >> > Chromium OS, which for Caroline is an old 3.something fork of Linux, so
> >> > this
> >> > patch does not really apply to Chromium OS or to Linux running on shipping
> >> > BIOS.
> >> >
> >> Can you provide details or a pointer to it ? The mainline kernel boots
> >> fine for me (with a ChromeOS distribution), with the exception of the
> >> Google/GOOGLE problem.
> 
> Hmmm, did you change the kernel on your ChromeOS system, or did Google update it?
> 
> My Chromebook was on 3.18 when I was still having stock Google Chrome OS on it.
> 
> This should be the relevant tree:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/release-R58-9334.B-caroline-chromeos-3.18

We normally just pull in a newer kernel into ChromeOS build for testing.
This usually works OK with x86 devices.

> 
> >> > Anyway if I recall correctly, the DMI System Vendor should be GOOGLE in
> >> > Google's coreboot for Caroline too, but I'm not 100% sure and cannot check
> >> > right now.
> >> >
> >> >
> >> FWIW, the DMI system vendor is "Google"  in my Caroline. I'll dig up
> >> configuration files later today - maybe it was changed to "GOOGLE" at some
> >> point and I have an old Bios in my system.
> > 
> > I believe all shipping BIOSes use "Google" as vendor, as it is what is
> > specified in src/mainboard/google/Kconfig::MAINBOARD_VENDOR and our
> > configs/build scripts do not override it.
> > 
> > I do not know why we have this difference.
> 
> Okay, so first of all sorry for the confusion.
> 
> The upstream coreboot still does not have Caroline support as far as I can tell.
> 
> Instead, I'm using coreboot by Matt aka Mr. Chromebox, who is working towards
> upstreaming all of Google Skylake boards, such as Caroline, into coreboot.
> 
> His default configs were overriding the CONFIG_MAINBOARD_SMBIOS_MANUFACTURER
> option as "GOOGLE" for every board, including recent ones which started to
> use "Google". I've contacted him about this, and at the end he will change
> the string back to "Google".

It appears that we have not been consistent with Google/GOOGLE ourselves
(across different products, not between different versions fir the same
product), but it would be great if 3rd party firmware matched the
shipping firmware in this regard, otherwise we'll have issues with DMI
matches.

> 
> >> Thanks,
> >> Guenter
> >>
> >> By the way please note that this is the DMI System Vendor and not the DMI
> >> > BIOS version string, which indeed starts with "Google_" in the shipping
> >> > BIOS
> >> > (but not in coreboot, see f56db262e46d3368ee4e5c9e19797853cab382cd).
> > 
> > Hmm, I just tried checking out tree from
> > https://review.coreboot.org/coreboot.git and do not see this commit:
> > 
> > dtor@dtor-ws:~/coreboot $ git show f56db262e46d3368ee4e5c9e19797853cab382cd
> > fatal: bad object f56db262e46d3368ee4e5c9e19797853cab382cd
> > dtor@dtor-ws:~/coreboot $ git log --oneline -1 HEAD
> > 82d0f91420 (HEAD -> master, origin/master, origin/HEAD) soc/intel/apollolake: enable exception handling in every stage for glk
> 
> Sorry, this was a Linux commit hash:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f56db262e46d3368ee4e5c9e19797853cab382cd

OK, I see. I'd say we should not have taken this in.

> 
> > Anyway, if you are overriding the shipping BIOS, then please adjust
> > coreboot to use device-tree compatible bindings (via PRP0001 HID and
> > _DSD properties - you can check out bindings for PENH device in Caroline
> > to see how they can be used). This way we would not need to breed DMI
> > quirks.
> 
> This should be the correct fix, at least for custom firmware.
> 
> As I said, the string in custom firmware will be changed to "Google", so it
> won't match the wrong quirk anymore.
> 
> Then the ACPI table in custom firmware (and upstream coreboot in the future)
> can be fixed too.
> 
> But with stock firmware the situation is unchanged: the touchpad would
> still not work correctly because it would be recognized as a touchscreen,
> since it wouldn't match any quirk and it wouldn't have the correct ACPI
> properties.
> 
> Because of this, should I still resend a touchpad patch v3 matching "Google"?

I can fix it up here, no need to resubmit.

> 
> Or will maybe Google integrate the ACPI fix into their stock version of
> coreboot too?

The PRP0001? No, as we do not currently have plans to move Caroline to a
newer kernel and 3.18 does not have infrastructure for generic device
properties. The pen binding was done when we were considering pulling in
generic device properties into 3.18, but later decided against it.

Thanks.

-- 
Dmitry
