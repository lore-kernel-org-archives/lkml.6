Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A74C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED4320827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XICco5dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED4320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeKHGbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:31:20 -0500
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:16256
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbeKHGbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hV8vf1cOKGTjI63UVmY5oW1kQ2Pz7es+sFXjy4YovU=;
 b=XICco5dQ4iotauBxM50ovGnBQ4fVeYJdx7fNh8N4Fi4fFarTPrmvlM1LJtUdr32+o2qBN41ABOEUMUW7S+frDjuF8iPFwMS1GhXvGJjXQAnMCnuZMD4ZCPum8BbsmjB5n8hBXmmKiVLg/DqS/dA0IWiz0aeLjECi7Ck8YpjI120=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2605.namprd12.prod.outlook.com (52.135.102.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.32; Wed, 7 Nov 2018 20:59:07 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::59ed:1b4b:35e1:db4c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::59ed:1b4b:35e1:db4c%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 20:59:07 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH] x86/cpufeatures: Add WBNOINVD feature definition
Thread-Topic: [PATCH] x86/cpufeatures: Add WBNOINVD feature definition
Thread-Index: AQHUdty5wKmORkfkHk+jXs2jD8H31Q==
Date:   Wed, 7 Nov 2018 20:59:07 +0000
Message-ID: <1541624211-32196-1-git-send-email-Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:805:3e::30) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2605;20:RMPhtX6Iu8dOyhVSdGD1AbWqVP5w1f41+4LEa25ty5PrBgzNCF7dWb6WDTGi8N06tE6dSzV+FHMORN4FbgtuBTqoEdWLJHeBLtZDe3ob6CNUpOzk4Ccv/cb54x9WV0iI1d0/6MtPx0RMVWKex8PV7ocLVDJNieR00vCQTFb1lPr0sidz8EawOgGRnNh77OWdPLrldr3YixcSdMQS5N+sCQKQEql08iz1mQvF3FRnZoA8QJP1rZC11pOsUYBgRuqR
x-ms-office365-filtering-correlation-id: 5c66bd51-6e4d-4b72-2d95-08d644f3db79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2605;
x-ms-traffictypediagnostic: SN6PR12MB2605:
x-microsoft-antispam-prvs: <SN6PR12MB2605CA3333024BED85FEE6C4E7C40@SN6PR12MB2605.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR12MB2605;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2605;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(106356001)(25786009)(8676002)(305945005)(8936002)(7736002)(4326008)(71200400001)(486006)(54906003)(2900100001)(36756003)(14454004)(71190400001)(476003)(110136005)(2501003)(81156014)(81166006)(316002)(1857600001)(14444005)(256004)(2616005)(186003)(102836004)(3846002)(6116002)(86362001)(6512007)(99286004)(97736004)(53936002)(6436002)(26005)(72206003)(478600001)(6486002)(66066001)(68736007)(6506007)(386003)(105586002)(2906002)(52116002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2605;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4U8QF4LAI5RWIvWuEEXOxzbLqZY4YydkG8eirDV06an6tH4ypKHF73enxrY2Z0c8jVHsaAyKR+kTtAVbYGYY9oSuO5LeVVhK5JwQSdzgodhokWDwr1jLtuvR7uTwJ2WRyV3g9CpjURnwFX9UTKy5ud3XGoQ97li6K8vy2RMoNU03rVB4AwkTb+qFfVZewIzq7wsq0c8pUcB5gTpKT4HckSHmZo9c5XdFRa1NmtevZsDtW0m6Fk4V136d12JU4W4hgQ00PU8yQ1QVaxIcQ+mvWaXQtfCO6OAhKFRTtukxBeRsoC6cMTmHuAmREtUvUPt0Z3bwN2dtmG3iIn5gCClHc7K2XX5LHW1r8eRsYserHRA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c66bd51-6e4d-4b72-2d95-08d644f3db79
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 20:59:07.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new cpufeature definition for the WBNOINVD instruction.

The WBNOINVD instruction writes all modified line in all levels of
cache associated with a processor to main memory while retaining the
cached values.

Both AMD and Intel support this instruction.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h
index 28c4a50..39a48f0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -281,6 +281,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error=
 pointers */
+#define X86_FEATURE_WBNOINVD		(13*32+ 9) /* WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction =
Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted =
Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Bra=
nch Predictors */
--=20
2.7.4

