Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238726-2-67330431611897616
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
    1523238725; b=V4mul9n8tW/xfkNZRHOjxdzo0CajMc7jksx7DKNNtiMOd5kWl6
    aJC5fStj9u5ilzKGebtIcycuB+CjQNjrF03ALg4caZLo4jHJhUe00MmsJB5Qm+sc
    8KV9TExf41UPjfzox8G8mD/awxoFVxgXU80Njy6Ltd9vw8AB89LVe1cfsKhq++wN
    EwXpJrBb9jIuIKsAa676jZ8ev+2f1ee1OiAPYsvD4AtdtckKaRr/PNEGgHm4iBFr
    gIR/4EP0a4SfySwSi/xcr12C5dTAOKf+kvkJBO7fbexE0FnGMGJaMxffzntpMh0m
    wP7ZIM8JEqLrrbluz2IyjWKrxQH1DUYsjDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238725; bh=d+eNvSC00q
    gQ6PR9DmpR3bmlAcGLE/Cdmx09a+DxrBc=; b=rj4hTi2JVPjPuAdxCJjaOVmO9f
    JNWDvo4zRo05CQylff96oi2K+pMvXw2thWRIYEIePdo4/VjzEIzQdjA42zvlfQMq
    u+YCxKL0pUiqOjUvQZ1MdLVC51Xs2zHIDxOzp4CiOBSlldGhIVZUzObK2Kwh4L44
    p1rHFyFWNSpxs9DFkQ+UyLyTKtHlwgRnk/io0UbnlVGnhkuRikdpBNu7fso2RjaK
    RxMYKBAHP6772p3wJWkMojIm2R59OrzyEtJ6pNLwTxqICxaibCJ5eTV9aZS1kh/z
    PYjbCnZoF5AsucRnDQgfeXGUJtP0CWZoGmFQSDJx66ATQU3rIlKSTsmRlNoQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SMAlgLa2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SMAlgLa2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIVd2pFaix+R8d4lddh3Te4hLyMjVr1Vbt/yM0NwXqQOg2c9ZlHnO01ROgPv4JO29uCLftqqYNhLOlm+m1NR+qitk3KRLL/mhte90NORejJems5+9tIC
    f4UAZNRz80LnxfZ0uYIi6QZb/18SCu/5ZMVPLO0rivNUXenBv4t2tjSFXU4zTW2a3+Xx2oTN7WSP/mFIk+eP/aqQ9O0wSpIlBK/MIzwHCu4EZmg77aZjlWYB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=hMv0cHFdvlu8jOsBITgA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756565AbeDIBvt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:51:49 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:45024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932334AbeDIAdt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 248/293] powerpc/numa: Ensure nodes
 initialized for hotplug
Thread-Topic: [PATCH AUTOSEL for 4.9 248/293] powerpc/numa: Ensure nodes
 initialized for hotplug
Thread-Index: AQHTz5lZg0C4hUcUZEqiqLYB2EIFQg==
Date: Mon, 9 Apr 2018 00:26:06 +0000
Message-ID: <20180409002239.163177-248-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:TKY5g8yxjhUgJH0GnLQY0W9x/fxQvNqVPBLA6TaoxAziVtmPzOQrCUt0gamfH/6vRmvS5W1qpYL3a0AKuIcjyaQYgeReN2g68O+HAAbmZTETsj5tLb8kPdOdOVv0Bsi3XhSvnHhlObCpC9+zK64xjsFAapYAAhfQgcfo6EW04oGkWV7eOqnO5YS7i6KsqaMBqzId+waSjtL2WRl2xWfPSv/crrgj91xve70p4TU6mR9XommVtdOWCYsSfrYW8ipz;20:kDj4T9/1yNfiYMmJNXwNHgI/5oxRQ26jEYGURUZeaLHh6PvyXlswe5GWjQOfqf81lvED+BwIrzclrXjhmuiJjrjUloHrFLsdI/hFa+gviA3xajVJBc0L3NKvF9f8SDbLSujLnZFyFEnLeGARNfJ/9HiCyV/5heFqXOMIWsUc0Ts=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3625ee20-2c05-4299-92cd-08d59db18d82
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099835628411B92ACD8381CAFBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(575784001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: T3Hn9hVlFr1Ws+38D/UvbVn1T15HUkZ7Sd9vGEpeLf6l1I+bDMppKsy9RMoiMlV0AqOU2n0X0SLKLvdbdf0AHg9rW0p4/7x/KJuyu7B2sKq3SqBJL8DSdVWDEqCKCtcb10y3VBaCFfnNj0osFYdkNdD1xO/QXC90IecZTtEMd+hnlMsni4oikb1yE6UzhD9r4Pcn1eNGe+DSM0YTf7//vRWR/CN9lbB/genNXXlSDWEzAmeqJKH5FfSV45gEZ4DZJFcraQrCOHZD+Oinkyf9JYq2daPU2WCgMfAwBIEXTSy+Jij12PXAzJXEUpbWMd9i4TF0GaXer59Ki/dZKeZF/1MyJG3D2AjzzFLW7wZFedkj73JPz7aZiylDYzEn7CCRBNY6Kp2CEN6VFrQkcHR04BXLwt3t+3bd5fO/RMbgjzU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3625ee20-2c05-4299-92cd-08d59db18d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:06.2537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index 18ea1e49a323..6cff96e0d77b 100644
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
@@ -922,10 +922,8 @@ static void __init find_possible_nodes(void)
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
@@ -1305,6 +1303,40 @@ static long vphn_get_associativity(unsigned long cpu=
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
@@ -1370,7 +1402,6 @@ int arch_update_cpu_topology(void)
 {
 	unsigned int cpu, sibling, changed =3D 0;
 	struct topology_update_data *updates, *ud;
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] =3D {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, new_nid, i =3D 0;
@@ -1405,11 +1436,7 @@ int arch_update_cpu_topology(void)
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
