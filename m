Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495656-2-6388316939923825855
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
    t=1521495655; b=c0j7eYv2bKHklcZAPvO0VtttQheFSbMmR96+p2zpNn2kBEw
    drR4c1G5TuEQ/zGv5F8qMGopZ9u5FrL9aOrlyYv/ZxN7kmYtg+3Y3kFDg0btQmDv
    a12+1COSzc/ktaULDHWTb2L1c1/3Fw5fHUHKaW50aBl98R5FmgPR0v+2leQ9tQqB
    tzU+lesbURsTOWQzx8TfXXy9jeqM8bV7ZielCnCG03VM6WCyCpPMX3S6n5oYoshi
    f15k/PCV4/81+P7hvpEOC72E1LHBfqLlVJdzXi5uIHY8p9BZJeQJyY++t+wHxWQR
    0hEFF4L3smUmLwWLqhdDID1DasTHGvGLaXNiX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495655; bh=hwKqrI
    R+0HMhUdGAGYjVDnjuWWSpaB2rb4OO5FQtTXg=; b=YvyPY/fymDkPSUJbOkMltb
    0a0/m+EK5IDZC3GvLenCM4251sjDGiAvW4jMFTWr7XTuJeCjyPanooYhkIGRbtSR
    +9pvOxFz1koJ7Kn5EAFSy5vhMr3Kq0CdBs9uv5NkBtlNu3ggrjhuttU1HvZaa9bR
    DQKqAmqOGU+1xOUorl3rDvWibIbRbqmF16pLQOqDHCf25+YTl8UHY7VzN8IXZWzx
    SfWaMeyJPCEFd6uwmYiDdn8diAKmT5hWY+6UcJhtyrjRJOmKfptxSwJLVuqeIlvA
    +SiXRhlfrXgZYDYwk98zX81zLL+otiSIszcUzSz4gWDRZxGFAMH42wue9AP/OCuw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jiwrbbo+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeeftdenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jiwrbbo+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeeftdenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965027AbeCSP7E (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:04 -0400
Received: from mail-dm3nam03on0100.outbound.protection.outlook.com ([104.47.41.100]:46912
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965020AbeCSP7C (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jon Mason <jon.mason@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 032/281] mdio: mux: Correct mdio_mux_init
 error path issues
Thread-Topic: [PATCH AUTOSEL for 4.9 032/281] mdio: mux: Correct mdio_mux_init
 error path issues
Thread-Index: AQHTv5seOkES94O4HUqTE7QXV1Rcmw==
Date: Mon, 19 Mar 2018 15:58:28 +0000
Message-ID: <20180319155742.13731-32-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:2PbemiXdap1L10iSOIwyZjogm3hfDyaD+W5ZtcmDG3rferwDroIf4CyI8FRGhZAWp5qz0ZGn7dsN5FXGrKxapHZAwdoleoS8N8xgJ8DWLNSeGlGGq3bOmi40Puc5wnw9E7PacpaFU1BvjZHmgiuI37hE+R8xvV5vcTs1A6E8UFeHYMFd9lLo3K1awD2GcHCmGtb2/0/bgAD2BYxNoYo24wYtE6x/s2lWPnD9M/pYTFjr0ssrzDq0nl4A133z4NTg;20:adMqOusD8H3dqKInwCu24Uhr0XFesAOIOkWImxEjQm749LiF6k2WZSq4PWXpsVWU7Rt4v2Syz9jtTCjarBIywlH3biOl5Ih/hUUgHZIoH0UIZDaHm85LI0wZmoBVghfAKxbzX6C1bEjvfSlVhnXd5T0fx3HTsevMCIQuufjC8bM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93b5366a-8833-4725-ca06-08d58db2536b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10157C101CB3AE0C6F76BDF8FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: wpDRq1jAlF+27YvbpagQQ9b4dXkP1a/5soXgSPIAds1NjVViwO9fHNeoZrx2kD6pJI5nXiUNVgwRRVnpIGnjJlBbYJENhQ0gO0qWFLuY2MZBid3UgaU/2/L/7xssK++J3IEXNYgsUL9nKes1InnqiMQqErVKJ3l/IJSK5lLhEbQIUH3bz3cRHnQFALW2GwJeH9lFRjwdYP+hvYa7+opppdjiImordPiER+qL6+urIjxgT3SEm4Yzi2SOFBEogi8hZyfBk/8dJqG9lU3Ny2kYFsCUWtMKQeX/W2NRAVg30Ub3xt12uo6e1NGV9neQezkVoKd+xQ07wDrB9oHIqJgnjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b5366a-8833-4725-ca06-08d58db2536b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:28.4272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jon Mason <jon.mason@broadcom.com>

[ Upstream commit b60161668199ac62011c024adc9e66713b9554e7 ]

There is a potential unnecessary refcount decrement on error path of
put_device(&pb->mii_bus->dev), as it is possible to avoid the
of_mdio_find_bus() call if mux_bus is specified by the calling function.

The same put_device() is not called in the error path if the
devm_kzalloc of pb fails.  This caused the variable used in the
put_device() to be changed, as the pb pointer was obviously not set up.

There is an unnecessary of_node_get() on child_bus_node if the
of_mdiobus_register() is successful, as the
for_each_available_child_of_node() automatically increments this.
Thus the refcount on this node will always be +1 more than it should be.

There is no of_node_put() on child_bus_node if the of_mdiobus_register()
call fails.

Finally, it is lacking devm_kfree() of pb in the error path.  While this
might not be technically necessary, it was present in other parts of the
function.  So, I am adding it where necessary to make it uniform.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: f20e6657a875 ("mdio: mux: Enhanced MDIO mux framework for integrated=
 multiplexers")
Fixes: 0ca2997d1452 ("netdev/of/phy: Add MDIO bus multiplexer support.")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/mdio-mux.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux.c b/drivers/net/phy/mdio-mux.c
index 963838d4fac1..6943c5ece44a 100644
--- a/drivers/net/phy/mdio-mux.c
+++ b/drivers/net/phy/mdio-mux.c
@@ -122,10 +122,9 @@ int mdio_mux_init(struct device *dev,
 	pb =3D devm_kzalloc(dev, sizeof(*pb), GFP_KERNEL);
 	if (pb =3D=3D NULL) {
 		ret_val =3D -ENOMEM;
-		goto err_parent_bus;
+		goto err_pb_kz;
 	}
=20
-
 	pb->switch_data =3D data;
 	pb->switch_fn =3D switch_fn;
 	pb->current_child =3D -1;
@@ -154,6 +153,7 @@ int mdio_mux_init(struct device *dev,
 		cb->mii_bus =3D mdiobus_alloc();
 		if (!cb->mii_bus) {
 			ret_val =3D -ENOMEM;
+			devm_kfree(dev, cb);
 			of_node_put(child_bus_node);
 			break;
 		}
@@ -169,8 +169,8 @@ int mdio_mux_init(struct device *dev,
 		if (r) {
 			mdiobus_free(cb->mii_bus);
 			devm_kfree(dev, cb);
+			of_node_put(child_bus_node);
 		} else {
-			of_node_get(child_bus_node);
 			cb->next =3D pb->children;
 			pb->children =3D cb;
 		}
@@ -181,9 +181,11 @@ int mdio_mux_init(struct device *dev,
 		return 0;
 	}
=20
+	devm_kfree(dev, pb);
+err_pb_kz:
 	/* balance the reference of_mdio_find_bus() took */
-	put_device(&pb->mii_bus->dev);
-
+	if (!mux_bus)
+		put_device(&parent_bus->dev);
 err_parent_bus:
 	of_node_put(parent_bus_node);
 	return ret_val;
--=20
2.14.1
