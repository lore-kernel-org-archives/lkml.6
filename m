Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239571-2-8624686172609820131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239571; b=jBPPuYWTseERmKo1rN8RUUoWtuhlNAWYqQo65lF/vr3fyjXIqV
    wJqRin3ZHY3yQYyvIRR3BqIxxDR2HN9pYjjo9q9SykJhmEl9/gyfvoA/x/0RNYFa
    Oml3sNdriQ7KUzQ6IxSDsDgvZ6+zA+05TudbirGaYLRaB24DctIhjmHvsD0crmIC
    DtLhX2o9Q+F8M8GR9qTZc9CSjS3VLDxOFxg/UjhMW23sHpIW81kq4IB7xsd8TuuS
    PDa2+AojlwQOyo0yHafxdPeMIBTRQG6SJ+A9SlJ9gV4MRLfBD6Abj1UKrWTrxel1
    NCGJzRngffJTHmfVI6e+m8mOL6Wu5b1I4eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239571; bh=oM5JRjnNOO
    vHiYlL/YkLYqPuwiH9qy+8TZmBlQ/mD7k=; b=K7mNIOWFR8+mC2Tt5EgJmq4iLp
    rgYkiiLmdiZsssWBiy9Q4/QCLZwzGfRT+pvv77JYkc5/6oRa4JSua467EITFd7tO
    Rtoo7dDBUqUbwEjaa0E3wxoAQ13/8s9NYZqtSxo62AVhVii1RvWY91y0SBqssjox
    AlW1icT3advisVEU71CxqdSYXLclO4UaVkq34mv0YTOIQq99qTeLjyzUu2u6pz0A
    i9AFh1lAZJLlq86xKeyRhStAbnOM6a+wkhpofHMPqofDgtt6LfWxQPqvMVXzrPVe
    Mw5TdN2Pp08BMM1Ina8/ZoaRDNYRlUv2lF3KPHn+Fk5lwi4ATidoM1hW8HBA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ib58pE2+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ib58pE2+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHQUoJXIvAgioyh+b2mpe1aWxYMkpGWThOZdD/HXb5MG3hPEmPTxVa+mgl1BbFVrmsY5PuSu2+RIBfHvx9IRk9IXikUyNIovdic7XzfWgBPSqCvf28bm
    5cP+uZrVZTYP54dGWS6A211aw8LXn2j9YZYyEkT4xznhs5FfvMFd739MpHYPNXBEe3xG049HS5gBUZBEtfe4PxB8SxjFYyqBCwjBaIBMc6gI8UeAqhIHRbdW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=OEySRT31XItV1Ocz9JoA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757796AbeDICF4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:05:56 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:40886
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756311AbeDIAba (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 180/293] arm64: ptrace: Avoid setting compat
 FP[SC]R to garbage if get_user fails
Thread-Topic: [PATCH AUTOSEL for 4.9 180/293] arm64: ptrace: Avoid setting
 compat FP[SC]R to garbage if get_user fails
Thread-Index: AQHTz5k7ATtWyuV53Uq5j1Zr0D3AAw==
Date: Mon, 9 Apr 2018 00:25:15 +0000
Message-ID: <20180409002239.163177-180-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:deJRSsX5qAQ4A/8WOaxFBYg85YTX5QBDakulVWXqV3Hb2ySg5mniuHNrQbw8B4HwYnh33qwk+tIi4sc+CPkw99kMwTMwCpd05MjUDNfTKXMBfvCo4lLC0aigZoh1sMh6vCeFhZ7f23+EBNVFC07xBo2/wd/wNQSmdorGVyq9zHRNd2vklXdxYSHjz9BKSHmXfV3Yrctz1e2NqsidsBoaxKfCmHY17UfY8QVQV3vKoiiUU8794pDmiU1TEuRc7tTw;20:9HSx+7IT8BWqx6A1Ndpo5abtZuj1ZY8lXmMmd4CcKeKCGRcMUUU1wCt8FSjfLHKZLC/RUiq7vdTo2Y3Pmu+3La0kakYL6Fwu0Q9TN+Z0Ck1kcTkkNQYWM9WK2f5KNEUCRPLN7ztZU/gOZdEp7WGWzWfW4Gh2XIjVve7Wy+k89SI=
X-MS-Office365-Filtering-Correlation-Id: f87fbee7-f379-48f4-1455-08d59db13974
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11266226B5FF3AC4CD515679FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9njMOfKEAOYAD0EQ8BNVRz9bBWTuEDwpbtwxE8wHjxXF8AdM+cMSsAoa4IpV0YEdkEzijIVtrhtfNsLpuOxtkSfkNd1FD3d4Xje8yMHTKC6Ibq+ZOUu7hp0shLJFuliX9FfQrd059sBAJ8cWykH8S4ewVWnYKdqE0fLFTvtOKeXgiMYfWNzmpgLsyEpAF5XpQFucnyQIhR7Gv1zPGJ8tF7aE3YGt3N4WSsBGTGO/qHpzJ6TZ18alz6obTSotPOMJNsyQ+FFncgu2XRvKM0TCkTvx8/IL7LgNTkI8PB/h0vF68YSJ90qoxUmHT+GZbww9ZhuOn6lQopCDlTvQkLnrjmGVsvyTKxvsYn+6NtIC9RmD2nJm+XHFwPhx3BBdM5HWVemZlyKNnfmuTX4RGdmAn01QKV+KLk5sUyoSitsnduo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87fbee7-f379-48f4-1455-08d59db13974
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:15.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Martin <Dave.Martin@arm.com>

[ Upstream commit 53b1a742ed251780267a57415bc955bd50f40c3d ]

If get_user() fails when reading the new FPSCR value from userspace
in compat_vfp_get(), then garbage* will be written to the task's
FPSR and FPCR registers.

This patch prevents this by checking the return from get_user()
first.

[*] Actually, zero, due to the behaviour of get_user() on error, but
that's still not what userspace expects.

Fixes: 478fcb2cdb23 ("arm64: Debugging support")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/ptrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5c78b64369cf..cca95e75aaeb 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -938,8 +938,10 @@ static int compat_vfp_set(struct task_struct *target,
=20
 	if (count && !ret) {
 		ret =3D get_user(fpscr, (compat_ulong_t *)ubuf);
-		uregs->fpsr =3D fpscr & VFP_FPSCR_STAT_MASK;
-		uregs->fpcr =3D fpscr & VFP_FPSCR_CTRL_MASK;
+		if (!ret) {
+			uregs->fpsr =3D fpscr & VFP_FPSCR_STAT_MASK;
+			uregs->fpcr =3D fpscr & VFP_FPSCR_CTRL_MASK;
+		}
 	}
=20
 	fpsimd_flush_task_state(target);
--=20
2.15.1
