Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1111413-1524079146-2-12683149560430216902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524079145; b=iSjk5pE39LhJugW8l2TvGVfkfCD5/J6aL2rulPU38IIYy28zZh
    kKIluh5WK0mkNBZejITQSq4o3QXI8pNo5i6zWb7UTTrhoERBzIWzIOLbWX9XH2Ul
    iH2tCc1Xg5xR4Yfjw9NTPVLusaODTltIhwC8/eKEqIDiN8gkGCVgBkjyeNUrtO4O
    ZJcZQUNTBq44rQOQ7irg+TehISOISzNdMjb6GXNlR2yuoXUYlkzTaGgtYlswQgxd
    FdUXe8RlzhI2jXqnnAQcM5SrTg42rXpFdKLVdOfXt+zml2achXupnOcZhPeCu1v1
    XUpLHFTe+qB+TL2J6pKxfsr+3bWLwVQBHPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524079145; bh=qocnK4YU5DScr2eGFCXMOiLmh7XeRhjN57ffvf2ReE
    A=; b=IJcyjet+YIokT3mt8crux9QZuTrB/V4l1WUQpxwndZkc1UxQTcsQ2/Cf3+
    z99aJiNLXujkZzbVoCMIZ1AxCtM1PX8x6TQMomZ1J3FipZF5EuPZmX7xYA2fdxsi
    cFmyI9ucZ9B9zLQdCafZx4QolS85vVg7y995E9etsZofhotHkf0qbmNL1XUEZFwb
    WxLeTZvLYQvI+T4ZYcy3PNV74/9hOAkcQmKyktdzUqjGLHRUpReok3IWP05mdF5B
    wyFxpApoODWpx5NAzhjNSeQQvVAYf1+8OgiXEdPhsoThcJUXY2p5YOF7n6OuCDm9
    /cpT1jH+BFwxPlCKeInralfgscjw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=googlemail.com header.i=@googlemail.com header.b=L0+Lr8VZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=googlemail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l1OJTvYy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=googlemail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=googlemail.com header.i=@googlemail.com header.b=L0+Lr8VZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=googlemail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l1OJTvYy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=googlemail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBqnJCuK0xz8UL1FUFe+ErvUWZMiz008hSsjuSHe37LI0AvLnvGQGY63wHjQry01zVMq4wKBGzBUKDqfnc5Q6GhwWfKO8oEeXao3QVwitYQZbP55hZyE
    Ma+H6qKq7pqE3gKl9PgnvoddWiysTBHim834COL8jtouIiiZDPKF3RlWRNxtrsOj8+pgGXtTppwX8FnrLzutOSXsPa/vEQxZGtLHh/CVAg4Q/74VB2XAwc/M
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=25T5d9ZgbPEA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=5FtrKvvtgB5l1KLKG24A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeDRTSw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 15:18:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42429 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDRTSv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 15:18:51 -0400
X-Google-Smtp-Source: AIpwx490jD1XkXAcKaWfoYTz5Qkw8Rav6gN40b6ZNNFErF7bfjzzPcUwEfNK/W5ozKU1srWGV2OyVmnwo0Oyg3o0Fi4=
MIME-Version: 1.0
In-Reply-To: <20180413151505.32663-1-johan@kernel.org>
References: <20180413151505.32663-1-johan@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 18 Apr 2018 21:18:30 +0200
Message-ID: <CAFBinCBYvi2RXEujcc-mKHq0iROeEThGaCe7ca_S-nWbkC3ttw@mail.gmail.com>
Subject: Re: [PATCH 0/3] USB: musb: dsps: phy fix and DT-topology support
To: Johan Hovold <johan@kernel.org>
Cc: Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Johan,

On Fri, Apr 13, 2018 at 5:15 PM, Johan Hovold <johan@kernel.org> wrote:
> I've been carrying a patch out-of-tree since my work on improving the
> USB device-tree support which is needed to be able to describe USB
> topologies for musb based controllers.
>
> This patch, which associates the platform controller device with the
> glue device device-tree node, did not play well with the recent changes
> which added generic phy support to USB core however.
I'm the one who added this

> Like the recent dwc2 regression fixed by Arnd after the device-tree
> #phy-cell changes, the generic phy code in USB core can now also fail
> indefinitly with -EPROBE_DEFER when the controller uses a legacy USB
> phy.
>
> The second patch addresses this for musb, which handles its own (legacy
> and generic) phys, but something more may possibly now be needed for
> other platforms with legacy phys.
I'm not sure if I understand the problem yet - could you please
explain with your words what "legacy PHYs" are and how the "conflict"
with the PHY handling in USB core?

I am aware of two PHY subsystems:
- drivers/phy
-- also called "generic PHY framework"
-- uses a "phys" property
- drivers/usb/phy
-- also called "USB PHY framework"
-- AFAIK this should not be used for new drivers
-- uses an "usb-phy" property

the new PHY handling in USB core only parses the "phys" property and
thus should not conflict with "usb-phy" (the legacy property)

however, I probably missed something so I'd appreciate an explanation
how things can break

> In the process of debugging this, I stumbled over another issue which
> caused the dsps legacy phy init two be called twice on every probe and
> which is fixed by the first patch.
>
> Johan
>
>
> Johan Hovold (3):
>   USB: musb: dsps: drop duplicate phy initialisation
>   USB: musb: host: prevent core phy initialisation
>   USB: musb: dsps: propagate device-tree node
>
>  drivers/usb/musb/musb_dsps.c | 3 +--
>  drivers/usb/musb/musb_host.c | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.17.0
>

Regards
Martin
