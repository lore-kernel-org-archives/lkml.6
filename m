Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120944-2-9281982395545845965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120943; b=CpofGTmgqgIq0xBzfLC78r0naBteLxb5v9gpAKgueoJDMkY
    pTFzD/h4rXKTIzCOin6ejz1jtRHKQqDFdmneCmb/icCTXdJPmeHKvzIbzYADRcEc
    sjTuxDZz9SKbtDRzUyRXVLosv5QOO24pSboAh4FEs53WtGucyUQ+CK+cJMwOmYzG
    PufNVg7zlnf11kIAdlICCWCll+HjufSHiZCuTGc/bHKiV0uVFa2Bmw2ufK6mWgn9
    /+WoLHbS0P/wFbadpHtH/NKX+m8QInHisGk0+Y8oNl5S6/PhhM7wbpEEq4Grr0rl
    aSalsHRPJwljToLXKFJoGE7W3DdvbxEtkbV7tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120943; bh=gBlMVs
    2GEDm1Ok8SwlspuES3fPfL3ME9EzxwxhvCbMw=; b=iu1zt1rxnQnkHlefPvr/i/
    Uv7jKf9Dpdbjx7KYSdlTZ0N61oMIMaElmT2vYBsiVU/7r7Nk8melMSOopa8eEzhm
    L7WtRFRhZBlYwhYCdEYpUETdPNEDebfCbJxEVxBMHNWnj5DNFmPLXpOephjRzbTv
    bIxNyPHx864R/eFg/xpFWSG1tVrcQw1rfPl+1gJBnYoni6Yhas5Mtw3GnSPlDQ92
    nwSCx0TlxUJZxFcZPrSXslk5BegEx3CFe3Ewc95DM/sTre3bh+pc0C4EuWAUVhT0
    aeMrExzdlC3ULzC7Uas6igCF1ff0OCcUJAIAawntEleX5za9Ho9+ygAojtdDh1zg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PhZnN3GF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PhZnN3GF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbeCCXtA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:49:00 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:37280
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934084AbeCCWd7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anton Blanchard <anton@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 100/219] powerpc: Avoid taking a data miss on
 every userspace instruction miss
Thread-Topic: [PATCH AUTOSEL for 4.9 100/219] powerpc: Avoid taking a data
 miss on every userspace instruction miss
Thread-Index: AQHTsz8C3wQhZbkUbEqRZi8NuMC2DA==
Date: Sat, 3 Mar 2018 22:28:53 +0000
Message-ID: <20180303222716.26640-100-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:7ZmNOsDoz86VvIbsba2kcQ1S2bQ+sgE0yvCMeysDc59IJKPx2aOHOR1GmD7RsKwqTJkL3S7XJt3bCRNUFStx+t0/a3qcdZ0qdEe6A67Mn3u2powmxcV/njnEbhh8AYxh+uWPUz0MWZqHXKRqLjWUxR91deWBoKe/BsI1YXPJqLYXqNFHGO/Y7O7BgEsRpH7XY4NCp4LRiuAH7BCcrE16UbtldVlOH7tG26U7QOHzJ2T5qa1j/d/0hxSZCkUnBB09
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a455edd-cba2-4158-e99e-08d58156d96f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065251500A8FE91FE1569F1FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: BzWgXdQO8/VlOVTQUihUPgQ5mlwoPM5vcGBVLwMaUFAUL4501eDScKztWdvPOhZTq5wT7Cw7ZkbXjGNjod0V4d6wSv8A4HM3SgfWcWDD3HUkUrbjlhGPKMlK0l02aHFNEcm6Ua+ytO9Q+jWlGHRt8zgG43zaUF8C8a73guv6nsU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a455edd-cba2-4158-e99e-08d58156d96f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:53.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anton Blanchard <anton@samba.org>

[ Upstream commit a7a9dcd882a67b68568868b988289fce5ffd8419 ]

Early on in do_page_fault() we call store_updates_sp(), regardless of
the type of exception. For an instruction miss this doesn't make
sense, because we only use this information to detect if a data miss
is the result of a stack expansion instruction or not.

Worse still, it results in a data miss within every userspace
instruction miss handler, because we try and load the very instruction
we are about to install a pte for!

A simple exec microbenchmark runs 6% faster on POWER8 with this fix:

 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>

int main(int argc, char *argv[])
{
	unsigned long left =3D atol(argv[1]);
	char leftstr[16];

	if (left-- =3D=3D 0)
		return 0;

	sprintf(leftstr, "%ld", left);
	execlp(argv[0], argv[0], leftstr, NULL);
	perror("exec failed\n");

	return 0;
}

Pass the number of iterations on the command line (eg 10000) and time
how long it takes to execute.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d0b137d96df1..9376e8e53bfa 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -294,7 +294,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long a=
ddress,
 	 * can result in fault, which will cause a deadlock when called with
 	 * mmap_sem held
 	 */
-	if (user_mode(regs))
+	if (!is_exec && user_mode(regs))
 		store_update_sp =3D store_updates_sp(regs);
=20
 	if (user_mode(regs))
--=20
2.14.1
