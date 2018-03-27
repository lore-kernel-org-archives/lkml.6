Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174116-2-6866460627897470021
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
    t=1522174115; b=jLAdoIlKqDpl1J+v3XCCmB5qfwYNuIF9kygU23znDTuy41S
    acE1NXky0g9GiNEKowkFni8RzKHxGMsFVd/Sh1IDVtw8NPIlyfh4awz7PCBmUHce
    6T3xEaF5s2RGWNAMn2TH6oicN/UdEgFRTXQdb1jsigrRfi/EyyQOtXJVHBQV1X7C
    RaAsR/WOFOkO4Rs1xIX/wFg2/UoblKdYZFnloczym7eZwTX2o+B/8UTFIXl3uDHm
    BPLHvCLntrUtTS535USNJJ+aVyQ/zgx9FAHK92jnL10H+GByTLhATY6L0IZeXkst
    wygpb2mZozBT35EP4GsAFB8Cx3joUHuL+aJRtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174115; bh=OvWmLAc+4ecyE8ReuK/5uO/QOe
    Y/+IvBuI7eVdkjBLM=; b=ma3bn7yaQteuwgcAsi8+hq6sr9oEtYJQwiQrir7hZS
    xoNQ3jEqs1XCJw2fSASioTePjh8r1Lffyo7+NyNyV2ZlXbBdyXPObTm5qWITfzYT
    z3Lg+lE75auze9nE/PNcfxRDAmJD+bJtUZ9JlkLh62w6dsgTXlS6Yf/JR+9HUSxI
    NVGaUZcfsHc8RiWk10F2rhK1NrwO7Et6DHI28IDdVwqbYwlJdPZcDag/DLrdllFv
    Hc3nUOxloOSbdNyf5fI/49sNU6PKv4oYjJvesUFCRcmkOU370Jd52nQAZP8UIYZ2
    EF6uwFAJKVdzxMBQq/UDbf9/v1slXybg4adrN+YsFUOg==
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
X-CM-Envelope: MS4wfGXRW4oNTWfxB3tOsYFkUR6xBKPDu3RRNrry3CbWt/aMk11lscozG0hrbGiBekS++dVKflv21aSyBY+5oiJ0wlL0q/TBFsvZK7mx3kq7FEoq9tbNcL+X
    64T5UShkga3aqr2OcFR0eobkzqKsCtxyL7Hs4oYM+QfQbsXIF/quIqIM5ebvdMm4HAcnn+Idy0LHz12JYWl/iRx8UUH58WWCPukdb3VcgBeM0Bs9okhFL2Gt
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=cH6R9-kdAAAA:8 a=ag1SF4gXAAAA:8
    a=ZqEw8qV9nNlwx4KyCgMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbeC0SIV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:08:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41302 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbeC0Q3W (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.4 25/43] acpi, numa: fix pxm to online numa node associations
Date: Tue, 27 Mar 2018 18:27:29 +0200
Message-Id: <20180327162717.824794350@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit dc9e0a9347e932e3fd3cd03e7ff241022ed6ea8a upstream.

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
Reviewed-by: Toshi Kani <toshi.kani@hp.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/numa.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

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
 
