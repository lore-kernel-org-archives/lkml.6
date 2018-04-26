Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3113896-1524774748-2-15916951504514147526
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524774747; b=asCPDTpLSZS9D8bNP9sRmKHn5AK1h3/lmyiyrjJBw2Dh3BPjdW
    mCgKfz96ENDptarjOW9nVwofC74OmpOptgHHsTG4o2Wpk3UxIRXClllDd8e+D+fH
    KcKRFydlM4H27LRRRbwW7xZ25Qw+j1hx3fryLLENCah/gmOKK1gtDMQa1W3d03nM
    kJGn3RxFibW2w0ESebscLoPDvXzgtUhEbk/Y5xYklPs90XP8rjqSipy72RKRmMNJ
    GwDaPwaT8+oSTA1wU2VzAR94gx8CB+oRU5lBm0JOhGU1Jg14BL2lFggYMs3OdInd
    ekJUbrR+5T2RWSt5bccu67BGlQimHAXLSjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524774747; bh=Z/I+ETkc1O9HHrkBR4vjqnkL2ccxoe
    EInpmUc7SInEs=; b=JMUETlh1y7sWSQwkanh/Th6OL26ihwMphlvgpdX2fRHg8w
    Fd6bZ0yttVBD2gk/dlgxFmkkF1weCgM7OqMS9IYe/VXCZe1zR7htiDENUimA407k
    8Vt5069lB2KNWeHmtUbx1bePOnm2TzavUEr7HBDM56Q+0Rs2+yJt9xWf2lzXKHFC
    2VuZ4vKUNj7Q25LpEdbn5UN1CTFZnm8/4TIG+5jOhUc4cU1mk5+vYIw7y6geHDvW
    tOSlyJqX1gxFgzDjXrVUfDTur7U/alpO/vlQo/UcCr5qil6wKtNgtHmxQJ31Nc+1
    MDexoZaSF+pAcBSxQMXHEAefz6sgtFHmeao2AQhA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKny53bO8HBjR+w41enfHqjsAkOtshWoIzQSqKjPaidHlfNBKsoVJS3HI8Vt02AiLnlYWHDuWB9UTyvlN9Q71fDsNJAKvTH3aMRO0Kcmk6LohBV+mh6d
    YzHcQeElt6zO7dWVdBoKsMbjEyElflNd77TU8N5y5YqhRzhYEf/y5UTp92oofuf9nqrxxqpJNLif4s8Hf0vaHxZV5Of0S3/kHmkc/GYG5y19c8EMtJa49Yw4
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=20KFwNOVAAAA:8 a=w7iSzLnatf4XK9UexT0A:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeDZUcZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 16:32:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753973AbeDZUcY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 16:32:24 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Richard W . M . Jones" <rjones@redhat.com>
Subject: [PATCH] libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
Date: Thu, 26 Apr 2018 22:32:21 +0200
Message-Id: <20180426203221.2683-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Richard Jones has reported that using med_power_with_dipm on a T450s
with a Sandisk SD7UB3Q256G1001 SSD (firmware version X2180501) is
causing the machine to hang.

Switching the LPM to max_performance fixes this, so it seems that
this Sandisk SSD does not handle LPM well.

Note in the past there have been bug-reports about the following
Sandisk models not working with min_power, so we may need to extend
the quirk list in the future: name - firmware
Sandisk SD6SB2M512G1022I   - X210400
Sandisk SD6PP4M-256G-1006  - A200906

Cc: stable@vger.kernel.org
Cc: Richard W.M. Jones <rjones@redhat.com>
Reported-and-tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6e400ff2b5db..68596bd4cf06 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4552,6 +4552,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* This specific Samsung model/firmware-rev does not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 
+	/* Sandisk devices which are known to not handle LPM well */
+	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.17.0
