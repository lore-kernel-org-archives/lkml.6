Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492839-2-5729445914303656660
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
    t=1520492839; b=EzZ7075FvhTQ9KWKyarKwrB6T4I7ZNl1tpUEiZYp1lRFmZq
    XNhAsxGjTYG7GzEC7aa4yuXQEFyXCqNAPs0JTqj3j0rB+CTfmttL7zrCsrO/Inu+
    +17P0SI1Kt6TmcW6Qa40k18eEfi2SnoBF3+qKG/Ru11WHw4h2M7Y8j1+YbHGs1YP
    H2nmBgXIPw1eB0PmRFYJjsn+01Maf2riTJI5CGWy/EzOUMtqzIw0yek7YIrAxwR0
    MAh0Nk56Lrgn2Hlfl4VfBNCyYeAkGYsKkZwJup3dO71viDR1EmUFfM+fcjSDwFb0
    ClZtWENL5CA5YzMNJopVTLwPv4lORoKHpOzZACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492839; bh=BXZc1G
    8UpObPbMzmzIaBnFLU5Ck1rKqL9LLw/DLZRkY=; b=q2XdMycABir+6z1MK3t4nb
    8JgnEkYfz+/iR6AICRSvXB7UYS5b5e/RnpN62dZRQSi+C2cufGXuX1EKV3OXE/iN
    9AhmNSBCa+hgRYV6+C6C6Nf+e5IeIX9so3PUHsU21My1zZB4CyBlkSx/xftfz3fa
    DyrMRaJBXfA5KUPBCY1tJoXy6/Avfk3bwuj9kBZqb8C7AyThFLjUNAloIhspCUFR
    iJVwr6LX1452OY3Y4NT/32Wt3B70TEReuBxKKYaM+ibcSm3zOpfh/DE6EzDr+PXE
    R5flC4hAQx13esh0gbNNAp+h1PRXrj2FeMlOCwG/0PLYujK1OI8+ujAK0yywHb5w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HAqT3uzW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HAqT3uzW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755255AbeCHE4d (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:56:33 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:1475
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755243AbeCHE43 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 21/78] media: bt8xx: Fix err 'bt878_probe()'
Thread-Topic: [PATCH AUTOSEL for 4.15 21/78] media: bt8xx: Fix err
 'bt878_probe()'
Thread-Index: AQHTtpnGVqsSCnum4kWauWEIgqYIGw==
Date: Thu, 8 Mar 2018 04:56:10 +0000
Message-ID: <20180308045525.7662-21-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:8jOWM3u0d/HndBoM6EU7VCvpI4JWBkK02Sxsbuyxe2cm4GDySe71EWHk6QzJZpAi24WqgavTSADI1X/YqlbFYyQvdvrk5GyOke0zoO8vr4/n0MsVU3k2wewvG2ylGrfeX+s8N4pT1q8gGdCqxQnMQ5w981vPq6hgs6tJnD+zjvPWQSwn+Tyn95bmSdC5rp4dLkJPURBrWTQT6Mk1xeGP0KZD4oNEfwCpcVqiu5UH35SkyWLFuTTCgg95GkSdcRGT;20:eLPyWUuLOp5iTTj5ErVApTP0EC2MvKMoai1+s+/PHQijXItVnjdFPV+IfmDCvAebTdP30YNgsq9kDUXpssmix/8Brrj3GZBm5yFHl7GQO2NL7o4FSiqVC3EB7EnkHMG9gwineSHQyiDrWg7TU+QSVNyao6ysnE0Xx3hq6YFAoQw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c86e0762-1fb0-440c-69d1-08d584b0ec54
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11112631A1C49EA936F7AAA3FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Zs39HAVaz9ZxHsamxoHE6FKLsvZArZ2YvifRbNL7D09AMuEgfvcz1Swg9aFB2jmuJcx0eyybl9dL7uW6MJ79+hoD1Dt6Hr3Ubrx48E8JaVGS9rpuq8VHUfFGFfePE2NRt1ezlNnEC5iawpdNWzvsZ2Wj7Dj1Tnyj/D7nlfKi22f51cz1P5j+lxhdVDtxx2M+jmKOFWwAh1uX96l8kgGSdVW5A9wMrnCXrPtwttyKBbQivaRufd8C4yIqe0Z6LBdSnpd03QWrzs1+/rDfVi3QeNjqoVtcBS395qyC42ocfYeXOSOcXXUuI3NAumLly7+gNcXgCBK0LTT/LCONiprUCQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86e0762-1fb0-440c-69d1-08d584b0ec54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:10.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 45392ff6881dbe56d41ef0b17c2e576065f8ffa1 ]

This is odd to call 'pci_disable_device()' in an error path before a
coresponding successful 'pci_enable_device()'.

Return directly instead.

Fixes: 77e0be12100a ("V4L/DVB (4176): Bug-fix: Fix memory overflow")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/pci/bt8xx/bt878.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bt878.c b/drivers/media/pci/bt8xx/bt87=
8.c
index a5f52137d306..d4bc78b4fcb5 100644
--- a/drivers/media/pci/bt8xx/bt878.c
+++ b/drivers/media/pci/bt8xx/bt878.c
@@ -422,8 +422,7 @@ static int bt878_probe(struct pci_dev *dev, const struc=
t pci_device_id *pci_id)
 	       bt878_num);
 	if (bt878_num >=3D BT878_MAX) {
 		printk(KERN_ERR "bt878: Too many devices inserted\n");
-		result =3D -ENOMEM;
-		goto fail0;
+		return -ENOMEM;
 	}
 	if (pci_enable_device(dev))
 		return -EIO;
--=20
2.14.1
