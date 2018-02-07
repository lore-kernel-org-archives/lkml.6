Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-840750-1518038623-2-322281058172891829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518038623; b=MRLGAXgmJcFdYlZxlb0qJEe6HJHJ0KL9UNj6d/6sHjzQlUE
    efOGgtnBtjfFFrWxWHzz8SYfG4eUyoY95aVA833JhU63zAW28IBmCgNcOaZl5Dpm
    DxQwKcg8tKnOSBMqBmolpNdowIi5fBLhNk6LaD4w8A9eFtJ/okifSNcq3yH+vlGa
    t9eVTcj12P/HKTBvhfR93ad1GjceGuiPxPWLXSN50UTNul7T4un/uzpM2fx+pmm+
    rEcOYvtF/l+T86h+M0Owvtf/QJVgAZ6VEgF2obd4NNACZGwzl9E54M3hWud7QwRA
    ZOQwwIFu7ydj2Dy4xSsHxLF4qS5mleFG6c3E9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518038623; bh=So+s2rLGnUQtBvLiyvFbkByYcX
    Si1A1u6rHjWmBXl7M=; b=GvrlahCpSFpiNVxUGvaK2KlTqf44TpJEwZyC6Cl/sT
    WRRCsaxQjJR1U517VCk7BftzvhSfuFwC/ayvJv22O3MOiHXnwBTEmsTYepIewj6T
    CHZlmZe0zFzAX/qY6Cqj07MM1wqYXMjVrWuWhThtlRaEdScv/ofUeBD6V95MSKIJ
    4UN0levNIqH4EeKTdNLLbi5e+/yJH7phc5uHYiyDcT9ckhnSE+dmFKqEwofFgmZT
    bbACrx9MGydvX2I4d3Q7yh+CW8rRwH4YhALvGM3DgLbVYGx60amnOTq8FfaV2ceJ
    Zuu+t+fCViV17y1ebWZAGQkQ/aALjlXUFfjLVbG5nfSA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755092AbeBGVU6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:20:58 -0500
Received: from osg.samsung.com ([64.30.133.232]:57051 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755087AbeBGVU4 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Feb 2018 16:20:56 -0500
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3.18 0/9] Backports for security and critical bug fixes
Date: Wed,  7 Feb 2018 14:20:23 -0700
Message-Id: <cover.1518036867.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As I started backporting security fixes, found a few problems
that prevent tools to build on newer gcc releases, deadlock bug,
and another bug that prevents client from being able to use
imported devices.

This patch series consists of security fixes and fixes to critical
bugs.

Andrew Goodbody (1):
  usb: usbip: Fix possible deadlocks reported by lockdep

Shuah Khan (8):
  usbip: fix stub_rx: get_pipe() to validate endpoint number
  usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input
  usbip: prevent vhci_hcd driver from leaking a socket pointer address
  usbip: Fix potential format overflow in userspace tools
  usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit
  usbip: prevent leaking socket pointer address in messages
  usbip: stub: stop printing kernel pointer addresses in messages
  usbip: vhci: stop printing kernel pointer addresses in messages

 drivers/usb/usbip/stub_dev.c               |   3 +-
 drivers/usb/usbip/stub_main.c              |   5 +-
 drivers/usb/usbip/stub_rx.c                |  53 +++++++++++----
 drivers/usb/usbip/stub_tx.c                |   4 +-
 drivers/usb/usbip/usbip_common.c           |  15 ++---
 drivers/usb/usbip/usbip_common.h           |   1 +
 drivers/usb/usbip/usbip_event.c            |   5 +-
 drivers/usb/usbip/vhci_hcd.c               | 102 +++++++++++++++--------------
 drivers/usb/usbip/vhci_rx.c                |  53 ++++++++-------
 drivers/usb/usbip/vhci_sysfs.c             |  45 +++++++------
 drivers/usb/usbip/vhci_tx.c                |  17 +++--
 tools/usb/usbip/libsrc/usbip_common.c      |   9 ++-
 tools/usb/usbip/libsrc/usbip_host_driver.c |  27 ++++++--
 tools/usb/usbip/libsrc/vhci_driver.c       |   8 +--
 14 files changed, 205 insertions(+), 142 deletions(-)

-- 
2.14.1

