Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481389-2-2852420071142542001
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
    t=1521481388; b=Rj/q0ROZ/GRlrHtbRaZ+anQWb2xQWohLK9ZBoM8CtTYvaYG
    YuiE8XqqVg0bZpepmH6l6uuvdLUg+rpZMR6uH9VL4U1rWrRejtPz/AvPcwjV6VHx
    ibHkoFHdLxTtcf0MxMqy5gt7snb4kfsPahAcxUzP5NspBY1UHWEGFvCvTCJ6z5wh
    Vzxaq1caQ7ZorToNrF1Y+hBPVNcB9a4/gX+gwxHwBxopWZufU0xE0v0G3kmG/1Ip
    7HMH54l7iLT+B5hSrF50OUI0ezYxPK/AJRVVMtNwvFsXoFg0gLlkH8P73XDGs5CC
    NekgqXvTIu71fSolUQ4qciLe7xWkI1Vec6LH1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481388; bh=atqmbD
    QhwAaYsc8CyxjzOH+AjCkM0+guDipA8ZOzatU=; b=YGtyZCXu4H6FTm7ANsnwPs
    G17QQ63SUmrU5mdZCgdWRzs6BusM6DjBqxMRUrPQmDClqkj7I+jVQS3KvYU6+Fpm
    ovWRlpQ0rktTVX+QLzA/eZ9uKZuboR07q4AAfdDM9x2yfuejIZSpZ3E5MXTHxVqO
    PSFERpnboiduToR3RgTw2iEgNPWTtV7H2/9MaNljXTRQ+T7Fb2JStkTZEl7175sA
    ml+ookY6v7R1JpjlS7ZlKR4Oa0FasXV61LAwH0Qtln6CFeua/OUJPRlKV77f99fE
    dxLQ2ZNydC6JS1gd/oep6xtjwbNOlgM5yGEk++T8a6jcneQmSaCZT5gJC6wVMPoQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hBTJJSh7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudehieeinecuvehluhhsthgvrhfuihiivgepkeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hBTJJSh7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudehieeinecuvehluhhsthgvrhfuihiivgepkeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965930AbeCSRmX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:42:23 -0400
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com ([104.47.38.128]:47286
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965846AbeCSQFu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Szymon Janc <szymon.janc@codecoup.pl>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 252/281] Bluetooth: Send HCI Set Event Mask
 Page 2 command only when needed
Thread-Topic: [PATCH AUTOSEL for 4.9 252/281] Bluetooth: Send HCI Set Event
 Mask Page 2 command only when needed
Thread-Index: AQHTv5u8x0lqG8grqEKwW6emDHBGJA==
Date: Mon, 19 Mar 2018 16:02:52 +0000
Message-ID: <20180319155742.13731-252-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:kTs3M9qa207EgBdqDCwGzAbKhijypoGEzCMRb0wbJqoJ56PtsUAHpXMuHE6asWhHoS3LSdvcqGHqFRRYmZy6Lumxo2OYJE0MQjyFu/v4OXg+efNxrlPfR/yKqsqxEl418239Vz2lZcJA+5xvB7UBHfD6TSE5pwhwx9madLBYmQLSZ52U3DWzSSTEp67rsxwJjPZ2P5SRO/dgzOe6aaOEFPiE/CWVBpuXHx3+QyFEK8tyZm34nudFmkybjDDMqICU;20:hX2MM4SGtz8XdmCfJCALVKwRScfoQByYnnnAPty8zBZhkhZJAZBzbv/kxNDNNgwkQ0+vAY1dUoDNE3lAqD0978ojm6RY5JBdDvV/unBAKQItLROf1p69JAZU4ZVEWj5WKmPG+0pXU8mxgZPidgr9VWS5BLysu14zWTY60rYNqp8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67538224-784e-4ee9-1989-08d58db33e84
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072759CE589D2FAD85D059C1FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lPnhcvuIOTEZE5XeG41qfC9XRTkbIHEhcgFZ+LPJaYhVjpeF/Lv4h84RjLuNnddmSvSrt4srm5+cTHVTT1tISh+wLNj72bVw8Q2jvsCtEDRBWurpJLgqKWo6jwZY71OrfHFUMtgSJn01oOAy47dUdK8i0YTMQLyN/+AnTc3BwdbB3oV4ViHEjeyCZlsF3J/lCoP9MsACq60934zqoQHfqDyED9ggh1kQUlxl7U7Z23ZV72DrmnuHLQcD8pg9bn8Z989qZeQHDPLTCvVXVfF4WQ5f1l4HuuASwu8lJutBFk09HyW4UqQ9Jsc0qUSj4mXg/EEt4fQeF2XeOMIpagwQmA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67538224-784e-4ee9-1989-08d58db33e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:52.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 3ac89e9ace71..4bd72d2fe415 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -548,6 +548,7 @@ static void hci_set_event_mask_page_2(struct hci_reques=
t *req)
 {
 	struct hci_dev *hdev =3D req->hdev;
 	u8 events[8] =3D { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	bool changed =3D false;
=20
 	/* If Connectionless Slave Broadcast master role is supported
 	 * enable all necessary events for it.
@@ -557,6 +558,7 @@ static void hci_set_event_mask_page_2(struct hci_reques=
t *req)
 		events[1] |=3D 0x80;	/* Synchronization Train Complete */
 		events[2] |=3D 0x10;	/* Slave Page Response Timeout */
 		events[2] |=3D 0x20;	/* CSB Channel Map Change */
+		changed =3D true;
 	}
=20
 	/* If Connectionless Slave Broadcast slave role is supported
@@ -567,13 +569,24 @@ static void hci_set_event_mask_page_2(struct hci_requ=
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
 static int hci_init3_req(struct hci_request *req, unsigned long opt)
--=20
2.14.1
