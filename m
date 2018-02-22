Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713482-1519321854-2-3310839052542024087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519321854; b=UO5xr9RJRPmAc/g/jyFlETJJc+U0BupvHlpfCB5CPIAwDX/
    W8GXu7l0W+Z5ldnCZjfsvST/2R2EX0X86RGadRZGK764LwfyfKc61Dxwn3I2/Y9O
    7yoV86cS3LNGT8rQOIJWRhrvPvM0nU3LgTYavuej0e1HzBkuaZrBVVGdlKTq4Qj5
    /pEqi3l/tw9uMmtY5tpiSVLPCtDOf4vNm8rWsr5BRdldgoC9BqAZnphD7GWTIO8F
    q9rsRg1R2rXfI5+usE1gACx0UgOM5f7D89YAhC10W6crwLbIB6XlJC/sZ6zgNmN0
    OC7nQ0VqL90xGc1VrUa5C4CihZXS516jYifF9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519321854; bh=rIuqJzIxhL6lh1dLVq+Qf83wnkWNbdfv4LOuE6NJGRw=; b=L
    DsqncHpzh8FCsItxQer6NUWbX4R5qMSJWaov2w/tKJ7fONjsqNoc3WVedZzFNyMp
    OObVPhYd33o7SKNuohLjnjywwY19nbkw72VZVj2nbAYk/2VNvnPDQX+s0QSUJIXD
    Pmn20tiDwyo7WsEKVv41DHgqfsOFcUy5DgTG7LkyTdDzdRT4ADrkf6kE/A5rgGyb
    08vv3Prr1feghXFN4cUfCqD6jmOcBKbIVaAR4+k/hVWjfV2IsPaN2kIdhGj71zr6
    XCHh54Wr6QLKeqmxipcXDBKd1pSjJb8nxhWLNhiclS3qOq163IXT044rYN5BS+bR
    sjWz68ezKaCRYdibehpSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933555AbeBVRui (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 12:50:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933581AbeBVRuE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Feb 2018 12:50:04 -0500
From: John Garry <john.garry@huawei.com>
To: <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <slaby@suse.com>, <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
Date: Fri, 23 Feb 2018 02:42:01 +0800
Message-ID: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is a requirement for supporting an 8250-compatible UART with
the following profile/features:
- platform device
- polling mode (i.e. no interrupt support)
- ACPI FW
- IO port iotype
- 16550-compatible

For OF, we have 8250_of.c, and for PNP device we have 8250_pnp.c
drivers. However there does not seem to any driver satisfying
the above requirements. So this RFC is to find opinion on
modifying the Synopsys DW 8250_dw.c driver to support these
generic features.

With patch 2/2, we're relaxing the interrupt support requirement.
As I mentioned in the commit log, the 8250_of.c driver seems to
ignore the dt bindings, and I do the same.

John Garry (2):
  serial: 8250_dw: add IO space support
  serial: 8250_dw: support polling mode

 drivers/tty/serial/8250/8250_dw.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
1.9.1

