Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1812510-1521170265-2-17447024768214906297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521170265; b=uZfntKhdQAEpaMVdI9bVh7GWCO+qwfMJoKNxa1cF2eOX9Dz
    4Yo1NwEVGqzUMRoTOx43e6lHUegJ8BXbYPCTRty7+RjZl+H2Byx5zdHjGUqlLcDX
    q2sDMDN1d/HX6wiDoYs/xDTtp3rmKu6TTOMuhZ7Ix1Hs6fZS0RRyQzmGmCe/FEQ0
    ghiNTmlcVfDjUA8RgmL66DrqqM12LCgfDfWOEtxJXJQomwaZsMWTsv7kHRqWTLfk
    TEWStER2Zqqkc0qPZLGA19arpkO7mnseTz+DvVXiJoriC32Zsb+kQrBj636NBntz
    GBGOZeekjPCBxjDQLL2Kw8k6i740fBjjsXLWB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521170265; bh=mzhsQQ93tNEPyA3NiBRvviDTzt
    XpAa+dTHHYwGGzOLQ=; b=qqlerueuusJL2DojwXtfMPM7md+ZJIqPCxxMaGLT9a
    pMue76w0TdPsYPsszlwMEwifAjGDj9buts9Ik0bTRKn6UeNaIxkYy0nD+fa/H3iX
    o3QVvTuAioY/dGO8peGCSpwvsU43HQ6Mnkw8QfuE41WFSAlc2ODCNm1l+Zhs4pnq
    n2aZ45pmNQ+SH0TNQln7NpAjvjQU2q7NIlfrp+D+TllXglEo7Z7jiEi+CkhNfE8d
    JbVucR/rjH+YzOj2lx/V/TtmwyECghhoY3aSM9C7ObsvjPd495fisanII7SVf9fg
    HkBZtWyCyoH4JD2dSmE8bDTqsCQIjVkVXBLnjl3nZxjw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbeCPDRn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 23:17:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:2730 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751966AbeCPDRn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Mar 2018 23:17:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="39383405"
Subject: [PATCH] acpi, numa: fix pxm to online numa node associations
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 20:08:37 -0700
Message-ID: <152116964416.8343.514895686858363582.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 99759869faf1 "acpi: Add acpi_map_pxm_to_online_node()" added
support for mapping a given proximity to its nearest, by SLIT distance,
online node. However, it sometimes returns unexpected results due to the
fact that it switches from comparing the PXM node to the last node that
was closer than the current max.

    for_each_online_node(n) {
            dist = node_distance(node, n);
            if (dist < min_dist) {
                    min_dist = dist;
                    node = n;	<---- from this point we're using the
				      wrong node for node_distance()


Fixes: 99759869faf1 ("acpi: Add acpi_map_pxm_to_online_node()")
Cc: <stable@vger.kernel.org>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Rafael, I can take this through the nvdimm tree with your ack. I have a
few other nvdimm fixes pending for 4.16.

 drivers/acpi/numa.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 8ccaae3550d2..85167603b9c9 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -103,25 +103,27 @@ int acpi_map_pxm_to_node(int pxm)
  */
 int acpi_map_pxm_to_online_node(int pxm)
 {
-	int node, n, dist, min_dist;
+	int node, min_node;
 
 	node = acpi_map_pxm_to_node(pxm);
 
 	if (node == NUMA_NO_NODE)
 		node = 0;
 
+	min_node = node;
 	if (!node_online(node)) {
-		min_dist = INT_MAX;
+		int min_dist = INT_MAX, dist, n;
+
 		for_each_online_node(n) {
 			dist = node_distance(node, n);
 			if (dist < min_dist) {
 				min_dist = dist;
-				node = n;
+				min_node = n;
 			}
 		}
 	}
 
-	return node;
+	return min_node;
 }
 EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
 
