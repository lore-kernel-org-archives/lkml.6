Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236287-2-4344214662478829920
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
    1523236286; b=oHdiM82ENmIm6gCbNS8kmv9+wNDd65O8kdE/gUQHY8uSWKREqp
    XOlqELuWjk4SZf6Gww8dBjrYkRFvcMX9XbLbTMcml47LMr+p/jtB8NCP1TKU451i
    ZnJr3GpDe5TKYxxwfUfhHvq36v5sVpw1Ilun5pewHeqf/REG8s5G0pL/mgkqKTlB
    GceksuCZRYQWbnGxHoeEIeQOiTB96oRvEEpI9avhD0NHDUu/9zOWtpVdz4pJlf2s
    1KxTfJpGK7ls//nDMeouQI2uJBvS/1C/oRNv1NyJqbLG2GXPqpOarT6EFkvNqtxQ
    MrO0FTdjjJ6SHeONW4pTwWmUm2FUW/o7sLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236286; bh=2/+CMCDbSl
    cOwFT6dTGwVjqJdyrkMwAk9RQvZ7mF/z0=; b=HEJiNXXiPs8xNtNTKIo9OZ7c0D
    ZpSZGG+0L3X4GQei7hXv0bZEmXOVHYjYoriq14GGC7uKiri12B/tUMxiuWRsYabt
    rQzNw0spqtr0bSrP8LL7HCdR4pYF8Bv8Mnjb0Z1NMIB7RQ4oB4zPkeZVpaVU5/SN
    xszpBmiDyCO46yizLZ9yUrRHZzIxBsYP2H/j9bmI0oYz68HPN3I+r8eUQnmTj/YG
    fOBUmFRNd+PAzZpgtPVOjUVZkmMrbzW3WHZoZwj0zlci51KJ2k7reFSF45EMH5yg
    mvwNvulq4O9sgi52bnokmin7Wy7vWJEgcgqAQzh9YecB4FiLcqtpb3zrD4+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EDotNk5r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EDotNk5r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOHZ6HGwueGN9wefCOZeiCn8KvgmJbWFg+psJ+y+V8aMAuA78MTYCdolDZYYym6gwwSJxCABAXQbvMFAuumkkK+uPricuMIl/enp/x1Ks+/kr57TWndS
    O42G7fCkHZeJak8P/To+HzBg8xyCgPKS8D/tgrB+/zCK6aThA7G5G33OJGqoVgEx7vOrEZuolApI0E9thkzr/D4csB40mySswioFC/r3/KIy1ql19DzG2L+W
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R_Myd5XaAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=5UkYvFHTB3ZtRazDmScA:9
    a=PROXMrZXyT9UIZUq:21 a=m7OeU_N4EMFnT3V8:21 a=wPNLvfGTeEIA:10
    a=L2g4Dz8VuBQ37YGmWQah:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757167AbeDIBKy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:10:54 -0400
Received: from mail-co1nam03on0120.outbound.protection.outlook.com ([104.47.40.120]:40064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933007AbeDIAip (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mel Gorman <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 142/162] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Topic: [PATCH AUTOSEL for 4.4 142/162] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Index: AQHTz5nYXt3GbxuflEemEDB3mA6xew==
Date: Mon, 9 Apr 2018 00:29:39 +0000
Message-ID: <20180409002738.163941-142-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:1nE5cR6RApFSTjtXHGWNjY394bZqJoAbxuddF5yst666bm1xkSlHdDof3MZi1+HNJi6bHtMNQoNnI5wfhL8IwMf8TXfh6A00x+wQW09AoeyIUBychINiFnKDBGtomURbAa6uEyCd7nHoPraKrPbwgtygI3NdzV0mgCFq2zQ3PxaTWDaCopgPxtCVH8n2GSHZYwOePPztzhFzUl7xnh0OGy7bdKTlvrmOZ/NNqyxzRCye4rYEWu0QWYoHak3krvGA;20:tFfk14uKaEWiaOrmJ4tP9NcYOpIPpboW6/DGmxa7fApHT9Qx+ToUA/P1h77+cwXj5QfMFuIjR0fja0OJEqtsMJWgQ91VvwYn40G9Pa9LDzD9NviZyGFQ9vacoUSpNBJtoKroJEuCh7n7CKeM/f0KshoT3QOBQoSUoEbvkMWeMWk=
X-MS-Office365-Filtering-Correlation-Id: bc4dac58-61ee-408b-d854-08d59db23f51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125A88D61E2BED395C22C08FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(6306002)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(966005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jlFPaZQMp+/22/GFOuUa564fGs4e/L2k71vNBIm15XpeWf++qWPDdE08SqPPOUTY5+pK/Ijq2roxdJmgnC6s8aM4BwHDw/JGW5rT8KSwpmZYZbS6UN9sHeAOALfbNnUkCznse3coTbRE5S11/l6HAjOd5ASRofceTJKzQJFETUFT3rCPjspR0J7HtinSUZKgQhLwjum8uo7s/GlkUlXJGMABZkuQe5+XugJcPnI2D+YVMoU17LfptLR2lpvm+gaIH2B5p6+pHksTuhQGi55U37jf2BPxMRzR1tuhi4Qk51MxuEj65TaCzsA43btcE6UVkM+y3dJZV/2JtQIcYhDLUinLwavVZdUz1cqyqUWSiP6ypUSsKRym8MOKF2nZbS329Kx2poaBTy1ka+DICPjMVjwNCnZJpGr75+3TVVLLczQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4dac58-61ee-408b-d854-08d59db23f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:39.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 930f7c67a9c1..d9dc6a48936c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1312,6 +1312,7 @@ int __isolate_lru_page(struct page *page, isolate_mod=
e_t mode)
=20
 		if (PageDirty(page)) {
 			struct address_space *mapping;
+			bool migrate_dirty;
=20
 			/* ISOLATE_CLEAN means only clean pages */
 			if (mode & ISOLATE_CLEAN)
@@ -1320,10 +1321,19 @@ int __isolate_lru_page(struct page *page, isolate_m=
ode_t mode)
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
