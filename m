Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121784-2-14703339865221060654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121783; b=j3BCbsiq2Z0p5gffPyl7olTFynM6+5jXooUe4mni67yEewR
    K5FPwO+/j6QXQ+5fe7JUfZvc13ykqivWoph/biKx5a2eJBPeVsBW3XEVisVkpSHl
    FUFH5REpUWY8DF1AsnsX0PX0dUR+2zxFWeCKnU5Df5AX+9O4kJ9YXhrh5kofnhX9
    9wHQYoj1gv0JeNafhGZwbckTa7feV9du6wo3F0oU+B7osMheJ3DHRrSmY7Ie3GlL
    i8JweJA+nHxXPAFLvzc57gaYd7zM1g2qQ/XyOHEea57RK3FtS3T5OvEqW4ZpxpYD
    oxb/Q3dWT2wn7UH0MLAvUSufg+AjB0yVijVW0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121783; bh=JwpgAu
    FWs+Nz+RsXbtapf8ex2zxlhJYQ88Mguk2/VD8=; b=OQdc2KhOVDJK4Sq7uO1sXm
    gSD2lrcuVKC9L+Jbu38I57hGVhk5qxb+MoqQTquMahy6dpG1I2LnWonH5BEIYAD8
    vaNP1cBiCNHtx8nKFqAC/8cslwsgoZzjph8hoB9mhT/b8hOoHXC81WrZRV+3driB
    30hIDEKfjB0wK+GUqMYlQflI6bGALzkltEz/ONgDqPuoEmH4prOAsrwt/imAB/j5
    nFvd1ACF/BYzjy6gpUBXsCeHZmpxMZzbVH8sk2QBbSxaxGL+xcMzlqcjPHC+kNGo
    s9rQfeQ6SuJplibOoC5U1pKAPf+A3Nqda/SY2o/t7Tz1K6GRucI1vDb714XhXb6g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m0eS0PU6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m0eS0PU6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933397AbeCCWb6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:58 -0500
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:44189
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932266AbeCCWb4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Quan Nguyen <qnguyen@apm.com>,
        Iyappan Subramanian <isubramanian@apm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 031/219] drivers: net: phy: xgene: Fix mdio
 write
Thread-Topic: [PATCH AUTOSEL for 4.9 031/219] drivers: net: phy: xgene: Fix
 mdio write
Thread-Index: AQHTsz7r3KV34N+SPEq1WVmmH7bsAA==
Date: Sat, 3 Mar 2018 22:28:13 +0000
Message-ID: <20180303222716.26640-31-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:9zqpyRnhmSlKyRyzMFkjlxAKS7gqnRiNdVeAVb7Ze/UBcRg/BneWAxBIQJYBtPNMXOXlTjs+IoY82hC2zNyV1AvmtJAsf/MWu4uTzyujQmmPSG3rC5Kw6ukwR+2VtvTxMz88o9DV52uxwO7eHK3xT1pqlzRoZrIQAsSLcYB3uLo5lKT+O0fQ3dKgHuWewRTiEn0oYN3k3CvepTXAFZuJpqax8Y8XVTyTMkRkXvvEehSBNF0F2MeIFBHcBabbrmsN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: caac88bf-bee6-4c24-9a55-08d58156912c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1083BF110B218A7CAC613FECFBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7ymn4Ypigqzd38J04AmcbL3umZ80VcjA/lQ+dOekCwRN8Rs0zhc8ng0/w1yxno8Hj2/MFnnPpU/ywkscQ6cMa9bFxv0zLWmvRAxMk+iPdFj3UIN1SBXtVqk0BJ2iQMZqS86b5gsz1YP1SX86xlKbTem8t02+9IPeRPN7Wliq0+U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caac88bf-bee6-4c24-9a55-08d58156912c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:13.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Quan Nguyen <qnguyen@apm.com>

[ Upstream commit 4b72436dc3dd2457056b22d6f147777368c869fa ]

This patches fixes a typo in the argument to xgene_enet_wr_mdio_csr().

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/mdio-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-xgene.c b/drivers/net/phy/mdio-xgene.c
index 92af182951be..7ed54707a0e7 100644
--- a/drivers/net/phy/mdio-xgene.c
+++ b/drivers/net/phy/mdio-xgene.c
@@ -229,7 +229,7 @@ static int xgene_xfi_mdio_write(struct mii_bus *bus, in=
t phy_id,
=20
 	val =3D SET_VAL(HSTPHYADX, phy_id) | SET_VAL(HSTREGADX, reg) |
 	      SET_VAL(HSTMIIMWRDAT, data);
-	xgene_enet_wr_mdio_csr(addr, MIIM_FIELD_ADDR, data);
+	xgene_enet_wr_mdio_csr(addr, MIIM_FIELD_ADDR, val);
=20
 	val =3D HSTLDCMD | SET_VAL(HSTMIIMCMD, MIIM_CMD_LEGACY_WRITE);
 	xgene_enet_wr_mdio_csr(addr, MIIM_COMMAND_ADDR, val);
--=20
2.14.1
