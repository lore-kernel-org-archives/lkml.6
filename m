Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F78FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BDF2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Q3cFA4pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfBKTOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:14:36 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:44062 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfBKTOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:14:36 -0500
Received: by mail-pf1-f172.google.com with SMTP id u6so5691399pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u9248qYnqOJQSpVMBLSGc4lZzM6zZ6O9CIztW4wz3Rc=;
        b=Q3cFA4pbFlg3C9NA1yCIGSx7Whe5G+cOvp3DQqtfBgHmeJDFvnBBmx8kZPmEVr4Dp5
         84pO+DpDsxbrEZru2E47JALr0nV+YSCp+36q6twlWdcVOpR+xJ29K7PnHz9SoIHM8rAb
         SQHfyECKbKTq070UIk0bBuFZpuBZFU8o3JO2m1ipSV+1zka9rJwkMjHh/ApKnG3NkJXt
         Ptl3a/cXULqPBhfY5vL5LjYCKSm4+4ydjX3zPenhduoo/7xKoVAdJzIayWxmRIvjWasc
         7I9hzxvKAiBJk53h90Vc+ybzVdHfhIXj9BMlXCosf/QP1Mkwv3JD6Gp8pXxJh7ZKWu2l
         B3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u9248qYnqOJQSpVMBLSGc4lZzM6zZ6O9CIztW4wz3Rc=;
        b=k2OAN7B/U7juWtrew3npmNamzJKraJdS6OehOUmF/z49lz2p2VGEMNNJAjlXwLoMf5
         9qR8515Lca4C8J9EPB4aOleYjXr5HebSoIdbIWjYLZdeEnTXfLTUELMOfpGXuWKh0aMw
         mowrJfnrYc+KP6IFsIMry9wsYQwOYGB4d79WkchWb6uscdociaQSDHT8gKPm7iSyXcBm
         B+ncO2sUF8jX5s3gwN1A1i4h0VeAHvshtpdxddanosySPpPlWsJlMcfaTPx9Kb7KqVZx
         8FAllEfMIFu3cD6woush1oHbYxEFI55Zvq6Zrx/Yga5PcDLFkjiTBvd7n/VXpZZsmwco
         X7Rg==
X-Gm-Message-State: AHQUAuZ8ne5SuVAyKhgXvQmYBOupcBGmSRfrSuPja8NaB7BE8PoY/wxm
        P+87MgN0r74gr+xI0iY1uXQUgdWigU0VGahmdOqeBg==
X-Google-Smtp-Source: AHgI3IYCVyGva/a54S65pyhhssTPK9W6o/3RuAm04Ir6i1paFzHA40PBfgXVZuly+8e0EmxpKZLNgIeNTvQ7aJFc73Y=
X-Received: by 2002:a62:1112:: with SMTP id z18mr37979820pfi.173.1549912474949;
 Mon, 11 Feb 2019 11:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20190210192408.GA81989@bebop> <CAHp75Vc_0tLLSeVjiBLFXZXJSw7Evf=vmBrgbtsj11_SWS_rOg@mail.gmail.com>
 <691cc9a7-e126-a7cf-b3b2-ce5a77eadbeb@gmail.com>
In-Reply-To: <691cc9a7-e126-a7cf-b3b2-ce5a77eadbeb@gmail.com>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Date:   Mon, 11 Feb 2019 11:14:23 -0800
Message-ID: <CAOcMMieCjobcM_d-ojuL88cOWFCFZbo=z5X=QWyqi_q7LZ5xHw@mail.gmail.com>
Subject: Re: X450LCP lost abillity to turn the screen off
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcos,

On Sun, Feb 10, 2019 at 5:05 PM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
>
>
>
> On 2/10/19 9:45 PM, Andy Shevchenko wrote:
> > On Sun, Feb 10, 2019 at 9:24 PM Marcos Paulo de Souza
> > <marcos.souza.org@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> Since 5.0.0-rc4 I vefiried that my ASUS laptop
> >
> > Can you be more specific, what model, BIOS version, etc (also would be
> > nice to have dmi strings from it, I guess dmidecode tool would help).
>
> dmidecode attached.
>
> >> cannot turn the screen of
> >> anymore. There were several commits in 5.0 merge window touching this
> >> functionality like:
> >>
> >>   71b12beaf12f platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x3=
4 scan codes
> >>   b3f2f3799a97 platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
> >>   78f3ac76d9e5 platform/x86: asus-wmi: Tell the EC the OS will handle =
the display off hotkey
> >>
> >
> > Can you bisect or just try to revert one-by-one from above and see
> > which one is a culprit?
>
> I already did some primary analysis, and it seems the commit 3f2f3799a97
> maps the x035 (which is Alt+f7 in my laptop) to SCREENLOCK, which is
> wrong because alt+f7 should be Screen Toggle. I will try to revert this
> commit, or remap to KEY_DISPLAYTOGGLE or KEY_DISPLAY_OFF, and test if it
> works.
>

User-space does not act on KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF, these
values should be used when the hardware is turning the screen
back-light ON and OFF. According to Asus BIOS engineers, the
back-light used to be driven by the hardware, but they have changed to
the this new approach of telling the OS to drive the back-light for a
while now (no specific dates or BIOS / windows driver versions were
shared). They we actually surprised when we told the that some
machines still have a working implementation (and selected by default
unless told otherwise) of the old behavior, which sounds like it is
the case for the machine you have at hand.

The new behavior, as defined in their spec is to only notify the OS of
the keypress with 0x35, and have the OS "close" the screen, with the
screen being "opened" on mouse or keyboard activity. This closely
matches the screen lock behavior on Linux platforms, so we are mapping
it to KEY_SCREENLOCK in the kernel, and it then gets mapped to
XF86ScreenSaver by xkeyboard-config, and finally gnome-settings-daemon
uses it as a lock screen shortcut (look for "screensaver" in
plugins/media-keys/shortcuts-list.h on the gnome-settings-daemon
repository).

> But yes, I'll do my best to track the problem ASAP at my side. Please
> let me know if I can provide any additional information.
>

You can check what is being sent by the kernel with evtest, and what
is being sent by X with "xinput test <device id>" (and you can find
the device id with "xinput list"). And you can re-map it without
having to rebuild the kernel using udev's hwdb. But simply re-mapping
should not change anything, since userspace does not act on
KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF. If you want to switch back to the
old behavior you need to revert "78f3ac76d9e5 platform/x86: asus-wmi:
Tell the EC the OS will handle the display off hotkey".

That being said, I believe it would be more productive to figure out
why your userspace stack is not reacting to 0x35 / XF86ScreenSaver and
fix that. Which window manager / graphical desktop environment are you
using?

As a final note, from your dmidecode output I see you are on BIOS
version X450LCP.207, and there is version 208 available for download
on Asus website. I'm curious to know if it changes the old behavior
(with the patches you listed reverted), but I'm not responsible if a
BIOS update breaks your machine in any way, so just do it if you this
is something you are comfortable with and understand and assume all
the risks yourself. We have been reporting machines with the old
behavior back to Asus, but I don't know what they are doing with that
information, if anything. I'm adding your machine with the old BIOS
version to the list, so if you test the new BIOS let me know so I can
add that as well. But please don't feel any pressure to update the
BIOS if this is something you would not do otherwise.

Best regards,

--
Jo=C3=A3o Paulo Rechi Vita
