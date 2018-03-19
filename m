Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482393-2-9613083532330997165
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrofr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482393; b=OCGP4nAnrJCLZA4BnmZEWJWS1uKm9m6Fb+dd47ZE2NKm1sT
    bawiCp+UocMwM3IR2hxG1VXMt7uO2JGsPV+t9J3M071ZNxF9oQaR3HdbqE2x8E0O
    QJFH3RySXnXUGeyXL+SqTeu8aPfRNyccy0ac24NwDUuvlyEJZWtEou4Ckdwq2XbE
    1m2SPu4XUxczOj1SDw8e3g0AclgNtsLTlKsBnM1sFZAxVsVyL3wWKbqk67q6igp+
    i6i4DL3Aov2AdFpcGATmis8cVoBJqFaXm0Q0YvExlHj+gRbTqB/f7eevUPZby/V2
    FLfQZKzeEQD9B3lZ1/zqQd7MVUGON1qn9HKH6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482393; bh=J3TW0e
    XX1lmGz6rgEqljfV8FkrG9cecZwz2tnDSIJ+U=; b=Z4ckZth7lHRhliHvKEqNgf
    H/oB4BbxHsEZHGmtNfzBxUqsP1Blx8BYfWnv9xg2uiFsO7JWdq5HFr4t0+VZq+Rc
    8pZzyQ4V6YDItvAZid/kqjt8PZfJfK4xtbvpV3TmfoymzcgvVkFUre4Be4WfcAmn
    tKWwNEyYxh4cpPtY9HrZdb4TbpFNmUrpc36JftmDWFlUeaviys/rqsdAkLBb3ZYo
    CRV28Ke3X89sKI44odmZx1dpAWvLyuKUFIRSZRDwq8tLZ9JKGBM/ocosXZ5lk1tO
    1ET2/IPIzNJFbRNHh8yElNXe3F6omYTik0fQ6pn5syiRohnJR2RQt+yhJ/Cc0h+g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BW/wICTl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeduieenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BW/wICTl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeduieenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965647AbeCSR7Y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:59:24 -0400
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:26624
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965641AbeCSQEU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 207/281] iwlwifi: fix min API version for
 7265D, 3168, 8000 and 8265
Thread-Topic: [PATCH AUTOSEL for 4.9 207/281] iwlwifi: fix min API version for
 7265D, 3168, 8000 and 8265
Thread-Index: AQHTv5ucVyEWKPCpDUatd7EVA+HXzg==
Date: Mon, 19 Mar 2018 16:01:58 +0000
Message-ID: <20180319155742.13731-207-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:McTzOkZixCIY7d3Li0qleKT6uv7MntOzSKVg2ZtnBpE8Bu4++4gy0d/V4YGMoZ6YtiPuYALYfWZgwTkIFI8kdwgfL0UsYFppSuITpFQHdGBZgeBI67yAQ5xkPUzdjfT2uKygFvQ3MXukXJyx8HcSFGOt1Md9O40WKF64igfS5+yGaWIXWfMnZU+NAgENljg9293neM8dV4flUXNeAOCziDQ9IN68Zh4FErMZrO0qm6FNy/3FK/6dVDnM6fO0VO0u;20:guAM+78IJYk/iBfp0h9NamKsa3n9Fw7OkqtML+5zhi1cZRPUDpYj05H1ROpORJxWV+KDqbtbXZVtK989N9bMX6YNbjRHFfsr/oclWJM+ofU63Sh7GZRMBJZcHTNyoiPYg5GU7tQzuWhh7WwDz7+T/nHKwU0I/mNFFmN3cLLvNyo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f30f878f-c768-4387-2e86-08d58db307fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727BB0F9DFB7F0164F3AA5AFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 27VmCHeeFvtOJCDnaQj+i7AyzxNwfmNo9hlmvqIzMvWjICWFhmJ3tZ4pyvxdFyA+cezz9MfZNUxMyuZkya65RS7MO1/ZESxBj3Xe5D+ztJ0uLal1PmoW0waOqHAWW3KvrsPsOlXUa2FSUsV1xERcj3VKlMAwVwA+ko4PNdmmrRw7OyQiySRcrcScy5TxUNnkNHiuKa9iTRuSQ0qb46515ov1LrQe1k/c79pZoXXLxBJCDIPntkmi0JPf/Wi0YFNrcrpd0fZkEWjq5iuTKdIGcqgENmry/eH9/0SSjY0BMMytjoX4v32oIooNppOmplEsaUzhJML5e76v96FjxxMgLQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f878f-c768-4387-2e86-08d58db307fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:58.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit 15098803d38778070b8edfa5a3d5fc4fef10d0a1 ]

In a previous commit, we removed support for API versions earlier than
22 for these NICs.  By mistake, the *_UCODE_API_MIN definitions were
set to 17.  Fix that.

Fixes: 4b87e5af638b ("iwlwifi: remove support for fw older than -17 and -22=
")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-7000.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-8000.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-7000.c b/drivers/net/wi=
reless/intel/iwlwifi/iwl-7000.c
index d4b73dedf89b..b35adbca7a5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-7000.c
@@ -79,8 +79,8 @@
 /* Lowest firmware API version supported */
 #define IWL7260_UCODE_API_MIN	17
 #define IWL7265_UCODE_API_MIN	17
-#define IWL7265D_UCODE_API_MIN	17
-#define IWL3168_UCODE_API_MIN	20
+#define IWL7265D_UCODE_API_MIN	22
+#define IWL3168_UCODE_API_MIN	22
=20
 /* NVM versions */
 #define IWL7260_NVM_VERSION		0x0a1d
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-8000.c b/drivers/net/wi=
reless/intel/iwlwifi/iwl-8000.c
index 8d3e53fac1da..20d08ddb4388 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-8000.c
@@ -74,8 +74,8 @@
 #define IWL8265_UCODE_API_MAX	26
=20
 /* Lowest firmware API version supported */
-#define IWL8000_UCODE_API_MIN	17
-#define IWL8265_UCODE_API_MIN	20
+#define IWL8000_UCODE_API_MIN	22
+#define IWL8265_UCODE_API_MIN	22
=20
 /* NVM versions */
 #define IWL8000_NVM_VERSION		0x0a1d
--=20
2.14.1
