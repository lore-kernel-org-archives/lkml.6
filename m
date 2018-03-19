Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493246-2-2835898264102839770
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
    t=1521493245; b=HoJKnt7EtWy/ls+rtHRTatLQUcKik/dtrJHxQLFg5SJU9pV
    LSj3Lra86gRtwhac7s9Mo3OWLl2JCv6i8CzavH1ruvbKq5XHelMogbNS1/QUGrlZ
    IK4adTzAXehWsrwn57bxaP66eahZJ9LmcM8Cb1PLEDUkAzIM5rHmJuOL2hL6cbAa
    sBSBcb3aFq0crwRl7i6i02JP6/frZhwsLWKNw7QOvSeRAdwhCPD55gn60WHyuxHc
    7gHA8QBbqVHAY3peFFvc9XmhWTaK5i+Ykq9brQbPRcUznRV9pM9sp2S7CrFDzyhN
    6aCqrgjs9DxtfsU4elAT6JY0tOEfASeuGdgjvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493245; bh=MbimbR
    erQ7qufLHXgwxNSrPOIrNgivTtHr5rW9FxEQU=; b=DG/83atoxfu/HOYye/moC1
    ZHSUasIL9W6uuxUBKWxME9W2JALreSvsvfXBBdG8D+hx1vxLoRQOx2Q509OUFvvh
    EjKosmszQYOIfbcpj2qjRCj38+tAX7oxjmysjTtgG/rLT4M/VN7fWl4CjaHinyhe
    mSEiffybXsybWYpJD7Rin/HrOc/sLbTVdvWdHJP2mdBxEJB/KE/n6RDrSAfihOaM
    QE1CcmkxwyVh2zs6Jp9Rtb75VPBA+gf0LZ4odyglk27LFQlS6MeYPBIiQRJ9m/9q
    ErwcTekqJC6ow6gzYS9NqMJEdO6NZZy2ptFBTD16PRTR01swtJPpLmeB0PYB0eJg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gEKMeWQw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeeggeenucevlhhushhtvghrufhiiigvpedvfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gEKMeWQw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeeggeenucevlhhushhtvghrufhiiigvpedvfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032294AbeCSVAc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:00:32 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:27264
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965491AbeCSQCx (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gary Bisson <gary.bisson@boundarydevices.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 164/281] rtc: m41t80: fix SQW dividers
 override when setting a date
Thread-Topic: [PATCH AUTOSEL for 4.9 164/281] rtc: m41t80: fix SQW dividers
 override when setting a date
Thread-Index: AQHTv5t9WrvWP0PmSUyKVWP/y1Q+sQ==
Date: Mon, 19 Mar 2018 16:01:07 +0000
Message-ID: <20180319155742.13731-164-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:lqv0zesKiVmvtDyw9BVwxp/KMiKnRO9feWDuGGFF7O8wKht0gZh9LPuoPxEDYLi1pAwj0MTCZmG90gsAEy8n0pYwCZvC5/ydq99Ii3bs6mAoZn1udSwAXC4fXeu4U2IupvAXJEPG77BNxkTDrl+3PJfo7OApWiuq85PHz9/GVc5DX5CoJmDp7DSxa3j2mhxwTTGSH7NyTeGEt27uLLCsbQdj35d/NOhDKxsak2wcuh4hoFJyhBeuHRzTgdT1TAHJ;20:jtvFhaEKklLHeU8yR6JxPmJfcm5DksqSvmRDn3XRapeuKd0tuApMZwW727GNgmjZWopBxRk9h9uoJ4mdnCRJKMZFVFYTpbAtId6FbxpRDCYhA5prc82OxE1drtxGGvbq1ahE71aLLO3/CE2zPPqa7Lv/6E0C90yZKdbUiH47Z7M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 628d858e-282c-42e4-ea2e-08d58db2dc48
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725DFBF7CBE6CA4426A7FC3FBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2PoUH2D/vQIo3eGPjZYySgWDN7UQWONgDNq6Mp036chwJNY+xKEZvbCjDoIEW/1gZfn/bjg2/NYdOb/BCOmAzLhBk87MsRSuAA7DGFp21fvgXJcI9gn30PXW851mUNeD2FeEIc070vUhPmQ2XvdcvqvmaITaC69nL5QVpj1E6wiwXZFjomg0qpXfYmaC8c/B5fLzVjwoZQfRnTdKO4sIifDK8BeSiItjiAwi0bAYLhEJkVTq0m5GOqu8+yAAi03Mb0JH6bmDfRvCKEL+k3/PvX0goLKB4udX5UM74c8gqeAXvVFYNCL6t8RFPSqwzSJCtX+f1dDzkSqx1f4vo0UrbA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628d858e-282c-42e4-ea2e-08d58db2dc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:07.8093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gary Bisson <gary.bisson@boundarydevices.com>

[ Upstream commit 0f546b058b86ea2f661cc7a6e931cee5a29959ef ]

This patch is only relevant for RTC with the SQ_ALT feature which
means the clock output frequency divider is stored in the weekday
register.

Current implementation discards the previous dividers value and clear
them as soon as the time is set.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-m41t80.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 58698d21c2c3..c4ca6a385790 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -168,6 +168,7 @@ static int m41t80_get_datetime(struct i2c_client *clien=
t,
 /* Sets the given date and time to the real time clock. */
 static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time =
*tm)
 {
+	struct m41t80_data *clientdata =3D i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
=20
@@ -183,6 +184,17 @@ static int m41t80_set_datetime(struct i2c_client *clie=
nt, struct rtc_time *tm)
 	buf[M41T80_REG_YEAR] =3D bin2bcd(tm->tm_year - 100);
 	buf[M41T80_REG_WDAY] =3D tm->tm_wday;
=20
+	/* If the square wave output is controlled in the weekday register */
+	if (clientdata->features & M41T80_FEATURE_SQ_ALT) {
+		int val;
+
+		val =3D i2c_smbus_read_byte_data(client, M41T80_REG_WDAY);
+		if (val < 0)
+			return val;
+
+		buf[M41T80_REG_WDAY] |=3D (val & 0xf0);
+	}
+
 	err =3D i2c_smbus_write_i2c_block_data(client, M41T80_REG_SSEC,
 					     sizeof(buf), buf);
 	if (err < 0) {
--=20
2.14.1
