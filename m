Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234782-2-10521107814490113071
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
    1523234781; b=Mb7RdOHm+C8VC/HUlcIjoItZf8K0GN9r1qWW1oiKUpR9+OHVu6
    N/lp/DXfhl74BcxfbLLTRTJBqf14Gd1mgMug0sIgL+o+8762a7oQVcM7PxuVllzG
    naEl/HX8ze6Wyk68zAiKdoZnisrAyb9ErEwDSJXd90ME17xBzUSCxEgF4FXUoay4
    6IAppDcJ43p9JDBFTZpJWlWzlqtSkiyVZSiqapkeELd8xlJGFHPCJaMP1aK65jg+
    h7mx6ITFoRg717UbCf1T9w6b1orwCtDe4T5qukFuY0tSZoAqtGyU+4ARkGTXxIjj
    DgBrcH5RHx1dkGHX865ToBUVpB+K2oQvje6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234781; bh=Mx53IIcuPy
    Hlfee+rmvP2kVrvm3EWQYQyF8Jxnrru40=; b=KhnVZEf/5armwopDM0ln+cbMUz
    Bc8huSIlqp07cwqYiZ5M7OywQop0MMZrkF2rRive1fBRbpg5VGaiWdsLZR+O8cOx
    sxwVq4Vh7Ib1k7vFe59iJtldlmuA9PICbH91mwuogV5r+2g8xgwL4uOZWvRC5y9j
    48SWCI9FHf/760OqM4XTcQAaGvFiwnMq3TOb6YmP/JtuLfJ+TXQfRa18xT70oRDW
    MHWJq0Cz69j3vnTF1irYcDIgv5rS9UAh95mf6y1SKesZ13JC08sxwXkZQZNxuJHd
    UVqtoSVoa4OTyS40KyIBiUd8QWtfaUML1H8v2jrf7hiHmpkwkrZeK8s4ow8A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=knFYeWBv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=knFYeWBv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4l95oxEPGm/dmToHFIpKCimgP500zoY6MQs8r3zZs5eePxGUwGNt/WOv7eVfoHZDlSwwgaB/tDRQqD14FvgWmgfQrQOGXclHsY/UcGbD7/4xyCWhLo
    C9jBpfQArIDANIDndZ830ENUgMiBl3GzOuHGDQx0C65Lgytw9xdApdIsaMYYJQdPQ9NnTy8n49+XWsFgZfcflChNobYd6Q4jiGk/OllU61wdxFC+I0MEboaQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R_Myd5XaAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=5UkYvFHTB3ZtRazDmScA:9
    a=PROXMrZXyT9UIZUq:21 a=m7OeU_N4EMFnT3V8:21 a=wPNLvfGTeEIA:10
    a=L2g4Dz8VuBQ37YGmWQah:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756746AbeDIApx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:45:53 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:44046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756760AbeDIAmX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mel Gorman <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 087/101] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Topic: [PATCH AUTOSEL for 3.18 087/101] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Index: AQHTz5uJsdBMIypNnkG5a/xYaPMJsQ==
Date: Mon, 9 Apr 2018 00:41:45 +0000
Message-ID: <20180409004042.164920-37-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:ejnF/sJnf5EW1bYhVqfTHR6+IlL8KT9AL3e5WCreKEH5a08V7a014E4qmn/gNgZqaB/N+tD/w1ZvvXCisS8UQkEgOI+8NddKpehtJ557DplZ8XL9n2ih6g7YzYYAyUXQMw4k4ZVTSFXvGAqZnO1t/geHxgHQXROXacPFvkeT2Rc9SBLyHF+vQhR2SVVa7SzuBWhfqM4GnYZz46C7X3bQ1jIQtV1bSR15u34/v8ocR0b47JCDSssRix5OLPHhlyGc;20:yxWCBhpOsxAGVSrHnZZYP4v0PG5B7/Hu9PoROF83ZmNfIqFB/jIrEP3lpuzEpWbAeMPy8FoE7TAdW482GkmEuBZl2BsoYLxOaYLPHTIej0lvWvovDsrv4v4y+aHFxZc+6dqa4cPd5u1FzUakc/gjY+CiPux5z/l9VFvLmzDpv/4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b9ac946-2ec4-474b-d789-08d59db2be57
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062BAEF63E34F5E3DBCBE19FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4qC7nXO9OA3AJwroZWp1/lT1uw4K96GOfldYgk8fEAqsLEf6ISIzj2FwANs/Q7iABPHSvajGOciqgPqcyVDdMM+V445EKUlS7xbrYRYD1Q3LZEw3miLdeloi2ZKkJd0kyrLGr1Ben07uI8prxSkaHQvVzt4oiHBNxbgD4O8zoI833zWtDpKar2LxYad5AIGVmqNY7L3TCqEsLFlVSHEx2WqYY/9nn+rRvuEqtA5aBtFNjYvYnNzCCkrv1H+p5YySS9jZLcEPctxj2AmFJdGtuVaIZIMpBwVU8k4MYl8gOCuOBWvHSWFui1aaXSv3smobPdsQf+rHGk84aEBStyHxBK61V0bGC/va4GbIHVUKsLB8Yrc0/3qBWV97J5wPpCB39Xa6dUM80VtpcrUHyWBPmiwRzfbviE8JO+OPbsMjQuI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9ac946-2ec4-474b-d789-08d59db2be57
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:45.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index 6d652990433a..9d38cf604760 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1215,6 +1215,7 @@ int __isolate_lru_page(struct page *page, isolate_mod=
e_t mode)
=20
 		if (PageDirty(page)) {
 			struct address_space *mapping;
+			bool migrate_dirty;
=20
 			/* ISOLATE_CLEAN means only clean pages */
 			if (mode & ISOLATE_CLEAN)
@@ -1223,10 +1224,19 @@ int __isolate_lru_page(struct page *page, isolate_m=
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
