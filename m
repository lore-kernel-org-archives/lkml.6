Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-642297-1518941641-2-16508943911007503303
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518941641; b=AZqi1Z0zrF5uszBOUF2Ksrg4lGXL4F/d885DRyKOYD5fQ9B
    E0+mKIWP+oDhD9Cg9OVA+oZIne41l7/4BB4xNHkBmyNT2K8nfSbNogSxS5tMkXBr
    XaHLmqTwn/1lAUcvD3k0NmA4/3WhySOOZP0dwNFgyr1ZKHVT1dK2coiAH+6sDzX1
    FFcnQf38oqPw4LVQGWKrOetAUrLiC8LQDm3jCGjnyALfmLDQSeWJKDJhNwbPXBmO
    86K6OkwJ2KD1Ra+2yK1djao8QLiRJECaayOfLE0qyQpFa4DLEEUfs2fhyFcKyJ9a
    KhnaQt15pYPIebhCxuBHlD7e4Dp+NJo7KvRrmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1518941641; bh=Jyu1o
    tdfIBoER5GgXcRKe1AfQX46RMEJPgja/QAGlLI=; b=aqsYpkOCRHFGrnxucysLy
    bDouJEQ7aFnOPk9HCh7T0UxanSSpwU7w7Da5UYFb96kgumwUC0APHagA7tQhLffG
    MsEITb1yyQFhxQpJskSYao+AB9lP5k33RziYP9BAelL2TJ4Mk/iDJoEDdbitnou7
    iq2KrJSVfkYoNOAdEIXdoucfJ4m2CwXJILnklfw5STNlnyFsPrkr72hD6zlIN0FS
    qkHF2qLUY70kHI2VPbH8mAonhS3YTWK2/+Py1JNcdB18mSRqlziVsT736R5a4NUC
    Cl11uoe6QL2zaig3A9rJZ1sX17ueS8N50JCwGv4H7/Q6OAq2qIwRffdeK81UCNDi
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VsSjX23M;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VsSjX23M;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeBRINp convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sun, 18 Feb 2018 03:13:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49413 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBRINm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 18 Feb 2018 03:13:42 -0500
X-Google-Smtp-Source: AH8x224GlocMOK/rNa0LHfoyTv10X7um9rq2XoWv6AE+tDTEv3INRp7MW4P8T4PmNqI0xwP9h8DdGw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
Date: Sun, 18 Feb 2018 16:13:13 +0800
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Brian Norris <briannorris@chromium.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>, matadeen@qti.qualcomm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <AC3BE596-68BD-4D15-B06A-B529F9559C13@canonical.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 16 Feb 2018, at 8:10 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
> 
> Ok, I've asked the reporter of:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> 
> Which is how I got involved in this to provide DMI data and
> I will whip up a patch for his machine and ask him to test
> and once that is done submit upstream. This is the only machine
> I'm aware of though and looking at the history of this I think
> there will be others.

I have one machine needs the quirk. I’ll also send a patch to
match its DMI.

Kai-Heng

> 
>> I addition we can add a module option to btusb.ko that allows us to force this flag to be set. That way testing this is easy on a vendor kernel. A bunch of the btusb quirks (and also core quirks) can be tested via module options or debugfs.
> 
> Yes a module option for this is a good idea.
> 
> Regards,
> 
> Hans
> 
> 

