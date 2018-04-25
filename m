Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-431479-1524647587-2-7357990605897273384
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524647586; b=ZgzWIKUMC0f5GhHqE1Rl20yMyEPRjBDlycTe4IsR248AH+Quha
    uTrfvGiW7/SdLDun/KavesjF2O3G2gAq1s4Tt0xgM5wP2NOYXBu1I8p+3kvHAcaM
    CgaVMEhXeY6ZefJGW2NmLy7RVTv9nljryNHF99vJsnAPRcT7tgZPh1Ym+JouV7MH
    J/d/CBgLanihtBxDZAR+qrUGppPxr7evmxY61Hzoo5aFZUBz9bvTb3bb6puSGCen
    67HqriOnUFSH8meQ/Ee1oj5cGvOGeMT4sAh4WdICNNINk79/anoJQeKJtoter37G
    2RiWHkrHb5Tervj0IRBSAZBxIn06aQ5PSWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524647586; bh=vXwXVqeXhgfV/mW02aIgTP377lzYcI
    tj1OGNBbg1mJs=; b=vZS/X3OGo1O0RSFViElGiLyARL5E7jvQBDvE+SjJnH5ejt
    5J3ljKacmaIzBISAAEutbxLuaRIpU4pKv+kD6XjSRm5pOfnO+zNw6y1X/aOtWc3t
    ZDikQkhoXlQVA644peLbryvuEdLsfazXsWJfIzMcV6dE7+zH+2cOhooumatPki2E
    7/n3+Kq5mx/IsTLdxzVk1BzYiOCOp4PlnIO0sk21o7FPdYhMg/odB4WEIoDrAfhL
    ALMmeI21c7DAV+/wumToObKCp/ObzEX4HZ1lqJTGe0gshKnS78spaocdHAm3mUwY
    Ob8O6tUm2Vjk+ALdkwVF4wTyBwMNoPTTDWxCsSaQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QalgCnYr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O1/Lqtyr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QalgCnYr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O1/Lqtyr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDIdGiVk8koqQ21BiHZV90dBA7MJygS4Eca0kswIGgdHFZk7H52RQeLskEENIRvR77vxZnma5mgrmfH+oFjYzkZkw3wKaZusb36CLKcXWh2b3klztAz2
    VtDvpwBAFjcRXOKy00mKXCGdhKUbCwbVRA+aANbGuruSPZqbnrXiFHAmpYWcKH9gkB8FlDG4Ynongs/HWxYqvj7cezBxvPGBOyEvmhzfQ8FqyY01jU+ea7f9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=ucKMGpqVoW-j15Z9pG4A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeDYJM0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 05:12:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35766 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbeDYJMU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Apr 2018 05:12:20 -0400
X-Google-Smtp-Source: AIpwx48GpNXkYfCWKCLcLyxiBpBRHY4052gDQfy1ZtFgs8RunDkw8h7mg88yE9vEyJslMTqUhefgOg==
Date: Wed, 25 Apr 2018 11:12:09 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Johan Hovold <johan@kernel.org>,
        Shrirang Bagul <shrirang.bagul@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
        <frederic.danis.oss@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC][PATCH 0/1] serdev: Support HS-UART serdev slaves over tty
Message-ID: <20180425091209.GM4615@localhost>
References: <20180424082954.11453-1-shrirang.bagul@canonical.com>
 <b4947b3c-15b3-15ea-e1b7-38169f11d0f9@redhat.com>
 <20180425074736.GK4615@localhost>
 <1821148.enBAg0iGPe@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1821148.enBAg0iGPe@aspire.rjw.lan>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 11:00:47AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, April 25, 2018 9:47:36 AM CEST Johan Hovold wrote:
> > On Tue, Apr 24, 2018 at 11:16:38PM +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 24-04-18 19:18, Johan Hovold wrote:
> > > > [ Adding some more people on CC. ]
> > > > 
> > > > On Tue, Apr 24, 2018 at 04:29:53PM +0800, Shrirang Bagul wrote:
> > > >> On systems using Intel Atom (Baytrail-I) SoC's, slave devices connected on
> > > >> HSUART1/2 ports are described by the ACPI BIOS as virtual hardware using
> > > >> HID's INT3511/INT3512 [1].
> > > >>
> > > >> As a consequence, HW manufacturers have complete freedom to install any
> > > >> devices on-board as long as they can be accessed over serial tty
> > > >> interface. Once such device is Dell Edge 3002 IoT Gateway which sports
> > > >> ZigBee & GPS devices on the HS-UART ports 1 & 2 respectively.
> > > >>
> > > >> In kernels before the introduction of 'Serial Device Bus (serdev)'
> > > >> subsystem, these devices were accessible using /dev/ttySx nodes. But,
> > > >> kernels since 4.15 can no longer do so.
> > > >>
> > > >> Post 4.15, with CONFIG_SERIAL_DEV_BUS=y, serdev port controller driver
> > > >> handles the enumeration for the slaves connected on these ports. Also,
> > > >> /dev/ttySx device nodes for these ports are no longer exposed to the
> > > >> userspace.
> > > >>
> > > >> This patch implements a new driver which binds to the ACPI serdev slaves
> > > >> enumerated by the serdev port controller and exposes /dev/ttyHSx device
> > > >> nodes which the userspace applications can use. Otherwise, upgrades to 4.15
> > > >> or higher kernels would certainly render these devices unusable.
> > > >>
> > > >> Considering serdev is new and evolving, this is one approach to solving
> > > >> the problem at hand. An obvious drawback is the change in the tty device
> > > >> node name from ttySx => ttyHSx, which means userspace applications have to
> > > >> be modified (I know that this is strongly discouraged). For the same
> > > >> reason, I am submitting these patches as RFC.
> > > >>
> > > >> If there are other/better ways of solving this or improving on the
> > > >> proposed solution, that will be most helpful.
> > > > 
> > > > Yeah, I don't think this is the right solution to this problem. It seems
> > > > we need to blacklist (or maybe even use whitelists) ACPI-ids until there
> > > > are drivers for the slave devices that would otherwise be claimed by
> > > > serdev.
> > > 
> > > FWIW I've been using this patch for a while for realtek UART attached bluetooth:
> > > https://github.com/jwrdegoede/linux-sunxi/commit/bc904e3703940600ca66c65fcdb0a8cb01dff55d
> > > which is a gross hack.
> > > 
> > > If we're going to do a whitelist for this, it better support some sort of
> > > wildcards as there are a LOT of BCM2E?? devices which need to be on the
> > > whitelist. I think a blacklist would actually be better though, this also
> > > documents which devices are lacking a proper kernel (where applicable).
> > 
> > Yeah, you guys know the ACPI space better than I do. I just fear that
> > if we go with the blacklist approach, we'll be playing a whack-a-mole
> > with this for a long time when people start upgrading there systems to
> > 4.15 and discover that their serial ports are gone.
> > 
> > Since this would qualify as a severe regression, me may need to consider
> > adding a serdev whitelist for every ACPI id we add to a serdev driver
> > instead.
> 
> OK, so let's have the ACPI discussion on linux-acpi pretty please.

Oh, sorry, I forgot to add linux-acpi.

> Could this be resent with a CC to linux-acpi for some more complete
> context?

Fortunately, I think the relevant context is still there above.

In short, when we added ACPI support to serdev, serdev started claiming
all slave devices to UARTs that happen to described by ACPI. Regardless
of whether there's a kernel driver for them or not. This means that
serial ports (/dev/ttySn) will simply start disappearing on such systems
when updating to 4.15 unless we act somehow (blacklist or whitelist).

Thanks,
Johan
