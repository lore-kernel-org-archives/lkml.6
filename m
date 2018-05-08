Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeEHCek (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:34:40 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.201]:58806 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753551AbeEHCeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:34:37 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxbVRjHe3rPfVnH1UsZ8tgN4up7GTiG0Rt
  NyGKiu5osUb9I2KK71WtvY1tqb1m6+MG9oWYDshHB2hatbM7RdUNLt5QxCgLJ3IayoeJ0IKAs
  046wADFsLgN7e7up337P+f/zf55z8hyGMH5AmxjJ55U8LtFhpgzYVpRaU3IqZ7Zq7WwTwYfao
  xTfmpT5j3YM0fyR2Eb++5Mhiv81ukTyu/ZfovnE50k9P96wnq/t78R8cPcMyQd3NCD+5vUQtZ
  4V+qevEULn0Yhe6DhsEWJzjbTwjf8mFvYGF7Ewe/kXLLTHf8TCYHiAFjrOvSMc/7tCqF3IF+Z
  jRS+yVaTdZa32bSHlhe4J2j2w0tfySZDejg4U7EEGxshdQXBi/BylFQMI3u/tJfegZQzm6gi4
  sj8rNOghsHsJa8Uogjb/GKG6KO5RODM9kmaGWcHZYGhKVj0EV0/CwoUOverJ46wQGrtIq6x6B
  hpqkcbr4OqHzdluD0A0UUupzHKbYWfcn2Ej54Mjk6FMr2XcMzA3PJg5R1whNP82nsknuAJoaQ
  5kcoDj4OCpIULjfPjz90VSnQ1xL8NM/FXt2AyBrw9m7YUw/OlepPE+En76+QWNy+B0Ww+h3gW
  4v0gIz09nixMIbvSEsg0skBi9TGv8FkyEOvUaPw/ftZ/MdiiCSP0k1riNgNTigxqvSj9KEu9D
  jwX+cweN10C4a47SuBgOfXaVCGTeJRfOfDyFwwhH0COK5NkqeUrWlZdaPXab7HWKdkdJ2Vq+1
  CkpimiTHKJVKX292hlD6X18V6dDCeTv2tCH7mX05nx2K56tMt5lrX5jmywq8mueGoek9KFVDG
  MGtn55Wsv1SDbJ96bdkV7q2zIwOeYVrCG91kZWcYtOxW7TpLOonBl9r66OYKLxxjrCiF3VLsl
  UwJ5XkzjVKte47gTd/iDDqNCUxyKdTmfMcUsep937fz2FChhkzmMPqyk5dpf3Tr9UehR9epTc
  iWvqKF7xX8m0HR0bvH8LUbwp7u4i+6a51dTyyi/ui2+bag1aLs6/Utz/cPLAhorNXV8ivaEnl
  qis6p240VLjHP3qibPJBf7plaaXJlt/iHaM2Maihl0zzzVZImYcjvSE6Gcbv+UvjDTJtyq73/
  bffc9Dt4YW3ecvnf6jP3Xo+OPw1JM4UFG+tKm+stuMFVkssxAeRfwHZ0crmhsEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-16.tower-144.messagelabs.com!1525746866!24501361!1
X-Originating-IP: [103.30.234.44]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "mhocko@suse.com" <mhocko@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "Ocean HY1 He" <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [External]  [RFC PATCH v1 5/6] mm: get zone spanned pages separately
 for DRAM and NVDIMM
Thread-Topic: [External]  [RFC PATCH v1 5/6] mm: get zone spanned pages
 separately for DRAM and NVDIMM
Thread-Index: AQHT5nLueGjGoEH+60mt2lr1nli+t6QlHRDw
Date: Tue, 8 May 2018 02:34:17 +0000
Message-ID: <HK2PR03MB16843F0A91E190ECDBB28F2F929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-6-git-send-email-yehs1@lenovo.com>
In-Reply-To: <1525746628-114136-6-git-send-email-yehs1@lenovo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.250.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0802;7:15uEvg6yWqVs06cMFL0a//aHLkBj7zbwlnS8LIyzK8VY8YobmANQJkvcMB9tz8RcxGH+3WupWglEayD7G0hnpekx4V84jteip7Ih/zPlSRNF0tIfzNpHuxDIyyxcfGfZ3tpiNwyQMjbOqJIsiJePZUoi7QCQti/AUoRwzZg4t7+HPahK6e3hLvIFSbH++2D0BF50MHTmH1hIrsWn0Zv2NRKnZqVuGKuoT+/qsLDsdFG65qNABjrFU+A2XYiWRf2m;20:xtPg3GoIaNNb8aM0zGn/FZch4Udlqyh+m4EpUHvZkivHKsDAEQpYEdeTZw4gfI0l/eqz83Y/bGoTtj07nbzc8IyzB6sBC6TGMJcVGX2YPRWACEf1ADFwCYdOjvz3aojX7YJMfME0X0JLtQKCXmKeZv0eMscPojT6V+CzfXdvMElWN75C3dNQnc06wr76c81AySsvW4TVRzbAL0K3DazZZUfeZNRwGagflRUA01QQO4+gj77AlSnqZtJxpWjwsyv65esNC2a6bEqcSK28ROXqD/+FbSYvQTLw9xNs7t1zc4jTwQTVEs6I1FDpbBr0Yn5XJ2Frzef9j1kjfDxx3Ck5Xw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39850400004)(396003)(346002)(199004)(189003)(14454004)(68736007)(6436002)(106356001)(8676002)(81166006)(81156014)(25786009)(478600001)(66066001)(8936002)(2906002)(110136005)(7736002)(97736004)(305945005)(54906003)(575784001)(86362001)(3660700001)(3280700002)(105586002)(26005)(55016002)(102836004)(53936002)(7696005)(186003)(76176011)(6506007)(3846002)(9686003)(7416002)(74316002)(5660300001)(446003)(11346002)(33656002)(476003)(486006)(2900100001)(4326008)(316002)(5250100002)(2501003)(99286004)(6116002)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0802;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0802;
x-ms-traffictypediagnostic: HK2PR03MB0802:
x-microsoft-antispam-prvs: <HK2PR03MB08022D5CD8368998FE4ABDC4929A0@HK2PR03MB0802.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB0802;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0802;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: Wu3hQ3wnAPf6qT7adUYcOxPL7SWtCdLkNOm4qXfM5vU/Dj+WprEBJT650B13P9OP6CpULq7kwXwr+VPFa//urIh7MG9KkoaZzWQtWp9o3IdYf/PbRhVwaj4H4G/TV3e4BcUBaFJ+NnOz/NsANe+pZXCKi5AxbVdptP9d5zZ9sAEwMvzlrD5PGwdlYBCPhzc3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9574ba14-ca44-4f80-898a-08d5b48c32ae
X-MS-Exchange-CrossTenant-Network-Message-Id: 9574ba14-ca44-4f80-898a-08d5b48c32ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 02:34:18.0062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0802
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w482YmuP006697

