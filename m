Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1528056-1521027014-2-10021681327699434072
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521027013; b=qVwtcUcucJmxj1YnvoMbuBY42QY2MZTuv3RiFAC066TULA8
    8mqyz98AOt0xE8hzmbuc0gn+keuMF2rL7/zogHptQGnGATJiyUqd5ZCBFzqyNrHe
    FMdO6qBAGw26Fl95BOScFwARIwFV2aqiMIFiH6HFJG5+sU9NZ/UfOU4MOj94Z+RJ
    A/bvlopZDJM0kh1WyEJ4cC3TZSXnIGIoQEX3AuuR5b2rDAseqHAT4ygpQvQxwpgJ
    FJK5izDooGIQHCeuuDQ137i7f0q3cdGIbLvCl4MNDHLvUY6wwV4YiZyCgWn2ahZy
    DeBxhe/t7Uay9qhv7T/kv5lKC3UBRSDNTUHq4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521027013; bh=mof7/J1dHsn94zR28Te2PxufGP5F5ktXPmAE/RFhoJ0=; b=O
    etA5VP6cEVgWv6Hi6AEsmw8OO2rj8651+Yt9Ygt0kKYhDiC3Q0tv3TR4q/vQmbFL
    HJxsfHYoSeXD6hEPHAPesbx78n0THearFrJz3zdCVsbZPlhYY3RlLUPqB+VFpsWe
    KK4gq9Xubj2mR5eI3k07/nX02qu133f4YMtGMi+i5E7h7xQ4l28Uxdr8VscTAOdj
    gB4NSGs2APIswDwsV1cF+78LyF1AkZTLt1n8pwFwp7PGK79eCO8uXqS1p+mzbV7K
    v50mvoYpJNgz9vtZwKlN7Joq9PyJhuEeY7zbNvMoqiyHEDT73AQxczvncXZ5lVQg
    TJZPlbIgYydLcMiJHEeIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeCNLaM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 07:30:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNLaL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 07:30:11 -0400
Date: Wed, 14 Mar 2018 12:30:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 4.16-rc6
Message-ID: <20180314113010.GA23819@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.16-rc6

for you to fetch changes up to 5d7f77ec72d10c421bc33958f06a5583f2d27ed6:

  serial: imx: fix bogus dev_err (2018-02-28 13:48:21 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.16-rc6

Here are some small TTY core and Serial driver fixes for 4.16-rc6.

They resolve some newly reported bugs, as well as some very old ones,
which is always nice to see.  There is also a new device id added in
here for good measure.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_pci: Don't fail on multiport card class

Greentime Hu (1):
      earlycon: add reg-offset to physical address before mapping

Jonas Danielsson (1):
      tty/serial: atmel: add new version check for usart

Nikola Ciprich (1):
      serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Sebastian Andrzej Siewior (1):
      serial: core: mark port as initialized in autoconfig

Tejun Heo (1):
      tty: make n_tty_read() always abort if hangup is in progress

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

phil eichinger (1):
      serial: imx: fix bogus dev_err

 drivers/tty/n_tty.c                |  6 ++++++
 drivers/tty/serial/8250/8250_pci.c | 21 ++++++++++++++++++---
 drivers/tty/serial/atmel_serial.c  |  1 +
 drivers/tty/serial/earlycon.c      |  3 ++-
 drivers/tty/serial/imx.c           |  2 +-
 drivers/tty/serial/serial_core.c   |  2 ++
 drivers/tty/serial/sh-sci.c        |  2 ++
 drivers/tty/tty_io.c               |  9 +++++++++
 include/linux/tty.h                |  1 +
 9 files changed, 42 insertions(+), 5 deletions(-)
