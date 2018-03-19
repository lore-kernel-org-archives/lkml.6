Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475874-2-2423451555245597536
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
    t=1521475873; b=E8E7d+azo8RFnTSd/17S/uV21ihQJBMwTCL33BatALhm19Y
    Yu4VAuXgiClMK5j9La185gmThh15ueIHKtAY1J+x67IvrOA5iCMQ6+dmoeCMPZyQ
    z+qbgEXLG58IvosUeD8xUn0ceyONY0Ies65L+0zRZ7Cipr7Uaa020xfhxVjlx3qb
    2XfYhRPgrJmgUN7qeZpT5B3A+vX1mzv5j62OVUfGvYPR2yO6h18WQbs91+6d9h5N
    BdzCLg2KJaHof8xiexBm/7ucKgXITG/qFbTSm+HsyPagJkg6AS5NfXozZe4ZkXcM
    xn/hYSnPf5novmDOT+ongAn4gWUssUnpiYHmjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475873; bh=WJogxd
    Uaog34ZudXom/VtXQN62UoIxwZYbKofkVKC1Q=; b=pmO6FSgJB5Ye03b2jol/jj
    BZKGzg6dd9bMAVWZBpYgNdR5EfnM2mzoye2G6KxqvabulGYdDuK06jj5QJJvOLEe
    mDymQeg0KTZQkR27l9dsaOP99dZgGgrpR0/K7t+Px3gRpzneLMMKSmr8O1bU1QDH
    LlWkF7afb60gOLbeZ6unF9i5DMQt1x/0E5tY4ag6tsgBtBmgxRPbBBLheHNclkD4
    CxLqKO24xIdMa71Ydechxw5E0VDGYKC/C6VRAxGdgxIWHXRBVk41jm94eUZ7SgcS
    OwiD857N3Hd0cXfHU708GRyV9eUy4lhbInkYNR3lOztwqzogwde91vuKbl6D8+/w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QHCuy/Il x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduheeiieenucevlhhushhtvghrufhiiigvpeehfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QHCuy/Il x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduheeiieenucevlhhushhtvghrufhiiigvpeehfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966715AbeCSQLI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:11:08 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:5984
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966694AbeCSQLC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Szymon Janc <szymon.janc@codecoup.pl>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 147/167] Bluetooth: Send HCI Set Event Mask
 Page 2 command only when needed
Thread-Topic: [PATCH AUTOSEL for 4.4 147/167] Bluetooth: Send HCI Set Event
 Mask Page 2 command only when needed
Thread-Index: AQHTv5yDwCHw5MDRb0mNHESeoa0pUA==
Date: Mon, 19 Mar 2018 16:08:27 +0000
Message-ID: <20180319160513.16384-147-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:ujHKND0CwhSvm3i78VIlziwj6CB3fKgejhGpXvNCWp/ZykgJTdnvGmwsiT9ALR5fElW3X5uP+8hYcgRcBgvLQf56F/G+MBx5p3G0GN2uyNLGBSYAgHNf60Kl3ktdQc0a6FgB9kw0Zo8GynXvD2ZYgtTbpFSI56g8/3EJ6aA3LJQW0QBIR3zDMXZW7uQzoGeB6zmWCJ8siYtelwXKH4ug6qzTEyAbP+QE7hgNM2mr4dh6TM3DnATbkfXf49R6POpi;20:xI4ptaPNvfLTGQFGx1H0Il9cpBMea1zpE1wZKPQVUtdSXbqbQkTJHVt9L64eB14x3TBB8FbR0xQ4k8rgr380UfoBeSgvEazwVxEkUhisAX1mRClZC5hNlOekFFHD+QBMLiiCRN4lzkDrn61M/ZdNScN+YmMr1FDJLhpibnkR05s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d92c1adf-0683-4607-e778-08d58db3fab8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095281D4C7C8AB497CA46A3FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HhmYESmQT/X/6bEK0XdTEf57S3UntemP7udHIcR3v+0SsqRc/cxSnLQCe095HYs78CuDxQD8dsRWOtroW0wzPFNX9qQnemJz2AaROEoeGeIze/GjevndRU9yfBjvlcA8lBRUP57+00jKWquXEvNVKGnc9sMJPwuyMQboYC2+wqeoIzk27NdawN6GR+BmKBTjBeGe2HeCES1+E0f5sxmQ8+zTpgXDugFxI7yz4TO5ij0PRHTDLkV6PqD75M0xkJjd+WM+IkakgYbuVr5vBC+ZyJBvZh6HT7wDqg7XI/C+iCwvroAuS1zF5zr7OjRLqtYKOTsN2mivwhS9K7WoXo30Iw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92c1adf-0683-4607-e778-08d58db3fab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:27.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

