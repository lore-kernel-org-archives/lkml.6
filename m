Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236308-2-13788234998279027604
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
    1523236307; b=pok72pI5jhgd7o1MkTWWGn9SVmf32oYn8soHGPFnoCea7thZ8N
    zqipPT3bfuTXuzF4WWVlTTb86JTfEhFeBpiN7lR7dq51w/iQLh5G95jenM2KxiFY
    KNpF+aUig+tW9+Z3jucRAPz9+GEx4yi4sU6TXnl91PhuP0sKEuJw1upExfX5rVNS
    iQVVncYTa4GWPbRIZ4Vp3fGIa84kyh/g8gRn3ETqLVl1sK9MITAc4cZzKKfJsAMg
    jfAsaPoWPR9cdGon6eKg5OpGR04a3lrybSTFDUQKMomq9mtVIslb88YuzazN+YJB
    la320TkzAJ+4pUyQoGgYYmGAMnsMlz6/+LEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236307; bh=ByOlUVT9DA
    TQFJJ7GIcQrIArP/ImvbPtbXyAiL7B/V0=; b=fTowExvo1UK1655MjQlZ2KlOsn
    KKm3QkbdLLGNbHU4QuxC+GBEZsO4FlkwkdGteiZSnAlzmCgtzG5WOPzpc0B/dAts
    c02jT2nVDRwCBupg1z/6c3nuvwEoW2zdpYuX8mrVW4meOq8a401HcuNCxc8hu6rq
    lK/WrLNGtB+QUAP5kxiaeO9eicJWXTRZ9MGiYSWBy1W2VX9WBgfhYkd10o8v4L36
    uU+quHTXWJTfb4ioVKKOjLWo/tjzUQ3tUKY2MHCauKL+isGD+d1o2r6lkyHJMxD+
    Oqi1AStMkADTNsUPYy0ZwiLcus8nVYkJ1lCeRTMbFi70CBkzziMHRraXwVsA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FKExHOOX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FKExHOOX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPameDPJ1D3zvwhD4uMAQeKcgzdzIYg8ZLHwYNOvUiciR8nBgOTp/hi/6weePbGYS379NRO1HvpXly8ptzdQBCksXD6Eq+kxbsDXHCH3C3ZY/kd0f1K4
    41xmrRde8kKwsjP2GGt9g7ChR7t39iSCP7zh2ScpFiXBXvD3+X9nklyheNRGh7plYeeE/DqQTv4FnRStZ6baQBkIAZdSzJwXMePasSucjxhG06+NQQ364r9G
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=ker1sbzaWBn98nDuXL4A:9
    a=Va9WcdoZwLmEpGs-:21 a=bm8wM3lKLVm61SVj:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeDIBLc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:11:32 -0400
Received: from mail-co1nam03on0129.outbound.protection.outlook.com ([104.47.40.129]:43760
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755134AbeDIAim (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 132/162] powerpc/numa: Use
 ibm,max-associativity-domains to discover possible nodes
Thread-Topic: [PATCH AUTOSEL for 4.4 132/162] powerpc/numa: Use
 ibm,max-associativity-domains to discover possible nodes
Thread-Index: AQHTz5nROQjwNJ96H0K1uEp5QPu/kw==
Date: Mon, 9 Apr 2018 00:29:28 +0000
Message-ID: <20180409002738.163941-132-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:M/CWJ3c4Oic9WvphRGqG7fZnmK9e9Pe9h7ScEltsLh21ATsq90dmkL2Tl+2O/e7vySk9LCMx98HJoJt/hFW9LtfhMkfU3NtofmBa3INY5bCG5OZ+Wk0usogo+20DuI/uzHaNTUmQd/Y46SmWNCEsW0IBHcmmNm1xbAkVbdFKdhsfv7ONyY/iJnoocqpF3KUJ7fNAKJo1TjHBQPYzaS3R+nyxTvaHTWo7MsySMNsC+SfE6QsMrC6xqP6QSVbCWZ0W;20:FbZPeAn0IUmeNzGe3KF2o/LsjEiNJ3rLnrB0gBKxeQsfBP6hPgQvwcVKn6g1HVGAxyZ5T602g0UU7gA49RBBwAJLzDIiARdm87OumqOYMpxnE1/jSyQQ2Zv7ymGTqKdLZU1kkB7AU1j3oZ7+X5/kXgKMZY39UMeBakVyB6xZjpU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e65f220-6074-442a-50b7-08d59db23bbe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095634765A7B04BBBCB28D0FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: l/Ez1Dkpb9fG7adKP/WHxi5EC2I2Y2JDaADbNQ0Pf7rg+z56eShZJzMS392Se+s5KHNTWHDB30TGx2tvd95R3rxPoKQTeYk0Act8NjLZ/Cmb8drMAeVnAhg+rW8JUA6EsxuZWwn29ahQvLBLh0nRBW+4R5oDX0wImRH6EU4WHt3k0UTvyrXzRcQcakbsQLTyxURXc+HEytZnnhSK291n3zBz6/lJOnkd3bVW72SbBXwxf2b6dqDqLVMd39TVpR1q7PvQyosUf0Q2NfemhJuBO98vs2VyDh3zUBjoTPKGH0Tf2VAvqwzGeJvvT2H2lMYlDcxcdPODfZimLKdK42Cikn0JdfV7S8AHYzskTKqJWJz5YAgTVX/c38wj1+7Nwrc7nbiGGUi3x32a6FKtCxrQeIxhXU6qjow+kmHfA452aZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e65f220-6074-442a-50b7-08d59db23bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:28.3025
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
---
 arch/powerpc/mm/numa.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e7fa76..8fd8425af27f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -951,6 +951,34 @@ static void __init setup_node_data(int nid, u64 start_=
pfn, u64 end_pfn)
 	NODE_DATA(nid)->node_spanned_pages =3D spanned_pages;
 }
=20
+static void __init find_possible_nodes(void)
+{
+	struct device_node *rtas;
+	u32 numnodes, i;
+
+	if (min_common_depth <=3D 0)
+		return;
+
+	rtas =3D of_find_node_by_path("/rtas");
+	if (!rtas)
+		return;
+
+	if (of_property_read_u32_index(rtas,
+				"ibm,max-associativity-domains",
+				min_common_depth, &numnodes))
+		goto out;
+
+	for (i =3D 0; i < numnodes; i++) {
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
@@ -966,12 +994,15 @@ void __init initmem_init(void)
 	memblock_dump_all();
=20
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
=20
+	find_possible_nodes();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
=20
--=20
2.15.1
