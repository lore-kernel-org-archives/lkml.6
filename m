Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494528-2-4816370795168145088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494528; b=mEJC4yvMRDzyE2Iwb3qjaACHqUWPA30dRtBrCjsn+2Yogod
    T0TCJx9pvXAuraGAPElGF+eLa1/R2XK5w2unnbeE2jMYgbCsgg0Gg+2zb2dON52N
    Fgv6bHXIjAbzmL1Cubx5Tva23pi7NAFFhawT7EOEGPRUrINHZ/cfsbpP837xQCqe
    XcXkjO2TI062OFvB5IvdiV2bUWWUNR/TBnch9THvGWO755ADHBtc/mp+8flDPOTs
    /Olu1VUxnYl6INYS7609rDo9+0lkRrWjsjVwsvu/6ZgN5icJFH61sYNgo79tkzC7
    3vwuunClc1N2+AiZ6Q5YvvK+g/ryvZJjfx/aMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494528; bh=g+WtTo
    rU3/8AyyH2op9fMJyTBkdzjBZwAAFj4i0CEAs=; b=W9Lp0/f5MaSWpa+uyHIevL
    Kfub+ZNTv+EMhhksloz3P7+XoY7ivjbERmsj6B8uPG4dLBXn+qjUJqCLVJKFssFe
    4JJLpghnep8jfn4BS/bvBOClkPOGXTAMbvJB4kZj1yTccthhqL3ijMILJJfzg5Te
    lIVPhsuTEbKqP494gZmSCT7++jWeWH4euaoXC0UkHjnFjUrU31L5bLs5zC1Cduer
    Kf4y5htuoloCexVo2nmc3FMRLLpiKIPC33i0BzhF5smTUdpnRy2LdjyzLp+5E+yO
    AF8+63uKPkq0ncbqQzSiRnDtfeLUofcxjbART+QSdSRDt6QMsc0jdrdJuIQgh6HA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K+nzXGUg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejuddvfeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K+nzXGUg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejuddvfeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934957AbeCSVV7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:21:59 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:3840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965241AbeCSQAn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tin Huynh <tnhuynh@apm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 092/281] leds: pca955x: Correct I2C
 Functionality
Thread-Topic: [PATCH AUTOSEL for 4.9 092/281] leds: pca955x: Correct I2C
 Functionality
Thread-Index: AQHTv5tKy7IVSIwgUUaSlFAJ7Id6Tw==
Date: Mon, 19 Mar 2018 15:59:40 +0000
Message-ID: <20180319155742.13731-92-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:vzuQEnErXnXxhhdv7xj5fxP1xxE8ZfWTSC+X/dDwyhJT6AQunNcoMNpn/3PLV4ibXpAL4pWaW72QCpKb6FIWnQ2pk/+N9CwEgEh94JJuwyDQW4P++jaOJ5Yktr34lCgLORuSHXciKSwiqankFtyrKZfsC/y45eE4HK59JQgHBQKFDq08CN2vYgspCe5xwl613K9Oc+OTtrO8ifI2zUF+X8hy8+fJF1fLWqlGQv5V6v1uTHTbORm2Q/G0GAqPePGZ;20:dZ/PE8VjSlaYKiFeTxiPNdds9YycLFjrWL7t9s5k6v9kthtjfZGz4bGHPrFnOLyY9VpV8phQ6xL6rZmXA29UZT+eCoQBcc1ahPauEOEAs2i7gZW11XPOly2NsOBiz/5R2UfWDV0MVlezryj8gVn6KztjN4tfbRYaGxwDFtc1b5E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e66ad8e-8421-419c-2c93-08d58db28fef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB09332DCBA55B8CE74F88D363FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(39060400002)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: MTZ0yBgABJsGiuY4ca+DNj3Ebshjn3WGKYt7hO43eMEY25MCQa6Pm4KWSPFkbnz5X0ph6yX/HWku7zn5Su4HTX8cQcoxRMMXZL1upoXQupfW9aHPd+R+pyLHJrnL+Y3QDnFFrHJ3xmD6Q1e1yHnNJyflpFJckAuCGrD+3bSinmVLfB8bsNCIqH4aMuBgZ9EoFihnP6tQ9LaOLXd/T2yNyhmnEkONYti0+kk2S4Q5Oba06UynxmucQ9adsdKTcaxPJKEGyz1nwFjPBhD5TYUHJvKDCxUgHmgz5FUIidnvhcHJ/AzqI6ucXgyPMxcWtPfq+lmEIxSaKMXIoP5gsLlUfg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e66ad8e-8421-419c-2c93-08d58db28fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:40.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tin Huynh <tnhuynh@apm.com>

[ Upstream commit aace34c0bb8ea3c8bdcec865b6a4be4db0a68e33 ]

The driver checks an incorrect flag of functionality of adapter.
When a driver requires i2c_smbus_read_byte_data and
i2c_smbus_write_byte_data, it should check I2C_FUNC_SMBUS_BYTE_DATA
instead I2C_FUNC_I2C.
This patch fixes the problem.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/leds/leds-pca955x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 840401ae9a4e..f6726484a8a1 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -266,7 +266,7 @@ static int pca955x_probe(struct i2c_client *client,
 			"slave address 0x%02x\n",
 			id->name, chip->bits, client->addr);
=20
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
=20
 	if (pdata) {
--=20
2.14.1
