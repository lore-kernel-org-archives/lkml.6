Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683111-2-12932255452421366805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683111; b=j/5tLIWCB2N9qcFhbT5BbjhKtB6Um5w+eQXiixbl6o46rlR
    v5C4eQKyxoQFHC+PNsMPp+dfG4hqxhDzod7jzdhuCzW4ossr2pvFK6ZHY+PgDloD
    DvYcXn9/6EBI6uZU/W9JFpEdaOxzMWSjmwwWEj4TgIQVE4Y8ygRCkUkdJ/fc2mDW
    Xx4yGRBRr9msZKAnibq6/CNbrJgXiJ0kjm3HznACX4edjnXfyJRsS6FLNgETe41g
    lTtxsabsv3ik201gzf/vVI82YSWwE0Jq2OyiTNBNsrKlfoxOOULjcaWQLucaiPNL
    N7GVk2vgLSWCcsa7uh7pSYvX6cnhJCLnOLQFgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683111; bh=gdfMOP
    3iX8qN6ZPLw4/H4+OP4iorcQZrARUpUl1NI70=; b=t0A976ORd172T0PQd7Qcpl
    TFwv3NgwDwtN9hbD2buvc9J3ZOoJzuovEUeKCxoajPtmCYx9HuiVi8oe7nqbrOmC
    jgSUoWwHOtA/O2UMRienUb4syiePYH9lmPcrLBm6cOHK9B77wAnQeei810+eEVlV
    5UqQValBpZgbA+VPmw2C3w6aUTaxK7TNLPlzg/uKWeUzFoHlKk8TClFLeFfa2sAa
    6qE2l8ubeUty1XcH20F5vz27Kj87mEBgq/o8Gr1yz4q+12V8LKADHGO4jaxWwYiQ
    MxykylpeRgnt7HqGLm97qdBmlr9xE4THqOKJfJYYnDHOiKcJBVvVTloIWVp3HE5Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ER9u6+le x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ER9u6+le x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbeBCSi1 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:38:27 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752966AbeBCSDo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 103/110] xen/gntdev: Fix off-by-one error
 when unmapping with holes
Thread-Topic: [PATCH AUTOSEL for 4.14 103/110] xen/gntdev: Fix off-by-one
 error when unmapping with holes
Thread-Index: AQHTnRkGX4BksdyDh0SfOWoTE6AIyw==
Date: Sat, 3 Feb 2018 18:01:32 +0000
Message-ID: <20180203180015.29073-103-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:sSc5ispOjJnadNV2JnDpNdqrExqmehmK2Al+1c5yNEWJKWdtmR9cb9OW/xI0gS/FzG4ZzvOhQQm/MQ9AyxU96Xrp2+TJ2cIPZnu+1OrTe3Hhjxk9f8k8tQo4sGT7bnZ+o6LBT3m8thbrheDGsnyuS84Ugogp5tUX3oMQFBwTijTjCYOtNeGNx9rvYFt1Zfndde8dsQmcTm7tVaTxf4mKokHgWfdB48syhj0E+kg9NnJ16k9HhQOiZfyb6AVLDoAe
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d07cc952-c0e8-4dc8-308a-08d56b305836
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993CD200061FE660360E1DEFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(8666007)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: eF1TGjCEytPrIjWVt2kpne1+PneLnnwTeNY6fPGNpcWHoWPayYCj7yu33jCcdw2ujNXBbSvxxrM3/xUBvK3pwQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07cc952-c0e8-4dc8-308a-08d56b305836
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:32.8315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 951a010233625b77cde3430b4b8785a9a22968d1 ]

If the requested range has a hole, the calculation of the number of
pages to unmap is off by one. Fix it.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/gntdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 57efbd3b053b..d3391a1e3796 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -380,10 +380,8 @@ static int unmap_grant_pages(struct grant_map *map, in=
t offset, int pages)
 		}
 		range =3D 0;
 		while (range < pages) {
-			if (map->unmap_ops[offset+range].handle =3D=3D -1) {
-				range--;
+			if (map->unmap_ops[offset+range].handle =3D=3D -1)
 				break;
-			}
 			range++;
 		}
 		err =3D __unmap_grant_pages(map, offset, range);
--=20
2.11.0
