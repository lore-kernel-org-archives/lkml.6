Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242640-2-13553294876254875563
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
    1523242639; b=cfMA+JcDQovsnYlT2MYkIN0ubQiM27LviOAhDjD5eHmNspy9g0
    2zLvBwA14ZjEVIo3hgXGrLQk8fNVSmph9VW7TugWnL8qUiVLH+sLus2o8gakFadY
    8FPglBtvk1uZ3JV5AmFQL5+Ml58gxJPrEwYCZ3bpcxM8LJMCM2KAknKdH0izkM2Q
    nq8QaGqPnwL/Ovc/X89nkqALslc61f3f7TCei3kXzKZ/BGIBnWEIJysWpdBkDhgO
    JyCHvdyplkzW9aJzYNiyodQizF4jFwhYCth+1+6W9+revObLr5AOE15m0Mz92ePY
    pdDvLTox1qoR7fsBjhEZKR3ZyAJqv1fLyeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242639; bh=NM3W/WWjz5
    P7hV9gAh5asjDBWnRBIbDWoyHOeLeDy2k=; b=RRLpLNQYDm3RdF208V52/BEjxU
    UhIdx3zcOMA90vM/CBx3kSA3e5f3ZA4UZ8w6kwYfOgM4u6+PB1o6cPnJ7Ju3WMgi
    qlaFQnvYmInzyz8p7qa9nZOOrcMO/Hfrq90DrxoW7470iq52DL7pLl3yEewLhboV
    ngeTw2yUHBbQZsiG/Ng+io5ucDbIJj/7O1l8009w/zNEDGxVRJ2btjWxRcxnYTR4
    fHAF4qp9Q7SlA22YcuPOLKRKOK81qNj9WC80SKudlhF4gl5Bs+80qSYnSrKb0/Pl
    cYOAyc+SomqJp17xYKkSs3AgccSz4Qsgk8U5ZSlC7kD7NmPLsmw51d2rC6nw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oG+MWAM+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oG+MWAM+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKykZXRppTRSg9l36ACz6H9K9GFvgc0rqEGbUx5tP9/niHDQDM/7Qonj6+KWPlWSPC1wEOmR78/45ghOE3M8DNTrTgHhQjCIi3uAU3uXZbL+q5LAR5tq
    T3kpeMsi9vWQWyAplrXfFoKT+0N9Mz70v0MK4HeJXl6gnhRe1U4ENdlb6RSMByekQ3WsOUTCkzBMtxtyFAJhKmDK25mVnXFfChyp3rS1oCZzuoKDz5XP39fb
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=43XURk6w0g5GeypUxR4A:9 a=wPNLvfGTeEIA:10
    a=Z52K5TbU17EcDgFyT5Ki:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeDIAZo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:25:44 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755228AbeDIAZl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 129/161] xen/grant-table: Use put_page
 instead of free_page
Thread-Topic: [PATCH AUTOSEL for 4.14 129/161] xen/grant-table: Use put_page
 instead of free_page
Thread-Index: AQHTz5i6DD0SKK4BMECQqVckO1MRAA==
Date: Mon, 9 Apr 2018 00:21:39 +0000
Message-ID: <20180409001936.162706-129-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:De7aNn9GgLFxyPJDMh8oCM/1jeOdGQ598tB7v1jLvNLBExSlMRfxSkI/4NMqoxbl4SqXDnXLuK3o7Z82DS3qIfqA6P1em+drB65Ab2S2pLfL0FfIAjoTdZ7eSTBMtNeeaC7+9ZlbEtl4LsmlHLGOR61MdLc37SCMaXNuTL6vgJ3CaCN1iMId0E1XoEpCmfBvQdYrM2y+JoXRgBSVbOwZvQpk4a9h7RbZkiv1r6T8JoGJG4cA8L6nA+vIOt8Rn8jK;20:dAQDY+i7JoB3AF51d2ZDFOIyxJpv62g6YcZiCh6Cfo2S+EoJg5cnP0yZ2y7MGKuEShb2e1sAB5gFun8NiiLiZ9xx35bH/km8V3Sf3SnY+VIw5k6IbQSBwLz+v2VZ1JjdzlAOwU6dpK8F+I4lnLsKUNaA0qmfBvrfpBjrnb8NYwk=
X-MS-Office365-Filtering-Correlation-Id: 53b63b9a-7010-4416-6fd6-08d59db06a3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013A151DAD4C49C4FE2B3EEFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8666007)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pFbw4UbUx7LJFWRjsFKHAA82vfH5V/jXdXUcv32L6Ve6tGZxUey+cXd9cYqnzvjVvZN5ucDstA1V4oiCv5bnVBa/7rL1UgWRcX766F78AkZCuUkrgq/rXwHNS9Y7+rRcKLIglU5dfcG/oj6EyNolWBedrGbl1vYXp+Ofv0KnZ0JSPSmWqw0xJSa3Q4sZN45uj2F1Mm/ifV9HpsgFSvJc8c5lMQvfgg+EFiSpj98kIp3FoR0HxsAJfl8zYbJwiWcFOofmncAvqxMSIxI9eCgQuY0i30W+w4qJaKpVI0SchqNTpFSg8rb5Gt5yeTc+QOuU0V9nZHy9hXdw9G9yQL8glLmRozq8vJDnRWx8k6XQ1PIHFyQcPUF+SXoAroG/9IZw84cngimY5UjZNrsY9vOgEdluiqQyfjaRdzbO+IbGjGg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b63b9a-7010-4416-6fd6-08d59db06a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:39.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 3ac7292a25db1c607a50752055a18aba32ac2176 ]

The page given to gnttab_end_foreign_access() to free could be a
compound page so use put_page() instead of free_page() since it can
handle both compound and single pages correctly.

This bug was discovered when migrating a Xen VM with several VIFs and
CONFIG_DEBUG_VM enabled. It hits a BUG usually after fewer than 10
iterations. All netfront devices disconnect from the backend during a
suspend/resume and this will call gnttab_end_foreign_access() if a
netfront queue has an outstanding skb. The mismatch between calling
get_page() and free_page() on a compound page causes a reference
counting error which is detected when DEBUG_VM is enabled.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/grant-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 2c6a9114d332..1fb374466e84 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -328,7 +328,7 @@ static void gnttab_handle_deferred(unsigned long unused=
)
 			if (entry->page) {
 				pr_debug("freeing g.e. %#x (pfn %#lx)\n",
 					 entry->ref, page_to_pfn(entry->page));
-				__free_page(entry->page);
+				put_page(entry->page);
 			} else
 				pr_info("freeing g.e. %#x\n", entry->ref);
 			kfree(entry);
@@ -384,7 +384,7 @@ void gnttab_end_foreign_access(grant_ref_t ref, int rea=
donly,
 	if (gnttab_end_foreign_access_ref(ref, readonly)) {
 		put_free_entry(ref);
 		if (page !=3D 0)
-			free_page(page);
+			put_page(virt_to_page(page));
 	} else
 		gnttab_add_deferred(ref, readonly,
 				    page ? virt_to_page(page) : NULL);
--=20
2.15.1
