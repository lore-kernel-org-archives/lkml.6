Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521476059-2-11233215275088984427
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
    t=1521476059; b=WUPYzoA3VC/WqSVyxhQZc8pawELmY0v3Qdkxc2zqz79tF6x
    8ql3qgKm7Wk4CfFdjNJsWupEpRsKBhcofSwY6/NCFQSd+zKHcYHf5/ifIpNaj6TM
    H+uLGZryAnt19E39RMJ78/WEs1ASsDIABhdgYckowb7983yNe5W5tOS7FR2ieLtH
    OkqK3P8GEL4fhvO5unDornSnMyweYW5MlO5VlNGKkbnNxGzoA/FW5FgyVALafqLz
    OAryE5VURHY6TpczOkciZlrRi6jLZ4Xcgbs0eAqP6wnTWc6Xo/hd4ZNqxy6GocvT
    n2HnsQpgCBxAjqtoAP+E77tWkhD/13ZK/p9gH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476059; bh=a88Sdl
    HOQ7oOiOJdLm3gJLT3f0c/QfGLnGhP0XD4B4E=; b=Rhuareb2HMS4v9bP1oJhUA
    JsFypvdwzyrlAx8lPcKqaW6JBfwRLzmKN/7LX8xchx3AhTD3grc4WdNr4g92iwy2
    zee4GpB0U88ZW1o47UVC3A3O+Rsx4peQMNW/o9PmNy1XQXSRW0h97frYexTYaVyM
    ZLMPSB4PzOE4YbaK5Y29THzeB0C6f7d3kmD88lmRHJJoCbe3si5icPwGTkIY3KfQ
    1JETb+3ihpzDibnYVsOgkXGV1jiesMOMz8cYTqqHfXsETNxu9aG3o54OMcgF0u77
    4RuAJp4D1WDVVy0w8tnmbklPjAIjKccloOaa7ZLiurJKgFBKhaFeL6Z8427CyqwQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=knsn1KWR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelkeelnecuvehluhhsthgvrhfuihiivgepjeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=knsn1KWR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelkeelnecuvehluhhsthgvrhfuihiivgepjeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966921AbeCSQON (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:14:13 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:53605
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966918AbeCSQOK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: A Sun <as1033x@comcast.net>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 075/102] [media] mceusb: sporadic RX
 truncation corruption fix
Thread-Topic: [PATCH AUTOSEL for 3.18 075/102] [media] mceusb: sporadic RX
 truncation corruption fix
Thread-Index: AQHTv50otqwPRHSjW0eFfZwlTDwQyw==
Date: Mon, 19 Mar 2018 16:13:03 +0000
Message-ID: <20180319161117.17833-75-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:iVOejf+BXPsKzGfHvKQ0O/y/rgVOPNioaE9/OSZ0d4d3EnHXxxu3bw+d7W+XGy3hloUrg5y3Mt0dWxsrj3eTa3twZhRUJBsehnQhRaDCpIfhB8VcJvw1hGjFt1u0ysKBYdVDNc2MiBKrhbPnak9wno86+DjppHKVWhzzY2GNlaZnYqbNX75xuV6mGRqqHpF2FXA98MDaipYexHu8nNGijA82Tc2YqE5/QGxctQweiB6Q7q+OXzTG/EAr+fe9zw3q;20:ILc6oDjlPzZZwZizmMto+mV+OhhYeBO8c1P5QpPWQ6C/OGWVfpPBpwsi4muwKfRPIm4aiiewjIyCrh66iNewwiI8mth49YnFfT6iRy3naZVHz/Y2dtPoz0ZqFodNXRtG2Xf2ObuflaqpVk8MvSIMIU/3JN6sVEYMWq+Ze3gSYfY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2543a24b-d50c-4885-ba13-08d58db46e78
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063CEF03669BF5859D0C77CFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(68173958961439)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(377424004)(3846002)(6116002)(8936002)(1076002)(8676002)(8666007)(3280700002)(2501003)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: PB85kh3QeBD0jXpG4525sEc5NOXmBz2kaad1J2aNIpD/Ch0lUsykLZLN9W8fbDnQtPLC8/U/eejZUkMdmyfI5TjKLiAIDvBga/qJLWBQ7vTV0A9WLF+lX7ppHoH4BV53J8pmNeeeyfkRmx3AJrqLqR3ynE0MBqdZihTFyDKdp+Zp6DDl6jxHSsbhwzy0fXj6VDWr0Ti49WYlDO4G5OKmlvmnD8oyHEcIk9YQeGLlr2i4ATsV0WFaY/B7mHYUS4Ql/ZIDOf6FrwrDkyJPtmEkaGskJQNN54DRUXWSphchmEAbYbPvWo3ViFeDV45AU/EGqj6EHkV4UrZH1za5WNhfhA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2543a24b-d50c-4885-ba13-08d58db46e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:03.3628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
