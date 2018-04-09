Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238506-2-14935832860829138012
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
    1523238505; b=ZUHNH6ZJZMo8Gzj9nutEa4q+jrWDl5olqi0l3rqnRj6Ot9TDz2
    E2DnMlS7SPQmeQ2XBNcVu9Cyp0BTgMj/B9vyNwXMc3LBGlrURBZlcOBbls6cXP3+
    bqv4yOdXsrhF09RIiZUzHsqIMxj34ifE/1vZosme4LXh/3C7O2IbDtvXMXaR2cER
    4EIXPa9NiR+BWcwmKD0IfzJM+vjysc48ICk4BmU1Ai9UP/UjPxIQIM755gU1tOP4
    F3GXpRctGf/HBn1PFJd/tNoWPm7oQ+FvQttFC6u8PlT2YC8Ntka/sNLBJZa5mqBu
    mC58p37s927BZTTx804f+ZVCz4NP8sYi0DEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238505; bh=6u55OahYOn
    2zmjF9cmMN0mwuDiajT2gQXfNRJF1HDmM=; b=I5Y0X3cVwApNHELj7EJ1+tHE3l
    wiyKa/AQe+8EUIGZd49eRgY5ttSmet9SgNKyuTMqS5NKbOoerC6DoqqRDryUVgSj
    iCTZx+sbX7Xfdemuw03Ucml9AO96pBzAtKs+Twj9hNQjxOjD8Fb3kAp962y4ovRA
    DLcSnhoIKtTc8WDIDQqOZRrd8VfpGzE1FoP7iWC6Ud0trhkbtXSuU9iM8Uv3gj+B
    EVwEHd4WtY/QOxioIApLbVmx/z2oNZCePrwQn0COCSacB7TowuIA9N65366/mZaD
    qLbSnZTvhmnCIAKqhtSHl4lqrPSwdK3fh8t0lg1CvmU2FNhBVczqerWaZa0A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OmZ5WuPg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OmZ5WuPg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL4+ZDl36W9anoig0XPqOSHPA00ILFf4PzieEDBaTRot5R9/BaTYYyMS7e624i7a3sB14+jvnFz3znmXOFGWGKlQcJywrrqPTwiwhemM8ZRbi6OxKV69
    SZioZoVWCk36MK3as8d8oPX1yFzJ603ZdgcAMvrmGpn1syYqm6dEQrPuxoB9DRr7uMBii4K9MPcUh89Q4pz1dzbgIq9Q2yUnMPz1wQE5RZymc38h/+z8uCQf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R_Myd5XaAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=5UkYvFHTB3ZtRazDmScA:9
    a=PROXMrZXyT9UIZUq:21 a=m7OeU_N4EMFnT3V8:21 a=wPNLvfGTeEIA:10
    a=L2g4Dz8VuBQ37YGmWQah:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757193AbeDIBsJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:48:09 -0400
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:2685
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932322AbeDIAeB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mel Gorman <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 262/293] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Topic: [PATCH AUTOSEL for 4.9 262/293] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Index: AQHTz5lhj1H0JiIFD0C/sMrEjAABXQ==
Date: Mon, 9 Apr 2018 00:26:19 +0000
Message-ID: <20180409002239.163177-262-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:sP2Y6LDjXV4IrpSWdF0NcdmxDqwRA12LL9fBF0ez2cWBHsw19WvqUTlO2wrrlyZt2Cus0k/Q99DnLiAeO/FDNYEg2G+QSIn/5Y0p6pzA6q8Gz3fRWf6YehR6UTEb9/Ij8frAGSkXT3Y5VbggE3E5O/nNsgK2TsVtX5qkmyraZPSndu2gx3GvmxSeVuncvCZjFzdc1mwt4C2fVnof34EY3NC8qbdHFldq6o4RRu2Ceyq7GnMRm2rXVGGZfv2NNFf8;20:DxqMBI4kF/FtfwSd1GCm28a2+UlNgMpvJxWelSYCopW9f9Nc2Fw3Tjsy2JGAVDbt+T6B6wI30QvixQ5Xzj/sMiP832JvAS6RZyAs3T09FruBtXSarjpCJRybH1Psnpsh+/58gJAmf5E4QaCstFBpI6XCiukLA4xwPeezjT77uQk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee1775ba-9d4e-4db5-ef4b-08d59db19514
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984CC897216FD64E3AFBF45FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(966005)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(6306002)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 57UHByP8S8MJsNC5dPIMULmZWIk0NREW1C7WXvpOuvzFvQOnx3JdKwjrC3brLg8FYVYnLzOY/KkuIsG5YwHZji4i2AZXQDxfIgXiFSxt8AeXuJi3jxCk+bPPFtiviwsDZIkEWv5Iff07CmwE9r2hzKRD1m7IwoDtCEvxT8Fu3YMytcJ5ePpZd+Ee0Q4iG5xAUn9aQrdeHlXMeXyCa6qDfmN/w61SkrcCIuI/e1C7en6tms8QYyoNuGQuM+SXdWoZn3YgmRWX+lM6h9QF2zXI8BEPREwHfzeG5trnQ2qZSJKibDviYD/yri2kWpJ7P6roBX2rj8HfSP8ZepuV3na9H3LVrP1PA9pODwkTPZ4nMaeuejz9075leeWSSB4pGejDUGkLD5pNNDMxl0NSaHAI3rxtWR8+auNubPoOtyz5b50=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1775ba-9d4e-4db5-ef4b-08d59db19514
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:19.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index cdd5c3b5c357..d012c13d96f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1374,6 +1374,7 @@ int __isolate_lru_page(struct page *page, isolate_mod=
e_t mode)
=20
 		if (PageDirty(page)) {
 			struct address_space *mapping;
+			bool migrate_dirty;
=20
 			/* ISOLATE_CLEAN means only clean pages */
 			if (mode & ISOLATE_CLEAN)
@@ -1382,10 +1383,19 @@ int __isolate_lru_page(struct page *page, isolate_m=
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
