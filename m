Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071467-1517852787-2-9569538744916158903
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
    t=1517852786; b=ExZ/WGFZSkRzrcah/Lrr1ID99D6j/ybHQgKFdlWWnE/WaAK
    1y63kBcMI0LYI2rrfU5qLCXQSqViM0BkbZnuM2jGqMOZP3daWRGbB27JjxNu8p5d
    atu6vE2JkiE8JIZfpMSHMGJbsM7z+eY3GXEJHAG2OTQsQLOStAEIS2euQPRKOtQ1
    KzDD/dDK3lB9jrKoEe9cO2Ys2HBBkUg2LPeTKoVlXgZEJP85Fh9vkP64eda+M8C3
    UgQUTHCSWgnBIjXH0LjsBEdw1tOoo5x3/ko4GP6UVvskagSOdCYNTLT2QPxhmqI0
    xHUstasyG4HQJ7DXTpzyl3K5D8VDa6vp9meuwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517852786; bh=PRjdGdCOXO6DLMV8xsOEjlzESl
    6YLaJAEX8g7OoJVxM=; b=DkHwFrIq34j4lfH6qxMtfyGOHyK/pHNGETNMfSXPM1
    ceZUKCl+B+Oz1NfTM53NCoAJ0pmJXXMHGs7keSFiS6IMww0+c4Ajv9R8selcxqAo
    9cBKscNNbS0sl6J/RCJa95E3XALAvAxbalN9cA8KOU/c3oCb+jQjDezdeRVxfVwz
    AHtNkhlUqaV12zCSDMB5SHTzWNlyIdr4ELSVQGamTMnomwGWrgptMLEB6a60Z6dz
    ziVKUvLUKaY4sxMhecJJ4g7GnWyqK3kNgTZd7t/Ek9TRs5dfbFejqVVuPITxCKH6
    VPVbN3gyPugmq1XYaQAYulNOql3hAu9wnewU1rG4bHjQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeBERqU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 12:46:20 -0500
Received: from osg.samsung.com ([64.30.133.232]:52997 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752999AbeBERqU (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 5 Feb 2018 12:46:20 -0500
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, ebiggers3@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 v2 0/2] Backports for fixes
Date: Mon,  5 Feb 2018 10:45:54 -0700
Message-Id: <cover.1517852037.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The first patch in this series isolates and backports a fix to clear
just the USB_PORT_STAT_POWER. Without this fix, client can't use the
imported device.

The second patch is fix to back-ported commit 3eee23c3ec14. tcp_socket
address still present in the status file. This is my bad. The bug fixed
in the first patch in this series masked this bug. With these two fixes,
client can use the imported devices on 4.4

Eric Biggers also reported the tcp_socket address still in the status
file while I am getting the patch ready. I added him to Reported-by.

Shuah Khan (2):
  usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER bit
  usbip: fix 3eee23c3ec14 tcp_socket address still in the status file

 drivers/usb/usbip/vhci_hcd.c   | 2 +-
 drivers/usb/usbip/vhci_sysfs.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.14.1

