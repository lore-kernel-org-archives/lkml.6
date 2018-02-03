Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681242-2-12132183889846202888
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
    t=1517681241; b=c4d72FFZJDGoAreAxrn80/vFsM67K6iozeVhKx42/nU68UF
    9zRRSlTbSR8Mh+VnQP0rWfLS2EBh0jJh4bF/1H4e9jfL188jl7Q6Xr8yUHQOLr0z
    1smvNbtHI/B0oeSGhngwZBpng8Om/BSaRVCqwaCqDZcs/4BFeZVeMF4EIbteDkrv
    cQZHHviQikLWdwLamOpILeIoGytBOmaRmSjaL15Ov/nDeQMeQ9A3VyLxVBJasKEH
    o6NtlHr2yzxEu6tNeaYUL0K6ZOweCFnUIr1PF9t+MOxNGwjxfUTNzFuJXRQPQ7jb
    gkIdi/iTtWGc0eTeHvxaHi0P2KPPsZZVVioceOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681241; bh=GjW4sN
    22dVr/JnIq2dRM8DUVmcNK+2qQ87/fCqOaJsM=; b=jyuuIKNLsp3652HApRBUYN
    aqp4pHkd0yPrvZal7esNpgv6IQg8lLw5mMLNXAwPSpkMTxzuwWqRZd5nlhJsyk+W
    nQx7SGkgI5ebp/VTAGb7PtDTuw9pHK/iGHRr2YdMSTb22jF4VtAORXGNLw7U2iz6
    TQUoUa7y13aDZ8VyNKXnCjI/Srs0DPe0tq4Ll6e22/He0XdC7VJ9xSJE2uLHITSy
    YDkw20MzEhL8qycHvFGuFYP2/pLQ/7YMJO8CP0/IWw85eZiNXKwBMTmuKt4mwg5a
    y0Q7qCxGvRzF3yS6l4wVMh3W6ckVIWxLNWfqgSvTZDy76xJ3onC9pe876NsYsfFw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ocp/U3UQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ocp/U3UQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeBCSHR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:17 -0500
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:63252
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753380AbeBCSF2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 49/52] xen/gntdev: Fix off-by-one error when
 unmapping with holes
Thread-Topic: [PATCH AUTOSEL for 4.9 49/52] xen/gntdev: Fix off-by-one error
 when unmapping with holes
Thread-Index: AQHTnRleZVQe4IrmAUmq3rM5RvM/Bw==
Date: Sat, 3 Feb 2018 18:04:00 +0000
Message-ID: <20180203180303.8490-49-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:ZSItR8etrNt6GvxjmU7peO3O/Ny2clQ9ZjxtoA9rBQ+TQpMy3Z0TmSmJ8Zr7wTCi1eMtNGVmzYO/MssrwykXaBeDE4MC3YtVnXYNK762fvJVt05TVZskQcde7aXho3IZc2B3X9DB64m+HOLqTEs8AQPO1jhpPjVQ32DryGV91U7Bf5C2nGZWDgFRg9hTzl0pq0BlNccE9dIOQlrO9I0KFSv4V2x4HKIXCd1C6yI+aaHz93ZDik2Tfl6p2K9TU9so
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b0ef663-c6d5-401b-015c-08d56b30a355
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB1089EF0E1B06602631A83554FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(8666007)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: uXP6aUqgOiBqV1j9mpfIMbU24o6wMK932yJkVKcfU2RdcIn9sckrRc4+XFqbuKm8vc4I1oz8GpttMoDnlEMu0w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0ef663-c6d5-401b-015c-08d56b30a355
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:00.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
index 79b8ab4c6663..54c4c4183fbe 100644
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
