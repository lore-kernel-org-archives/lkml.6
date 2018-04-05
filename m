Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeDETAS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:00:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42152 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752313AbeDETAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:00:13 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 4/4] mm/docs: describe memory.low refinements
Date: Thu, 5 Apr 2018 19:59:21 +0100
Message-ID: <20180405185921.4942-4-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180405185921.4942-1-guro@fb.com>
References: <20180405185921.4942-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:c820]
X-ClientProxiedBy: DB6PR0601CA0040.eurprd06.prod.outlook.com
 (2603:10a6:4:17::26) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fcb1d12-cdf0-4352-f67b-08d59b276ad8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:fGKT0o3PLa3bVmg7F51I86/BNTHfpSzGl4fuQyHrYBQOsSr4pTb2FEGsmxqjNn3+0GCLntMUDN03k7XZIzuWFj2Y9pnJ1NOFe0IlSOz/YbO4eQgIdI1XHjopvJO5rYD4XqW9LgpS8xLsrRn/TS9mk6yf2ZLmgOIEvm7iNix+ycGQc2l4MrtCWyu7qCH5SoG3F8/qFpZm2oayhBvrAdKt2CJekLmgmfPosXYpMdHwCieTVkgWCPPQaS2mFhfSd+Hv;25:AMqE38jybu6eHSmSbZNlSrW5KKTS+4LALgc5rhxiRi6gA/MS6pa8Zle3Tf2+MW9zrb3tTz5Zy1R6/sxBPNdvNZotnukHrlbknJo7sdTwIAbac5RzOsnH6dX42rhva4towgd10LSHYeeIznqrwyHdxgP2rF3sAaV/u2W7xseGBn8eqtv1PxHsAA2/FCWG4M84hsfroj6AE68lkGsqam+jhihL8LjGag5pJmXg3PhYJCGGnkd+9lBqInxl20d9rrIbjOV3ebIapg12LoeCu10VWHZt5NHOP58qiteIlOqFpG6CKl/u0VplsOGum0ZTTxlx7XIyzCWyB0FQf6yAl2mLqg==;31:V1m4Mh73TNRdpuBqbHWxc2mRTAVFyNAp+goZjyylxu/hcAVmiOOGQggYHy4gc++ZsyFjXlbVyLXro5DhyjvMlhnGs0VOC9Xto/g40EDJr5HTw0KCYSTlAi35MG6c7FlgPELkYXZ00jTlDPhdjIrw0dkUBUQwJhpF27RW24/ty9R6dkETJp5BVRke0RLd3IMGpL1RSmDRijN2zHMpJGUgx82KKpL1Ua1/zJ5/jUnCwlg=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:n1MYKHKtGmavBXsW13G/fOsbh3Hh6YFtOeIryLu+DSWBHgd4Pg4ySm+hWOoVp7fXSwyUbOT+Ss0rF2f0we1CHkAGHy60Z6sWPiZufbmD4eGgoLwtx4d+rSHmF9Le/xkmCyUcxthAXKgJYkBe/bvONfOm4GFo5DJiN6iUt3OTMZia3AjpUcZVcTrln7exWQ4BFKa66Jg7C11usvDMMnEsSS6Qn7Sar1u00UmBA2t6C/Yp9jquDmpP9fuJ8v+D/ZVQff7/dB3zdNa/IoiT8+mPwYIr+bSueAXNP2YBjB9CE/ooDbAKMfK/GVSODzyK82mxvMoePu3bsvQVq+yyvtqMw4hx4VQALrlIgmdMPl/LUprLj+gxNp7byw5vY7iJYGAD4fD3t8Hr3MKGV33DMPPEFLZArUBUlRbiNhngljrY9RTFRk25P5k0SgkmxWKdeA9IfmBTrkb49a9vhr437NayC2e9gObNzs5qr3x0OMQSdmg92xW0MkpzrSPGFYHYtCj1;4:UqEHdst+N/JKaeK2WrsqK0zSfJbFC8wssuLQfSTFW3T/+pJGkszRTrCl13ws+LNB/ql47n4gYeCDSUGS2Xog8NUgNqPqCgurZZacBzMED9pTHlQ0coYr/O0z43I7Zf/EEcAF3sY3UD8KTlUNUryYkcwlnUXSeKDkUFBm/iiRMJFvw7lz/G1QA3qW9K3fL/XylsfXcC4OtRRRps7ixFWxCe+s2Ob/67b9jQxFDC/QxsaslZGU+AJmBuXHpBlhc7R4oJa6ExW2YY3cp3Nasj3TmJ5aPO5VJFiMOGA7HPmyyrAg8ALlL4npnsngRM1gxu3hx728P64Ypky7zKM1Q4YCfICCNvcJLFih5zgRIMjQWxNE4h7i8dO24fc8lnT5eieU
