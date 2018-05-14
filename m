Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281392-2-12845850446209576126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281391; b=QMCL2h4kR4yQSww57yisale9xpC5H7HruYkOmWowp0155hlVsL
    KeTnnsQJWGxpaQk3zdNlBLzcNmk+zb4IzQhd58DbkYqMlCdDQ6zmSfo1LfyPZWJ6
    2zvfovEhcCocvzGo1mc29aoNNhDyPLedhfK7UTf6BLdUdaJ9wfGVZIjVNfv6YfIt
    yl477caODD53gh2yH+14JzbqQq0eejmlUFEsHU4lfySSgyI7RlUu0qEXvCC7jWvE
    M6R1Go/VGWHGtZGlqNIh4aiilw/W30NW4gSAFihZ8n4Z1yDqv/312fmXWK7MW0mv
    M2OgyPL3QUv5rTPM4OV1bsdwReJFuMB2Tqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281391; bh=wfFxVKZ0jVm//tg9qg8Woxpck7/5Ht
    AuNrc9M8t3cvY=; b=ahDKMcl6GiReJLQ36bGkZK9PGh6w0lW+uHV1fXha/Q2iF+
    cEExz0ZpLAP9BX09walADRwTy5T7YToKCCOfG82BZvCmoKDGPjtfF6olPExaAkjv
    yI56ztl6BA0N1d1/8C+fyOMxHQBnK1hvTwQTAoXyN/Aa5iTjfT9E8/aVxOEUFtWY
    SKSu2MGOEyboIPOR9wpTd60Z7AeRw/gBS8O952SWZzdhjfHHRAji31Hak4u21yPx
    8kblRlCDwqXV//M+s/YmlDPsspxYG0A6+koHCsTn5JX9x60NKg/vTWHShCRiHyFX
    9TFzvDhSLnZaZdH9+55KCy0aasGdI56112mnb96A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hdOGiFmz x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=hdOGiFmz x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvQzZeZQEQ8Wc7W/w/4F9rcIUH2UPzKQMSmo61isO0C+kvjwC8CuNaUGM6d0CdsIQaiwJWMhCYfITTmLwQSGQvzLGrAIssrElK+NKKGIpI/3dsj6FXE
    6HkgyrLEGN5pgJd1UudhVH3GUbLeZPjwrY20z8pLlTScoS+szZnOePfTtZg3M/4RzoRm9Uoia7K7iZDEcywuqXA60ZnGK7FgtlBlhN63o9JmVmJU0oQfTLgc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=v7_0Sr9Y0SOqTs3S9F8A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932070AbeENHC6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753921AbeENHAY (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.16 61/72] nvme: add quirk to force medium priority for SQ creation
Date: Mon, 14 May 2018 08:49:18 +0200
Message-Id: <20180514064827.293635921@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 9abd68ef454c824bfd18629033367b4382b5f390 upstream.

Some P3100 drives have a bug where they think WRRU (weighted round robin)
is always enabled, even though the host doesn't set it. Since they think
it's enabled, they also look at the submission queue creation priority. We
used to set that to MEDIUM by default, but that was removed in commit
81c1cd98351b. This causes various issues on that drive. Add a quirk to
still set MEDIUM priority for that controller.

Fixes: 81c1cd98351b ("nvme/pci: Don't set reserved SQ create flags")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/nvme.h |    5 +++++
 drivers/nvme/host/pci.c  |   12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -83,6 +83,11 @@ enum nvme_quirks {
 	 * Supports the LighNVM command set if indicated in vs[1].
 	 */
 	NVME_QUIRK_LIGHTNVM			= (1 << 6),
+
+	/*
+	 * Set MEDIUM priority on SQ creation
+	 */
+	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
 };
 
 /*
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1091,10 +1091,19 @@ static int adapter_alloc_cq(struct nvme_
 static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 						struct nvme_queue *nvmeq)
 {
+	struct nvme_ctrl *ctrl = &dev->ctrl;
 	struct nvme_command c;
 	int flags = NVME_QUEUE_PHYS_CONTIG;
 
 	/*
+	 * Some drives have a bug that auto-enables WRRU if MEDIUM isn't
+	 * set. Since URGENT priority is zeroes, it makes all queues
+	 * URGENT.
+	 */
+	if (ctrl->quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)
+		flags |= NVME_SQ_PRIO_MEDIUM;
+
+	/*
 	 * Note: we (ab)use the fact that the prp fields survive if no data
 	 * is attached to the request.
 	 */
@@ -2684,7 +2693,8 @@ static const struct pci_device_id nvme_i
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
-		.driver_data = NVME_QUIRK_NO_DEEPEST_PS },
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_MEDIUM_PRIO_SQ },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
