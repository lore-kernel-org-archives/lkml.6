Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246864-2-4785502961165958041
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
    1523246863; b=GopMqloUaDk49d4Lu3dhatYzE3SE9ewqCDf/pSbguzyCCBCBsg
    GhtR4yW8dPW76LnpijPHENP6M2DRdXSlsKHqzP0oWW3XChP5YNysWPLub4JKHe9J
    0pDwp2QBOJyYydEAPVO2be+S4+h0qCyDNEX13xgQ3gCcIKZoV+KCpmPV7HAUkZZ+
    9OEqSdzcQX3o64AITB1WFCiYtJ2/O3YidKiB7PCRrWDtQlInvpX+j0AYjKxFzK71
    UWeKL1pTcFRwdokS05gskkNl2wH5lMZrRnNEYezdA2qud/dAeeZv1KHNume9pJKO
    QCkfU8kkL/KPvo03KkeTiFdEAtYHKN0A+p3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246863; bh=Z5bsm864xv
    xGjT1l6ANHwN0iSnkfF9Og6dIuCVjhQi8=; b=on9uPOrU9cFQAd3gp4NjXZ8mDE
    dhHhki9N6ZamxW8kFubuXRb9T4Didjyx18/fl5IwtBITR2AqzYgF+hXWxCdXV/gW
    BYmjFKiE8rZo9pjmV4oBvyk6dchyDXsGy9ESt5p1+CvCiU7mNVhNMVIQfOemlNgP
    Z9ubdMyxlh7eJcLtuN30mycXvOsP+WSjpPbaKOdbRUddYgmWHLIaCd+99750+7i3
    RLgMoKb4P0MLhUXOgYwGswz68Q4gYKujbDWFEBzKxBNAbHzKzc9z+lLNmSyr8tBC
    0ZYUzQI/3Nhzx9cYguHAFoF/wTpaSzhpkzWOcImB156P6w7NAN1v02/WW0aw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H4GtVRcc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H4GtVRcc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDalil7wSp0Axt81N39EJbXmd13NkWFQitBhPug2F6eehvjQ5/k6zLsw4RH3bzMkWB9AJRh6u8OAXFJvZ7j9aV6K12eqR/qkQejZxU56Y8gI9vSWuyZa
    x08RtON4TMig4wU715ehCVl3piUHTsOWwYkJSbeQCrY1gqKmweYs+enZmZCnl3CMgmIOUe/M+me4cEFMeiJp9HmR9j1rSq7rf6kKptRN3IfMtX3K2/Hpu5Zg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=B-XsAANk3QweM85GNdUA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeDIEH2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:07:28 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753183AbeDIARr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 034/189] powerpc: System reset avoid
 interleaving oops using die synchronisation
Thread-Topic: [PATCH AUTOSEL for 4.15 034/189] powerpc: System reset avoid
 interleaving oops using die synchronisation
Thread-Index: AQHTz5gbh8L0E9ssOUOQnUUbKgz09A==
Date: Mon, 9 Apr 2018 00:17:13 +0000
Message-ID: <20180409001637.162453-34-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:86UxAldKQKjoqb+e4E1nJlU8ZE0Rkvt2tFGBzdBco7WIL+L/gUBMQY2fXWmtLOQubR04PLJ7gbb+63FZ+hK9Rj4Bh0eORakvKM7lragU5Ce9AWPsGJ+HBm3DUs4QvkWnh67bgMgvGjk0Dd4IWUvgGSvMxSzZTUntQ7ZoO2spzf5GjbNaUNRN44bCksB+65deyRTKMedp9mk+PYpqYInOVGu8EOzlYPP4Ry2/gtJhRoCGW/aVfBGYxKisERxURWhW;20:HIOi/Wqqb4ghrYqn0zuOps3rzvI29PCLI2F+ycFZjT90r1QTx8sZBA+0zVILCMmCQdfGJn5WVxFR2r8rUeaCYIoyK9uR9l2d6vm7Q225KJhFGQ9jdUsHrKK5SUlw2PbxdVrgLknqzvgs8rDAgA2v8IZ2+8yl5/2qgpz5iJa1eEQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5edf9d46-3faa-4e2c-82e1-08d59daf4ff3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048ABF0824C3417EDB73480FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(575784001)(99286004)(6116002)(110136005)(3846002)(54906003)(39060400002)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oNWUIHBfXKvd9wiTGV1jt7AzUswgmdoXt8F4Wl2x1CWAZq5HYYPZVQXzdsnDpBVDve9kycbhTshdYzweUj0hd5w1WVUPLhLfMWQJbI6+Zv9Wm52F8eCkhv1E106v0Ro+ZXvVUIyWQNO8gj18qmNiD0wkbk8Yhc8AVv5INyEGH0XkZOJU2yBIeO8U4zqyNW0W4vGX6P4A1QO9rZSKNV8k7hnYKKTeSBAMgcRcwbyBOWq7JK8MfZKOM36YACnu5e0Zg5Wjfa4sanw+QG0yLuhMVAUScUqFAmnFoOutuJihiLIWypL25nqvE8p0hgKXJqe1ohsiPYAOIH+wIPnSB67q4JFPMtcV5LnhpHl2sTloqCacOtpFq5GGm8+8QyIbBoAVggEPTW+0gxEczQIHUefmy0FgrsLlWcnlHH+q1LKD40U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edf9d46-3faa-4e2c-82e1-08d59daf4ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:13.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 4552d128c26e0f0f27a5bd2fadc24092b8f6c1d7 ]

The die() oops path contains a serializing lock to prevent oops
messages from being interleaved. In the case of a system reset
initiated oops (e.g., qemu nmi command), __die was being called
which lacks that synchronisation and oops reports could be
interleaved across CPUs.

A recent patch 4388c9b3a6ee7 ("powerpc: Do not send system reset
request through the oops path") changed this to __die to avoid
the debugger() call, but there is no real harm to calling it twice
if the first time fell through. So go back to using die() here.
This was observed to fix the problem.

Fixes: 4388c9b3a6ee7 ("powerpc: Do not send system reset request through th=
e oops path")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f3eb61be0d30..109989676776 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -337,7 +337,7 @@ void system_reset_exception(struct pt_regs *regs)
 	 * No debugger or crash dump registered, print logs then
 	 * panic.
 	 */
-	__die("System Reset", regs, SIGABRT);
+	die("System Reset", regs, SIGABRT);
=20
 	mdelay(2*MSEC_PER_SEC); /* Wait a little while for others to print */
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
--=20
2.15.1
