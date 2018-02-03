Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681799-2-1272911962418499940
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681798; b=aiB+IpvntdpujhKlQ46HHii9NA4T6RC+AG3skjDHSz9PTeL
    tCrpJdbmOSQwXeDeFJgBgWBkZeGhGBr/Q5TuOIpFPpeykjNEA58uT3aV/7uPHDPa
    pN8hVomYohQXe9QrE5UglKjytp/jEOAupvXS6V2LbXF8KSTwBUmL/Fqy8nuQASGo
    NfY/WMLmRgw00Im7RfHNtlBTNZ1vVgjl/yBzjQ8D8B0oVHY2NdMGRZv7GOgFvBI7
    64nF1CrCqrHR7pr8XmpG4IxLuz7Md1xuEbIcAD5qEX7i4AOeFnXmHT+s0wzkOkTA
    nEGfNR+URkZwOkexfJKwvyrb37ediRQyw++VnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681798; bh=CwBuOl
    IkSo699dyNocnnZfvx07j4tg9i+FgoKXjeZVE=; b=cZfrruA6+4G7p2fidUcXgG
    1udCOon4trp1vxFRt6XenkWh4Mqun2telCSWvCW/vxftCbmk0UCQi8HkucE5s1Mn
    TJzUt3zwpEwM9BeGYxB4WBZb6WKSgu/8txPZ2Xf0TKpUVjcFmq3gskjPJWsx9sP3
    gzxunmlP5WB9trqtWJ/dqFiuvD4FN2DLZbWKdKEJXVHfMejXhl79K9PQmaeBddJX
    pMf9R3BzPgs7dwLI8AaCdg7jQWsoSHvZahMzjRrB5/2mp8qNJizUgm39Xp20H0dI
    xO4qYGVlAogeHrWZQOaHxzLBYjHCx98n+w+LCZYsF8EJua0CEcvTGjE6QelyR3OQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=deazuWpN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=deazuWpN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbeBCSQX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:16:23 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:42587
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753252AbeBCSHJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 29/32] xen/gntdev: Fix off-by-one error when
 unmapping with holes
Thread-Topic: [PATCH AUTOSEL for 4.4 29/32] xen/gntdev: Fix off-by-one error
 when unmapping with holes
Thread-Index: AQHTnRl2ptbXoc+C/UO2uZnspEzL+Q==
Date: Sat, 3 Feb 2018 18:04:40 +0000
Message-ID: <20180203180413.7438-29-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:HblF7er6sgQ7gqpKU085pfj09ajnZPaQi7YMw3ZnebDDVn8OzpdTf6yjHDLxuh4x0Ygefe5Si1JRS+xgvWhPRR5mcSFdkD9Y7W92phA5LyRoyEUAjzK9OWmIcjsQZpRfYx03jH/54zIJ78LiQrQaGbKGKk3Q6/+T5jaSw80wmNieK6WjeQ3tjE5ACBQhj00xo6u/f0jDXaryqNnk+1EZb5/beLxybPIs89W4UTkTQ4LPIBtPEzoJzqAUWMYfzDB1
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8af55566-00cb-4138-fbaa-08d56b30c8af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009AAD07CB99346EF048A00FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(8666007)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: xanA/BWUFSBgWJKo9yegGn/Kzm6Z+bmQEeSJkFMMHJ0BDUjnzcoWxRfiArhZBY6ATp+L7WXNre3J36lBJEHf5w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af55566-00cb-4138-fbaa-08d56b30c8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:40.5808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
index a4d749665c9f..44a9d8eb0eb4 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -378,10 +378,8 @@ static int unmap_grant_pages(struct grant_map *map, in=
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
