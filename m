Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482556-2-16875535672553891890
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482550; b=s9VcS/zf1TtiKI33WyQwn84mKC8OGOETrkQ+ZMVk7rtkB8g
    2NOmPoE3u+Rb/+U0o/8RF0RoWi8Av+BlhBQrD6LLkr/ZXgSbTj/p1Y63nkuOA8VI
    h3ORvGFLg+oEX2wgytKQTW3lgj74zV+sqwoaIzrjCtW5EPR1sz+rTwxHjjI5DabG
    FAutnzrNchO5jWK3zvZcZgfRQ2Kb3NFpiEgElwsaOD0Mrm8+qjlSlmEYqBAEqyB2
    JkHLrzBVmhfliRH8wGeEMexIYdh4BFNLAxFTeub9gI5Q7X/LLX4rmzRKyRjBna0s
    e8bv+uaZ6dfd95jGMnt/wsb/OtCztuEQ56zepWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482550; bh=GfoyY+
    FDKY6903hZobpm+zsO6Ra2LR8BzwVPMynZdgI=; b=H6/46QH0MDatZAPUbaoGb3
    TODR84DTtAlpvAAB8v3GPVvAC2nXytOcUkivdM/88AvXbaTKN8MmAja+hton1pGb
    NC0G1ZGjfIrooek2O9FH79E7MmO35CCT4IidaBSZXd0Wv+gL03Ph8CK9wVUAxmDo
    J4jd3WmYY+1oswS+abxV8FQkTwI43uLdQHW44lT47GWRORihABHfYEJifIZWlpX6
    NvFHwS4YwDtxFoVr0SOfrsY0+ZTJl7dIulnqnaaaI00wrVytMeR5hZnJPTqyrXOR
    fPWJFUEdBqaTrFO0j6fmEN7tZ9qsqc/VNINJlxZEFJMrrtSkEbjRkOhnD8d84FCw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U3AvnRvx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekgeenucevlhhushhtvghrufhiiigvpeejje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U3AvnRvx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekgeenucevlhhushhtvghrufhiiigvpeejje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934979AbeCSSB3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:01:29 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:46928
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932923AbeCSQED (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 191/281] cxgb4: fix incorrect cim_la output
 for T6
Thread-Topic: [PATCH AUTOSEL for 4.9 191/281] cxgb4: fix incorrect cim_la
 output for T6
Thread-Index: AQHTv5uQuh0a1tbzl0ug4uXp5UG7sA==
Date: Mon, 19 Mar 2018 16:01:39 +0000
Message-ID: <20180319155742.13731-191-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:EYaDcHwA+F26EVv3AJl8omShawMSY+rQS97YgLXtbY6yw+fM3t9XejsLILAwnflWfS4yTBFvIVL/hNwgzNIv/CQiqLSy1LzG/y6CWRlqDK3ai9GQcHr7MPO+p/qKUrgsizsMdzLcGobIUenVY0q88g2CRvB2d1VprZKFNRsPvTqLTeCVNXcqKsOwCJ+DxVVNZ72VsEIPN4H01n5FDHM7ojLwZCxRVxs77/SzV4XbIadJDPKgYQsf6/S6wTgTBb4g;20:NUomtJcoNYmI+YI/52Ng1/xYVICIhK9jIbpntrso2XRec3rNcXBsk06hMw8PoPGI2EfN2ZKNwWTnilgVnq0sMgYgnW/hQ+tvb2D29SG0Icipahy6r6dvFjaQHAUaTxO3s4qUde7dJ5v8nCCZ0TdGayapXGdjnVlgjbR2svkJGag=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d180b301-37cd-48f0-5aa6-08d58db302dc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077ECB6D70FA217AA9004B4FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(43544003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SRdew8hRhxVVJhIk7LTneEVVIqiy9hfZEXT2ojxYzyJkzRQa29qGavS6cxPq8o8r88IGTvvzRH4bkFCI7rVncRqjs3QUnJ+r39fhHi+4kSxwWv4jEAl+lwWQ4X3dtBzCG5o5c6w8Cgv43ParogW99QKNLqAbOyr0cuPn0Pc+cA0Fi5I+6i1E9hZvVRz6Gd19aDrGlL0S2Wrr38nKo7ThleByeCR6SNEa0yA/QmPMHJzeAymJnSm8AZH1ulL8eHTB6gH6NjcESgmCSEN0PXMBQkmPdCTpRhMtl2MXHcCoApOWOH9e+5TCmciTa5ShCcwSKS3JJXP5i4nw8jmwYpmquA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d180b301-37cd-48f0-5aa6-08d58db302dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:39.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ganesh Goudar <ganeshgr@chelsio.com>

[ Upstream commit a97051f4553551d13e586ab3cb6ae13093a44a81 ]

take care of UpDbgLaRdPtr[0-3] restriction for T6.

Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ether=
net/chelsio/cxgb4/t4_hw.c
index 24d391899730..ebeeb3581b9c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -8088,7 +8088,16 @@ int t4_cim_read_la(struct adapter *adap, u32 *la_buf=
, unsigned int *wrptr)
 		ret =3D t4_cim_read(adap, UP_UP_DBG_LA_DATA_A, 1, &la_buf[i]);
 		if (ret)
 			break;
-		idx =3D (idx + 1) & UPDBGLARDPTR_M;
+
+		/* Bits 0-3 of UpDbgLaRdPtr can be between 0000 to 1001 to
+		 * identify the 32-bit portion of the full 312-bit data
+		 */
+		if (is_t6(adap->params.chip) && (idx & 0xf) >=3D 9)
+			idx =3D (idx & 0xff0) + 0x10;
+		else
+			idx++;
+		/* address can't exceed 0xfff */
+		idx &=3D UPDBGLARDPTR_M;
 	}
 restart:
 	if (cfg & UPDBGLAEN_F) {
--=20
2.14.1
