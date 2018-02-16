Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3975444-1518774505-2-10940663239663116101
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518774505; b=U560qheYKvIxCaIUqj8cLGztO21pc/nts9YacM9Mzk6+/cu
    i97zgTzTqyRzu8x5xgxvUd7PbxXWCcogtKll2Sb8cqD9SHsBTEIlJHnCBVD6Tpqy
    BKpQLYowhaRXZwjxcc9yJbCXoipLc/OrMMJpQMUH06pgbBxsHkoTEYAVTuA3s2Kb
    qoLD0+I4dVLO7I8a7DsNHEjbhKHx9a1s5VNw1bYLB7SsrUzXkmxslQAe59tISJmH
    I88jBCo8Q0efz8o8JuAakSm6JzSO52b1I3uFWiA2wyHP6tyVF0aNS5PKLo5VkIMp
    t0GxQrjOCnHvpXQeVePQkNnyUEISS92GJ9FpQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518774505; bh=1nfEYtTDhX/gWJpZ3nAZ1834go
    +w+XyEeTclRKXgd5Y=; b=rvIPvhdl0cjijeWliqkOj/UI3BSWj7z9Ew+wbTnu9G
    Y2P0rU8fhb+isdB+Wq/J0wutEYpxV4oFiScyL4SiJWsHQM8Dq+BAd8IIa2YZtqR3
    Xf9vaIrdfHF+uWyIDFzoqHmoeyEnIl8isKYe3t8dQmj04xX+qGzXuprkwG8S6NbG
    jEgvbor7x4Ic5+TA4ZL11pwa+p9K+cbcJvXOQkCxi2SpwGiBLNb3SJ35nfHxK+Ci
    w9W7wt6artSzL3w+6h4evOL1C37znh6fMIar7iqEPsK8ElmTmT82aqITTJNP7Urv
    R4V8/4vRKspnwAezrKo5ddu8YryvP1Aoxf8HushXdoAw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932414AbeBPJsY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 04:48:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932325AbeBPJsX (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 04:48:23 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
Date: Fri, 16 Feb 2018 10:48:20 +0100
Message-Id: <20180216094820.3587-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Various people have reported the Crucial MX100 512GB model not working
with LPM set to min_power. I've now received a report that it also does
not work with the new med_power_with_dipm level.

It does work with medium_power, but that has no measurable power-savings
and given the amount of people being bitten by the other levels not
working, this commit just disables LPM altogether.

Note all reporters of this have either the 512GB model (max capacity), or
are not specifying their SSD's size. So for now this quirk assumes this is
a problem with the 512GB model only.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=89261
Buglink: https://github.com/linrunner/TLP/issues/84
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3c09122bf038..d8be0fe548f7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4530,6 +4530,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.14.3
