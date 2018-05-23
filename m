Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219543-1527086381-2-11684462773961079849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527086381; b=VeIdkZt2TEPBN1eRaZH4eO25idIQuN7cXOw843tbzZkJVh3Rex
    LEJJhJckEk6F/glmAVOcIQkzrv6tPejOiXFx/Hv1MyFQ3cKC7xGMnJogQktYjH9a
    9J1k1plB55O3pUy/Wn8dDXMpwksFVcGSZ1kTXlXi/7o3XZYOo4V9qmS299zhovTX
    OwaPrE5Tqt41kGDE5yATomfIiaiURsuFK57+ueug3KoSI9s0uZwLmrQ700x0Fvlp
    ihrreYxP1fdW6o5tWs2t9K7B5BpLitR7l9+YDGxesAc+FeMQlbmskUJP7CpP/dX6
    aiTgwhpkQpuLax7X8n9UWXTJ+VsZGJQFfYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527086381; bh=lkEqxgV9bR6Mj9fVm2/SIoxfgwjjQH
    IxymlZoJUhzTg=; b=g8qF6jw/jZIRAIxPkS9vDER9c/tj3XK9Xv3EMlnuD6juee
    BJwbRhroKJRG2ANnZZRbNITY3EPoVuA8jdI3NOca3nT5JiY7MS/TYBKJk7a9FJV8
    YD8yoEzKFTeqBnnry2MggARAEG+kMlsVxgZg1/0k33qc8UEp5J2Rl4bg0HQvheHh
    e9hWZMlxoRLcNgJUXpvIsx5jNHUafde4tR6wKRnlKYH+nyl/wQ19xdjrMLGR0R5I
    gW41/nQ/hv7WR8ctgRsM2H+QBvY6IVmQesACEWoSgoh9etbd8XtA3R6UvB/DfLTG
    4/C/xyvZViy4gY/d+kfGSEzjK6QbnWZxvAxLRsKw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP92xi8w0qsLLfTPndoQYqjpjcspdrSrvMO0J5l3PxffEuqtUidz3fCqDdItmt2Nh8RbdEj5TCse0+QCiKu81yMH1jrThPScuD0lQmnfXfDaB0ci7WiR
    LCstEmiB48h4uRzv8s0kdpLihhPVFiIAx3sRyWTKpJNaMgdIC36vXNZNAJovDWtwxajGKrtyeJrXrDSopXRa/816yK6XeLHpfpCmari/zSTAs/6n4eG/SpI2
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=D19gQVrFAAAA:8
    a=VwQbUJbxAAAA:8 a=NDYl8ijhr-JzrrvkMkAA:9 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeEWOiD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 10:38:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:29020 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933081AbeEWOiC (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 23 May 2018 10:38:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="57814992"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 0/3] [PATCH 0/4] usb: typec: fixes for Cherry Trails
Date: Wed, 23 May 2018 17:37:55 +0300
Message-Id: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is second version of the remaining patches that fix various
problems I encountered while testing my USB Type-C Alternate Mode
patches with GPD Win board (Intel Cherry Trail based). In this version
I've addressed the problems pointed out by Hans and Guenter.

Link to the original version:
https://lkml.org/lkml/2018/4/30/350


Heikki Krogerus (3):
  usb: roles: intel_xhci: Always allow user control
  platform: x86: intel_cht_int33fe: Fix dependencies
  usb: typec: fusb302: Fix debugfs issue

 drivers/i2c/busses/Kconfig                    |  3 +--
 drivers/platform/x86/Kconfig                  |  4 ++--
 .../usb/roles/intel-xhci-usb-role-switch.c    | 21 +------------------
 drivers/usb/typec/fusb302/fusb302.c           |  1 +
 4 files changed, 5 insertions(+), 24 deletions(-)

-- 
2.17.0

