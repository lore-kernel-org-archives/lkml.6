Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236191-2-8808042432839761561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236191; b=pi7/j1WTqdK2HiXTIl5xq7RxHiqCJsy8p1XWeMFwUDCt79Glib
    2qKzwl2aC+yxoQPMOS0faQaqWTpj2d8kE/j29AbXsWEUrcdQxLwnSbCWH+9fUGGR
    +CnebYQaGDLePR1KcJFMKZ4XPJq2qcRIDiq5ctpMhyRH2jWf7esTTKWPm1uKzB7h
    N4EodkF4evjp8rgKC6pMnIZuPfRqSH+tMmwcMRhs9HKr6FFGWrBdMWhA0L4kHBoL
    pxUzfPLfb1WXz2dPNNMdA3DGUXIfAOgkE3+AYRGmWs9SujqPyEHJsQ1+xndd+YAO
    KpStHFEt1hsVmLAsdmiDWw9ExcuQQ4Quf30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236191; bh=SyFy5ZpwuX
    Tts2XXrqGqmvNt25sjMBrvOdKaOEarW+s=; b=FNuWF5CornFo+3GBIRrBSrzYxX
    abg912ZRvBaPWNp4GHkyP+fF6VTChvuQVmPjne4O0a8N02eNJWpM3/OTnVRq8bCj
    Ku0Izqr2kRvnnIym5r+95tFgJBN3L+Qw2fIcvoYU9rz7doMk/0ecOzlVVieY9I0s
    c0+vYUSbxrGBHfXc8eHT9YHPg6qaoJSqvIBdvKc/SP0PXix3PUPCCieVDJbp7uAn
    Dtl0Scso6PwRWgrev2qhX7IGiwySDiXI8Mr88e1YUPN0IQfPVTHcxOTJ+2K2eMsQ
    3+S01X7wxkGP8S/aWxlZiqGZk1UIG28tHjj7PRBtLgjGhQS26Y4yE3t8qyvg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i7E0JK71 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i7E0JK71 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCNvLR/+jjBfqxvPtOxgNP3ZAs6WCVcguHLmq6wqy2hfXr+rBiHOJzkoH8nD5u1Qz/3DN5xcHaE9famTLV9TttAZyHjIGYoBl3wysRCku8YLMfvB9pr+
    ETSrLb7FXlfp8sfP41HUdcAjPXV9xNfCcHT15FuY5zHdZrKCRXRBDzrlQ3QNQxN16w5V0xDRQIwr/wlLF0/ih9yP02IATsxG8+JXvpYrazbDXea0bulX3TWu
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=hMv0cHFdvlu8jOsBITgA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeDIAir (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:47 -0400
Received: from mail-co1nam03on0129.outbound.protection.outlook.com ([104.47.40.129]:43760
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932996AbeDIAin (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 133/162] powerpc/numa: Ensure nodes
 initialized for hotplug
Thread-Topic: [PATCH AUTOSEL for 4.4 133/162] powerpc/numa: Ensure nodes
 initialized for hotplug
Thread-Index: AQHTz5nSSyQY5cDmw0aY8uV8tpAxiw==
Date: Mon, 9 Apr 2018 00:29:29 +0000
Message-ID: <20180409002738.163941-133-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:UoOlnW+Twja30lO7ZxLOk9er2EBFPNhjAgNBk8e6uMHaNfO6BQ7VciFyi8Wer+x7Zn58Oqk7tJ6+9wam6SB7MYQIqPK+iUSbWUsa1MYG2Je44CiOUDCrMFWa5296njtjSyob8Ere7yq9CmJKaNq4p/R2AfjloB2M+GDx4tnfbrNaivdBt+U4d52tpNAsP0K9JehPPcBgLLzSfGgWgX0xy3eLavfxF86B2vhW+KAC8t/4vDAQvbfWOpe1uNe+uqoA;20:8dCoqGpjrE5+Pq/GEy40Sayp/rvVrjtVJ0WbhVZd8WbTKWoMQrpiI00uO22SrUw/+metrG+YmdrTOA/G83LKLfjdeOIRnR+MgCBWN2QiJCBtNUGqPWEqWWnRZP2G1rFH7606y+BFW1fK4gJvxateO8ftb4Eb7dKO4yBNwRtHt70=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0bed7de-2e45-42e4-74f0-08d59db23c03
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10952D857FDEF64248AE5898FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pO/fBi26X//ADF6u9vuMXPfTuF8w+3mCzYVkr3Ib6xDSkameI6h3x5SHxZwFbcMG6WdRMsHpOZNR5AlxshUsWaXB0vvRvTRPeShZ36HXjiRqz68Vr5q1LwLSgCaX+dDN3Q2qeW2T423E7rqH+pAZB5tD4UpMsQ8Ttc+cL2FokBwTa9hcOyNV9ZRvtFCBWGJ1KwaihTuqoOzgvHyJrbXBL4LvPGxnGm09PADIl3ixcVNmwR7VwgpX6anymjxULTCEVldeg+q/A8aGPxpn1lG/q9tAR8hQ7nHsBO9qgMCP6f1YyD3LClrwRPhsjp+gEIiChmmDllCLYHZvPDBcy6Nbwipy7TwTdpqR9NZLam5pkif0FPZyFN5MkTTaDrTHjGgHQQOOBe7RtvwQ0czx+2wd7ZfCLF1gP1RKzNEkki5QcT0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bed7de-2e45-42e4-74f0-08d59db23c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:29.1150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Bringmann <mwb@linux.vnet.ibm.com>

[ Upstream commit ea05ba7c559c8e5a5946c3a94a2a266e9a6680a6 ]

This patch fixes some problems encountered at runtime with
configurations that support memory-less nodes, or that hot-add CPUs
into nodes that are memoryless during system execution after boot. The
problems of interest include:

* Nodes known to powerpc to be memoryless at boot, but to have CPUs in
  them are allowed to be 'possible' and 'online'. Memory allocations
  for those nodes are taken from another node that does have memory
  until and if memory is hot-added to the node.

* Nodes which have no resources assigned at boot, but which may still
  be referenced subsequently by affinity or associativity attributes,
  are kept in the list of 'possible' nodes for powerpc. Hot-add of
  memory or CPUs to the system can reference these nodes and bring
  them online instead of redirecting the references to one of the set
  of nodes known to have memory at boot.

Note that this software operates under the context of CPU hotplug. We
are not doing memory hotplug in this code, but rather updating the
kernel's CPU topology (i.e. arch_update_cpu_topology /
numa_update_cpu_topology). We are initializing a node that may be used
by CPUs or memory before it can be referenced as invalid by a CPU
hotplug operation. CPU hotplug operations are protected by a range of
APIs including cpu_maps_update_begin/cpu_maps_update_done,
cpus_read/write_lock / cpus_read/write_unlock, device locks, and more.
Memory hotplug operations, including try_online_node, are protected by
mem_hotplug_begin/mem_hotplug_done, device locks, and more. In the
case of CPUs being hot-added to a previously memoryless node, the
try_online_node operation occurs wholly within the CPU locks with no
overlap. Using HMC hot-add/hot-remove operations, we have been able to
add and remove CPUs to any possible node without failures. HMC
operations involve a degree self-serialization, though.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/mm/numa.c | 47 +++++++++++++++++++++++++++++++++++++---------=
-
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 8fd8425af27f..3c4faa4c2742 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -551,7 +551,7 @@ static int numa_setup_cpu(unsigned long lcpu)
 	nid =3D of_node_to_nid_single(cpu);
=20
 out_present:
-	if (nid < 0 || !node_online(nid))
+	if (nid < 0 || !node_possible(nid))
 		nid =3D first_online_node;
=20
 	map_cpu_to_node(lcpu, nid);
@@ -969,10 +969,8 @@ static void __init find_possible_nodes(void)
 		goto out;
=20
 	for (i =3D 0; i < numnodes; i++) {
-		if (!node_possible(i)) {
-			setup_node_data(i, 0, 0);
+		if (!node_possible(i))
 			node_set(i, node_possible_map);
-		}
 	}
=20
 out:
@@ -1335,6 +1333,40 @@ static long vphn_get_associativity(unsigned long cpu=
,
 	return rc;
 }
=20
+static inline int find_and_online_cpu_nid(int cpu)
+{
+	__be32 associativity[VPHN_ASSOC_BUFSIZE] =3D {0};
+	int new_nid;
+
+	/* Use associativity from first thread for all siblings */
+	vphn_get_associativity(cpu, associativity);
+	new_nid =3D associativity_to_nid(associativity);
+	if (new_nid < 0 || !node_possible(new_nid))
+		new_nid =3D first_online_node;
+
+	if (NODE_DATA(new_nid) =3D=3D NULL) {
+#ifdef CONFIG_MEMORY_HOTPLUG
+		/*
+		 * Need to ensure that NODE_DATA is initialized for a node from
+		 * available memory (see memblock_alloc_try_nid). If unable to
+		 * init the node, then default to nearest node that has memory
+		 * installed.
+		 */
+		if (try_online_node(new_nid))
+			new_nid =3D first_online_node;
+#else
+		/*
+		 * Default to using the nearest node that has memory installed.
+		 * Otherwise, it would be necessary to patch the kernel MM code
+		 * to deal with more memoryless-node error conditions.
+		 */
+		new_nid =3D first_online_node;
+#endif
+	}
+
+	return new_nid;
+}
+
 /*
  * Update the CPU maps and sysfs entries for a single CPU when its NUMA
  * characteristics change. This function doesn't perform any locking and i=
s
@@ -1400,7 +1432,6 @@ int arch_update_cpu_topology(void)
 {
 	unsigned int cpu, sibling, changed =3D 0;
 	struct topology_update_data *updates, *ud;
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] =3D {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, new_nid, i =3D 0;
@@ -1435,11 +1466,7 @@ int arch_update_cpu_topology(void)
 			continue;
 		}
=20
-		/* Use associativity from first thread for all siblings */
-		vphn_get_associativity(cpu, associativity);
-		new_nid =3D associativity_to_nid(associativity);
-		if (new_nid < 0 || !node_online(new_nid))
-			new_nid =3D first_online_node;
+		new_nid =3D find_and_online_cpu_nid(cpu);
=20
 		if (new_nid =3D=3D numa_cpu_lookup_table[cpu]) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
--=20
2.15.1
