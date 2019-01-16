Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE36206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mc925hme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393883AbfAPPKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:10:38 -0500
Received: from mail-eopbgr800087.outbound.protection.outlook.com ([40.107.80.87]:29856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730669AbfAPPKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVNEyauJqXzfSwaQSjbHqJBsU91hOkh6PbDZ9NFZLGg=;
 b=Mc925hmeCMExkmVbIwqQo3pQulg5xFTwMYVR1TXfwlX2vYTU/1cnJxjiFUSRNEtsyA6tQSAhWh7o9azhT9TjH3nlSwkFh7QdI4mejNxVSPpAIbRp/Yb2Jm4b6g9IRLYR5VUxwCnFp8rlf3WjKHbMqZw1b/xs8QeGY7WEwhbzM1g=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3040.namprd12.prod.outlook.com (20.178.243.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.20; Wed, 16 Jan 2019 15:10:32 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f%3]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:10:32 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: [PATCH 0/2] x86/mce/amd: apply missing quirks to family 15 models
 (v2)
Thread-Topic: [PATCH 0/2] x86/mce/amd: apply missing quirks to family 15
 models (v2)
Thread-Index: AQHUra2f1iXzkuMD8U2DcZ2VEAgJvQ==
Date:   Wed, 16 Jan 2019 15:10:32 +0000
Message-ID: <1547651417-23583-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::27) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3040;20:WpMOJJ2dkaiJRZk5QyU9jUvvgFGxM2gA6GVznRpFv0/a9n4H6lUI0hs/kJ+vBrlFcC6EyEqMJikGpR0pqW4c9eFYdzgMIgEXcyQoKi6mBbLiY+tAiIpJX8+6CxdliiUi4XspITWRWKb55sN5jMwbH//1o666cxWV1kgfXhpeGt2n6r13C1D+SrvpSW8VdN3gFyfac0/IgJINrgpL+hjS365Dlb4F4gqaYKkLjLA7WFaNOD3NdgkUP8W0skn8DMt7
x-ms-office365-filtering-correlation-id: 31189320-48cd-4a05-4445-08d67bc4c22b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3040;
x-ms-traffictypediagnostic: MN2PR12MB3040:
x-microsoft-antispam-prvs: <MN2PR12MB30402ECA2AD715909D9152D3F2820@MN2PR12MB3040.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(346002)(136003)(199004)(189003)(14444005)(8936002)(97736004)(25786009)(256004)(6436002)(2906002)(186003)(305945005)(105586002)(99286004)(7736002)(6512007)(81166006)(53936002)(316002)(8676002)(50226002)(81156014)(106356001)(54906003)(478600001)(3846002)(6116002)(4744005)(36756003)(66066001)(4326008)(72206003)(68736007)(6486002)(6506007)(386003)(486006)(2616005)(52116002)(476003)(26005)(102836004)(86362001)(5660300001)(14454004)(6916009)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3040;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ccqCJzVn848iNRDmlC7q0Bnw1Zqp/wCjKLc7OcKJ/0765feg7+d0TDxXwiaO2SZSubtycHTe7nQN4HrYK+v05NZu16MjrjD1fcfFkLwZUNjG4qbFzLY+OOeb0abltK71MYLNSnZFKncj6qtNqYYVoq0cWExOjXUvYNyjqSzZvzV5fJYo+NL++mKJKBcN53zLhsxSpg0JfjV52DDvPtKdDi3ohkvhar8BMOSaO/4WH52FYtUsZSfTRE0yH9S861N/YcIGmuCr8bhvAtBw//vGRE61oVBiQSXFUMnUH8Fx9TYR/Xx4r+pI3GnteyIw3uKPxeFFB/6jBtkx3lC4URcYNjeQyMaX2zsNcRr6AiZLLGOEMJzwuigAeBEaX7V2isEuXCMBn3HVHKsFarEaXKSIm6UaXx5PkQIa7+aSWkvBzwY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31189320-48cd-4a05-4445-08d67bc4c22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:10:28.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below patch series applies to family 15 CPU's of AMD platform, to address a
consistent warning of:

 "[Firmware Bug]: cpu 0, invalid threshold interrupt offset ..."

at every boot and every resume, which is misguiding as the reason is not a
Firmware Bug but "MC4_MISC thresholding quirk" not being apporpriately
applied.

Shirish S (2):
  x86/mce/amd: apply MC4_MISC thresholding to all models of family 15
  x86/mce/amd: carve out MC4_MISC thresholding quirk

 arch/x86/kernel/cpu/mce/amd.c  | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c | 30 ------------------------------
 2 files changed, 34 insertions(+), 30 deletions(-)

--=20
2.7.4

