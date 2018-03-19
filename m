Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494713-2-10962458710899389757
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
    t=1521494712; b=kztKkrfxK+QuFOsWUSKV8kEqDvfLvgeeoWiwA/znjgF4bpm
    oC6Uzb0gp/DXRUj9Ko1ihuw+pBzdBBr4cc8zXB+LkuhTdCDwnj+Wc8B8di9dcmO4
    3UypxxHzEpZl7+79escaquYBPuK8mhPPL9tpYsKkrmigNvQiYIylfMoyDbHTvTpO
    kgpDGKcQLbjoUPi839s5Tez376X1HRjDkdDVF3xeBrdzZom962Oz512AoZInAfi6
    IuJYam6ChrAlxDrsbl1BgMfIr7+wNZ15WuxWGh/C+A3h7ThT8Sf2BTahFZWjIahF
    RnWnTcD8s3+lZGlBSt+Ekeie3O/GXiXFndtCLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494712; bh=/QfUbk
    r0TEWGtWU5QWKXJZfXXTBh5nwITSUfQ0vR5Bo=; b=iR71DhOC/WE/HDvWqb2xhA
    MnX4N3E7kc+xGxoYy2qTLtvGkayuCookiDRXLrq2sTiE/eRYEjS4UunnZtZW8/WA
    0EWS+k2TbLyIGtuyEJLpvP49U3mOYrktkwUZ2omNCHKpWjgbMXQ0cNJpqlqn0T6h
    itOEGshnTzPt/TYmkCO4RdB6oI6j8uwbmVPtA5a7NFCA+YLrbYAHzrn6JNH77MUF
    i8Zs98qBjr+sPIqn6kT8DQVmTT03kYUGU1SleHjXZ5NqYNcnqzYmfjwbdnb+ovrM
    OethOfqqm9TbsqqFZd1lfKcp6rKY3SCFYij+VSdQFabmc32bzrjZx5oaAj19j8xg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DKV1TD4l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtgeenucevlhhushhtvghrufhiiigvpedutdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DKV1TD4l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtgeenucevlhhushhtvghrufhiiigvpedutdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934889AbeCSVXk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:23:40 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:54448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934850AbeCSQA0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 080/281] ath5k: fix memory leak on buf on
 failed eeprom read
Thread-Topic: [PATCH AUTOSEL for 4.9 080/281] ath5k: fix memory leak on buf on
 failed eeprom read
Thread-Index: AQHTv5s/oLV1dTSHCk+lAcxPdHQIlw==
Date: Mon, 19 Mar 2018 15:59:23 +0000
Message-ID: <20180319155742.13731-80-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:LaPTLgfm99W1yPOdZNDU85CXeGTOztvf4ra9sbEibC6z+2KX3LoorkUYa5CSoehq7ZDb1p4F3ZG5FxVboOBX/raaktLkQfpiq7/Ci4bNRXXv5dEUgz+WOg4vdqmd4isHUMxNOCRWNfBsXEWpZ/TVjvtkkbfWeArB1G8CaXXvhKNSogGVYSNAzdeL5cTk6dzuJurWzBpC5ndgEK9QlCmMGdrM8d6I3zIths2rSrn4SBm7OFr4dO3GW+naeQY+rdkf;20:An/kryAKZQSyrqFlUrCA+Lr7/PL2LkT4t7MRhf0VdN+gHUzRu5Vy7uX++UXWiykcg0xnka0gBo1c4vDUApIr8TuYMPwMR8ZrNPzPZY9EGxbwBJDkWp+Cyn/LD71l3oImjy3aeD/LeiozqBRnm/hnBnbECqJ1QHuJrPrlfIUP3Gc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7507893-46e1-41ba-8ed0-08d58db27a8f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB086982BCADEE604F89E72CA4FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: j+qFGVspm4y9yEE+jhXl3x1X7by0ACCmej2wWe4Jmg4/8nFWfarcbENLqrRsErvvY+ndXE36BQdHT/Bc1IaZ18OWB7ERkKX+h6yK7yTUOLaUykXLmbka4PY/strqAPyRZH3bfN2JcJkVIDmG60odYyd3eZCqKlfcBQ2OUXMz0LNGZipnTKOFVm2u0sMU0QfZmCWNPUnZsQcqbjTncamxeJBwkYMc7RmNCR7IVFjlepmv+2kEM9QxIWR6O3WsPqJY3SdzeUZvRtBeTAGoodpNnxUlClY6ACalPaCuz+7uOEc8lOQxhoZAZyZFXt3TAnTic5MSf9TTGAU1eAPVSzD17A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7507893-46e1-41ba-8ed0-08d58db27a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:23.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
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
index 4f8d9ed04f5e..4a1054408f1a 100644
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
