Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1748446-1525113841-2-9827397819154329752
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: subject='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525113840; b=RIQSdjz/d5mLOD+Dl1sXkKCYDZLo+bloGnWuX8gv5h3iQzJZCM
    4/d1Kj8PpkiJFaDx3z/Tvetbqlkw2lR9WSMHSjJ0TxbLDxdiYvXSIv1F9lzM+g1i
    r5uQb7sE1aaH4/dOHPcN6j5khZZCFbVQLEbmkUkwUb6HRwXQSUlvvsmHjUSadSm7
    RBuQWLR/RDf1gAiNtTfrJFu5LF3KJE7QxZXAXuTkKPItg4tlFdAWSwFXWXx8BMmI
    RdXUA4iy+1i6QKdKkIAvGTpyLlp7s4B8jL3FkeYX4M0wfgTT2nTO2DRXHgYt+Rdi
    obzST1bkTcNDVWd5fl0638IUYTmd4si2lIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type
    :content-transfer-encoding:date:from:to:cc:subject:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1525113840; bh=u
    UH+6dVlNw2HEqTGR2wGvIxjOc4M8rMDSpt43K8TwIA=; b=O+dKjbRReqIM7GMWw
    aBPLYhPjPLtosqwCWLY1I0vDihVHcaLVjMGSAm+Mw7sdUwib19SRZ7buLuleJLcc
    ndDIq/Gps1c0gX8oKrjSHQ2e2shx6WgW0vJtJwEUpNdX1doo9ErDpsP1m1gaW2xk
    tKcGY5jBfk5yVJtdOFphBFV6JK3/rp3pS8eAR6zSw2TbTi8Hl0BGUSlmxUQYiSFF
    N0J/sXejOVg+0jlS/fuq6ya43kxPnrh98Qim6VWVYbXJdjxIiHlyxpqE3OtOS25U
    XJAv0Tw6rY26SSLBWxJATJC0foX3XiXq0ueaNMO2zFt/dHUtYNiO3VJmXZYLL+9b
    NPhxQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (4096-bit rsa key sha256) header.d=vittgam.net header.i=@vittgam.net header.b=BM51KvVk x-bits=4096 x-keytype=rsa x-algorithm=sha256 x-selector=20150519;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=vittgam.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vittgam.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (4096-bit rsa key sha256) header.d=vittgam.net header.i=@vittgam.net header.b=BM51KvVk x-bits=4096 x-keytype=rsa x-algorithm=sha256 x-selector=20150519;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=vittgam.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vittgam.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMsYk5bzi18QGF7RG6NJd/K2CI+IbZPBDTBnU/Ed5FVxbPnVukxnSePA/HLojBNx9MdKy4zvvVSUGj1Y5l+9V7h949jtjSR6sSIyhCzodWJY67Yulosz
    iPZl9lCFk9AHF4MiFwk8w3S+D+zgzildHK+eqbS2Fd2qC54utpuluZwAA7rAZ9YhmP0xxhLboIDNDaa4cT9L4af9fJm8KmrB8PQiGpYHrRUl+StZAISt60R4
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=rEqvwrX8AAAA:8 a=VwQbUJbxAAAA:8 a=nx57h0buAAAA:8 a=Oh2cFVv5AAAA:8
    a=Hnm2Hy9fAAAA:8 a=V6RTdrMuzYjkX9DeaY4A:9 a=QEXdDO2ut3YA:10
    a=2B8fXRCmRxTqFPaLtVU6:22 a=AjGcO6oz07-iQ99wixmX:22 a=YtO9EDU9lxz8Tya6zqt4:22
    a=7KeoIwV6GZqOttXkcoxL:22 a=qByqzKpv1oajCkFmDuv_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeD3Sn4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 14:43:56 -0400
Received: from server1.vittgam.net ([213.239.197.142]:27020 "EHLO
        mail.vittgam.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752994AbeD3Snz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 14:43:55 -0400
X-DKIM: OpenDKIM Filter v2.4.2 mail.vittgam.net w3UIhlJG003918
X-VittGamMilter-Outgoing-SubjectPrefix: [linux-stable]
X-VittGamMilter-Outgoing-OriginalSubject: Re: [PATCH v2] input/touchscreen: =?UTF-8?Q?atmel=5Fmxt=5Fts=3A?=
 =?UTF-8?Q?=20Add=20correct=20touchpad=20button=20mapping=20for=20the=20Ca?=
 =?UTF-8?Q?roline=20Chromebook=2E?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Apr 2018 20:43:47 +0200
From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <mrchromebox@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>,
        "# v4 . 10+" <stable@vger.kernel.org>, <nick@shmanahar.org>,
        Benson Leung <bleung@chromium.org>,
        Salvatore Bellizzi <lkml@seppia.net>,
        Guenter Roeck <groeck@chromium.org>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v2] input/touchscreen: =?UTF-8?Q?atmel=5Fmxt=5Fts=3A?=
 =?UTF-8?Q?=20Add=20correct=20touchpad=20button=20mapping=20for=20the=20Ca?=
 =?UTF-8?Q?roline=20Chromebook=2E?=