X-Microsoft-Antispam-PRVS: <CO1PR15MB1078DC420872AC75A9ABED03BEBB0@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(2361001)(2906002)(316002)(5660300001)(76176011)(69596002)(51416003)(52116002)(446003)(52396003)(106356001)(47776003)(11346002)(86362001)(46003)(68736007)(305945005)(6116002)(486006)(478600001)(7736002)(16586007)(59450400001)(50466002)(39060400002)(1076002)(48376002)(36756003)(6916009)(2616005)(6506007)(53416004)(50226002)(6666003)(4326008)(8936002)(54906003)(476003)(97736004)(186003)(25786009)(6512007)(53936002)(16526019)(2351001)(81156014)(105586002)(81166006)(386003)(8676002)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:IEmbeKYeJjkcfVqeVgVIrJQtmhgpOy2+fvbGYhWpB?=
 =?us-ascii?Q?mfo26hbaNMa80R9gOJws4EXaBPC89izsQrNz3yb6TmrwyqLRfS+NaNpWqXb0?=
 =?us-ascii?Q?DWL9kAeKGuHeqJS0YJkagV9/YLs2YU4JG0TSqZ+mfLGZQJahYJZQnmed1a9p?=
 =?us-ascii?Q?WAjq71GZir8IdcvFvobXWgnoRuxKa+NRkyfZIde0z/iswqyqIKTBmFsyCz5G?=
 =?us-ascii?Q?hPTp4IaRbg4Zq+7w6Fm4FOdSQfShSjkT3qsxbii2scXdJInNGowsu0oZ89Kk?=
 =?us-ascii?Q?gk6WjrxZeaJradwMpvtHTWN5bY+bMwaayXp3t0wylRwoYfc5gkUIwZwCzQ+k?=
 =?us-ascii?Q?zmpS59zyWBc88X2WqUxRcNlOogZCbVRHMIa5bXvxCTTk+sxYcJDgvuO3VniW?=
 =?us-ascii?Q?2bqSsix7gzPl0AZg8q8ODURJbla1axtfXPJGov02iWe7AX463H30jcC2McbT?=
 =?us-ascii?Q?1R3zz1CUDChS81qx50Oltmuv1cbkvJXLqYznQggt1btSFPnL2rJT7GHkBL5n?=
 =?us-ascii?Q?YtdtLC7evTWFteTa6AZT9uNJDPoQ46zmsHOLvJwfU9i91+DAho08LPkGoh+g?=
 =?us-ascii?Q?2l8E1Ez7OlSV/YIB+kfgw1BrRJ6HeAFHUiAa3VokgvI+DMxirXSrgJmeX1MR?=
 =?us-ascii?Q?QPKo+t7t8rlgZ2byDJk4jDPMJOsHi60FBrpOaHPBZXSlyIRCK3noHEaXxUpx?=
 =?us-ascii?Q?l/LXMpb33zIk8jbHB5a83uDL3/D/eH0bPL7HXzt8mipL5ycRfuVO5jwkrMEF?=
 =?us-ascii?Q?Ewd/jKyaN7wHAIt3Ns6ZAkbDgElFG2WPm7UsxMckEKe+K2uAMEOOsvkrKkSf?=
 =?us-ascii?Q?bOduuJheoHQYirbmIA6gg3H4e/Jun38t/FbCZLIoBWNHpMrwaWpgILceibAp?=
 =?us-ascii?Q?tnZP1zHsDaHbuYKK4Eb4dkwmA4WTSmDiv8mzi4tBWZKKDTwqiSk/PjqRsNNu?=
 =?us-ascii?Q?uZFj+oMnw2qbn6m0iPVH7V21FjaZxnYVilO4HTkq/DHlwe41+TRJnSqlg+1W?=
 =?us-ascii?Q?n7YGrMELh1argtHlSLWXN2zvZomvf1M3T3RMnly8y/w1z9qbTL/XGi5rY32D?=
 =?us-ascii?Q?s7fbxM3MftHUTgk3AJV75Un0qRoyfshCB83wNwS8X239cTggzupRoBirMqrl?=
 =?us-ascii?Q?1hhYybfz1AtVWGtGcpYrYyl3ycCixnq1xLXPfJyDIWk1mWYAIAV3ZrT1JM4E?=
 =?us-ascii?Q?T7eBWYCxazWJcgEYEFFXskCBpkf5Fh9l9AFn/I/pTBZLw9eMsTfGh2ulNNEB?=
 =?us-ascii?Q?rzoJOsGh9kAta3KTPC7fw6ZhJ3jUpayCj6TsnCaB9I5212xudlAo3L0s5wjl?=
 =?us-ascii?Q?GZFXCMj9/Z5A2ScjrQsmoy3Piczjo7L11jFzjEzSwkG?=
