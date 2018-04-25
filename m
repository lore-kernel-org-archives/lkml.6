Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524652875-2-1139819509601293556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652875; b=e0jI2tjiMmjbg6nx0prnTibtsO4pE1ZbxA/XloHOCn5spFGcCS
    GJ1LrNgySdUYWgq9jtrDZf2n6fzGFqVCTj/HO2yqw4mQtk5lNLFRrx6ojG7x9MY3
    wGy60cmqf/Alt4srFaEjNC4c7FLDonsylGhYAkiFGp4Viio1yIHP2HTh94fOWlOq
    MfgmyUR7rXUTODaiFfuc6XtXVhQ9zfnFmcrfAUoSiFscdqkpc1o9X2sgzMY++q8J
    pTybZESI1ejye5gtEyD5bljhJcZtJ/1+/yrXh7583bAgtiWTzAbfzBVQByPw8E9P
    eLUQMW4ZHAeiUC8cACBSL1HZSfipZ4Z0Qrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652875; bh=WZff5QMqU5+G2p/GJczz3Llxp/cLGG
    PBkd2lxpIUA14=; b=Ke/aT25RO4Wl3YvglzU0UMhi7dLOXet2pn4RkH7/jfgPq3
    I43L7Mb1bWFjclD6beI2DUGigwpm8WlWeU45YPfpCqoMEWL6rc/lGEsz5WtWDz4U
    IIf7e6ZQwanZGWSths6td5MfYFOZJq46z+gJeJD5UH4YUQdijUn78UiP+gfOx2/c
    Xr/V88BdVvDdifG6rCyoddi8zV10ziKjKnQ5ZPJDzXU39nN48QuEqaNlE3VnwRrb
    8sE67UV3keNSclciObfBa20biM81L0hHL0iyrfiHafi7c7bmCHP7tl8IXhu7yDDw
    aqocljdITJAeckgAy9AvVHd6rYnqmjynJukAoPUw==
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
X-CM-Envelope: MS4wfEgBNbQH/Z30gY83GufYYOpflmvQPTLB3hWW6SkwOdsYgzd+BDrjn3frtqnb7q78RWPgb709zad0PTUvMhIiuRn/nIfhtFV/woyqp+MJpsJM1+vZvf5R
    rxsjxyDE6zj5cq/MUpEAbEc0wH1pFFAGBN9Z7E2qCDqHiuQn38zmOEkyF9wQaiClNzLh2nTEqXH+Iwvd+go5wbkQ6zuAEd4OFyrljQbo4mwf3hkLJ3joV0jh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=ker1sbzaWBn98nDuXL4A:9
    a=c5f4_iBJNndPm3ws:21 a=_pSWdaq6HwE5PMKV:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDYKlL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:41:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeDYKlH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:41:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 097/183] powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes
Date: Wed, 25 Apr 2018 12:35:17 +0200
Message-Id: <20180425103246.371393406@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bringmann <mwb@linux.vnet.ibm.com>


[ Upstream commit a346137e9142b039fd13af2e59696e3d40c487ef ]

On powerpc systems which allow 'hot-add' of CPU or memory resources,
it may occur that the new resources are to be inserted into nodes that
were not used for these resources at bootup. In the kernel, any node
that is used must be defined and initialized. These empty nodes may
occur when,

* Dedicated vs. shared resources. Shared resources require information
  such as the VPHN hcall for CPU assignment to nodes. Associativity
  decisions made based on dedicated resource rules, such as
  associativity properties in the device tree, may vary from decisions
  made using the values returned by the VPHN hcall.

* memoryless nodes at boot. Nodes need to be defined as 'possible' at
  boot for operation with other code modules. Previously, the powerpc
  code would limit the set of possible nodes to those which have
  memory assigned at boot, and were thus online. Subsequent add/remove
  of CPUs or memory would only work with this subset of possible
  nodes.

* memoryless nodes with CPUs at boot. Due to the previous restriction
  on nodes, nodes that had CPUs but no memory were being collapsed
  into other nodes that did have memory at boot. In practice this
  meant that the node assignment presented by the runtime kernel
  differed from the affinity and associativity attributes presented by
  the device tree or VPHN hcalls. Nodes that might be known to the
  pHyp were not 'possible' in the runtime kernel because they did not
  have memory at boot.

This patch ensures that sufficient nodes are defined to support
configuration requirements after boot, as well as at boot. This patch
set fixes a couple of problems.

* Nodes known to powerpc to be memoryless at boot, but to have CPUs in
  them are allowed to be 'possible' and 'online'. Memory allocations
  for those nodes are taken from another node that does have memory
  until and if memory is hot-added to the node. * Nodes which have no
  resources assigned at boot, but which may still be referenced
  subsequently by affinity or associativity attributes, are kept in
  the list of 'possible' nodes for powerpc. Hot-add of memory or CPUs
  to the system can reference these nodes and bring them online
  instead of redirecting to one of the set of nodes that were known to
  have memory at boot.

This patch extracts the value of the lowest domain level (number of
allocable resources) from the device tree property
"ibm,max-associativity-domains" to use as the maximum number of nodes
to setup as possibly available in the system. This new setting will
override the instruction:

    nodes_and(node_possible_map, node_possible_map, node_online_map);

presently seen in the function arch/powerpc/mm/numa.c:initmem_init().

If the "ibm,max-associativity-domains" property is not present at
boot, no operation will be performed to define or enable additional
nodes, or enable the above 'nodes_and()'.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/numa.c |   37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -887,6 +887,34 @@ static void __init setup_node_data(int n
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
+static void __init find_possible_nodes(void)
+{
+	struct device_node *rtas;
+	u32 numnodes, i;
+
+	if (min_common_depth <= 0)
+		return;
+
+	rtas = of_find_node_by_path("/rtas");
+	if (!rtas)
+		return;
+
+	if (of_property_read_u32_index(rtas,
+				"ibm,max-associativity-domains",
+				min_common_depth, &numnodes))
+		goto out;
+
+	for (i = 0; i < numnodes; i++) {
+		if (!node_possible(i)) {
+			setup_node_data(i, 0, 0);
+			node_set(i, node_possible_map);
+		}
+	}
+
+out:
+	of_node_put(rtas);
+}
+
 void __init initmem_init(void)
 {
 	int nid, cpu;
@@ -900,12 +928,15 @@ void __init initmem_init(void)
 	memblock_dump_all();
 
 	/*
-	 * Reduce the possible NUMA nodes to the online NUMA nodes,
-	 * since we do not support node hotplug. This ensures that  we
-	 * lower the maximum NUMA node ID to what is actually present.
+	 * Modify the set of possible NUMA nodes to reflect information
+	 * available about the set of online nodes, and the set of nodes
+	 * that we expect to make use of for this platform's affinity
+	 * calculations.
 	 */
 	nodes_and(node_possible_map, node_possible_map, node_online_map);
 
+	find_possible_nodes();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
