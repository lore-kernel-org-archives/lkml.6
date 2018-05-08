Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbeEHCdK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:33:10 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.201]:49361 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753721AbeEHCdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:33:07 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpll+JIrShJLcpLzFFi42JJl3ulo5vE8zH
  KYP10A4s569ewWSzal2ExvfE8u8XqTb4Wl3fNYbO4t+Y/q0XzxNvsFjuW7mOyuN/nYNF6eCeL
  xeyWd6wWsxv7GC1+/5jD5sDrcfjNe2aPnWtXMXlsXqHlsenTJHaPEzN+s3h0z/7H4vHx6S0Wj
  /VbrrJ4nFlwhN1j8+lqj62/7Dxav4t6fN4kF8AbxZqZl5RfkcCacXDNX5aCpwIVDWdb2RsYJ/
  B1MXJxCAk8Z5T4P3ciC4RzlFHi74W5bCAOi0APs8T02c8YITK9TBI3N3SzQjh3GCWWfG0Gcjg
  52AQ0JU6+ucbcxcjBISKQLnH+SQZIDbNAL6vE94ubmUBqhAXiJM4+WscCYosIJEtsW/GCHcI2
  kjh+9B8ziM0ioCKxas9ksDivQIzEik07wHqFBCokXvf9AOvlFHCS+HJ/IhuIzSggKzHt0X2wG
  mYBcYm502aB3SMhICCxZM95ZghbVOLl439QcSWJWQeXQNmyEpfmd4N9JiEwgVWi584qJoiEoc
  TxlfuZIRINbBKLtkxkhXC2MUpcPnoaql1LYum5OywgL0sIZEtMWFcAEbaU6Lh0gwXClpNY1fu
  QBaJ3JbPExS27GSESMhJz7u5jgXgtQ+Lfkj9MExj1ZyH5AsLWkViw+xMbhK0tsWzha+ZZ4JAR
  lDg58wnLAkaWVYwaxalFZalFuiaGeklFmekZJbmJmTm6hgYWermpxcWJ6ak5iUnFesn5uZsYg
  UmynoGBcQfj62XRhxglOZiURHnLWD5GCfEl5adUZiQWZ8QXleakFh9ilOHgUJLgfcAFlBMsSk
  1PrUjLzAGma5i0BAePkgjvPZA0b3FBYm5xZjpE6hSjLseaLZN6mIVY8vLzUqXEecW4gYoEQIo
  ySvPgRsByxyVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrxaIFN4MvNK4Da9AjqCCegIwQfv
  QY4oSURISTUwTg7xZyr4v6nWK/uc9ktfA9NHP7dlnDUUl+med8K4++HPjwYHQms7mQv7be+r8
  AkrtidkZS3wmlWVdDbrRIP6WUf1s13Bqmuv3arknfQtsfO9c8CF6dN9nmwtyV44S7ghoHyjwq
  fD5/mqv+9iu1s/8a5+7PuTwlZTdBr0tb15g2/ci/gb6xanxFKckWioxVxUnAgAO5KEiBgEAAA
  =
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-6.tower-218.messagelabs.com!1525746776!22725576!1
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
Subject: [External]  [RFC PATCH v1 2/6] mm/page_alloc.c: get pfn range with
 flags of memblock
Thread-Topic: [External]  [RFC PATCH v1 2/6] mm/page_alloc.c: get pfn range
 with flags of memblock
