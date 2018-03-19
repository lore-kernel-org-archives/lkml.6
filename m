Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494756-2-15981589695368663483
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
    t=1521494755; b=kvh1Mdk+QL80Gj3gw63NpmVCA7xejdS3OFinna436Fi6bIY
    oF8zVSUBWR1ZUZDhSj/wAJ5LjyUiSWZurnDwahXdEepfObn8owSZZljznIIF3RlB
    MD1WGxcz37rSpgF2cfvT/K1DhQ+uUmtvKkvhoaol0E9J6wiXhqsPOcpKy/to0Zuq
    xRXsinFHBBp9h8WfemFOXmkcOx7tyEVKYMEQwtIG268vZNNUXh8PxBVKfzFYQWvB
    yCfwy6Wuz4JrAwY2OdRG1FwCusHRCp2nBvqg74gfXa+QtKPTZjdAphEoT8A0uIPJ
    SboTpdK5J6KBknRcpnRoZvRH4n6luH79/D9iD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494755; bh=9wlYva
    WJFnbJeBpTdd0uWyB1W7xJ+ITK/JgcYEFSJjg=; b=shs+ORlCk4yfK2P4gtVQfD
    mA8d+Ld4X2UhKxUcqQvqAvBEeDBuwU8j+r0G1/yAx7gr7nlTLA0khjpwBoOnuvsS
    5oS9ljWckl6c3pYFbSH3BpLf3vOZc8f7toFKbYlnpcDGqUk/Yd1kwOUUMoDAWtzi
    Z5eDNsTePYTAg2W3JL7v1LRWyC0JDwT4CBcOCCxqx33W7Ej4f+e/CqxqLoChWDPo
    NdIBsjkyceqxRHzAOGVzd2MssovW1JTLpt53s0AHz9eyjIjI4pnvs2n9T0Q7kzks
    5N8wAtPNxhjGNhgHUmz9kJ4UO6sT5mLxzsGk3Zil58VnAgQeaYE3aKEQ+SjdD8Xg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bpz5IZUd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejvdejnecuvehluhhsthgvrhfuihiivgepiedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bpz5IZUd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejvdejnecuvehluhhsthgvrhfuihiivgepiedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969892AbeCSVZt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:25:49 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:56553
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934828AbeCSQAV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 084/281] iio: hi8435: avoid garbage event at
 first enable
Thread-Topic: [PATCH AUTOSEL for 4.9 084/281] iio: hi8435: avoid garbage event
 at first enable
Thread-Index: AQHTv5tEk9nDAMevMUmFHDnPgQP+EQ==
Date: Mon, 19 Mar 2018 15:59:31 +0000
Message-ID: <20180319155742.13731-84-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:eTLD8viE8cASXxA+q6s3W1fSrmTR6tNb+ikkBMmg2Iq/cLHnd3zHUlS0mHVloalDrPOuHIy0O/thjSH99c8mqGRWw5aihkFN/Ac+2eyqJXI/c65eppqzK5Pn1T7NCnWftNoOL5nxDHXRHKqasxOGchxgVdVPtrUb5R8j0a9efLCOaDcx4p8GEuASoEGArLxfSvvjlMhUbYnHve3pUFk9Fx86Wkw4M8n35u2O5A7D1MxlfCwf0in42t0Y0X7XxFqy;20:Sa8Ro7Ro00bhilC95VVau9r7+JIKILYzN1VxrGgf9caa69F1O00gwPix3almCkANaEspEeCxFyXfjglA4qBjnoTbwkC9nP2wUCDJasiBQEyGmD/6TUCFtOqwGSA0ypYOl8WisZxTZGVAHlEQ6M1uSuw85EfIhGLjm4h5Yv+l9e4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 629aad17-aa5a-4261-1c05-08d58db27ba2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984CDA8D461D5A242F18BFCFBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lML6o7Xj37XFQ7o7vxXNBiiC/rZliONY/REG0+zO3UT9gqEbGCgU3L9IOqMV1vCFhp3qOdUUdVvVVUK6Mdxi3uIpXPJ04uxLB5W8jKCrUA3iGaH1mb0oMzXfemLLnrDf3nq5jweW9+kxmZDAHuknxbO6dlpyqSuWnzFOt/bYu07TghJKLRwxRfxR/u0yxa2DMuZiaycxrF+qLP5ydnd5d3ipb+YK8b/B0XYIFF9ZSEMkfQc918dzRNT/cRw6Nx/k2HIbzOj4Ab9Ef1x2CVoy9QiTGPwGBImP/RC5TO2XkcwsJ09Uro3AlzMLB3uBBSKj3+0ZoG/Y+6bfLjgRcib22Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629aad17-aa5a-4261-1c05-08d58db27ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:31.5169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

[ Upstream commit ee19ac340c5fdfd89c6348be4563453c61ab54a9 ]

Currently, driver generates events for channels if new reading differs
from previous one. This "previous value" is initialized to zero, which
results into event if value is constant-one.

Fix that by initializing "previous value" by reading at event enable
time.

This provides reliable sequence for userspace:
- enable event,
- AFTER THAT read current value,
- AFTER THAT each event will correspond to change.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/adc/hi8435.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 678e8c7ea763..52b2dcf1d942 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -121,10 +121,21 @@ static int hi8435_write_event_config(struct iio_dev *=
idev,
 				     enum iio_event_direction dir, int state)
 {
 	struct hi8435_priv *priv =3D iio_priv(idev);
+	int ret;
+	u32 tmp;
+
+	if (state) {
+		ret =3D hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
+		if (ret < 0)
+			return ret;
+		if (tmp & BIT(chan->channel))
+			priv->event_prev_val |=3D BIT(chan->channel);
+		else
+			priv->event_prev_val &=3D ~BIT(chan->channel);
=20
-	priv->event_scan_mask &=3D ~BIT(chan->channel);
-	if (state)
 		priv->event_scan_mask |=3D BIT(chan->channel);
+	} else
+		priv->event_scan_mask &=3D ~BIT(chan->channel);
=20
 	return 0;
 }
--=20
2.14.1
