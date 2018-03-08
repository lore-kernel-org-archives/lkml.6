Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491376-2-10386774389679954180
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491376; b=HChaWouYIfDI/VDTTGIbbildXKLDSqmWM1qyRplDJuV1juu
    uSuHUP2eDK0ayCjhAf37aQ5ZRjI4Fo1+5fa9aERHjrAXdd+I+y3L17bF8j6Umn/0
    CjKFbpdd0yedfMPM53FeWLI1R1kZm0KQZe//kmdU3GX5Eyw4le+lIqF8pEl+u5yx
    u0J9DErYLxXQ//xNgySkRowvp1TNntl63CkE11oNiTcSq1n9wIubF3Xe16buYso3
    oE7Xck69FFxcWok+vIY8/ShLbcYURTaFJQvbzgAEvLcMDq/0ewNhOQYMZpZxTBRn
    YAzyBgYHpd8aWYbX6pkJ9xUZsYEzzmz2ZDdXwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491376; bh=k+tpxE
    ess4MEsDM/AnJCvtOBGHZPFxl6fG0VhO22o+w=; b=heFHYHYkOBaO0Lu2P5hLAB
    xGlhTMnA1bgL/ylEX7js4xBcYGUKtWI2ZTmBJz3WkRoqSKF29978r4duA0IpefB5
    8cxYVZjYdVaGRhFMEHFy7TO6y20ttFNHbE0+sJJB7ftbvgZ7OXXEze2Tkw34ajlC
    XHFn9UZ96s2BkIcNtRESu2HReQGXaoVnNLTFYIFENGjdwlu7iO/8XHSHzmmMd5lT
    gghUaFfiy59rakmfbLqybb4vJj3xb2QIqeNQZTVUr/GQvQ6rYglzNaUnWJCMLv7m
    M63Nj9XvTJImapIkAYigJI3RXlPDcBwdeFBQiD2FOfMzarS3uAASd5GIE7mr01Pw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o1Y5pOqz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o1Y5pOqz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965350AbeCHGm2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:42:28 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:6433
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965242AbeCHE7A (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 38/67] IB/umem: Fix use of npages/nmap fields
Thread-Topic: [PATCH AUTOSEL for 4.14 38/67] IB/umem: Fix use of npages/nmap
 fields
Thread-Index: AQHTtpoApTRTZR5WLEKU14Ycjc5gBw==
Date: Thu, 8 Mar 2018 04:57:48 +0000
Message-ID: <20180308045641.7814-38-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;20:l5WNz+edoYQEctK7ZLh5Zk3lc8ChAWSKCDJ1X1yCjxG3yfjbLrP+dyyzjJ690oTds+ltazcCwNIXM1LkiEtOehf20jON2UIaaOshzKvh44AWeT3Z6UAA6GbOEjFq+zcNiqAxQYbeJE/tGOTc4OtK2C9bTfd3VP5nI8hVsscz3Fc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e8b2c92-fd7e-4afb-68fb-08d584b14c4a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10805DD2FB9BE416EB918571FBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(36756003)(97736004)(54906003)(110136005)(5660300001)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Cb2B86BrQysusDI2HHFkF9SXGTL/u9L+xjGkbyTI75Oo2WqOGNg4go3f1LZOXUb4WVq6SJo4ae7S2AwUA9TdbKnetG85qwZrFyZRfLNrPoBaI7vDk3Qj45mKMj2k9qRUEMh7CaREfwdt79ikN1Hh+eYj3CZIC5AeqKued3XTZ9dn51agw83Sh2k0JjpTr4bmkCyiOs/xvg1Rs9b4muWj+1Z8CbEIn262dQ4ZMQkzzQz4MuTsVA3clkbVVCCNSBnpI8lORDgMM+ZJw/lBrG0cOnXmvHts5EMrxjoJa12fS3bnweN9UUm9u1xtVgKpetNWZXQs7DEnldlWUJI3voi3FQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8b2c92-fd7e-4afb-68fb-08d584b14c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:48.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Artemy Kovalyov <artemyko@mellanox.com>

[ Upstream commit edf1a84fe37c51290e2c88154ecaf48dadff3d27 ]

In ib_umem structure npages holds original number of sg entries, while
nmap is number of DMA blocks returned by dma_map_sg.

Fixes: c5d76f130b28 ('IB/core: Add umem function to read data from user-spa=
ce')
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 130606c3b07c..9a4e899d94b3 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -352,7 +352,7 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, =
size_t offset,
 		return -EINVAL;
 	}
=20
-	ret =3D sg_pcopy_to_buffer(umem->sg_head.sgl, umem->nmap, dst, length,
+	ret =3D sg_pcopy_to_buffer(umem->sg_head.sgl, umem->npages, dst, length,
 				 offset + ib_umem_offset(umem));
=20
 	if (ret < 0)
--=20
2.14.1