Thread-Index: AQHT5nLwVHl4qe8WykyzbX8ZVhdgSqQlHIMA
Date: Tue, 8 May 2018 02:32:47 +0000
Message-ID: <HK2PR03MB1684A17E526A6E93444D871E929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-3-git-send-email-yehs1@lenovo.com>
In-Reply-To: <1525746628-114136-3-git-send-email-yehs1@lenovo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.250.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1490;7:koBtzTy7mCcmMFfDppu3KKJVoSSfAijiM06z452z0TNGyOJbNL9MgHY0Gi1HqPoGrUL+BtwTIfNRvRZ5PZGQneeRREuRDabHQ0I0uhx3zF+6rjeoAz5G0pulpTZcD7QllnMqKhcDEfHekMGn9prFT5k1SvmNhkOeMQFJFVrzTXDX2ohBCW4AsR5tnvfQiGyxZn4D1Bb3KTJ+r7sqwBORomjQ/EiEKjPzPyYsbpvD9hRgQR/zE4NYKlxJ0vCVaV7L;20:Urg9TRN9V9jOHYctkMV/gkVvwG2MBgaNmghZPFOzEwy46EVvo+sjxCGkfgqVk5fzBnUZTna/ZC+qdWoxIlRzBEO2K5wgfXNpRS32qVJbnPEwHSvVTGmTQtmWwcv1XWVDxPP5KoXV7d2EXTCk1Sz+KKqzFrMAzeNf9pt7Kv0IZ9Av3savpj2HFhdwzCzf7+4vJFfy6NLUaqk/8txyiJi2lpcbZ1gK/lZgve8/iaHDA550Dw9OpQfL19ILeaOZNHjTf88ocgFLecfyE6txYjkyJfY4JA4BZh8bLkuzF0TcVOQmnrOk46N9C3Nenm9M1uAVwbN+mI8W5XfCkeYYvyX1Jw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39850400004)(39380400002)(376002)(199004)(189003)(186003)(4326008)(68736007)(11346002)(476003)(99286004)(33656002)(6346003)(446003)(25786009)(6436002)(102836004)(53936002)(9686003)(7736002)(81166006)(8936002)(26005)(81156014)(8676002)(316002)(55016002)(486006)(54906003)(110136005)(305945005)(76176011)(59450400001)(7416002)(2900100001)(6506007)(6116002)(3846002)(2906002)(14454004)(66066001)(5660300001)(74316002)(86362001)(3660700001)(105586002)(106356001)(478600001)(97736004)(5250100002)(2501003)(7696005)(3280700002)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1490;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1490;
x-ms-traffictypediagnostic: HK2PR03MB1490:
x-microsoft-antispam-prvs: <HK2PR03MB14903E85000BEB5624618BAB929A0@HK2PR03MB1490.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB1490;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1490;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: TnsSkhtiT/fUymM4zMzYpeoqIcxrXVNKyjN4Ozww+QpcitJgxWzSx96n2Y4UEkPD4kPLecKFJ25mkbUkdNYvWygbAWlK+fg7qb6dtjWBTgpk5iW7yb5s+jcQ9gqS8NxZ5371GmpoxL3oqC3o6S2HeJYpLDN5urN86wVRR29QDtEoAxg/Ycb06Fo0C2/I/7r5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: deee0964-d9a0-4262-c979-08d5b48bfd06
X-MS-Exchange-CrossTenant-Network-Message-Id: deee0964-d9a0-4262-c979-08d5b48bfd06
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 02:32:47.9125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1490
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w482XGQR006669

This is used to expand the interface of get_pfn_range_for_nid with
flags of memblock, so mm can get pfn range with special flags.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 include/linux/mm.h |  4 ++++
 mm/page_alloc.c    | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42..8abf9c9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2046,6 +2046,10 @@ extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
+extern void get_pfn_range_for_nid_with_flags(unsigned int nid,
+					     unsigned long *start_pfn,
+					     unsigned long *end_pfn,
+					     unsigned long flags);
 extern unsigned long find_min_pfn_with_active_regions(void);
 extern void free_bootmem_with_active_regions(int nid,
 						unsigned long max_low_pfn);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1741dd2..266c065 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5705,13 +5705,28 @@ void __init sparse_memory_present_with_active_regions(int nid)
 void __meminit get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn)
 {
+	get_pfn_range_for_nid_with_flags(nid, start_pfn, end_pfn,
+					 MEMBLOCK_MAX_TYPE);
+}
+
+/*
+ * If MAX_NUMNODES, includes all node memmory regions.
+ * If MEMBLOCK_MAX_TYPE, includes all memory regions with or without Flags.
+ */
+
+void __meminit get_pfn_range_for_nid_with_flags(unsigned int nid,
+						unsigned long *start_pfn,
+						unsigned long *end_pfn,
+						unsigned long flags)
+{
 	unsigned long this_start_pfn, this_end_pfn;
 	int i;
 
 	*start_pfn = -1UL;
 	*end_pfn = 0;
 
-	for_each_mem_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
+	for_each_mem_pfn_range_with_flags(i, nid, &this_start_pfn,
+					  &this_end_pfn, NULL, flags) {
 		*start_pfn = min(*start_pfn, this_start_pfn);
 		*end_pfn = max(*end_pfn, this_end_pfn);
 	}
-- 
1.8.3.1
