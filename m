Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480320-2-5765949468519776729
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
    t=1521480319; b=IFPpvNKFx4k5TLDMFcdJfgy0NGCv5U0Z+LlpC1+TApVFJND
    e+AHol+6q7n9COA5tBG9bybtTOULkLhWkF6K6Lk2rRgn13LJDm3mqMEIQhhRLJf/
    PH6P3g/5Fj2Hbe/kR6Lk3Fmr0qEh9jFmywEzil6xdz+TSFr/wUr5TiOgN2ne63rd
    m42+G9ZfO9F0D2nDIdKunrmZzydOjJgwXW9NPy/2IwsXW6gpYQeIYTv8yhogo2Kc
    JDnnA/x6aQyfXWkDQHu8Qpr/A7qSi8rC6WxYBqiAJPR2+tC/O5BBTHkw89Do3L7+
    h7l2BKI8KyGZ1qjJLx+wDFJVf2Tzx0iTxVmQdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480319; bh=7M4BAq
    xNiz0bGwGHolcupcnNJXbhgkATi2Lek6riAiA=; b=wrgiR96j4dTYd7gCMgCG+/
    3te1qJT7pGC47i02zGo1NhHEWSo7VN2PgV3hZlcyP5FWEYnswBOP9XAJJJcH25kR
    5NRKfRWzSuZQGc+OJEzmVhwTb1rFYERyf8PxSm//EWd1ELOiXrgcgmeP+pU2kbYQ
    FGX8ZkCsky5hy7jE+CoPBKHtSwS+mmiOiJhFqgZvHx1ECAsP1RZYc9LGY4OARnlY
    adhY1jntDfrh6uPWUBM1VAeEd/EZDO6xu3gna03iucjrJIBrl+67TIfCc7VfVJbc
    Ms7ockhCyuwAPNLtirtdM1bKyCd3AtzzRUFSnSDn+r/o4WmxkVn1pFb2CWWY9I8A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e9p5MQA0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdelgeenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e9p5MQA0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdelgeenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966306AbeCSRYs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:24:48 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:41411
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966296AbeCSQI2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 053/167] ath5k: fix memory leak on buf on
 failed eeprom read
Thread-Topic: [PATCH AUTOSEL for 4.4 053/167] ath5k: fix memory leak on buf on
 failed eeprom read
Thread-Index: AQHTv5w89DE88rU+xUG5hEkknL8pbg==
Date: Mon, 19 Mar 2018 16:06:26 +0000
Message-ID: <20180319160513.16384-53-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:D66cAcEja3ztF7zDaCouXpCAktiqSRlV1H6+vxJuKfITpWEruqH/+DfSHbkdme34HkJ0b3KI0sJ4w+w4t1tBetYx94U9aQM1xcN/T83XGgI48aWSWQYlksWVmDedVjjjjSolOHoszJwFFDEZN9RuBnHhMyrrLlszSli+XlcafKEOVI8LkRBjhhR9WXzg1GHDJ1fPE45FfqzQ07OvLXvrMpYW8xzw3n+nvPfp4O54J4yA79GtR+GUGZhBJaQIRkuL;20:4RZDeGVnG+bQKcKUXhqQ+vgiTyzqiK88NF+hGfxfh37mHTnEAyLu4+4CNnrRZCSLjnJMZHB0vAwWXpC6TqqXWBGrhsX31vsXdlGimaZNnFFPM3+Badj4fka8NVGX7K9DuTbW8xRfFhLuUaTKCM+CkyiF6/09kBJpn267WCI0Z6k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f8e8c70-2fcd-4a1a-034f-08d58db3a238
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1094F06DF02DDBFDFE9BB8D5FBD40@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(199004)(189003)(106356001)(10290500003)(110136005)(22452003)(3280700002)(478600001)(54906003)(2906002)(2900100001)(2950100002)(10090500001)(186003)(26005)(97736004)(5660300001)(72206003)(66066001)(107886003)(102836004)(53936002)(59450400001)(6506007)(6512007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8676002)(8936002)(86612001)(68736007)(3660700001)(86362001)(575784001)(81166006)(81156014)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: akNWwWUtQQjSUBPWf43a68hX79OLT/+04OL6Zz5f1JsMnxnthuUZyH7zBZe2HgCWUuXfr5GhYtJeDewyfrctx3RdmMUBJlk5TudbIk3zEkfgp/dbBtmCoEsYOrjvVwhS1NfetblzPEok/8op9Y6NEYGM62QyR5vkctkoZ0mljuigW5rGevGWYZpdm8C3fb1VyUet0iK492VjjS1SXXBfoe87dygRtXREXlLp6qAsoZJGLi/iPd2WcP7kGdeHS/4AtogOzwTGWejt+gjJK80bbM33MWCrBvfArXaRd0x2fsxDWm17MBIGUy1Wf3pohpY3E06wiFJWIqLzGKihi4vvAQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8e8c70-2fcd-4a1a-034f-08d58db3a238
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:26.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 8fed6823e06e43ee9cf7c0ffecec2f9111ce6201 ]

The AR5K_EEPROM_READ macro returns with -EIO if a read error
occurs causing a memory leak on the allocated buffer buf. Fix
this by explicitly calling ath5k_hw_nvram_read and exiting on
the via the freebuf label that performs the necessary free'ing
of buf when a read error occurs.

Detected by CoverityScan, CID#1248782 ("Resource Leak")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath5k/debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/=
ath/ath5k/debug.c
index 654a1e33f827..7c5f189cace7 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -939,7 +939,10 @@ static int open_file_eeprom(struct inode *inode, struc=
t file *file)
 	}
=20
 	for (i =3D 0; i < eesize; ++i) {
-		AR5K_EEPROM_READ(i, val);
+		if (!ath5k_hw_nvram_read(ah, i, &val)) {
+			ret =3D -EIO;
+			goto freebuf;
+		}
 		buf[i] =3D val;
 	}
=20
--=20
2.14.1
