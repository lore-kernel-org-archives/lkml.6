Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174201-2-11536768325712914362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174201; b=iPWIObC4Cd55EVNENMqpDBWuAMZWl9Z2D7heYBMN9AzbdBJ
    FNbNxfugV9APsEgvtqpE0pdml7+JyIrxcHIE6PYRBaKknEL+xCLNRdfNsmqzjg2J
    uF/QoIQ8B3Fb0fwWvzqKgROv27obdqu9fY46Rqlq6iqmRpicp3w82NKZ3QexeQfC
    Vcd50deqbbdJiMJ0UmSiGVxlvRRm8RFENOekDGgRVt8YMtrU24jQeiuDBWRKz5hp
    NfYMbhfnF48mpDx7qByEL7blFLgidP/y7beWP4PXD9M3znttz9eBpCtAv4f/ZRmY
    uj9zWOGSyvkW56cT5hEQOAXcpVEexKSIYiYTIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174201; bh=sdPMYsfh8lcxJz6QY39ywywRB5
    9pEiksxmg5bH6Sfog=; b=DxjWrOwUZf4QhCKg5wuBnTZWeYIwXI0CwPd7E4R0lX
    1AsHjE1/+cXt90D1gdUBLQ3WK0kgXNqD8v2jDzbCm4ZS35ns4m4axcJ6zV9oSuoX
    SuAbEzRDVnwaeITOqAPS93z10iY5hmiXFjwRhhhFm0WyYuDeRCfhsfYJNKNpavcM
    u4SwOwrxE1bB53iQjuEH99fO785DEN9L9mP091bHMepWR8vLh4BVjHPmIh9XR2Cr
    EVSAOHLdPZa8fLLa4PNHsk+gf9lj7FHwhAuhETmcrOb7kSWTv6Gh3i0W9bBtbw+5
    YL6NmxCpi4dnWD6yLTkxYoJ/MHEkSeIYwbGJIA3hsU2w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJpP5T0GQcg1/wWUngAQ0q1rUaUh/K8XGO5t0PrZKhXGnjUzZNth7febhr9tdjiTHTnX89mzvIE9xmuTgkAr5UuLHQeWAkYWL0jv+I/++uGbnJucYPyy
    +P9QEfNXd8igSZE1Ey3uwxx6V6kkStxgrCu18ym9ueGHZ74E0Ll6/NMiAGwLNa0gWl5Zr8FrdYZ4ayEneCtVPdGy0tl/DSdDt5uKHkBhwTJUXhMgs/tP1qT3
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=bagWFXBM-fKvo6-ZGEgA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbeC0SJr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:09:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeC0Q3A (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 17/43] libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
Date: Tue, 27 Mar 2018 18:27:21 +0200
Message-Id: <20180327162717.418760406@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 62ac3f7305470e3f52f159de448bc1a771717e88 upstream.

There have been reports of the Crucial M500 480GB model not working
with LPM set to min_power / med_power_with_dipm level.

It has not been tested with medium_power, but that typically has no
measurable power-savings.

Note the reporters Crucial_CT480M500SSD3 has a firmware version of MU03
and there is a MU05 update available, but that update does not mention any
LPM fixes in its changelog, so the quirk matches all firmware versions.

In my experience the LPM problems with (older) Crucial SSDs seem to be
limited to higher capacity versions of the SSDs (different firmware?),
so this commit adds a NOLPM quirk for the 480 and 960GB versions of the
M500, to avoid LPM causing issues with these SSDs.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Martin Steigerwald <martin@lichtvoll.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4232,6 +4232,14 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
+	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
