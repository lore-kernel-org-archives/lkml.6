Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-29808-1520455418-6-10890517983662715712
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455418; b=pHP7bBVBtvy1UllIqZ3DLmYkDfHAU42Na2Vz8QgiYq2J5ar
    tNhJHv+gYdQm6h9QNGWVnYDDLjpPfSL7DE341lo7QEl6nQ9qQrw4h5KgYVuz4Xwn
    a1Z/VpO0ZB0yZY8iMRW0xj7csGXOL65jJGKEFFHTY8wObWAK/zgRxUQXLjmqF7bI
    3s/OYkgsa1rjbiYygJDyYKUzvDzFpMGjYVB7AWef61tjiMDULEgeJ/mFIPNk5koP
    t8ykccDG/TmiJR/QoeVOSXrsRE+p4sY9RiHrxUXUXA41KLM199INX71huX8ut7MZ
    t/8Al5QwooaBlNqMjSacHtqP5ruXSJKb/Bna9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520455418; bh=01i34uxo8gCDxznX9UPBLNY2yB
    Q41OMHGFXintUiN7o=; b=o0rY4vrTiuW5PaTKMX0cVunNJrGrmAZm50hTo9jZaa
    lsj1R0EUMyZkVbRDrZZmT2iMHmMLq43snJPQJvazsQdxhngRzzAejqKV7JCXYW2D
    800A5zm5Zdp2WjJbku1DypOK3ZtKlQwQwLgshEPS9GafeEzGhBFCFMp9TGHE4gTk
    m3Zj2CzZNqSl6i9m+JbSype0nE4pueZAKaAiaA8tOCUCU/NtHORH5fkaO7DG86ge
    yAdlRgzCC4Oadrilui/w1iSWKmYB7k8UrOyn2cEd7R/tmr8CnHB0tKVNs9JlWWCc
    kq/o2mMyfB4lHg+yfvPuBvYBrXjJI9sKRDbw1Dcw4+Kg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935000AbeCGUmz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:42:55 -0500
Received: from osg.samsung.com ([64.30.133.232]:48621 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933736AbeCGUmu (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Mar 2018 15:42:50 -0500
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, yuyang.du@intel.com,
        k.opasiak@samsung.com, nobuo.iwata@fujixerox.co.jp,
        julien.boibessot@armadeus.com, jdieter@lesbg.com,
        peter.senna@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] More error codes for usbip request/reply messages
Date: Wed,  7 Mar 2018 13:42:23 -0700
Message-Id: <cover.1520455010.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently ST_OK and ST_NA are the only values defined to communicate
status of a request from a client. Client doesn't know what failed
and prints a cryptic error message that something failed.

This patch series adds more error codes to clearly indicate what failed.
For example, when client sends request to import a device that isn't
export-able, server can send a specific error code to the client.

The first patch moves existing error codes to a common library header
and adds more codes. It also adds an interface to map the code to a
string to print messages from tools.

The second patch changes the server/host to return the right codes
in reply messages when client request fails.

The third patch changes the clinet tools to recognize the new error
codes and print messages.

With this change the messages say why a request failed:
    
    - when a client requests a device that is already exported:
    
    usbip attach -r server_name -b 3-10.2
    usbip: error: Attach Request for 3-10.2 failed - Device busy (exported)
    
    - when a client requests a device that isn't exportable,
    
    usbip attach -r server_name -b 3-10.4
    usbip: error: Attach Request for 3-10.4 failed - Device not found

Shuah Khan (3):
  usbip: tools: add more error codes for usbip request/reply messages
  usbip: usbip_host_common: Use new error codes to return request status
  usbip: tools: change to use new error codes in server reply messages

 tools/usb/usbip/libsrc/usbip_common.c      | 23 +++++++++++++++++++++++
 tools/usb/usbip/libsrc/usbip_common.h      | 11 +++++++++++
 tools/usb/usbip/libsrc/usbip_host_common.c |  5 ++++-
 tools/usb/usbip/src/usbip_attach.c         | 11 +++++------
 tools/usb/usbip/src/usbip_list.c           |  6 ++++--
 tools/usb/usbip/src/usbip_network.c        |  6 +++++-
 tools/usb/usbip/src/usbip_network.h        |  6 ++----
 tools/usb/usbip/src/usbipd.c               | 18 +++++++++---------
 8 files changed, 63 insertions(+), 23 deletions(-)

-- 
2.14.1

