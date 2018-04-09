Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245690-2-13476561718298283572
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
    1523245689; b=aoF26e4HYCJpFIZwrIZzW6aJTze21IBh2O0JxazSo48kXRUdXf
    GoEy+5YSTwM74KzlYkpSsHjjIMQ2yrKon1LmsqLNSMpSC4nFlFdJBU8sc1WmxLAZ
    7G0iuckkxJlAnwC05vszBlouHVHrd5PC54wqHrE9iva35uRxvjBgTrarZtCncLr4
    Bx9lxDH1On+ToJyUJCeTAIv961Z+ZSqnwh1k+CLqTGXJi5fvwTHn/W3dbFmdvsXm
    e8ag/SAaib7ND565tEIREoJ3HCvAJ/NYQXOeLke8oIm3afJkf3FX7n0MC1cn1BVB
    eRB7gaVe5HQBlDla2Oj/P3as9kVNqe7pq4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245689; bh=T/1guFsy+C
    QEO3UEFOK+J5u/RJbii1q/ioxyV5XXBvQ=; b=uhxgEtbDYl/qDF6yoaIxI1Rg3V
    GDZgiH2GQoJZuEXVNUfSLJ0JVLvYnmlCVxPjs8M80HH+M+kNQ6jbqxXv9xh8gvwQ
    1TeiUFISUuXsxE26zT8egJTcXcEBGEoohWG1OAEBdpP/Duil+BMlRYH8IhOlg3R9
    fNyo3JeLq7b8/LeL42MocDDUPaYZP/M52V1jxFeWd6piFPTt2YnOYwp3qDmNFlip
    LHtFxcIvlz7r3CVMCATjPwS75F9UlNDvOw1i8Gqu+N1sWy9SmMk+EwnCGd71DpDX
    jk2bhEv5eQgHmhuZEWJz4GPDF+EMEi4rjaYLEAEl0eBqo5ycl6kd9jMm58Yw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NO2vZFYE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NO2vZFYE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCETAnI5Qx+8NezPSSBf0KnuPlC5ciDIF9B5OBLWXD+g9RWkNvm5oRZDYlQnHdcTzCHW74New1giJCM8Wc0Tu2bnz8zWfpRTfFVdSFey4SuBdp9BOTay
    dxFxlLD+WfcNp0zXulxKnH9P/BlYvy8P0aXCgvgc8/9ygOIVbF8qvOP1NHh+elLUDLt0ouCjbMKK3J7OlzqUY6s6gse1GnCOY0N8ljAFq4c3U23Q+VXsC5JW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R_Myd5XaAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=5UkYvFHTB3ZtRazDmScA:9
    a=nBcaKYlxCHDu0bf2:21 a=v-z3_9pDjzYYlBDq:21 a=wPNLvfGTeEIA:10
    a=L2g4Dz8VuBQ37YGmWQah:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeDIDsG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:48:06 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:5792
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754086AbeDIAUI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mel Gorman <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 124/189] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Topic: [PATCH AUTOSEL for 4.15 124/189] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Index: AQHTz5hHF2F1cF1ajkm/qzD0Z3NMUQ==
Date: Mon, 9 Apr 2018 00:18:26 +0000
Message-ID: <20180409001637.162453-124-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:dAvB+CXTLDIWQ5q2Yklj5GCkMMY31gATEgqKGJ6stwPJUNH9BZgIcWJecm/NOOyn5eVptbb4si001ieqEtLJC7t9OVHn1S/WHdQWQTO/9N6N/ugkaV9rW6SRKhWIwqZl2kk2JcJaVeeCOiDfKhja9fWisxdVEAt2X6NwIR7npOpxDtvXAfUVryfvQWLcUZUgOzU7kNGQcPeQodlpT5HH0cOmKCupLEmbYTnYQBoQHAHfC1+NSybt7lIff2gZpVu7;20:LyPk13G1DSvVWmu7NqiHp6ttktIAwB2YfDD/wUu6qbj02hXLe1EivmbKvEk3c4HOfUIcYmLr2POCuZHAm5OwrTfieLQhbKLvyddyxuYkCmNzYLr/aOV28LPzJsRmT+OQ2zm4vTbxEi/BpxaUUzVZEswJJlq2m3OiTivOkO4i1vA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9eb5ef80-cd3f-43a6-93ad-08d59dafa4cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726C0E75DA06F6301E9A93DFBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6306002)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: E3ig9WAKeub09PYHy2VDXucGrz1OGZjHdTfcFkYwr8oFp3nyaE6dPDmX2EY4oSh0chfoVAn9a7fnlAUimtvXygMCwUi49t4m8zZvroRwuat/0ShaLxD8UkxHQFMAj6PMCxoOHo00VuM4zqkI3Wgy4UF5543iO403EOFZKrZ4M65YdATtnphrqO6Dc1UERRGagpaE9U6fmpuJC3I9OD+3pCg1mdse1/Oax+7SqAhs6WDoXUoDLdeOnp2pQAM/Gky/b7ZDR6/qfo1psPLHJlBP8pKyZAXOBVPfiVY9wMBj3FM4W1Lce+ic2q26n1dS6diIEiFVacfgDJnnYc/Ng66bZe1GuUahn3r9C/SYl1YNNxt3Tn3czNOvkWtinEE4CaLC5t64NTOxNvF32lfMW+A7LBiCTZOgsocRDPbIYBEQurc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb5ef80-cd3f-43a6-93ad-08d59dafa4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:26.1291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mel Gorman <mgorman@techsingularity.net>

