Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233478-2-16543085875466697614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233477; b=kAnXji7t2GAPxxM4kSj9haJXy+w8xwa3X9e2PAz9/LwzhEKjnu
    7k7bGXpd+Ja9WLrvjDWV+YkQmfLNEWyt2Q6E6TkrZ7i9DAQmRygwvxq4X1CtfVCX
    isgFFWIPJ7ORjeDze+i61MN8gXogoe5GFJwN35LKkn0Uy85q+24aI3ui8VtDm8l0
    kOXb/LdwwQqLu1dkGhxkfkfsHCLHS+TzpmhzqsrpAo5Y56GUCk72XIlqTEefG7T6
    cCzmuWBs6e6nnDSpUinpjvQGOEpovC9FxBdjucc45bpGdcaPD4v8AvoHAd2KFBAe
    8Gxg5XYAkMqHkc+jGlCmZRC06sL1+LB8L+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233477; bh=1DMHLlTLGS
    Lhf4D4THjJeBHOd8yLAmNtT7WL8qlNw4E=; b=tmITc++pC8NbVWIe/XyMfazylX
    JEmXabD/KGVLjj5RfYBK0MtTXHd3/l+SyytGDE7Yz2taudnUhPaNAHyFl/SfKjHY
    5+zz2hleJbFNu5i6BocaeJnE8fcQ/DmrbZy4dPQ1lFv4vqOuuGMcUA9ZGRo83OTF
    rTfUfinCI9mVidRIFx+QQW99iGvNM/mral9VTacD4wftcJioqHh8HwzpWEhCMFQ7
    fiSeGHmHh1lRiVaHMjmQg4GmBG7VVKujT8DtGPehABxsrQfs6q3reUH2e8KkCrFP
    ZTXhku4t/5NPChxXcgBijbu4lmZdUb+8Rq0NV7bsmMrN9ZvqIeK9Y10rGqbA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BBVnRcg2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BBVnRcg2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDqoXVBsbeeK/7XQCfqCBuCx5cgIU9fho6Ys9DQCB4doBeiLBP1q7KNUWK5CQykvQRFFhJJ5cO7lMKVMTGX7VNax8YYVtdo/hWHbXKnU/kvwFosRh/Zc
    Idfc5Jxtxme2GRdsQ7cySdD07UtQoTXIkrMpzIgpsgoC6AQYvNMFWoysRDB+KhEAXLm1KSiLY5kGTepwi5S7K1Mq9U18I83gbq9LJNCbINocmV8Kb6nh07jP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=b_NYci2VRridOww_u-EA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932066AbeDIAYd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:33 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754108AbeDIAYc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 086/161] powerpc/numa: Ensure nodes
 initialized for hotplug
Thread-Topic: [PATCH AUTOSEL for 4.14 086/161] powerpc/numa: Ensure nodes
 initialized for hotplug
Thread-Index: AQHTz5igTDhf8gU1S0mWOxagIKe6kw==
Date: Mon, 9 Apr 2018 00:20:56 +0000
Message-ID: <20180409001936.162706-86-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:zEYJyhH9FU/3AXdf/rQw6Dqxg0+TpCw4uUKuIyVpQquCBKAVz1uX9yuxrKQ2Jzd36ETAt7aSIJoONsnuI7tBbMJAtJtiKbXHM4RxeNPMo+BzcjaC0Cp1qFcEaYRl7sorX/OixOXHbgsb/psEUQgxnUugxmLzhRbYTqZY0eWR9npVfjhhaGntjwxiibRbv7WoUpgEQ4FchK7plQJvV0bBn6uJ7b5BwsSbXpzkTMOYeU7LkZZdv7mScmfh26qG2UxX;20:vg605lN7Gi7ycK6qZ6yVcIr4pHAp0Qqy1Y57ZhtXCB7e/HRurY/3ONjwRaQNSapggNKo3FxxqcjAOJhHLgUJFfN/nucimStViVzpbyc78QGfv/B99fLWEMiHksAIKHGb0Hyf3zddqyXi1qKgm5+x81ZeLD6OhVmoLlgMY3klQcU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 176f872d-678b-417c-b80e-08d59db041e0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09849E98668C8568F5F8EA98FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jGa8XMPCYuTTvPSzz6LZkD6QrlN9ErToJaeGz1v2kRrtwCUliHqrohMgYa2EhQ7K7O6mvcgf6MTm+B1KJsAk9X4kdr734yKXqriCDL2KyxqjuibIoo2x6HlS4EBQLcxEtz4FvI/sJTtfkMY7OUjdONTOxBuXd/ObHJmrpKLAJ56bL/dUPMfOV2VJ/yS44zmwe/bGfefqk+jXC8BFcw5uPUY6O1EsfxarboICjPNE90bf48uWAtLn3bDW3hd7nvRjn0OSNcQ5uhHzb6GdFeFY9McVGE1dGcJp3aGONp0s1F0lDPPAwmiiubbZv+Jsr99EK+VdbDSMw7hWFvFmYNCHFtW/IsulWZj3fxp9/iuSA3DHpbwuoVJSGUd290V5sIw7GHWUM92UQgTc97FS2e60YqkqPI9TbgzEP2ONlSpmoAc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176f872d-678b-417c-b80e-08d59db041e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:56.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index 0356c6cceff7..9fead0796364 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -546,7 +546,7 @@ static int numa_setup_cpu(unsigned long lcpu)
 	nid =3D of_node_to_nid_single(cpu);
=20
 out_present:
-	if (nid < 0 || !node_online(nid))
+	if (nid < 0 || !node_possible(nid))
 		nid =3D first_online_node;
=20
 	map_cpu_to_node(lcpu, nid);
@@ -905,10 +905,8 @@ static void __init find_possible_nodes(void)
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
@@ -1277,6 +1275,40 @@ static long vphn_get_associativity(unsigned long cpu=
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
@@ -1344,7 +1376,6 @@ int numa_update_cpu_topology(bool cpus_locked)
 {
 	unsigned int cpu, sibling, changed =3D 0;
 	struct topology_update_data *updates, *ud;
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] =3D {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, new_nid, i =3D 0;
@@ -1379,11 +1410,7 @@ int numa_update_cpu_topology(bool cpus_locked)
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
