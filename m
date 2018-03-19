Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479373-2-9616361057750540376
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
    t=1521479373; b=vT2puCheTiYSKpebT7II2pCsxecZ1eUikH+SMFzD1PbcibD
    G8XJf3wwIg61C03mVLk3YYjVrtPF2o+T6ZZZLBGwwXdWZPsmIVZeqyUAdpaStM/F
    Z1WDgHwUTcYlT0O71wzyetx1ItPawZE0ctIjShuDMJh7Fak1Kl+WZEXIGTSn48/Y
    9nu/xfauN6cbZRqB5WnyNP++hT2Q5rYwhBrXqyOhODBeFB1OVYE3QwVeuqEwJEqg
    dWbXdRmLQMajxi8sebCWyWZCeN3Fw2pHkSfOJVKkxcIm5Z9hEiyHwe9sDdwt6Zqz
    K7BGe+cLrdKAes1bee0NSJB/JZ6uTfGugbRWcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479373; bh=a88Sdl
    HOQ7oOiOJdLm3gJLT3f0c/QfGLnGhP0XD4B4E=; b=DrrdGO7lPh6wdyVyYU4TRX
    9rIM5xkDwUzYysRNdpOSwD612dM5CMpzIjbxHEn9yvHYtPAqf1LmcVUAUALHUgjx
    kaElJc2mPSdqT+k4lgLnXCOstUuFZGb2iZmqTKK0d3nOS8GhmsUT8qgAr8cT2KXt
    RgJ6WPFxUxTlKSEd2iiD0dUNgz/1N8Jss9+rq+4LeblXQxqahJLNZf7X2cCztVbv
    V9OpDj2dcfiU5YTwWPNkONFkPoTcFbzZctFpo3vcioHELT4slpiCvF3P8INBDjw2
    is3bTnWm7xxznUVtmh4NCeP8iqc0sNDCbcWPJ6hX5IAc0dEpTbzc5ICVn5gbxGQw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IjdfuODJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelleegnecuvehluhhsthgvrhfuihiivgepheei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IjdfuODJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelleegnecuvehluhhsthgvrhfuihiivgepheei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933974AbeCSRIo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:08:44 -0400
Received: from mail-by2nam03on0091.outbound.protection.outlook.com ([104.47.42.91]:31330
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966657AbeCSQKq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: A Sun <as1033x@comcast.net>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 130/167] [media] mceusb: sporadic RX
 truncation corruption fix
Thread-Topic: [PATCH AUTOSEL for 4.4 130/167] [media] mceusb: sporadic RX
 truncation corruption fix
Thread-Index: AQHTv5x2u91kHxqU4Uqo0HaLadueHg==
Date: Mon, 19 Mar 2018 16:08:05 +0000
Message-ID: <20180319160513.16384-130-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:fbUnXbjlPhF2I7P6AEU8h6lu22fyFK/cG+eG3RrJxsw+5GF0KVBz5Wn72FWW63IvBT2v1hl0eofGWKP+JNu0BTA9aEPIg+7uQvcRUikXsX2Oqw6k4BYOHULcWjP2iaxhLRN1CA544OCc/Hs+L5592Zw7ECQjgKsI8b7Fw+qYlgVFg7bMEIvlovxhNoBFSEratnvWIcq+YCUMmn4s3rQ0nIjkdJF8XmxGVEscsEud7p/AN4MDVYfLhiO9jwyWREDT;20:Gyg+zn31HHe9ZX9CgMeVyjmM4bBMpQLHq64Cya+jTkoPSuYd3JdA1orN2g5O+N0oQy0u1o7gYKV7Tss1NHJJ/R+dG3YSD7RZyiZKGdHIW7trfUDtEHh/cWD3mz7uf8ZrsXSpNLk2TnnwAxY1uFx2CDpmdJwUg4jg0VdhYbPRXZw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f4aa1e8-32a8-4e0b-c812-08d58db3f4b8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045B551B37C35672173B28CFBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(68173958961439)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(377424004)(86612001)(66066001)(6436002)(76176011)(10290500003)(6666003)(2950100002)(8666007)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(102836004)(8936002)(6512007)(7736002)(3280700002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(2906002)(14454004)(81166006)(316002)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kzILG0mT9mVVLK7db3fv1WOfISmnuZwhjUBvm4xfhDykmW+xYNBhLaRlR52tbS54ni6rDpPtp8b7pHrP3nuVs8sKshJnA12Hmgdp+CBQNZBRcnfMHvXFYS9XggOXuomF/jKSfENOyNuJSqqvuVGVzxEzTJiQfaPXT461uFazrBl3rHUU/HeUH/+GoAG81LK/QvBCnyYRKl5VKWBDGUP0RCFFZlptP+Lom4bzKrkRhN80Pjfn5URRiLvRiEe4GjuL1F+cn80NTvhugzgn2ofdtSv1X+cxDdiLOKvcvF3d9sV5/+UlpQ3lWXJdmZhCtpWX460dbHDkW1akWe55iHB4Kw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4aa1e8-32a8-4e0b-c812-08d58db3f4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:05.5380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: A Sun <as1033x@comcast.net>

[ Upstream commit 8e175b22e8640bf3a58e071af54190b909e4a944 ]

Intermittent RX truncation and loss of IR received data. This resulted
in receive stream synchronization errors where driver attempted to
incorrectly parse IR data (eg 0x90 below) as command response.

[ 3969.139898] mceusb 1-1.2:1.0: processed IR data
[ 3969.151315] mceusb 1-1.2:1.0: rx data: 00 90 (length=3D2)
[ 3969.151321] mceusb 1-1.2:1.0: Unknown command 0x00 0x90
[ 3969.151336] mceusb 1-1.2:1.0: rx data: 98 0a 8d 0a 8e 0a 8e 0a 8e 0a 8e =
0a 9a 0a 8e 0a 0b 3a 8e 00 80 41 59 00 00 (length=3D25)
[ 3969.151341] mceusb 1-1.2:1.0: Raw IR data, 24 pulse/space samples
[ 3969.151348] mceusb 1-1.2:1.0: Storing space with duration 500000

Bug trigger appears to be normal, but heavy, IR receiver use.

Signed-off-by: A Sun <as1033x@comcast.net>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/rc/mceusb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index f838d9c7ed12..0fba4a2c1602 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -1370,8 +1370,13 @@ static int mceusb_dev_probe(struct usb_interface *in=
tf,
 		goto rc_dev_fail;
=20
 	/* wire up inbound data handler */
-	usb_fill_int_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
-				mceusb_dev_recv, ir, ep_in->bInterval);
+	if (usb_endpoint_xfer_int(ep_in))
+		usb_fill_int_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
+				 mceusb_dev_recv, ir, ep_in->bInterval);
+	else
+		usb_fill_bulk_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
+				  mceusb_dev_recv, ir);
+
 	ir->urb_in->transfer_dma =3D ir->dma_in;
 	ir->urb_in->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
=20
--=20
2.14.1
