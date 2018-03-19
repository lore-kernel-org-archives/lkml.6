Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482316-2-16785846132032462735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482315; b=CzlbCttkJ0HEJF5OHpwpoqFhvaHPXglRomLH/xCIM+pOd1V
    AITz84i2Bt4CjGHO6DSk9PnhDvhQHC1y3ba69mryXyOzLGr9kWFQcifesqwor/mi
    sv/ozf5y180+4TtwA6ll4qQJYLVIrwsjKw4VmxkNqtz6F2dYnpWB99O8wii6LmMk
    cuGOXwYnCZm7PQHUhOfHMWJHz1u7OWx7FIr7ujfHzP5eL5rCcoBiYgcI8GlBVFkL
    /tM8oitWOHFDFYZvoaqnTZ8yCTB9iSEQRf6//fWP4HB0x0iH/9Z7B11MrWU8AVZG
    Cc70/NK48LErtx/t4mGoLeJeDlSU//1CftKeXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482315; bh=w5Tpzv
    uWlXLV4TvvI4kMorXlyRYZHCZh/P3gwLyxvO4=; b=mfG5jzwHtaccLTHeHc2nGy
    RWcTRVLplwrIPFU3ge+iOVpVX33yfGzeWhxXEthjYYsMtv+uyQ/Ke7NLmlUO7m8s
    HaF0LD/kB+zB3/Lj3HkGEaY/4wKyrphrmCNLTnPNkGVy353sPesH6XJlZZY6JBS1
    HYOguWZcJq+wvdUo0BTCqLHpVHpyc9RmPaXSecJPsjzjn48NLWiXbqh2npO5jpDe
    twlJegbOd60Lp4i6G/+HgJLl+Gz3ENGiPfomt8k0Gj//XMSeNyPFaIp7xTcnemRe
    qTK7DkAnA4EuJJfJaFkiyyxeaJDAePfu2NR8vS+Y3SFtDPVZlZWV4hSB1uQB8ZUQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RlwDGInH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekleenucevlhhushhtvghrufhiiigvpedvhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RlwDGInH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekleenucevlhhushhtvghrufhiiigvpedvhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030308AbeCSR5i (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:57:38 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:4621
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965678AbeCSQEm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 216/281] ARM: imx: Add MXC_CPU_IMX6ULL and
 cpu_is_imx6ull
Thread-Topic: [PATCH AUTOSEL for 4.9 216/281] ARM: imx: Add MXC_CPU_IMX6ULL
 and cpu_is_imx6ull
Thread-Index: AQHTv5ui15lFxkk1M0u7OCdMpEpySA==
Date: Mon, 19 Mar 2018 16:02:09 +0000
Message-ID: <20180319155742.13731-216-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:k5RSVQFi1LHI+WfIYMqHoEnuq6418pRR3oDNnxGijJOYpJ1GildzZ0lVCBHJEhOU9r8+4LHm5h2h/z+PgWwW6xV85ugsqsjN5bdAywjHOpaE6a77MqLlLpypur85EigISvxTdoDRZq9TtoA64U8B+1hcBdOj0/lNXbGU7QBPt2JAgcVpcknvWtlLWpcpeVuxe7RLV91DBTaepXBfdqozMMEsXyg2mTIM3TNBf5qDu9ft2dOIhT8uIeJamTgBPEuM;20:B2pnpFQHM1qJpS1CO4bu0FlQgnDHHqVc52x7leT7uJngYHESgshQwSSn+De7AAXRnY6itKiWwK5M8XXFJHm1IbdG/2eNqYFLvhweLxleNF/Gt0Dgggd4mSjpr9rjHm35/EyY7c8+Uqu3urGZFUS2sHTPdS7cuSfKmg7Hw7QvgY4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d640de15-db76-4cc3-89dc-08d58db31d18
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805707CA6506B2953CD5040FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(66066001)(22452003)(10290500003)(4326008)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(8656006)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(575784001)(3660700001)(5660300001)(6116002)(6666003)(6506007)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UEoxnW8guJqDeb1OmUR5meL+B+wwRBN9kpy43yuhj9ym8H2xTjj2HdOR40rmhNmY4yTJvsaDb5l78JVi3ljf2GxAHa92EokBSOt0ftPNBfMn/UOtgZKjIA61g4D3NVMFCNpn8eQP1qzkjtzQ68XsxvUQyRxhJUjEKl64UV8oIGNRO4S9TFA52ehNQxy5Axya9M0ZUItp+JY7DW7oo60105Np+k15HP06sG+bJfGdmDkEdbSZi8UR0EJUNNS02XD4DcmjRxfeH945BCHhxvqwmGPbz8X99lZkrCKQW/6QrjPxnhxc8pTx2T8fy20YNEtL7pDePTwxkTt2j8wQf2LLkQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d640de15-db76-4cc3-89dc-08d58db31d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:09.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit b3ea575770c7eeb259c77b6861cd14d00eb309df ]

Support for imx6ull is already present but it's based on
of_machine_is_compatible("fsl,imx6ull") checks. Add it to the MXC_CPU_*
enumeration as well.

This also fixes /sys/devices/soc0/soc_id reading "Unknown".

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-imx/cpu.c | 3 +++
 arch/arm/mach-imx/mxc.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index b3347d32349f..94906ed49392 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -131,6 +131,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6UL:
 		soc_id =3D "i.MX6UL";
 		break;
+	case MXC_CPU_IMX6ULL:
+		soc_id =3D "i.MX6ULL";
+		break;
 	case MXC_CPU_IMX7D:
 		soc_id =3D "i.MX7D";
 		break;
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 34f2ff62583c..e00d6260c3df 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -39,6 +39,7 @@
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
+#define MXC_CPU_IMX6ULL		0x65
 #define MXC_CPU_IMX7D		0x72
=20
 #define IMX_DDR_TYPE_LPDDR2		1
@@ -73,6 +74,11 @@ static inline bool cpu_is_imx6ul(void)
 	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6UL;
 }
=20
+static inline bool cpu_is_imx6ull(void)
+{
+	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6ULL;
+}
+
 static inline bool cpu_is_imx6q(void)
 {
 	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6Q;
--=20
2.14.1