X-Microsoft-Antispam-Message-Info: PsfvWlOF7fEnisRi+Kmz66akvnHuFokGZFBx263/gGbUyktJ2K4WoNy3gwqE77+XT5iT3k7xKyugfX3mtStzmsnJmOOGciUwE6ucqM+Yg/eZ2xlvjhWCbnT/+DK1K6VyIDww58eYg5A+Q6Ud4eoMsS84eVr9WPXUFx/ovi00b0BWfjOqPTs874Vby8GL6Lt7
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:0M0ZeJmKJvfFvISX6/617V5qPFHGE3QsIktbZi6liTtxHGqeADYM/erT+qnoFePV/TLFVnGnlr98XrPI/W7oA83rTsTskDCIHe2uREaNbTdeUrpswJE9Stb+2/YlDCUqCEojYQeA1lTuLDZHfFpSo9b6qf4Z1Htym6T8NCQGZlQsMrALkEzEHqnWL4sAkDAaSpSiJlCX+1VJUkTWehvKrjiBDuQvOpqDEZFZpXJY7fT2ZI/vsrrWLYRxewRcYdNIDGYXtv0sZklO/rSR7HCeyyJFZOLHm5uFeGm7oQA04eQCqjC9PejPvNWts17VDyDiJrQxQtNRNXZcXR04hkW6J/5iVdgK5aDKr2TynJ1+CBp5BGDY97TMqTse4H01nn7+rUR/1iY2RRlcLgoPO73M7wdcaTM/NiE4FnqXhbtESWQn75xEDTPm/JCCwbhn510Pd2vampslw62Me8pG4imRBg==;5:h6EV1N+UhaqjRXwNxaJSbkmDBAVfebKx2v/psmzf9850mlSZIpoEDfnj5Ov+d8Zc7fI07CXTgd49TMb3pavT80cwdktMa146qkE5qhR+XSBEFL47+XCmSlwlJSw9fpvyuCSYzeumkZjMMidY4sXm3oEcjJwLX0NYBRAmiZyF/6o=;24:jn20e28pZyIpp7Bas7w52Z7ffk0wX1YpWymHJbrh/uK5fUyGxAxQwKFT3mqt3aXd2rB9UI/JCRanwi7Gr2h8xdHpF/HTvtKJ51/56dTG/ns=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:1+GJZB5auKnNr/ib1HMlsf+esVzKpC40uwThSOVYM0K8FSSW2PTpcSy0PrZG5VYM/+WPtZjO8nIQuD7Pci1n07xggydBEnv6hn+Te9xNfWhjI+aDY+urWl9x/7qxBrXA1WJZ6bQRmQt0E4FBI+EwHfd6tambNTzghZYYVyX5qHqsLzQZr3NG0+MmwEpLVkoqjGzE5gisf91c8L++HoAc595a8TpbwJfANawKNLRJ9edHQJhR/kpG1OBBx/vnZJRQ;20:KcOVXTKrdgOEXAKsAXdcUKEZXSUE34UEYtoflNhs/fjh2XtBv8sceQFwvyw/Y3+tnN8+vP9WtaKQuzeWpcLjOEsIBfYz73E2+g7KaKsaxrgw2euLQxhJtjvR39UmYKPtH8hScXhb2lkVbUFR6whvjRZizHhgie/PLmkvD8AB2Nw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 18:59:52.0488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcb1d12-cdf0-4352-f67b-08d59b276ad8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refine cgroup v2 docs after latest memory.low changes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/cgroup-v2.txt | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index f728e55602b2..7ee462b8a6ac 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -1006,10 +1006,17 @@ PAGE_SIZE multiple when read back.
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "0".
 
-	Best-effort memory protection.  If the memory usages of a
-	cgroup and all its ancestors are below their low boundaries,
-	the cgroup's memory won't be reclaimed unless memory can be
-	reclaimed from unprotected cgroups.
+	Best-effort memory protection.  If the memory usage of a
+	cgroup is within its effective low boundary, the cgroup's
+	memory won't be reclaimed unless memory can be reclaimed
+	from unprotected cgroups.
+
+	Effective low boundary is limited by memory.low values of
+	all ancestor cgroups. If there is memory.low overcommitment
+	(child cgroup or cgroups are requiring more protected memory,
+	than parent will allow), then each child cgroup will get
+	the part of parent's protection proportional to the its
+	actual memory usage below memory.low.
 
 	Putting more memory than generally available under this
 	protection is discouraged.
@@ -2008,17 +2015,8 @@ system performance due to overreclaim, to the point where the feature
 becomes self-defeating.
 
 The memory.low boundary on the other hand is a top-down allocated
-reserve.  A cgroup enjoys reclaim protection when it and all its
-ancestors are below their low boundaries, which makes delegation of
-subtrees possible.  Secondly, new cgroups have no reserve per default
-and in the common case most cgroups are eligible for the preferred
-reclaim pass.  This allows the new low boundary to be efficiently
-implemented with just a minor addition to the generic reclaim code,
-without the need for out-of-band data structures and reclaim passes.
-Because the generic reclaim code considers all cgroups except for the
-ones running low in the preferred first reclaim pass, overreclaim of
-individual groups is eliminated as well, resulting in much better
-overall workload performance.
+reserve.  A cgroup enjoys reclaim protection when it's within its low,
+which makes delegation of subtrees possible.
 
 The original high boundary, the hard limit, is defined as a strict
 limit that can not budge, even if the OOM killer has to be called.
-- 
2.14.3
