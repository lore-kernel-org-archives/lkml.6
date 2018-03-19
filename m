Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475809-2-11028708997701713201
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
    t=1521475808; b=o3tRuB+Qqqs/Fl/+dMD+J88ptcA9+M00Aix7834ENdBKshi
    QTJr4N92SKmimUaw9Wfyfk6XATnwlhD8qpGRjIfNlZjZK+Rh8KByIUufif6FjzoB
    q/MgbRUAuevR+DpAKSwONQ3DugMsvP6y+g8PhY5OaR4T6LkECyBOnKGddVHnnlEL
    GC7UjYO0HrN2KCDui2G1k8VcjigJFf33TaN3IK0hOGl36OrXxoDChX1LCGfrmCus
    yeFiRIrUiSms4h0EdMLdZmW7TbX6yM7Gzg7vAup5HouOxppfJl73RQilwVSJ8rOO
    tU1LF5F1MlEuDzGtd2JMy+R3MqWqQXiXZDq8m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475808; bh=QEi28D
    BxJokVh9NWeJKywBL59ZHsqKeDHFBQnW4igqo=; b=RSiZvxHduDMAA6jLRqJoNn
    jAxFfRS5VFf1d8uNpS0JA5gQuTmVo4NDOQF3pq4lGDMsdTFzLZienhCNRSPAkvvO
    zmfenU7lU6Nnfnr6bfEJLU2M3DcSnhKwBu117YVbz3gc0SljR2kVWKBMXl94Tu56
    lPYBEAbHC17hS4aIunNOuKzRv72k9z5+z30rFBsnUfVpZrB8TEXYwIWYW2t3Uxbg
    WFCLnjg8yoWCAlZRA7iERycM7vLTeOeeWxwFi/vhs/FGMFp6tCaV6f9PCH2Z9tX+
    wwKRR3ZRh2y5hrXi23Io2bt/5BC69HWnB+oLC52b3pstiDmZ0ERwuvZWO8imr+KA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b1z+ilC2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegvdejnecuvehluhhsthgvrhfuihiivgepudeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b1z+ilC2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegvdejnecuvehluhhsthgvrhfuihiivgepudeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966407AbeCSQKF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:05 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:51328
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966522AbeCSQJv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        "Reported-by : Jason Kridner" <jkridner@beagleboard.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 094/167] gpio: label descriptors using the
 device name
Thread-Topic: [PATCH AUTOSEL for 4.4 094/167] gpio: label descriptors using
 the device name
Thread-Index: AQHTv5xbhHKqIh7KaUW5x5q/EcBesA==
Date: Mon, 19 Mar 2018 16:07:19 +0000
Message-ID: <20180319160513.16384-94-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:p6Mf6DLc2PMpMFAQWR/Z+JUIsUbNxzFT+PJbJB6+RGefpfXUaMwH5dxL32EdfCp0/MhjtVntuPpVSgmKT6qGsP2S/UqvNdUDNbOEBHKVtF5kOEqDJDkXEDPnLxHKgDlnpvT3Oo5KRCbdSW4QtJ69RQInbF3SgS9SK/xcuMV8U2MAsIKWib1yZyj2PTSGD7lj+AguzCWqxW/RJBjUCIuJe0ulDYqn26XGVSJuLFooN12HXCefT/ZppRd5Of4j58KB;20:CKD2NWvkPwd/nuJk3d2WXG5ahhdZL9qMnTF9j7t2JCOa47nd/HorAzVzYzzfDZG4F4L/yj+y+9XIhXskha6rZFhKLGG9MCP10yiygPqyQsV+jywACD3e1a8Lx/z0ulRdzLDPqjv8TtaMpOmFG+JNx0sweRWbcZYXIrscNMCOunE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7dc95409-fac2-4fc5-bf42-08d58db3d46c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09028860B87015031777A7A8FBD40@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(4326008)(305945005)(7736002)(66066001)(105586002)(316002)(8676002)(25786009)(8936002)(6666003)(2950100002)(5660300001)(97736004)(81166006)(81156014)(3280700002)(22452003)(99286004)(186003)(2906002)(76176011)(5250100002)(59450400001)(54906003)(10090500001)(110136005)(6116002)(2900100001)(3846002)(2501003)(1076002)(86612001)(107886003)(106356001)(6436002)(6512007)(86362001)(53936002)(6506007)(6486002)(26005)(14454004)(10290500003)(102836004)(68736007)(3660700001)(478600001)(72206003)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BbJCFcLa8aGkpaZTYz6DHe7xTT1Nn4Z1B2AmMAmWmcW3Qx0D1xDE+Ee1Pg9hChXFVdGtFoa4TG+CdF1/SXI3WA53Ouk3Xf4I3Q5pUJOZd2Ilez8cO7JG2uXbm3JCbF2vhkfT30R2PWSTX0+RljnESC/AUn0h6E+LSUDm5kDakgdUeQy3bEEbUhhnclR1Wa+5EM6Q0SAjHCLbyweN0G1F1h2NJGviKWItXFOWReeHY9bqvRYuy0L+ZCeYNT6o9Lr3KHnEPPWGWXdipM/PNA7U1748yxpWS5IQMLIQcA9Pd570JasLhoa8D9/ltRTYb0s1OcNvedL31Owdks4AnJdSdA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc95409-fac2-4fc5-bf42-08d58db3d46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:19.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 24e78079bf2250874e33da2e7cfbb6db72d3caf4 ]

Some GPIO lines appear named "?" in the lsgpio dump due to their
requesting drivers not passing a reasonable label.

Most typically this happens if a device tree node just defines
gpios =3D <...> and not foo-gpios =3D <...>, the former gets named
"foo" and the latter gets named "?".

However the struct device passed in is always valid so let's
just label the GPIO with dev_name() on the device if no proper
label was passed.

Cc: Reported-by: Jason Kridner <jkridner@beagleboard.org>
Reported-by: Jason Kridner <jkridner@beagleboard.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 06d345b087f8..759a39906a52 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2145,7 +2145,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct=
 device *dev,
 		return desc;
 	}
=20
-	status =3D gpiod_request(desc, con_id);
+	/* If a connection label was passed use that, else use the device name as=
 label */
+	status =3D gpiod_request(desc, con_id ? con_id : dev_name(dev));
 	if (status < 0)
 		return ERR_PTR(status);
=20
--=20
2.14.1
