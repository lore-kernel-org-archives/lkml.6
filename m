Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474862-2-9309624528793408834
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
    t=1521474861; b=gpDJw5tT+mrQ3jaXvJ0Su5cZGs91h25QO1hWWbJ+U5E1cVv
    egSWe4G4zZ9mm6ASUx3SZe2xkXRwMAKdtN+xJtxC9tO0779InVSRwK5wwBPtu6ol
    E2qo15yvdfgVjwacuii7zvDFKPmUmKkqp4WQUAaOEeoNMZItcnbzBKm5P0X0KF0n
    /diSc+qNsH6U7r9hWTm/8UZK6ayxfrG58cN5n4PiyZ7wuKK1mXwUsw5yT/i5C7Hu
    Sgb1bvdsBmm44xV+4HVf59Si1C5ywwcotW7WWYBb3d9em9tYgBSuGNprXNX9IIhv
    vTgio7beUFJNHNKkpENi86uhl0tBtAnjksmoPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474861; bh=EEczb3
    3mfFSDPDTJRW6bQ/2e8XgsmE1AXVCB/KH/Uug=; b=m4D9abnq94w6+B8ir8X+3w
    OcsXE5aHFQwvi5rT/za8XCK8Xb/1GH7RO8j35+K2TwJT6ICLe+FxxV2PhBj3X8eR
    2xVH3zzf42nGLExlr7gqsRa2zNcdHeOUUEhIjuvw0FQveSGJBRLiJZRiEKlKYEpV
    izl3zsBLm7FmUaiQ05ZQqJARQR4ifgedUI2sAbbux7sqtNinP2SEZJ7rWOx5k8oB
    lRQVLu3fSWbIUE4qMgOT5jD4nwX2JqkOfmboDrWN52a2VxTdKFHf6xDMmp+AijiZ
    67B1pZyQP6ZrfsUYAv6o2PHi/jck057HFANs0vbbUolUqLdU8e1jpWEnpmMBpFew
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FxsmjGR8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdeludenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FxsmjGR8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdeludenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934049AbeCSPuH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:50:07 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:64697
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934025AbeCSPty (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 096/124] EDAC, mv64x60: Fix an error handling
 path
Thread-Topic: [PATCH AUTOSEL for 4.15 096/124] EDAC, mv64x60: Fix an error
 handling path
Thread-Index: AQHTv5nEaMnouIXXr0K0laarnn1jvw==
Date: Mon, 19 Mar 2018 15:48:47 +0000
Message-ID: <20180319154645.11350-96-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:pamRfOBkaoeaSOPq7bMIQBevU7/VOMsgnDTGa+ZNWZD4ojflZUxILVhhcTHxHz89Mz5iXeYpt/a6Z3tiWSmHMaKdFV4MA7xgqAu9nEMwPCvzKvd8j4KZ+/azQUeZhxQqVz3oXkn3g8FHna9vCDJvuMzZgvFneK5sxIPdEyOYAGGYbkqWSyXnCuPU+zNyTY8I0pZutNWUBM1WemV0dB0AlGvq9p3l+QQvz4TCGqXiEi6JsknfQuae/nk7jAWFlcW1;20:KQ32cavgpAddm1UIIJPrjynQIklSkLoEabMQWT6KyyuQqIjiJDu4wSZGg+XDnK4qnGKsK8hMf35zc48sAixVcKbc1osNzoVEJEe4Ig70lhpSGo58vJzq3tEwlnsImeKF4sZMoRm35fMt2Eg19Pb4DvR9WQw66VSlasVwb7PoTe8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59e9a1f9-cdc2-4444-fbae-08d58db1060f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098115AA735A9E4DE5DF2FBFFBD40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(155761271638844)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(6486002)(26005)(110136005)(5660300001)(54906003)(3280700002)(6306002)(6512007)(68736007)(102836004)(6436002)(107886003)(10290500003)(53936002)(186003)(966005)(59450400001)(72206003)(14454004)(36756003)(6666003)(2950100002)(316002)(6506007)(22452003)(478600001)(10090500001)(106356001)(105586002)(99286004)(7736002)(3660700001)(86362001)(76176011)(305945005)(86612001)(2501003)(97736004)(5250100002)(4326008)(3846002)(6116002)(1076002)(8936002)(25786009)(81156014)(81166006)(8676002)(2900100001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: y1/sWmIl9hyTK013sqW/LjbkNLSXFa3TqoXbLcf0w7lByHQBZ6TnCi+jR3KYJREg0lkVVwDZFllpD7qUB+yvTwgR2MvluHfxpVUYu0XGSxGp+ZxbaD3grEqtUNBAmIm8KYf2sZV6fIuIQ/5bfrTWVtVtiBnl45ZHAIKsUsJzwo7AiR+83RwPoSqybsXcVufXmR3v1uJpHHcRQKUhQaeI7NMqckKhsre8cbhWNxKKx2zb7w2/mqaU9y3t1zINxhiuDRqT2tRb8gk+h0Slt2Go3zp7nKRlN00YgZYIUADpeaQdSMevIefvDhxlmUSYJ/wlf/0O6REdaQoAAKidZXQGmA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e9a1f9-cdc2-4444-fbae-08d58db1060f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:47.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 68fa24f9121c04ef146b5158f538c8b32f285be5 ]

We should not call edac_mc_del_mc() if a corresponding call to
edac_mc_add_mc() has not been performed yet.

So here, we should go to err instead of err2 to branch at the right
place of the error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180107205400.14068-1-christophe.jaillet@wa=
nadoo.fr
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/mv64x60_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index ec5d695bbb72..3c68bb525d5d 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -758,7 +758,7 @@ static int mv64x60_mc_err_probe(struct platform_device =
*pdev)
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res =3D -ENODEV;
-		goto err2;
+		goto err;
 	}
=20
 	edac_dbg(3, "init mci\n");
--=20
2.14.1
