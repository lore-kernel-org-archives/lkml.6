Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243116-2-10130821505382827116
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
    1523243115; b=gvwm0HtU8W5LUK8tzUISSJZXgS4n+q7O+36dZd5kSu6npEZaqM
    /FgvZjpuk4MZzFoz9rtLXRG+9H9JZBTfpTuzK3ijmRSrkD7z1MgrgG6JFCSINq7C
    DLD8X4bnxeJh7Oqz2lcz/tfwT2WKLCEGhPyGgnvd9mSAdI2LjZVAOu4bZhG8RssV
    7uOWkDiFP4K3rvBv0SD5gCOY9eFGnfXJ4zw3DzcQivENr2ppS3IbTtWLCZaVb3Z3
    lLkb7QBS40gVl4iDikLyEQCWW9CtIFGVymVWqK096Vx9yo6s8AZBi/mmmEEF8haN
    fVSVUlfotP/YCeYn8J9lUn/hD4Y9rt287Q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243115; bh=n9qRUAnadB
    yiU+/I9C5X3tz+XI4BeI2PtKIn59+pdZ0=; b=Yx51dQPGHv5fNGdXbPRMArlIIe
    iXJ3gQeRLqQLduXvVis7c0IjAYN650zEnq4MvYN13TygKz/Bp8I8FSJEGj6/z4tx
    gwHvkIVTUNpnQcaxlLD4cgBrDNlSfUDjoEYsMaA67/GYUPyyw1r1Wnl+laz4sg0c
    Kk5hAtbpnoZP3Zbxi5VB6Ew13T+vuwdKvQc7N+5p/lmg8IPfQwBsw5AV+12l3rEN
    qHXyWwZRBJDJZid+1hZzKMt2hOTYXUg0mNgO2/E9DLjSlpXgAs3WZ1RXVyFb72R0
    8csPKZVLzNjDwomYoDDYcxCpgsXAMs0JYQFga60uD20jJJclJJU9c1z5oWaQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q/LPJIZq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q/LPJIZq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGxAqY+uSaUh5ez3NIh8z02IFoVwpiKrfdUrhC2XFbHP60cjEN0teD8S1gHVTGxfRsf0qhfzMfc3OdEELa9xQuOJ0Dt01vKyFKBn0a++1ptr/+iNZnQb
    Q61E6YFAWpzcN8sK7WB7nb1ffKwIlCE3D4mqC1BWxHsIbxN72JpvkWDxzZ4lb8z67yOfg9gWYDo5OgAtWBGSDN8+ZnJEoAklqapJKqhdq4mbYFc8oLCQe6Ft
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
        id S1752812AbeDIDEh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:04:37 -0400
Received: from mail-sn1nam02on0136.outbound.protection.outlook.com ([104.47.36.136]:19528
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932122AbeDIAYu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mel Gorman <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 104/161] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Topic: [PATCH AUTOSEL for 4.14 104/161] mm: pin address_space before
 dereferencing it while isolating an LRU page
Thread-Index: AQHTz5itkDLTllA0qU+lwlqvfrqahw==
Date: Mon, 9 Apr 2018 00:21:17 +0000
Message-ID: <20180409001936.162706-104-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:yudqWVuPOapyffXTJnR0I6i3ffop99HOSMr1R7FpqujUJhC001OhL0lQQsvcHpAUScrB4j6GqfxSP1RnZPckittiTqClR2nOnOlndazwibvDl3oerRdu7qB+hC9CSdVSlgbmTxvGXvynNdI2RHt67zskQdBU4ugfxmWNSGDWlTH41M+uT47Zz6+8brlz99XsVsX4CycG7pBqH7Xa/gQItiDZV6pTP6ku6//pHyq41hwRE5fYBrmbeeVezQO4lDgb;20:kMDntM0qUbBisGbIFIy08c2evjqs84SN2/PJPoMfwV4zkBAAqobErNxpn8grOXWbO/WpGuoJ8DR3YbGU56BPM1GBXXxXI8fC4QWlIiWdhSy71CTSDaYhQWIPFOpk16Vi26K2hv38DYt4ydcElXZ88zL0+2ImD7V77KikXPPeojc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb841f74-4e17-4676-21b6-08d59db04b6a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098367C2F704428C9EBAF76BFBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(966005)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6306002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fzdgTkfFcuFsnURLgClHDKqwxc3FeGzIVFjVHFOuz+QWbogofSkqV5aWFByyhs/WQYKY/E2NR6LPYoEuzhW8cDw9jY9/xt6FimYUMAblK0bywghLELTlcgcEUQHbCzRkKCW4bk595e9YEjqUli1SZNVAUkIyFT6tEmr/h6hONEet9ikAR3FyJMyH2+aYYlXUvn7BMeDpUwF6eWvYqcoz3agISxcKDCcIwFNF4V/nRNHcyiPdcOmcFejIGw9zWjmRiblxxTITFlL5NGADIG2Z0OoV1TIDSoNp8JRrG01E2ss/4qIezsvD3VDhtGNpZt1GS/sDnd6ALOe39EOxacrP7z2TaAU8colwqpag8gvxYnBGbR2C2XQcxrkoH6NyCm1NM9glc5WHzhwWZRkoGK6VAfqRfK4d8835qtjUcjdwI0s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb841f74-4e17-4676-21b6-08d59db04b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:17.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index a8a3729bfaa9..b3f5e337b64a 100644
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
