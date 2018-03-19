Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479966-2-8683143782830673451
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
    t=1521479965; b=TY0VAuostWgrP8ByUCaFozy52eVL2wopfONWB/Pkfu3aZZ0
    VKIBcUgxGMnJeiO4ju0IxFtS5I30FoKUl1KCjr4iL+ykRKLkSkZtJyhunPJpOM6a
    Dsb7yF0Les4ETDWVHRa5kFxFQXxCA+CvbwCEPNk4QJQcgbxWHTo8Ndgs/dnK3ZFu
    byoq1a/fsP2uPm/HEyumYBzljTONlJIXhHE1M1bIOx2h8qT4qZMWLA5YVf2/mP2l
    WspbcQZN3tXSGogMp80fs3vh6lgGuicZgbbZUbp2VMCiT8kP0/OyaDubkcqCdXcJ
    c8A6eYuMf8GO1GkL9h4UEWLFGJZ7me7S60ZmZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479965; bh=+hkY/h
    j2eA4o0H0fjcDpq3pwappfUGX1XtnaCvyqMqo=; b=nTv9RHS5hYM5U5gtr96ege
    sGkL+w9OVGVlDs91IGAR2Vx2wwXAIcHQFhu1593IunBnLZKDFYRjkK311xOBNy0U
    GG9UC0hXaUVxZzQrjmeWQfHm6NEwpjvvlGJB5sVOS2Y17g/CIA8q+m7IfwjBvPux
    NZ5y3xe8KYJX+fRSr1LSr/nmO/haV3Bc1N7kETvm3T51ln1DZldukYB1tZ1++fPf
    9ya3FNABQcKI6Kv+y0Q9IFI5s1b47f3hTfWjEe3aTKBbKubZ0IBCfs5gPuiWHOTj
    bk8FDDJfS19Jurn6V++98J/Ihyw9HVE+fWusSWYsHsvUtEsWTLXiOmoMhsKK8tkQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hy+UhCqU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefgedtnecuvehluhhsthgvrhfuihiivgepheel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hy+UhCqU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefgedtnecuvehluhhsthgvrhfuihiivgepheel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966360AbeCSRTW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:19:22 -0400
Received: from mail-cys01nam02on0124.outbound.protection.outlook.com ([104.47.37.124]:59524
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966422AbeCSQJP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 078/167] Input: elan_i2c - clear INT before
 resetting controller
Thread-Topic: [PATCH AUTOSEL for 4.4 078/167] Input: elan_i2c - clear INT
 before resetting controller
Thread-Index: AQHTv5xPfPC0aqJaHkKjxIpes1vfnA==
Date: Mon, 19 Mar 2018 16:07:00 +0000
Message-ID: <20180319160513.16384-78-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:nJ0i2honiTNhdlJaW9Twdcjx6L5WEZTHe7t6C+F0GPDr+A4I1S7ECElmvHtguxYe3l2kAa0koqWmdnfRtjBJwqbHAPuEh79i/ljuIVGhJR0O7QdwAFHMOxQBEGx/Pe/5L87mf0Iveb0A6p2fJwjrgZ/4gE+eScs7lNi+e7g1WIDDFaBnAybzYuOajD70vwFyW9wM+vFUgzDVQeNIHjwKHEDq0yplJnm9iPt7xTIq7lfWe+hHApiT6NJojOA4DrFL;20:QVvwiIfVd0dEBSyOQpCYaXhz07myRdj1IiUAHVgJl4r+0o3Kb1ND9TZF/Xh3/bay6rCFpLspECDMUMHA0ixxup/lIr0GaArf4a4EjMu7GYOXWp0eLsuHLcFR0I5vziCaAOxMzvqXzvOqGNDcv2Djqh/el2D6M89Y4QJ6JFDRaJA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae79292e-e5c9-48a2-0f7b-08d58db3bbba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965A38F19CD5339538D11D0FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(39060400002)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Cu09Vy6D1Hl8vU3AaZsjSXU24KGJIZP+ZiwNcXCpuzPEHlthOAOUSG/ruaePP4Xa7uDK/pcwGUSmpjC+L1YRGCEWSkBEAQjbLzVR1PUyG27po0AECeXldHNaln3sOs8S0kun5S01h+oWCKNAzwOLT4xsmG/00mVZZ3fH51FHHcrCm5OMRDcV0gCad8jW+3dnSX+0gOjymTyEOgjgM8kgyNgpBFOvj45yyvZ5REWkPCv3z5xu67uWQjdoUc0MyNGRdtudoV9CJxsjmXQCEH/H4qLkx1SBI77AHvqhA3TJlbusN50e/z+H2unltEvy02GxghrcImruijGyyvBecXRhvA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae79292e-e5c9-48a2-0f7b-08d58db3bbba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:00.1207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: KT Liao <kt.liao@emc.com.tw>

[ Upstream commit 4b3c7dbbfff0673e8a89575414b864d8b001d3bb ]

Some old touchpad FWs need to have interrupt cleared before issuing reset
command after updating firmware. We clear interrupt by attempting to read
full report from the controller, and discarding any data read.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/mouse/elan_i2c_i2c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_=
i2c_i2c.c
index a679e56c44cd..765879dcaf85 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -557,7 +557,14 @@ static int elan_i2c_finish_fw_update(struct i2c_client=
 *client,
 	long ret;
 	int error;
 	int len;
-	u8 buffer[ETP_I2C_INF_LENGTH];
+	u8 buffer[ETP_I2C_REPORT_LEN];
+
+	len =3D i2c_master_recv(client, buffer, ETP_I2C_REPORT_LEN);
+	if (len !=3D ETP_I2C_REPORT_LEN) {
+		error =3D len < 0 ? len : -EIO;
+		dev_warn(dev, "failed to read I2C data after FW WDT reset: %d (%d)\n",
+			error, len);
+	}
=20
 	reinit_completion(completion);
 	enable_irq(client->irq);
--=20
2.14.1
