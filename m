Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941320-1525372776-2-16960272075894177655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525372776; b=VmeaBVA9h1Ediz8mchIhTUyvkGc1Jzlye85j0FjrBxic8gzkFg
    ahypSyPrIjWLSO84k90Otfgy3piMBycVNgCIykfqbqBc4rkWY+fCYzcQkfsXP+0I
    tgu9uj+oWks4BZ3VfmgU9nWL046yZYze/CxcPcdz2uzJVJyNw0ny1fZOjrMKMFaA
    J2YSSROEhyjS5iTseGblnOl4ImxCdILUigkBalS4u5GBsCM3ctp85nnlIFAAmVDC
    4srKsRTEX2X6T0g9Rd7w4qZIgtNeQWt4qAvmEOscS7WLTN6RkuecLBUZGSSTvmVm
    wptSqDiy/t4WHcizezY/VZa6ek918zdCgiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525372776; bh=
    xcTzDdC7kS4mNsgue4/ljEInDC8m7hROwHlFKZV6S2A=; b=Je4ZroLvbUSA86Vr
    pAbNlsraYozrUKHsiky/m+zqvIkJ3ioKu1Fkh+C+8iExZEVda+hvDo35OMEBMa/p
    4/SxcSTAP+4XLqnrKxaTb65s39bPMVQMkOKSVfRsbzyWZMlxFwB8mTQvppL7lc+D
    Qh+LikTeVY0htw0lMMbd1yNqUw1+y3raHBCsTXZ0c+wzYxripiqUkNfZK5cSDRaZ
    B24K7U1zoAnQxHqnft+sNQGlgJLto1IZ2sP8Cws0MeXKMG+J/pdEKMaBrCeNBQKX
    sreDhGfriXGAWVCx1fTNjhW5vFs07D5wOluaUe5vTsEUNbTB1Fa0NbSBw/7iM4to
    cmaLIw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=b/Z2FoHQ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=OXKHgauH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=b/Z2FoHQ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=OXKHgauH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHdNi1kKgeD98qcb29uSExSJkWdC9uYqwk0fJxLAVt+BcfDT71nvCJlpaNxWyy5SawbJKfA5g2t5sxg/4OmFvQO5dCwpxEKhnKoX9vWfJA8oR0Oxa5cQ
    zCkYgopQeMt8CRYOW/S4O/0HABAfwi7T/arI/xwWDbwpTGiOigezScHY0Dm4GbCFFmlGxzlHqEte48hcD5c7GCtryQaBJo8LXJHYDnpIXKyJIqE6m4MSv4iI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=1XWaLZrsAAAA:8
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=Aqq4grhJvZhRwofscVwA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeECSjO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:39:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41892 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeECSjL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 May 2018 14:39:11 -0400
X-Google-Smtp-Source: AB8JxZoPEValrlApAkRFmRUgTIPfhujAMbDYcGDITolgOiiAHq/U4ujHYKfGQfApCAyW9/GSjPpRMg==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Christophe Ricard <christophe.ricard@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Todd Kjos <tkjos@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Stable <stable@vger.kernel.org>
Subject: [PATCH v3 3/4] NFC: fdp: Fix possible buffer overflow in WCS4000 NFC driver
Date: Fri,  4 May 2018 00:08:55 +0530
Message-Id: <1525372736-25094-3-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525372736-25094-1-git-send-email-amit.pundir@linaro.org>
References: <1525372736-25094-1-git-send-email-amit.pundir@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

Possible buffer overflow when reading next_read_size bytes into
tmp buffer after next_read_size was extracted from a previous packet.

cc: Stable <stable@vger.kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3:
Reset next_read_size to a more readable macro FDP_NCI_I2C_MIN_PAYLOAD
instead of 5.

v2:
Remove redundant __func__ from dev_dgb().

 drivers/nfc/fdp/i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c4da50e07bbc..2c5ed2224c5e 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -176,6 +176,15 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+			/*
+			 * Ensure next_read_size does not exceed sizeof(tmp)
+			 * for reading that many bytes during next iteration
+			 */
+			if (phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "corrupted packet\n");
+				phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 
-- 
2.7.4
