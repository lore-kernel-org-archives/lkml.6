Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118743-2-5292827509259576290
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
    t=1520118742; b=pVOqF1kpOO4Rs5HvGd4KV/xIHTCXHK4OM9M9Kl3MQPTCdDb
    v9KfPhKPYzaI2+P+QfEM/wb8aIl5nbMQnulpRtGxUelX8WsxSzaI6Grurs9h1tbH
    GaTvqP8f7CVGaFkxHW4ZzD6j77gFFQpwFThomKk2r7vsh9g1HVT6h7Y2YM59M7mu
    zAkyUjcNO4j0spDqhFoXbDkeEao4kypfpo7qPRjkUU55KRIj3w0d3/lByt91iWKU
    ZoEv7hl1mjkV1UMrdDSN0W+RB6d+qhzAD6NHzpZJq3RW91qDC2KlDOQnW9CsQ/Vx
    ciucplz1+GTAKsE2JX4kQuGjjvV55s1w8oqvydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118742; bh=8RSsN/
    Rv6LepEmRcXh4lirBa68f0dnP8WMpLwv0a52s=; b=esFnMWQGIwhrjT6OnRHYIC
    tutACU73+mVWuE9ZGBmLTe3KogSt89rh2y8orjJi6rIWQCn5kP9dCRXW8EpomzqX
    XmZ7KF8S/QHSvTgFoPZFNF8XMcDq4xcsn4YzcBYsyoxeRsa98HFOsUeR4BvGlWZD
    802JNeMLbpQgx2IxQhZQVpGK2qAXib13/Cz2ROtnMdpdmrRqEFLS5Dg3+uthJA/8
    0TxecwyU1XKlvClyhVMgFHPYEaJIWGpDk9ffrWluoxqEq/787kQs3mTuSB295Y+V
    7DIq+T9pHCbtdGWMM8wxmvHWWvuWNAmX8xlvaANoyZlWmywlTQRdf5CICEcLl9jw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BVc/9wBI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BVc/9wBI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbeCCXMD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:12:03 -0500
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:24173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935055AbeCCWjS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anton Blanchard <anton@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 050/115] powerpc: Avoid taking a data miss on
 every userspace instruction miss
Thread-Topic: [PATCH AUTOSEL for 4.4 050/115] powerpc: Avoid taking a data
 miss on every userspace instruction miss
Thread-Index: AQHTsz9YEJDimf73Wk6CXD+VNj0VAw==
Date: Sat, 3 Mar 2018 22:31:17 +0000
Message-ID: <20180303223010.27106-50-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:XnfS/HmzZl67bRsSlCSh6RxbcD/OIlXJFUCWwfPToFrWddWYAJFL8GjUIz0z8sWJO+ETJvdhkE7QwObokS4iCv/pXfghJZ1A/DLdJ/ubuDTpXaavRSKAx25m5hXr7590wnN9jY4rtkfH8QOpjPnMY0o0Vfy2HQNxkAaXAodmFVPd8cuOUEyCF/913sbxL+4QshglNwG8N6hDg2E8Mm5o0wZpFj56qmPB34a/TxcZNnaWBv4retEml8K7+oUByNsj
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f79783bb-0441-4474-20b3-08d5815798b0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113742835AB9333BDD2E5E0FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: BX0QTBmmxAfU6hj/ab1TClZfmosqrw/P2YVGpWfQ94PYMy0HPU1W8k+qjdIizlwVdkKnQCI9CvsKlHW9VdbBwuBfRsbuw/J+mBzHNjKa6jHG0QmSxQrwVQTRcI7MjvTjJCSHLvA5dzfFMRTCKHTGhStfuGgYcIbUu6WmRW2+luk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79783bb-0441-4474-20b3-08d5815798b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:17.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
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
index a67c6d781c52..d154e333f76b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -294,7 +294,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsig=
ned long address,
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