[ Upstream commit 69d763fc6d3aee787a3e8c8c35092b4f4960fa5d ]

Minchan Kim asked the following question -- what locks protects
address_space destroying when race happens between inode trauncation and
__isolate_lru_page? Jan Kara clarified by describing the race as follows

CPU1                                            CPU2

truncate(inode)                                 __isolate_lru_page()
  ...
  truncate_inode_page(mapping, page);
    delete_from_page_cache(page)
      spin_lock_irqsave(&mapping->tree_lock, flags);
        __delete_from_page_cache(page, NULL)
          page_cache_tree_delete(..)
            ...                                   mapping =3D page_mapping(=
page);
            page->mapping =3D NULL;
            ...
      spin_unlock_irqrestore(&mapping->tree_lock, flags);
      page_cache_free_page(mapping, page)
        put_page(page)
          if (put_page_testzero(page)) -> false
- inode now has no pages and can be freed including embedded address_space

                                                  if (mapping && !mapping->=
a_ops->migratepage)
- we've dereferenced mapping which is potentially already free.

The race is theoretically possible but unlikely.  Before the
delete_from_page_cache, truncate_cleanup_page is called so the page is
likely to be !PageDirty or PageWriteback which gets skipped by the only
caller that checks the mappping in __isolate_lru_page.  Even if the race
occurs, a substantial amount of work has to happen during a tiny window
with no preemption but it could potentially be done using a virtual
machine to artifically slow one CPU or halt it during the critical
window.

This patch should eliminate the race with truncation by try-locking the
page before derefencing mapping and aborting if the lock was not
acquired.  There was a suggestion from Huang Ying to use RCU as a
side-effect to prevent mapping being freed.  However, I do not like the
solution as it's an unconventional means of preserving a mapping and
it's not a context where rcu_read_lock is obviously protecting rcu data.

Link: http://lkml.kernel.org/r/20180104102512.2qos3h5vqzeisrek@techsingular=
ity.net
Fixes: c82449352854 ("mm: compaction: make isolate_lru_page() filter-aware =
again")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/vmscan.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 503fa224c6b6..ff9066d096c1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1436,14 +1436,24 @@ int __isolate_lru_page(struct page *page, isolate_m=
ode_t mode)
=20
 		if (PageDirty(page)) {
 			struct address_space *mapping;
+			bool migrate_dirty;
=20
 			/*
 			 * Only pages without mappings or that have a
 			 * ->migratepage callback are possible to migrate
-			 * without blocking
+			 * without blocking. However, we can be racing with
+			 * truncation so it's necessary to lock the page
+			 * to stabilise the mapping as truncation holds
+			 * the page lock until after the page is removed
+			 * from the page cache.
 			 */
+			if (!trylock_page(page))
+				return ret;
+
 			mapping =3D page_mapping(page);
-			if (mapping && !mapping->a_ops->migratepage)
+			migrate_dirty =3D mapping && mapping->a_ops->migratepage;
+			unlock_page(page);
+			if (!migrate_dirty)
 				return ret;
 		}
 	}
--=20
2.15.1
