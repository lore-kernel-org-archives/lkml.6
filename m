Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492302-2-15636259468131932167
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
    t=1520492301; b=Y0dYJMkpzO82ZfEAH/xzF72YI9L5+C6wmYAElhZ331b9u78
    kQo+750dRBY2o1j4Xiz+X3fjJRWd6yqHd56uJki6pJpZdLHWTRc7ACSgwm753MQN
    BxfRnOTk3yZllGIZuv+Yk1UBkanSJCT52vHaPZc1NH7OIaKfO0pGGE357r3w6pgP
    8fW0w99DXazqEkEA/RmS+R4lPEqB/bN6aw9zefNTap4WXtHjW9fNlRsmVX5CJJRe
    risCW+X17TmZnpM18dEeDHZ0ba5vHJO3hAUtFnlUtB8LLeTKHlPP4mDkkSdSDfvi
    ZerzkNIdR8qE2IfYKnIChHew1Qaw4UrIQDt22Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492301; bh=k+tpxE
    ess4MEsDM/AnJCvtOBGHZPFxl6fG0VhO22o+w=; b=S40Y+yTS6hCPiY/q1AAFw5
    0d2S1TcnVYbKEXXtrnWTOs1B0oPbc2DhfHZooTOMnsk02X6v4Jlf092Gvroxq65I
    B2i73uSqX0ULbYndwUu/Cw/02M+13Dybm+OXzbvBSanxloWjbYj/n9ktzrSK5UnB
    LMqYuZ1yfnzzb9SZ9oPuQNzRF3Zb8LY3x3Lp16Nxq8QXEozD8daj7/oJ9Ta0tog5
    qXnEjSMp0mmed6NJqqcBagJPzzPj1UqhfkGTCx1l3DSNKqsGzownCskHCYkDygz6
    ePVhUEDyGt0zgCOyDQHOsJJy8+isGK0yzIdVlpa1YM+VGNIv6gy0KvT/UiX3XjZw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RkEDFGEy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RkEDFGEy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935043AbeCHE5Y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:24 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934942AbeCHE5R (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 43/78] IB/umem: Fix use of npages/nmap fields
Thread-Topic: [PATCH AUTOSEL for 4.15 43/78] IB/umem: Fix use of npages/nmap
 fields
Thread-Index: AQHTtpnMjZMPIWTuJ0+gDVhpsYdAOQ==
Date: Thu, 8 Mar 2018 04:56:20 +0000
Message-ID: <20180308045525.7662-43-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;20:hmGh5mzB9hfVhsRNPed+Db6xBdwY9XSurzxDzVUbr7ABOrp93jU4jWLmYSV/yRyKhhPVYvpxYxJXJcSee+aH/9NTI036kw945GIEstwkxN9LGJVcyay7ZAhHtjrhM3g7JrObl03S7AYjwMNc9kUCi17E/tZ/2uCklTxMSJSYwhQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91d13977-30d0-423e-5dda-08d584b10c81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10796EC2E94CFE7B03CF1783FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: R769uhThdZ9ys6yJFZn56StohonmkWKfNFZgCuvfm/IQdX+by8PN6Cd96HbzU2z7qHYDzkQHHCwy6tMFDx02DVjW7ugK3GE5MiB0wshtcKNsH/34ohi9dFm8Zh+3t52Jha/8gP4WQj8N2x8q9wmbR7FY+Zs7cuQOE7QRc7nVbyF2EHg/f1DC6lZSKRHMtDcFDHG45e2M3tFqa1hLLmeQQYVdVU8ZOAf3WEaJ1pnkmcHmV2qgEQsO8DDjGdw0ZrOXmqriuqXWVgB9iKubpoqyJXyl+hZgYG83PKNxfMya0cOjFT0OFyW6W8p5SZYx7FCgMPNZxvKcFBBxnnm81CtcKQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d13977-30d0-423e-5dda-08d584b10c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:20.4331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
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