DRAM and NVDIMM are divided into separate zones, thus NVM
zone is dedicated for NVDIMMs.

During zone_spanned_pages_in_node, spanned pages of zones
are calculated separately for DRAM and NVDIMM by flags
MEMBLOCK_NONE and MEMBLOCK_NVDIMM.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 mm/nobootmem.c  |  5 +++--
 mm/page_alloc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/mm/nobootmem.c b/mm/nobootmem.c
index 9b02fda..19b5291 100644
--- a/mm/nobootmem.c
+++ b/mm/nobootmem.c
@@ -143,8 +143,9 @@ static unsigned long __init free_low_memory_core_early(void)
 	 *  because in some case like Node0 doesn't have RAM installed
 	 *  low ram will be on Node1
 	 */
-	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
-				NULL)
+	for_each_free_mem_range(i, NUMA_NO_NODE,
+				MEMBLOCK_NONE | MEMBLOCK_NVDIMM,
+				&start, &end, NULL)
 		count += __free_memory_core(start, end);
 
 	return count;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d8bd20d..3fd0d95 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4221,6 +4221,11 @@ static inline void finalise_ac(gfp_t gfp_mask,
 	 * also used as the starting point for the zonelist iterator. It
 	 * may get reset for allocations that ignore memory policies.
 	 */
+#ifdef CONFIG_ZONE_NVM
+	/* Bypass ZONE_NVM for Normal alloctions */
+	if (ac->high_zoneidx > ZONE_NVM)
+		ac->high_zoneidx = ZONE_NORMAL;
+#endif
 	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->high_zoneidx, ac->nodemask);
 }
@@ -5808,6 +5813,10 @@ static unsigned long __meminit zone_spanned_pages_in_node(int nid,
 					unsigned long *zone_end_pfn,
 					unsigned long *ignored)
 {
+#ifdef CONFIG_ZONE_NVM
+	unsigned long start_pfn, end_pfn;
+#endif
+
 	/* When hotadd a new node from cpu_up(), the node should be empty */
 	if (!node_start_pfn && !node_end_pfn)
 		return 0;
@@ -5815,6 +5824,26 @@ static unsigned long __meminit zone_spanned_pages_in_node(int nid,
 	/* Get the start and end of the zone */
 	*zone_start_pfn = arch_zone_lowest_possible_pfn[zone_type];
 	*zone_end_pfn = arch_zone_highest_possible_pfn[zone_type];
+
+#ifdef CONFIG_ZONE_NVM
+	/*
+	 * Use zone_type to adjust zone size again.
+	 */
+	if (zone_type == ZONE_NVM) {
+		get_pfn_range_for_nid_with_flags(nid, &start_pfn, &end_pfn,
+							MEMBLOCK_NVDIMM);
+	} else {
+		get_pfn_range_for_nid_with_flags(nid, &start_pfn, &end_pfn,
+							MEMBLOCK_NONE);
+	}
+
+	if (*zone_end_pfn < start_pfn || *zone_start_pfn > end_pfn)
+		return 0;
+	/* Move the zone boundaries inside the possile_pfn if necessary */
+	*zone_end_pfn = min(*zone_end_pfn, end_pfn);
+	*zone_start_pfn = max(*zone_start_pfn, start_pfn);
+#endif
+
 	adjust_zone_range_for_zone_movable(nid, zone_type,
 				node_start_pfn, node_end_pfn,
 				zone_start_pfn, zone_end_pfn);
@@ -6680,6 +6709,17 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
 		start_pfn = end_pfn;
 	}
 
+#ifdef CONFIG_ZONE_NVM
+	/*
+	 * Adjust nvm zone included in normal zone
+	 */
+	get_pfn_range_for_nid_with_flags(MAX_NUMNODES, &start_pfn, &end_pfn,
+							    MEMBLOCK_NVDIMM);
+
+	arch_zone_lowest_possible_pfn[ZONE_NVM] = start_pfn;
+	arch_zone_highest_possible_pfn[ZONE_NVM] = end_pfn;
+#endif
+
 	/* Find the PFNs that ZONE_MOVABLE begins at in each node */
 	memset(zone_movable_pfn, 0, sizeof(zone_movable_pfn));
 	find_zone_movable_pfns_for_nodes();
-- 
1.8.3.1
