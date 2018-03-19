Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475173-2-6491290353075952843
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
    t=1521475173; b=hwP94U7Zrn9m4fLMLyT4O95sQ/+Rv+qYyjVdcXjPvqohe9u
    cA3Q17nbPH8cUfqBADAnLB4kVkmya2xKcUCmvqIK9dlrptRa3S7mULcnTWypkDHA
    DW7q4hxaoJVX/E1vaT/AHOPVuK1/aDoEAOiS3HJNE94ByBPWwR4Iars1sAlpWDBI
    DhSpnIF30O82tv7zcS/D+81awkqC0xdnvhDe/qBolbNa+Fwl5t91jv76u47Ze499
    Ede7ebUhMJ9J/aAuv6dZmAGxlHrHhn6X77pVOoGsBUHRTImvdAWAvMUExzUWMP61
    Sp+b0G8B2RhrqrgmPPvokVVTZ352nsvSCUjUvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475173; bh=vB4LgH
    UemDY8+GWf7IXw3NJGUkwqCpmkCINplo52G8I=; b=JPY1EjV8L6IWwiLImCE8uH
    MTyph8F6Ro4+FsZ37DlPRTtmmElvr+FYV50Q4/QPZyg83kTszEtA8fc4Cw9wICgN
    X0HxboU2V6tUBhQUr1G3XRoSNH0+BrBT0iMXkOD9OQt1Xy9AmyG3EnglHilJL8kl
    7aBLR1DRJ/Q07TQb9vHG9duYqhSnQLJ0B1mplbeozKQ3Umip+onwfCxpFI+3hgBS
    whp4bZBaVVp+BS84TvkuyuwNZfoCyAxLYD0rEWiGFcsbJIPJ+8msmLJUe/PQWRym
    PkRRoS12KFW0ADyZz1DOL13W8uQUNdYOfSEaKj+R9izXpQ2vRGsAC9NBKdiKUWnA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gNasbSaa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeltddtnecuvehluhhsthgvrhfuihiivgepjedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gNasbSaa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeltddtnecuvehluhhsthgvrhfuihiivgepjedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934502AbeCSP72 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:28 -0400
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:52960
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965068AbeCSP7R (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrea della Porta <sfaragnaus@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 046/281] staging: wlan-ng: prism2mgmt.c: fixed
 a double endian conversion before calling hfa384x_drvr_setconfig16, also
 fixes relative sparse warning
Thread-Topic: [PATCH AUTOSEL for 4.9 046/281] staging: wlan-ng: prism2mgmt.c:
 fixed a double endian conversion before calling hfa384x_drvr_setconfig16,
 also fixes relative sparse warning
Thread-Index: AQHTv5soT1qoUrtxz0C4ApyrP7WBSA==
Date: Mon, 19 Mar 2018 15:58:44 +0000
Message-ID: <20180319155742.13731-46-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:FAeOLx1ot+vU1xykjm9rFgZK5DWs9E2XyKHJbcY845PnO03RMob/bqMqOlK8zXmwPzDTzuaXDIUAIRY20RS7MHsccp9jUFXYxsWRlqrLv8iCjtws42Dkh12b4NhpKfrcSZMckLYxKVsq6PUmg14c/1VamEOiuc/GJcpCkcHL/GlC6y9NoPc9YTIATnyQxpUI1a6dCFP2ZA+/RFrIBca3NeEnBpclSR5yJQYreo2w+oeF/SgoIf4oXgdmeW7QujAx;20:93Ffp18it2C7SocnJYULnHxFm0eVZnSCeynHJrPiKMpGNdR913CqHnMQzqzCjDiQbZvy+cXD8I2VmGVuAGhny3PtcjXmjISrI2h9q+FIyGiY2/b+VF2DQTXfDHKQKeaoyVqQV1QtZQjYME4VPc25TeZGw0/kjUvp7+6wK8qNGUc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a5a34e9-4bee-4579-72be-08d58db25d31
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11098D6BF670B43EA53F094DFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(39060400002)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(15760500003)(4326008)(25786009)(86612001)(5660300001)(575784001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(59450400001)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zlFbk/RLQFLQ7kYSVKKxIPAA0yW6rdoCXT88GzYzroMKs6600kSlWr3BtLZYpHZwGy4Gq4ixPDO+oVZOM2piCLevyCmCyI/y7zLNlsKOxiS0rq6jyPgSUxzFtIehv9Efmk0fjQDGhhz6mWSSOwPGlxmWh8hrVqFU3Niy9jF+i/ZswxlNXpM+WlPIpqc6jXz/7oAIacDm0V86lrTxVPu9DPyhwnbgQri3kyluW3lisA7+ZJ6twe4KQxDyTsuVdR2suQ3kXIgAQGSknuGk7VkB+SH+LodufHM2cijtmQw1b35Suh37bWSUXjMflut9d/9VRLB843bf9GqyTlUFsjVDRQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5a34e9-4bee-4579-72be-08d58db25d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:44.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrea della Porta <sfaragnaus@gmail.com>

[ Upstream commit dea20579a69ab68cdca6adf79bb7c0c162eb9b72 ]

staging: wlan-ng: prism2mgmt.c: This patches fixes a double endian conversi=
on.
cpu_to_le16() was called twice first in prism2mgmt_scan and again inside
hfa384x_drvr_setconfig16() for the same variable, hence it was swapped
twice. Incidentally, it also fixed the following sparse warning:

drivers/staging/wlan-ng/prism2mgmt.c:173:30: warning: incorrect type in ass=
ignment (different base types)
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    expected unsigned short [un=
signed] [usertype] word
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    got restricted __le16 [user=
type] <noident>

Unfortunately, only compile tested.

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng=
/prism2mgmt.c
index 170de1c9eac4..f815f9d5045f 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -169,7 +169,7 @@ int prism2mgmt_scan(struct wlandevice *wlandev, void *m=
sgp)
 				     hw->ident_sta_fw.variant) >
 	    HFA384x_FIRMWARE_VERSION(1, 5, 0)) {
 		if (msg->scantype.data !=3D P80211ENUM_scantype_active)
-			word =3D cpu_to_le16(msg->maxchanneltime.data);
+			word =3D msg->maxchanneltime.data;
 		else
 			word =3D 0;
=20
--=20
2.14.1