In-Reply-To: <20180430173859.GA54182@dtor-ws>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
 <20180425222650.GC200812@dtor-ws> <20180425225734.GD200812@dtor-ws>
 <ff623f6afb4e7910f3bb6d211f0f187f@vittgam.net>
 <CABXOdTeh3yLtsWxUCWFdpQNQReAmVDnuJh+T07X=YB3dq=uG1Q@mail.gmail.com>
 <20180426164218.GA162443@dtor-ws>
 <843bf017fd211cd97ffab30e0d5a4e73@vittgam.net>
 <20180430173859.GA54182@dtor-ws>
Message-ID: <e3fa9a479fd513eaabfda3c011f7342c@vittgam.net>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On 30/04/2018 19:38:59 CEST, Dmitry Torokhov wrote:
> On Mon, Apr 30, 2018 at 01:44:07AM +0200, Vittorio Gambaletta (VittGam) wrote:
>> Hello,
>>
>> On 26/04/2018 18:42:18 CEST, Dmitry Torokhov wrote:
>> > On Thu, Apr 26, 2018 at 06:45:32AM -0700, Guenter Roeck wrote:
>> >> On Wed, Apr 25, 2018 at 10:37 PM, Vittorio Gambaletta (VittGam) <
>> >> linuxbugs@vittgam.net> wrote:
>> >>
>> >> > Hello,
>> >> >
>> >> > On 26/04/2018 00:57:34 CEST, Dmitry Torokhov wrote:
>> >> > > On Wed, Apr 25, 2018 at 03:26:50PM -0700, Dmitry Torokhov wrote:
>> >> > >> On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam)
>> >> > wrote:
>> >> > >> > This patch adds the correct platform data information for the Caroline
>> >> > >> > Chromebook, so that the mouse button does not get stuck in pressed
>> >> > state
>> >> > >> > after the first click.
>> >> > >> >
>> >> > >> > The Samus button keymap and platform data definition are the correct
>> >> > >> > ones for Caroline, so they have been reused here.
>> >> > >> >
>> >> > >> > v2: updated patch offset after 20180409 changes.
>> >> > >> >
>> >> > >> > Cc: stable@vger.kernel.org
>> >> > >> > Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
>> >> > >> > Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
>> >> > >> >
>> >> > >>
>> >> > >> Applied, thank you.
>> >> > >>
>> >> > >> > ---
>> >> > >> >
>> >> > >> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> >> > >> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> >> > >> > @@ -3035,6 +3035,15 @@
>> >> > >> >            .driver_data = samus_platform_data,
>> >> > >> >    },
>> >> > >> >    {
>> >> > >> > +          /* Samsung Chromebook Pro */
>> >> > >> > +          .ident = "Samsung Chromebook Pro",
>> >> > >> > +          .matches = {
>> >> > >> > +                  DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
>> >> > >
>> >> > > I've been alerted that shipping BIOS has vendor not capitalized; where
>> >> > > did you get the firmware that has vendor all capitals?
>> >> >
>> >> > Upstream coreboot and mrchromebox's coreboot, which do support loading
>> >> > Linux
>> >> > natively or with UEFI, both use capitalized GOOGLE as DMI System Vendor
>> >> > as far as I know.
>> >> >
>> >> > By the way, the shipping BIOS (coreboot customized by Google) does not
>> >> > support
>> >> > mainline Linux natively (eg. without seabios and nasty tricks), but only
>> >> > Chromium OS, which for Caroline is an old 3.something fork of Linux, so
>> >> > this
>> >> > patch does not really apply to Chromium OS or to Linux running on shipping
>> >> > BIOS.
>> >> >
>> >> Can you provide details or a pointer to it ? The mainline kernel boots
>> >> fine for me (with a ChromeOS distribution), with the exception of the
>> >> Google/GOOGLE problem.
>>
>> Hmmm, did you change the kernel on your ChromeOS system, or did Google update it?
>>
>> My Chromebook was on 3.18 when I was still having stock Google Chrome OS on it.
>>
>> This should be the relevant tree:
>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/release-R58-9334.B-caroline-chromeos-3.18
> 
> We normally just pull in a newer kernel into ChromeOS build for testing.
> This usually works OK with x86 devices.

Ok, nice to know!

>> >> > Anyway if I recall correctly, the DMI System Vendor should be GOOGLE in
>> >> > Google's coreboot for Caroline too, but I'm not 100% sure and cannot check
>> >> > right now.
>> >> >
>> >> >
>> >> FWIW, the DMI system vendor is "Google"  in my Caroline. I'll dig up
>> >> configuration files later today - maybe it was changed to "GOOGLE" at some
>> >> point and I have an old Bios in my system.
>> >
>> > I believe all shipping BIOSes use "Google" as vendor, as it is what is
>> > specified in src/mainboard/google/Kconfig::MAINBOARD_VENDOR and our
>> > configs/build scripts do not override it.
>> >
>> > I do not know why we have this difference.
>>
>> Okay, so first of all sorry for the confusion.
>>
>> The upstream coreboot still does not have Caroline support as far as I can tell.
>>
>> Instead, I'm using coreboot by Matt aka Mr. Chromebox, who is working towards
>> upstreaming all of Google Skylake boards, such as Caroline, into coreboot.
>>
>> His default configs were overriding the CONFIG_MAINBOARD_SMBIOS_MANUFACTURER
>> option as "GOOGLE" for every board, including recent ones which started to
>> use "Google". I've contacted him about this, and at the end he will change
>> the string back to "Google".
> 
> It appears that we have not been consistent with Google/GOOGLE ourselves
> (across different products, not between different versions fir the same
> product), but it would be great if 3rd party firmware matched the
> shipping firmware in this regard, otherwise we'll have issues with DMI
> matches.
> 
>>
>> >> Thanks,
>> >> Guenter
>> >>
>> >> By the way please note that this is the DMI System Vendor and not the DMI
>> >> > BIOS version string, which indeed starts with "Google_" in the shipping
>> >> > BIOS
>> >> > (but not in coreboot, see f56db262e46d3368ee4e5c9e19797853cab382cd).
>> >
>> > Hmm, I just tried checking out tree from
>> > https://review.coreboot.org/coreboot.git and do not see this commit:
>> >
>> > dtor@dtor-ws:~/coreboot $ git show f56db262e46d3368ee4e5c9e19797853cab382cd
>> > fatal: bad object f56db262e46d3368ee4e5c9e19797853cab382cd
>> > dtor@dtor-ws:~/coreboot $ git log --oneline -1 HEAD
>> > 82d0f91420 (HEAD -> master, origin/master, origin/HEAD) soc/intel/apollolake: enable exception handling in every stage for glk
>>
>> Sorry, this was a Linux commit hash:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f56db262e46d3368ee4e5c9e19797853cab382cd
> 
> OK, I see. I'd say we should not have taken this in.

At least on Caroline, when booting with SeaBIOS on shipping BIOS then the
DMI BIOS version string will be empty.

So the lowercase is needed for Caroline even for shipping BIOS (and I'm
going to send a new patch adding the lowercase match there), but the
uppercase match might still be needed for other products that exhibit the
same behavior with SeaBIOS.

Do you have any data about this perhaps?

>> > Anyway, if you are overriding the shipping BIOS, then please adjust
>> > coreboot to use device-tree compatible bindings (via PRP0001 HID and
>> > _DSD properties - you can check out bindings for PENH device in Caroline
>> > to see how they can be used). This way we would not need to breed DMI
>> > quirks.
>>
>> This should be the correct fix, at least for custom firmware.
>>
>> As I said, the string in custom firmware will be changed to "Google", so it
>> won't match the wrong quirk anymore.
>>
>> Then the ACPI table in custom firmware (and upstream coreboot in the future)
>> can be fixed too.
>>
>> But with stock firmware the situation is unchanged: the touchpad would
>> still not work correctly because it would be recognized as a touchscreen,
>> since it wouldn't match any quirk and it wouldn't have the correct ACPI
>> properties.
>>
>> Because of this, should I still resend a touchpad patch v3 matching "Google"?
> 
> I can fix it up here, no need to resubmit.

Ok, perfect, thanks.

>> Or will maybe Google integrate the ACPI fix into their stock version of
>> coreboot too?
> 
> The PRP0001? No, as we do not currently have plans to move Caroline to a
> newer kernel and 3.18 does not have infrastructure for generic device
> properties. The pen binding was done when we were considering pulling in
> generic device properties into 3.18, but later decided against it.

Oh, ok. So with the atmel_mxt_ts quirk now in place I'm not sure if it's
still worth it adding the PRP0001 to custom (future upstream) coreboot...

> Thanks.

Cheers,
Vittorio