[ Upstream commit 313f6888c8fbb1bc8b36c9012ce4e1de848df696 ]

The Broadcom BCM20702 Bluetooth controller in ThinkPad-T530 devices
report support for the Set Event Mask Page 2 command, but actually do
return an error when trying to use it.

  < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
  > HCI Event: Command Complete (0x0e) plen 68
       Read Local Supported Commands (0x04|0x0002) ncmd 1
         Status: Success (0x00)
         Commands: 162 entries
           ...
           Set Event Mask Page 2 (Octet 22 - Bit 2)
           ...

  < HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
         Mask: 0x0000000000000000
  > HCI Event: Command Complete (0x0e) plen 4
       Set Event Mask Page 2 (0x03|0x0063) ncmd 1
         Status: Unknown HCI Command (0x01)

Since these controllers do not support any feature that would require
the event mask page 2 to be modified, it is safe to not send this
command at all. The default value is all bits set to zero.

T:  Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D03 Cnt=3D03 Dev#=3D  9 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a5c ProdID=3D21e6 Rev=3D 1.12
S:  Manufacturer=3DBroadcom Corp
S:  Product=3DBCM20702A0
S:  SerialNumber=3DF82FA8E8CFC0
C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Dbtusb
E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
I:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/bluetooth/hci_core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 62edbf1b114e..5d0b1358c754 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -716,6 +716,7 @@ static void hci_set_event_mask_page_2(struct hci_reques=
t *req)
 {
 	struct hci_dev *hdev =3D req->hdev;
 	u8 events[8] =3D { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	bool changed =3D false;
=20
 	/* If Connectionless Slave Broadcast master role is supported
 	 * enable all necessary events for it.
@@ -725,6 +726,7 @@ static void hci_set_event_mask_page_2(struct hci_reques=
t *req)
 		events[1] |=3D 0x80;	/* Synchronization Train Complete */
 		events[2] |=3D 0x10;	/* Slave Page Response Timeout */
 		events[2] |=3D 0x20;	/* CSB Channel Map Change */
+		changed =3D true;
 	}
=20
 	/* If Connectionless Slave Broadcast slave role is supported
@@ -735,13 +737,24 @@ static void hci_set_event_mask_page_2(struct hci_requ=
est *req)
 		events[2] |=3D 0x02;	/* CSB Receive */
 		events[2] |=3D 0x04;	/* CSB Timeout */
 		events[2] |=3D 0x08;	/* Truncated Page Complete */
+		changed =3D true;
 	}
=20
 	/* Enable Authenticated Payload Timeout Expired event if supported */
-	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING)
+	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING) {
 		events[2] |=3D 0x80;
+		changed =3D true;
+	}
=20
-	hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2, sizeof(events), events);
+	/* Some Broadcom based controllers indicate support for Set Event
+	 * Mask Page 2 command, but then actually do not support it. Since
+	 * the default value is all bits set to zero, the command is only
+	 * required if the event mask has to be changed. In case no change
+	 * to the event mask is needed, skip this command.
+	 */
+	if (changed)
+		hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2,
+			    sizeof(events), events);
 }
=20
 static void hci_init3_req(struct hci_request *req, unsigned long opt)
--=20
2.14.1
