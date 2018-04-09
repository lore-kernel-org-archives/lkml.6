Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244263-2-3316563957757184245
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
    1523244263; b=BqeeINhRg2ss40i3nFwvbsGi+bLD2RZEDPhvwBhAZ0vXtT8jjD
    Fldfuoz8kwBNbUHRQpahHZhUoQm+DA1hIoozDE5SDR7ozEr0b7aF7hmjvU9c/N04
    F+kpqtBggyC4OI2BOCFORVtA90hUbhIPu3GH1oxO+vp+PRizts4e/qqeRSiepa9n
    utz1R3fu5YvnCYjEKz3ew0qqUds6hU8jag2EkfRaNKnDNA00zIWeSiSXa6q+khwH
    clxaGsyLP+3ElQ0uOixlrtFPIz4DEnQnqt+kUcGEoodrMOseyFmrxsBS7zOg0Ofn
    CFry8LX61VjijLbWWjHIxpqyFAxKz95Uw6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244263; bh=9w2DJQTQuc
    SWZDjTkdGVxAIolNfcXgFJrfOXDJGKgho=; b=s+oYuWfmiw1waS8eEqXKIbzqeg
    DrewW4flW1xsDfuYN+nFh1P+PkG5TxE6aIPekzF0iCOGiql2Lc2L/He5PIb2sc7C
    JQKl+3LB5/Ppuid2z+S0ROlRXHx7igD8fCqbCtsrxqSKt21+VJry9Quk7Bt+K3Ly
    0t7PNuxtyo+NuxmUFdVOywlydhSKL0t3iD2zaT0osseb7vdjSVRlqz/MZRJlRPf4
    Lp7d7zveiBAzKReHe2Vtm5XVGvTQEHPzcsqo5soD/DwzV0qPhfEYPh8fYRz1DQiP
    WInVUNI5ahLOaaHvUtK0R0OsGJijxAFXIH+zHHvILHnEaSpPKcYNtctBYxmw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CI3s+I0R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CI3s+I0R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAqbWKvzKYnyn3TQ+cYYUn/2uY/GgrMdwNHJ/waolmQmZnJwMqLXrLgql6lNU1Ms5uchoSABO5lfZ3JiRuPx3mbOrm+dy3mu3pm3P/uk/iF+1btDiBJ+
    v8EM/3DJo3DWYW/qs6LX4Xrrn30mktWewYqQ5omLkk1MFYmjVtIv4TMu5W0Ti8iKDDopCrEq5qaglDyWFFPkI5gItmsBB8L7MyEeLqBB3euKw8GMg9ZO9JBq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=B-XsAANk3QweM85GNdUA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeDIDYD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:24:03 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753402AbeDIAWr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 030/161] powerpc: System reset avoid
 interleaving oops using die synchronisation
Thread-Topic: [PATCH AUTOSEL for 4.14 030/161] powerpc: System reset avoid
 interleaving oops using die synchronisation
Thread-Index: AQHTz5iDy9+DM4TMtkCw8qRVLERjbA==
Date: Mon, 9 Apr 2018 00:20:06 +0000
Message-ID: <20180409001936.162706-30-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:I0mvJcf2nC9jUk5jOALrgsiEAHib9cVr9NTCk4Ql98xOr9UhHyiQ6uhxT1NhvwfgjCGtWLfKXedWvG/QiDtlhdzJOYU7VxNApTIrSVrFKa3qW1lKW7I8xbr2FW3hQ45RJxyq39Yu58QpaqqPQu6SsMcPjIXM6tou0ZYsMXRI9favoeiPRJDVH34MLg7spRgPh8XjlG+A1yPak6aim4xaeeGu3a85HRQGZonHKkA/jc8fHOoleZIrrTDiGqTOMaDb;20:VMx9LsqZAICqvjxvAT5m2Cuh5hitgmavhG1liNekJOZuANlAsLbu1Q6npAbZ8hm4Db3ySC3fdj3AiVaqL0cL5zQf/BgHoVBQMeYe6K9NRIBW1NQFFddHJt6+80KcxjqqqnuGb1Nv4YCMUch1v89K6GjVv2Y+YNcWtgHVsekMElM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b715215d-ccd0-46d3-a737-08d59db002fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966BF0BC549F8BC5E7ECC67FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(39060400002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1kSDzJ1syfpTRayAigsdwZpLgO12NgKkJWVfzWtj9RrSK/yP90pMjkAiHs8fYzvJysBVL67NvzSoG5Cv/l5nmsFe//3/60JYmeKi7/9+ZU2+ET76gehXX9ML1Nj5UU0I+lDvgMPdxZvUEW784T/cgoAtl3xOjNS9jErUHPLBzBciyV2F5CSctgAQQYj5XkBORlvl+cOeoYKqsh2MjQ8gyxh0xH+lGHx2486Qe3YAhPJ/RWc6be4+XsgAMY2ayyI9dD5BGpE3lmPdrIclR+fVmTg9qNJrPg6WGWdzcF/hAnd9heQgbhfvE+WuYMrG1q/8By84X2LQY442BPaFJO5LYZ/ucf+PhfCFh5nvWUj4fG79zYGTVuVjWVtDppRynk/Hf9aCb9glALmM30sTckD+wiBIOOjGP6w1fv69j4ykb98=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b715215d-ccd0-46d3-a737-08d59db002fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:06.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index 13c9dcdcba69..d17007451f62 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -336,7 +336,7 @@ void system_reset_exception(struct pt_regs *regs)
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
