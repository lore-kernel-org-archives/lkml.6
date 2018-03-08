Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488698-2-15086497680258050048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488697; b=NoYYJgwbY6+Vb8jH4IXtxxSjWH2gnXBVIQhGPRZyYvHHXpj
    O+T8dBe6gi6d+suwavHTPBSknxsncDzasIvxL+EtFJxKof2LjtnGjuQxlROwxgH2
    IOgoJ6jJmX/hnlLKK7tghPDZKTbyWYWCOGBc231wRAHNEOHXH///+AbRlPtX98Qq
    nY31BAfyFqTD58lOldMCGwfUgxGrzTB/mDDhLn/1xGouZ+7hd0x1BLVVAvndHarb
    3qFAGUTl8Kxk9KulFjRh3Eo3CKTbSCUls+2pmiew0t8Viq4rqpWw1qCjW/zWn2Zt
    f7Wh1y4OwDDBoqEdEeayssqbR8UrJUNzM/iGYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488697; bh=MBZSkJ
    cHkm+sRi+ac6+GBomslgr6As+e3MSn3wqOIgU=; b=jm0ckecHv7m1jxfeip6yWT
    3Q/sFt/5fhZyiePfYnYVpH671X0tQKxp9pu+mWflx4oCIqqWw52qWsdQtsvYI+pw
    bzvhjKUpNJev2sEhe878dUWd3kzg3JYu4ycKPBCkY2ZHMAi3j0Pk0ONNswZ7IIvA
    5hj1tiDlA/3+HX8ZXO1Amddgd9cG3haclhpVOnredcs7R8DGygMOUfjs2IcELkFU
    UxL/6JPHAfiZIHeZehS4e+0sRUFNkE0m4c9za2OVfWi3it9FRE1WqhvaQITMY2NA
    e07MKkc76kuoi6liFp3iYwGFXwTVi5yyznpfwVbYQrhO3lzqw4/OX86LXnznAxHQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Se5Cl/l1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Se5Cl/l1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966008AbeCHFD2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:28 -0500
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:37347
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965889AbeCHFDZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Weiner <hannes@cmpxchg.org>, Jia He <hejianet@gmail.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 143/190] mm: fix check for reclaimable pages
 in PF_MEMALLOC reclaim throttling
Thread-Topic: [PATCH AUTOSEL for 4.9 143/190] mm: fix check for reclaimable
 pages in PF_MEMALLOC reclaim throttling
Thread-Index: AQHTtppMvmMl8BVmYESXHYFE6izwwA==
Date: Thu, 8 Mar 2018 04:59:54 +0000
Message-ID: <20180308045810.8041-143-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:qj/CciyqxUWXvm8eVQs6VKTjXf+oxbM3S6J5rWZsT1eN/YGmgeW+R0n6aloXmzEh36rz57U1YUcHOODrBcYjx6uq0UwlbpHJwD2NKAExSdbzrVtfs3IMrID3OiVkUQ0m6oU7VwQH9vRLIV+yQqOnUhchehHA4aciabBFHRBvV3zXyhX334i5KXsK92OEggftRQyt16Dv5nmmc6izH7YOkm4ozmBgtdZrSRxRZSOpanTmLTi+jbSXc526MuYezQu0;20:RxtKdpebpP35y/W06xh9F2DzyTubClMsJd340wEeKTSBXm/UsLMe34mL6W1z8OZK3UJbAXEHgTO1EK6/oh46X3+YDke2O6uXbLt0SyJiA7aQKvUm/JmwiGF4uYnAjj9QlPofe4aqlo8an1cS9uPqBWjjKDllKT3YmWm9fD2NwvQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8762d205-7b86-400c-421f-08d584b1e940
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902D4D4F5DABDB56DD05308FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(551984002)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(39060400002)(54906003)(110136005)(68736007)(966005)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6306002)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: EtjwThHnxm1/4OmkAurzglo1AXlu+oZGNKZHA4e+ZWczbRt39rnbvnMGrJ1EDHFBLPqnOiBzAQKibEzZfiJot9BLIKbTiV9MDCx3XDFTplW1vKXfpGhBXOAzvd/kMhMPpmn3LpEXCRXpGP3imyEZ079FvrThu14pmrz8dOo015TI+5KuBK0XOooUk9Kb5pCwEMwPOCtsgBR/8p4qEd6asuVhbVw200vOJnj0oGbVOrYMRH9MAm89nvPYI8WRZ3RBL10vu7/XQlVyZGlnEs4aAVqYjAmJ7TgS5skkLWLXsjbeWRBhFZfoETSEvlNGr1dDFPEFlIDIU3jdsY4fRqK9gw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8762d205-7b86-400c-421f-08d584b1e940
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:54.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Weiner <hannes@cmpxchg.org>

[ Upstream commit d450abd81b081d45adb12f303a07dd44b15eb1bc ]

PF_MEMALLOC direct reclaimers get throttled on a node when the sum of
all free pages in each zone fall below half the min watermark.  During
the summation, we want to exclude zones that don't have reclaimables.
Checking the same pgdat over and over again doesn't make sense.

Fixes: 599d0c954f91 ("mm, vmscan: move LRU lists to node")
Link: http://lkml.kernel.org/r/20170228214007.5621-3-hannes@cmpxchg.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Jia He <hejianet@gmail.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/vmscan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4365de74bdb0..cdd5c3b5c357 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2841,8 +2841,10 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
=20
 	for (i =3D 0; i <=3D ZONE_NORMAL; i++) {
 		zone =3D &pgdat->node_zones[i];
-		if (!managed_zone(zone) ||
-		    pgdat_reclaimable_pages(pgdat) =3D=3D 0)
+		if (!managed_zone(zone))
+			continue;
+
+		if (!zone_reclaimable_pages(zone))
 			continue;
=20
 		pfmemalloc_reserve +=3D min_wmark_pages(zone);
--=20
2.14.1
