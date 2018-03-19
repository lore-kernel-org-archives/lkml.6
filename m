Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474439-2-13109985176909458923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encaes, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474439; b=YIpQvfJgFbe8HF25Pjivvn2u/BgQSnRokzxrX/nCfe59JIR
    43DFJx5kQZlXKS4g4ghUw4OHKEmN5nEt/PXL1R65N6Cvj4yqKK8OZ7QKJKMiP7Ts
    fY2lO+FXjryzEh3703gjwJ3M96pYwit4Ps5KkrCF69SvdBB//N/OiCYQHr8lBesO
    5bh8T+3D3E6h2XAB4YqmodA6CRZ1WZiLuPfV+qr6XmjDCgShK3uwygsUqslyWupO
    i+C/jXJsPtAVwMwckkwH7Y1F3KFPRSOvcTL+2LVCrUGFHqYn4rRyRf+RHCSldH/k
    rJ+3JKx2izJI4roBv/ukWDUnLb/MuyPq6WfbyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474439; bh=gQVkjG
    sxVFRSCNlaRm3RZj/18l0hAY1LW25c79D5nNo=; b=BzTW15hHRxCVbEtaKXa7ID
    dirwUilJtdjnwtcCXVdec+J6chDAHla76kgJc7lukszf87RZb2GWTQQYyc5O0w0n
    AdndAZxsxHBBDm6TgmHaQyukGqITdwL1thHoaIUo05hY2kQuiFT6XVEh/enpoVB8
    TVWTSvaUE+Nv/Ff/JE233ZXrhqETCw2jz5VMLSVEYavfPinjketo4uw9pHhnmklD
    VxzcTEkS4gmxCT1czePAWjSCa/lKbe8IUkBmUPSo4sb0Bis9l3tZ4IG5cc1BOqXK
    IQkKNMnsV2CeufncTTDDACEOdStnjAWpwkhoQUZreI3pWiRFiMjKIuxpw6iAyNdQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSK9mNQL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleefuddvnecuvehluhhsthgvrhfuihiivgeple;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSK9mNQL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleefuddvnecuvehluhhsthgvrhfuihiivgeple;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755962AbeCSPrN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:13 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755991AbeCSPrG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ioan Moldovan <ioan.moldovan1999@gmail.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 006/124] Bluetooth: Add a new 04ca:3015
 QCA_ROME device
Thread-Topic: [PATCH AUTOSEL for 4.15 006/124] Bluetooth: Add a new 04ca:3015
 QCA_ROME device
Thread-Index: AQHTv5mGbxcVlUvxKE2Z3OQQozl+XQ==
Date: Mon, 19 Mar 2018 15:47:02 +0000
Message-ID: <20180319154645.11350-6-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:trMwP7tOR3e63RGTlpfVnbxbkj7T70HB+1M8XdswKP7QzN7Q+U2F/yHCTpny6TMdhltq/OqobseqyULVxCSyUK47GxjBlHouGjkQIIODaNzpJYZmVFDF8NUUfWT/71MCyOr9zw4h7Fodyu2zbLGV4eCSQhFdgjNCVdIy81t6ehmQOc4hUmGIigJirzz2IOg24lAIxZC+yJFdySkz7cFJ8ZsFgXi2XJsQg80mCjAjwaXxE4xXTb+k2zS8dnWh/+z7;20:mVO8651zzqnQc2OAOGRFX6eOqXu68EY04L/ScOr+B4vgIUn9evjmZk0lVqSytfvfRGCT0yelRRBux0KnaFJ8VDMM5ODtuLsOohZ+lCAjg6SYM3DX80K6J8/wycRKtuBbCwZWeZdzp8ICWkwpZoZUKRa73Eb6oa+BL6PlwHpdRxw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ad4bc30-963c-4065-cd06-08d58db0a8c3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013F170FCF777CD50955D7FFBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(575784001)(54906003)(53936002)(36756003)(107886003)(3280700002)(39060400002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: FlcvtxfCyCx9qCH6ilHIYvKxOoof70WbEgNsI91MFda8O8dhGvJ1FkJeq2dEsicyV7HC/2i8fJzZoJ2+lmGZMOh3veBxsrIw9Gt/SBYDJ0UgeRbUKbMNCGWdDZtBrp2b0VLfZFS54Q5BTwKyY0VgBWjGSuQF6czBrLQywlPGJWiZd2jtZ36jHhQmzio58wCF973eK49rs0RMtUNcZj9p1RIccXvYVNFnwHasp6DsKmHNOljDRwsDbr33rohdn0ivWfZV3Z2xPZ1ShDpSUX0a7wu2LbHrz2zbZYfpbzQHSszr03Hm/CiXWoiOEj2Nh+6/1p6tdymQ+xTufLs6PfqJxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad4bc30-963c-4065-cd06-08d58db0a8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:02.6637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ioan Moldovan <ioan.moldovan1999@gmail.com>

[ Upstream commit 0a03f98b98c201191e3ba15a0e33f46d8660e1fd ]

This patch adds the 04ca:3015 (from a QCA9377 board) Bluetooth device
to the btusb blacklist and makes the kernel use the btqca module
instead of btusb. The patch is necessary because, without it the
04ca:3015 device defaults to using the btusb driver, which makes the
WIFI side of the QCA9377 board unusable (obtains 0 MBps in speedtest,
when the 04ca:3015 bluetooth is used with an audio headset).

/sys/kernel/debug/usb/devices:

    T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D04 Cnt=3D01 Dev#=3D  2 Spd=3D12 =
  MxCh=3D 0
    D:  Ver=3D 2.01 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
    P:  Vendor=3D04ca ProdID=3D3015 Rev=3D 0.01
    C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
    I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
    E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
    E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
    E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
    I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
    I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
    I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
    I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
    I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
    I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

Signed-off-by: Ioan Moldovan <ioan.moldovan1999@gmail.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e71e54c478da..9ec3ada7c8e2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -272,6 +272,7 @@ static const struct usb_device_id blacklist_table[] =3D=
 {
 	{ USB_DEVICE(0x0489, 0xe09f), .driver_info =3D BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info =3D BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3011), .driver_info =3D BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x3015), .driver_info =3D BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3016), .driver_info =3D BTUSB_QCA_ROME },
=20
 	/* Broadcom BCM2035 */
--=20
2.14.1
