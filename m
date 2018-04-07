Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4175590-1523113283-2-13434099965595870032
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523113283; b=tuuGRO0U0EB3B+MbvGYwXDykZOIkTNM89B0om9zQ5mP4AGjVEk
    rkmx1boFIwivnn9CuCHWdzi5MFlxmpaJ/PtIV+tGzDNwMyhB2cyqr7l+MpKd6CNe
    hbi5QfSl0v0CS+wkx8AS/uiCHPXni/VNQFitQxG3p83y8h+3bJaV8nh4UZsbHoZs
    ANQF25t2e/W7EyYgRRN0VwenNNYif5C1S3q7sc2D3ea6u4ubNvd4ZGffO84b/q2P
    i+OepSt+NNMFxnccVNv+9DCw3fB0JbsGEjNjEe5dVTzyVXAjDm4l7JVu7di9/XYd
    nmlBgolvxgBXJjNYyt/8Z0fa9YtPbpvNbdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523113283; bh=G2OU5ugkqyg8YUARiFxixj4XmifPrV
    pWzJCmEvFv3L0=; b=Csa6bR2rIUZFrJMQWto66zsRUyW5VHZXhbAFvua3hOmiAg
    +7d8rhQ7r5jDEjvxW/R7WsxsYhVUcKnYgqviK1DYy/yzVUL48vBmSOelNiW8wZtt
    a1nhbtKCS6/6btI3hnnflvCWwh+jqc0JOJTGHKLAErWbcJPGcH9XUS21L1FjsGQ5
    0s1/yx0tJQ5q/ul3wXO1MQFKp4sYAFN53642uB4wbqgAEh58MIiZyk7YeR5QuRh6
    ijBHgrGC9RibAfyd/zHefo5roQyggsNxK2xIAk9kJ6GzLEI20i4VysUFGmeO4YJE
    xwTXGZ4bdX8QeF+W35WyWJqLxcBjxEk8nQ/Q79Vg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKyTtzlJZfsUnYfhedYyd4e9nW1Fk2FJh4J1V24/VddiZPn3Z4qjTEHLbrnY9C9iemqPYhwIY+QhiPZ1keUha39zvSu2uEb/D4GmzrcHThWol3J5Xqz1
    /dic047fXyn3JAG/fwJfMptqHgcICkDTJ69zesnzcavT3o/Di3SgOqMIf3MeM9LaQkv0OX44MAZZ7JySyTQOjA7xfno0na5hY0bD81j82d3+dJnwGqjJUu7Y
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=w5gjqegq9f1TaFJGYl8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeDGPAo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 11:00:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:56146 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbeDGPAn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 7 Apr 2018 11:00:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="44244223"
Subject: [PATCH] libnvdimm,
 dimm: fix dpa reservation vs uninitialized label area
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org,
        Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 07 Apr 2018 07:50:46 -0700
Message-ID: <152311264681.13507.15332881622190583231.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

At initialization time the 'dimm' driver caches a copy of the memory
device's label area and reserves address space for each of the
namespaces defined.

However, as can be seen below, the reservation occurs even when the
index blocks are invalid:

 nvdimm nmem0: nvdimm_init_config_data: len: 131072 rc: 0
 nvdimm nmem0: config data size: 131072
 nvdimm nmem0: __nd_label_validate: nsindex0 labelsize 1 invalid
 nvdimm nmem0: __nd_label_validate: nsindex1 labelsize 1 invalid
 nvdimm nmem0: : pmem-6025e505: 0x1000000000 @ 0xf50000000 reserve <-- bad

Gate dpa reservation on the presence of valid index blocks.

Cc: <stable@vger.kernel.org>
Fixes: 4a826c83db4e ("libnvdimm: namespace indices: read and validate")
Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/dimm.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index f8913b8124b6..233907889f96 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -67,9 +67,11 @@ static int nvdimm_probe(struct device *dev)
 	ndd->ns_next = nd_label_next_nsindex(ndd->ns_current);
 	nd_label_copy(ndd, to_next_namespace_index(ndd),
 			to_current_namespace_index(ndd));
-	rc = nd_label_reserve_dpa(ndd);
-	if (ndd->ns_current >= 0)
-		nvdimm_set_aliasing(dev);
+	if (ndd->ns_current >= 0) {
+		rc = nd_label_reserve_dpa(ndd);
+		if (rc == 0)
+			nvdimm_set_aliasing(dev);
+	}
 	nvdimm_clear_locked(dev);
 	nvdimm_bus_unlock(dev);
 
