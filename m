Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486103-2-16467077344405162252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486103; b=d2y0NuLYB3wUF8nRioLVIVCot872fSfwaAxn+iJdG0h73b+
    GfdGW3Uefql6K4so1LcpRrYNE3BQVu7VEKnsceIKnih1RbJeNEbblMetXyHaQvdU
    M1YWP9OIcqH9C0/BUr539x28Z+ADhpGluHaBFaB7lT9R6Cugm95c5fYwJtNSdmTl
    Zvc+6u2nugRUGskI0rhfznYiVar6DLAS365lk9HEMgGnQ0LUy2RAcSKAGrGGtkHl
    9tW7ULLXy1xptMU3iH3FqA35xx16BdjeU3by/bjwNHxh/PrjrravfxitKtPRAaoB
    WoNoJhrJ7slgGhhoNNhwwhMeFJMV54vRHakElgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486103; bh=G+6ED2
    4Hx5gxRNOBQ1sXbPELtZ9gUbTgx4Hr0x5oP+w=; b=qEpGfHlNIuCBY+wY7ot4un
    6kyru6BBrNZeSIAhJdSrpgswdz2RXH9qqXP69N3BeyAOVP2rD6ko3M0HSYfBsXSS
    IhALyV45iJqe6MQnq2V+uiWFZlflz4H2nDcPI9Dz9oql/GEklBJiUicyF043Oi2V
    PIbjjpugZQebqiPN8FlB9EhpS6/MxeHQmiF4Rds1+rP9iSRBMXlp385qIJg7GF+E
    o07mx5gZNlYaRUmdUPpqFVvB74ez3zS+vLJKR87VcDBC/nq+Apa19XSD16iGXVqb
    75bgViMEqLrP7hUDgonHEzZZLpp/1FTLfYEhYPN65hplPko+TuvH4bDI/NHSyrdQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LS7g47FR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LS7g47FR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966687AbeCHFPB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:15:01 -0500
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:47760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966205AbeCHFLp (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 45/53] media: bt8xx: Fix err 'bt878_probe()'
Thread-Topic: [PATCH AUTOSEL for 3.18 45/53] media: bt8xx: Fix err
 'bt878_probe()'
Thread-Index: AQHTtprLoDLNEW+uCEOhcAKu42rjow==
Date: Thu, 8 Mar 2018 05:03:27 +0000
Message-ID: <20180308050230.8876-45-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:fLKbbs14RfWSdZqwypeBwe2eexJY+N3k8EdGVq3IL+eyzn8UuVi1sUmV7sUcdYbHKb4nIV4j16OKwi2Nu3CR9baKeFPXIB0FV8QKqZvbpijjMxOh2yXs1U9m65a+zLSVH3JJzwyGPnNzJHEQC1MdzYBZN/V/j5WAbnUTVczkZiwza3FsLTy6OkdlN93lm6iRFerkHRhammGrXP+QrXNBt7xpFdiXlgKX2jZGQytncSXZSDye3WmZzwrNV4Zqr45Z;20:IBg6ogk34itwHf/EVIjjuh7Wd/6yjCto+5NejY0AXHJty49HAgT4F7MZv90FYo130XqaAHVwFV0ekUpUdyLAKwP/RzdL1Pmvnw0AoQNQ3WXh4H+qgCqHePsQUyYGorsM1QO+KhIk7a0sbOuOT1P6dqfaLlP8AN92tSeTwTDCmXQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5116412-2cfe-43af-721c-08d584b3145c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030F90D5874EC96C0851CD3FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(575784001)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: XUG6kzH7p7ow9YhmQ4Cj0w64fUxaysAokMe/m3TFszrk3mxh9Okk1+viLMb4x+dQf09EL3oUxVWrFIsTPTffeIRtm81lLLg+GwIQdckTymgN/FPrPBWFv+wmGhfkqP+VvlUM+KmAnhe+mq+JTuDwXh4DAiscNxPP6O3f9cfq+B7uUGxbUR2PiEfZMQ90zFpeF8wRgmvrjxUWYyAzwzmYpIC7Qh3p2r1R2XBDCZCOi2PKWTs/n6NLzJq4b5asUa9YKcgaiwIQUobFRMN5K0Mr+3MIx+0K+e6CDZ1gFmI3AdQ3qSFZC0DLC9wpM5CXgAy3b6S2U+X6KI+BC27yYQ2okw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5116412-2cfe-43af-721c-08d584b3145c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:27.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index 11765835d7b2..866e6c8323f4 100644
--- a/drivers/media/pci/bt8xx/bt878.c
+++ b/drivers/media/pci/bt8xx/bt878.c
@@ -425,8 +425,7 @@ static int bt878_probe(struct pci_dev *dev, const struc=
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
