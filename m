Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495463-2-7507407984003897912
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
    t=1521495462; b=MxlrbN2d13GK/57miKnkMm+y7Svm6KO/0mH/45dB1Dnj4rW
    /ULlhLMEi7bWI/GR36QxjvYybei7jtwKOAcjSyO8usTFFlv8doRUYM5prDsGcZIV
    3RrqRksplQAA/rcXuK503udQ9bYt9L/IfSxzx+z5MfKTLuWayu4UygL7/2rZI+5g
    7gOJmwOG8BMePGc3NXRxS0m83MIJaOyOGmh0r8DhLjbo1KV7It0mmTL/bjTiUEA7
    ON7YlvIiD4KULMvVo63DoauIZqUiMupmh9WSFhdP4Mgi1T8DYQcWjhdn8CAHUv2a
    I7ohrp/emdgGBp27mpnkvwXrQfszDznm1X/9Wtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495462; bh=LXr0So
    atjFmdym0n0oIL+fZDjaFVysSPn4Bhnfd4RoQ=; b=JkxKYerhxliUc7ujQ3Zd9F
    Lmcj/cNLo7tc1SkQVj1+5Ng7iSXSz2EdDN2MP2a/UfmuhvJXcUjS0A8zkiBQimkf
    mO24IgI9nMQnS4rNVHLxRvLzXbW3IkpzhgE1qn4MHcV+5ZCEouBQSDR1qmPAkqDv
    e6/MqxVCXnDjkrphHZXrfF+6WdDSPU99plnYCFyrfuHHqky79r5Cp44GkBuZCKaz
    AhopgvWyAnO8vqeVO1VWUWRWBIJJlScDzf1RIxUPhIIES8HMWzT0jzE2s6r/IMCN
    w9Si/QH6vLRNckJZMDIwEGTVZHoYErwbwCBZg5rlfXOrVe9ih2izuB7/bHKvaDAw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hh/70Cnh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieeiheenucevlhhushhtvghrufhiiigvpeefge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hh/70Cnh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieeiheenucevlhhushhtvghrufhiiigvpeefge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971909AbeCSVg7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:36:59 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:62208
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965114AbeCSP70 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 052/281] arm64: perf: Ignore exclude_hv when
 kernel is running in HYP
Thread-Topic: [PATCH AUTOSEL for 4.9 052/281] arm64: perf: Ignore exclude_hv
 when kernel is running in HYP
Thread-Index: AQHTv5sslrxI0uoFykKx1dYwbyUB2A==
Date: Mon, 19 Mar 2018 15:58:51 +0000
Message-ID: <20180319155742.13731-52-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:k5ZYZEkn3Q4ScXgLfTgdDCR4tQSHunUxol+gRPF9MhNheccD0s5afokX5GhI7LXJWyfikanQJMINx+EXOG/10Uyo3gid/JSfgcuBgYcM/4i6tPO/7Dbe+K0f6fvCmKe/+6KCtf+xFFmEAqA9G5EbYPRw0Per5Cg2sKQiBGkzLzJLx6/PQEmXsirFXnWSJNSS/CoM3GzH+RyU8RI+al8jP53DWERiC8z0r+IdyS+UM3L9ksxAin9ivHpOvzXv3kPc;20:7BO3Ns7UNG+KbSOakzc5WuoJd1Kgq0p8AmQhfS21esgNw/7j2ck9+GyO30wu60pBB2rSp39Od6wG32DWj4Np8yhHEHUZHkssyGfilISW6aKIiLY3RLNqcVLbRtaLN0/WVcBadweCQNX/gy5YWr4ROc+oJWY+s9DgDvKnWk+BdcM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f86c3e86-235b-4107-13f9-08d58db25faa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11099C7B2AB85E36316C7C6EFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(278428928389397)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: HBOYCUwa2p2dlnqivcwprBIteYBtIwpzs5AuT98GCG0oG5N3+RLxR+Hik+Tt4uTLOra48v8HcfLIIh9M+27todFzQSwrA+yKeS9RPyFi4Ax1ABq5YHF756jjjNunLID/6GzoHyAOIKEp2eRxVzW80YGDkgWeKedAxJcvC8+hMLu71P15cqO8sJLMS/SdZcTNZhmG23nJR2tpOZ5hddhzOfWehMlXpu2VzAHuhY5uULPnGadYBKuUkbNBuNftlXsJ5eNwv8CDp4zpZEczw3IlkKKGNcsRgHeCpfxrfTDdk6r9owBzrO61MDWIoEVRybjNz6dAcLioehyTXoUdCNwVjg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86c3e86-235b-4107-13f9-08d58db25faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:51.4789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

[ Upstream commit 78a19cfdf37d19002c83c8790853c1cc10feccdc ]

commit d98ecdaca296 ("arm64: perf: Count EL2 events if the kernel is
running in HYP") returns -EINVAL when perf system call perf_event_open is
called with exclude_hv !=3D exclude_kernel. This change breaks applications
on VHE enabled ARMv8.1 platforms. The issue was observed with HHVM
application, which calls perf_event_open with exclude_hv =3D 1 and
exclude_kernel =3D 0.

There is no separate hypervisor privilege level when VHE is enabled, the
host kernel runs at EL2. So when VHE is enabled, we should ignore
exclude_hv from the application. This behaviour is consistent with PowerPC
where the exclude_hv is ignored when the hypervisor is not present and with
x86 where this flag is ignored.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
[will: added comment to justify the behaviour of exclude_hv]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/perf_event.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.=
c
index 57ae9d9ed9bb..199a23f058d5 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -871,15 +871,24 @@ static int armv8pmu_set_event_filter(struct hw_perf_e=
vent *event,
=20
 	if (attr->exclude_idle)
 		return -EPERM;
-	if (is_kernel_in_hyp_mode() &&
-	    attr->exclude_kernel !=3D attr->exclude_hv)
-		return -EINVAL;
+
+	/*
+	 * If we're running in hyp mode, then we *are* the hypervisor.
+	 * Therefore we ignore exclude_hv in this configuration, since
+	 * there's no hypervisor to sample anyway. This is consistent
+	 * with other architectures (x86 and Power).
+	 */
+	if (is_kernel_in_hyp_mode()) {
+		if (!attr->exclude_kernel)
+			config_base |=3D ARMV8_PMU_INCLUDE_EL2;
+	} else {
+		if (attr->exclude_kernel)
+			config_base |=3D ARMV8_PMU_EXCLUDE_EL1;
+		if (!attr->exclude_hv)
+			config_base |=3D ARMV8_PMU_INCLUDE_EL2;
+	}
 	if (attr->exclude_user)
 		config_base |=3D ARMV8_PMU_EXCLUDE_EL0;
-	if (!is_kernel_in_hyp_mode() && attr->exclude_kernel)
-		config_base |=3D ARMV8_PMU_EXCLUDE_EL1;
-	if (!attr->exclude_hv)
-		config_base |=3D ARMV8_PMU_INCLUDE_EL2;
=20
 	/*
 	 * Install the filter into config_base as this is used to
--=20
2.14.1
