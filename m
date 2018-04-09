Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235181-2-9408012260614390222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235181; b=ki9UtoCL8A4uzjfjmkfDWmJrtul2gw/9f9fl2WC1bmCqN64Cg3
    tLp339EB3BzH1Ed55onkTEr8I9wgeTjGutREr+KEAg352mqF5qG5Dt3UzbW4Aw6c
    I49e0SgML9NEHjDeQFf7u1KFu81YbdZ6qLHUIpy8x+7UXjr5CrUoghxkMtjX845C
    bsCH3kFdrqB5OPTIo6unuw2AS2vSELyENugmKLr/k16jKpFUzyaucVGp1C5LWpB5
    EfOHxTal9GHkWdB6RmZvKOXVa92QLxOK6Y+8zQcNqHdNcZLjrmDDAane+WJwHuDH
    2TYSV8egvjF+xmuJT6N2pFcRNZL4TT6COJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235181; bh=QFDQoxWb6x
    MHSnO92LuCW06HI61H1oUwJfcho8andsg=; b=YExvkxFghO30TI8ajE0zlevH5V
    T7R8radXu5+WQJ6G5bV7YayUvXN2jFyIXOYXOreGov6uLzbpmqpS61g3D3SnevCK
    uNm2JiW5LgQqfVxXNvT74zTSwVGIxP0IAzCDaRV8tFRx4N20SaMezPL+0uasSOa1
    JRQ36zh6+lSQmYO0WPLaXwEOQzt7sMRQHX6OjX8nDSUxXHnn+NLfXu1GPyObaew2
    a9Mxo63eBPsZPLlDLYZRa2y0S/V4+Alaks0aDC8OIZ8lyRbkiDysh6jH9YADtlJv
    DMilK9i3M2HFl5RanDZRLUTSccuav5vGXKwCcdTi5T86sqjzgNH9xpMTshcw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lMXVBzP7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lMXVBzP7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAg1DF7PcSP0aP77g/G8IQkPgCC6zuJ1anQsdJ9lD+phpVG6ErcwJKU3eihPMrQBhBexLAMwd/usp/JdWZHcgJrYCHcZ/IdTN8yhQYg3EItUcGhX5Cr5
    2vwIQe3iH9a2svtUrswrLO2CTIdMv1JI+5AxAbFS6DrCXT1XsNQVLAWW97t/sylTkjtyNiLgRTP1fV4Aw/4NJatrMmQZeJZK2lNjGc8+VNyTgf6xE4LHFI+G
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=OEySRT31XItV1Ocz9JoA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932913AbeDIAwR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:52:17 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933421AbeDIAlZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 057/101] arm64: ptrace: Avoid setting compat
 FP[SC]R to garbage if get_user fails
Thread-Topic: [PATCH AUTOSEL for 3.18 057/101] arm64: ptrace: Avoid setting
 compat FP[SC]R to garbage if get_user fails
Thread-Index: AQHTz5t63zIp/W+nvEOMbAgceMkktw==
Date: Mon, 9 Apr 2018 00:41:21 +0000
Message-ID: <20180409004042.164920-7-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:Xd0QxPoF6iYGKpyUbt80WN8ymeNdeEuTb8d1KEi306sbNp/ii4AjxnzqOC7pOVMF6f0mc8229RcdwI0lP2dL7zE/dKL4Gu6HhFSsPU5Jg7ud64ZFWdrqzF1VELnXkRDRCazzXtieAiOjjb8mBHIDixaWGvi0yI6DRHoKk4thJleqRMHGXg/WuozuWPCnnxJwxxfLmxSKt4v0dOaoeoJ6Fdf+JdHRgaE1exFsZiAE0I6p3X9DVDswgCJYJ2eUkMhF;20:bs5gmrZU7DBrQbTiE3orR3kuNfyD6sxdb2Jg50YOTw5PSJtVYAuvqfKPvMxaUjmRoXCNUMfGDyPo0sPThxSwJWZeeXnUfzBbF7iK2NEeCJAYoGxBapQrMBPLPGWaIDc5iDkyhlnR1cLi21qAU2BzFJjBeVzJNJshLVn23V002A4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77d37509-af0b-4b39-b1f9-08d59db29e06
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901DBB72DFE33E5D3F223AEFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vLgjRz/zANIr2eRJVi7Y9n33j3O8YZLtFJs1GRWfgpKMmusVfq4jG06o+gv97NCibfVTKBdTHsP9awTfEQYoEcuNgHDmr+w1/4VBOGECx2NbMWul0NwbS0jGCTZbRVrNiBu0QANiFv7yNNzE9AX4w0hAo5Mku4CCM7oh3eHGQlsWqs93KJy7UHSdknAfy0zs1ae6a5ez8s1iOpSR3q8NSxkDIHEdw+JgSQQHf6TNu3id/Q8BXHh9HTcXTjBlBxuoO6PZ/F/F0xM9mS/lYcGUOt2ka+cZZvaj0bXKePsv2GzsyoxhEVadI6bAhdCq1QqfzV4jExQVuL04M715LSy3yPtOH1CbwA3lf+qhdLAfdCnP0nN29n4HNRR95ixGazsx8IlizyoIDHKOkz+8tH3g+oh+N3LzTjyh9oW5CO0TOT4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d37509-af0b-4b39-b1f9-08d59db29e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:21.2677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index 2e845f5c8ab2..a12eb17e7985 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -785,8 +785,10 @@ static int compat_vfp_set(struct task_struct *target,
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
