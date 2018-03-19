Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479576-2-15900638560148928758
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
    t=1521479575; b=gM+7uaWD/nAXO28tdgqhT4j3vElGBS6f+z4RSbaaojNJkpF
    gDEwZ/hrKIBgTbPMtpp0sCq5MrwhVVlfcz3yVZn84qNEqezHhT7ohep6dX5EYn1B
    QwdcbHGkhaozp604864IdjDgJaFc5ERqDgrndSZtemdlBfsE96LBnOGREfrJ7H3T
    0GzPEZ67zbzuMagXykaHryh7Mc/3NiwAbkF7VqXcCvNlmEc3w3cdnHJnOTEkLbym
    mnN6Dprl6Wdsth7umhG70NHDVZgJyKLbpqR0yrke79Bz3eHVJnh/eQphuCt3Aa1J
    RAYmAYq/tre+Qh20XKUYbkwS06hoOLDywJOFfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479575; bh=RzrNut
    m8zHsMkzpzPwIzTeGnb648kAIkCgRK/r30qDA=; b=DRp2dcHUhZHz1QHXRkTtUU
    e3rBqHbo90lYA705mFjP0fHFb87h/9ExIcLQzZDn/7pVLn1PFR2Mdwj8jwpNzQOv
    4J3XMdOhc+CqPtZFmnjvIb6S9yQq0wfKf1AnDjBU5TPrp/f40ZDjHZ+HsHeauvy1
    1xz3s4jbCX6yWt95fnpGGZB+iRmUxNcDxGKLiqxjq2LVAgCic1rOlfOogmxNeI7i
    a1mZxEiz0QqqxRaTCyvQW+idxLkE0doiI9AZKxtme5mK3LowqWFQxKM1XTmYz/oy
    I/yiUsxTn6MtHBoBV7NbYDXqDV4kgg3OI9Ze/Aie4m/4hBhH24BamFDLHYgE7Rcg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R3NODWdd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegtdehnecuvehluhhsthgvrhfuihiivgepvdeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R3NODWdd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegtdehnecuvehluhhsthgvrhfuihiivgepvdeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966598AbeCSQKY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:24 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:35072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966561AbeCSQKG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arjun Vynipadath <arjun@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 104/167] cxgb4: FW upgrade fixes
Thread-Topic: [PATCH AUTOSEL for 4.4 104/167] cxgb4: FW upgrade fixes
Thread-Index: AQHTv5xjzNyk7MVGO0WjOzcMP/9wig==
Date: Mon, 19 Mar 2018 16:07:32 +0000
Message-ID: <20180319160513.16384-104-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:w3VWHmIWy6aim0I3hnsej5+cPmZRxVuhN5FC0T46qLOqZYDu2b/e42gLS4tn4QWRuJ0XDl8A+rYZEZT4LPZEcas9rHtQBQG/uLIeQ4sqem7LjDdJDgkCG0Yw4eXxDl6NoV3f/3pQ8gD0zxztdPu+fle86i+HNXYODJnVwNUdgRL1Uke/2AxhN+bp27bnUsOw5WZXxXhEXjnnW2xMb1k20RmjD7zmAEnLgAUYlq82o4+Bb7oEng30TGz6R4bfapMT;20:5ZR1IwNF41bUy2CkQv0lH2sdFcNkWlHyO+cfZ/y2TJ4mTL5v91OFb6EfIQ2F7iMk666EI5qJm3F4mSnk9Y86kFnPEXzHjsLuEtp06JzipjIkdsVXs/MbaZT7vTAqlOpD/HP80QMFaKJJJ3mwF+F3jAlbBjkIYXZSun/iO66dfF0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18f145a9-4597-4cf2-5aef-08d58db3dabb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109515607B39C9C009879D52FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DNCoAOIxTPsUd9hjIMV6Q6vjvl99GB40P7UboYrN+d+Z3WxeK5ml1rDntEoUCR4IZ4Bv3uFc+JWQZCFyojtgbKO20KltL9VyuZqKdzf99KMUQJjDPPlmRZRqgf8VeM7/sf4wXNIcnI6/4xkOXPzLdlvYIk+OXrjFVt/8K0Chb3TuvuTZTi5eepcjv2wT7cNG9Fo+VWTd1LU2MVbn7cy5ey5wmh2onuRmErybX25xg7e/McFcGqFetz4HTC50S70rua0Ol4PpujPs+s7yX3lAbrE05V53bdY2wjg11akU5k2QBSPhtOToEQS+SsVH80R0vvLmKV2NOQFhs0P2E3tBIQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f145a9-4597-4cf2-5aef-08d58db3dabb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:32.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arjun Vynipadath <arjun@chelsio.com>

[ Upstream commit 26747211486c5bc7dd014c3caab206576e00c0d0 ]

Disable FW_OK flag while flashing Firmware. This will help to fix any
potential mailbox timeouts during Firmware flash.

Grab new devlog parameters after Firmware restart. When we FLASH new
Firmware onto an adapter, the new Firmware may have the Firmware Device Log
located at a different memory address or have a different size for it.

Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ether=
net/chelsio/cxgb4/t4_hw.c
index cf61a5869c6e..a1b9d6c74309 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -6076,13 +6076,18 @@ int t4_fw_upgrade(struct adapter *adap, unsigned in=
t mbox,
 	if (!t4_fw_matches_chip(adap, fw_hdr))
 		return -EINVAL;
=20
+	/* Disable FW_OK flag so that mbox commands with FW_OK flag set
+	 * wont be sent when we are flashing FW.
+	 */
+	adap->flags &=3D ~FW_OK;
+
 	ret =3D t4_fw_halt(adap, mbox, force);
 	if (ret < 0 && !force)
-		return ret;
+		goto out;
=20
 	ret =3D t4_load_fw(adap, fw_data, size);
 	if (ret < 0)
-		return ret;
+		goto out;
=20
 	/*
 	 * Older versions of the firmware don't understand the new
@@ -6093,7 +6098,17 @@ int t4_fw_upgrade(struct adapter *adap, unsigned int=
 mbox,
 	 * its header flags to see if it advertises the capability.
 	 */
 	reset =3D ((be32_to_cpu(fw_hdr->flags) & FW_HDR_FLAGS_RESET_HALT) =3D=3D =
0);
-	return t4_fw_restart(adap, mbox, reset);
+	ret =3D t4_fw_restart(adap, mbox, reset);
+
+	/* Grab potentially new Firmware Device Log parameters so we can see
+	 * how healthy the new Firmware is.  It's okay to contact the new
+	 * Firmware for these parameters even though, as far as it's
+	 * concerned, we've never said "HELLO" to it ...
+	 */
+	(void)t4_init_devlog_params(adap);
+out:
+	adap->flags |=3D FW_OK;
+	return ret;
 }
=20
 /**
--=20
2.14.1
