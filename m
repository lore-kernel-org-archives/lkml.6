Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233802-2-8880201267885180658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233801; b=OvjKT945vN9nTIJRrzbAdDAovjkS8+ZLhs6RQXHvLt5rxUePj/
    yVX5AqwDXpRjuczUcdPe9M8WsO3sUEXFcc5iijSZuBbfqBtDxi0KzcF+CFQO2qHa
    BFN+jGxRim6w6/DI/o/psgBalQTv27L3FFzV1evGeB6aW5ug5vXq6KtzeSlACuHj
    Mxk/eY7WqVOcqf30A7o8nOFA4lQjdgEVju6oCqtscrP2MnTIp3H6lhHvLZmSj12I
    z+cp9I0E46RloLbIRbCr/nN2u6KRysFbaDikw1+6BiEwd2mcmJbu3jtvep7kRjLk
    8nkJmRlfeW+bNTyVYwOxTbBvSkARtYEluA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233801; bh=w1XtxC+Adn
    j2sCyJ7ENVtJkh+HRgsE9Bzg5J2iMLaEU=; b=r8eQAl8HFdACTqR1dcbo8I8Z8F
    W7cyBQdS3tFDLu37s6oPl4Rc+MgtYeqBQBwfm6K7WHprSH9YU5QMQ1IAa542ftqD
    y+laIItofxzNGKd3y9xCLYAsLSkgCeJDemCygUNl+Zad+zsMvt8B6MHgDqI+dXbv
    W2cpiVd5QO4ac/GnUCywboB1NSY9LKKy1ND5ntyk2/oDOIEFFNtg1ywztTvmjuyl
    pmfeXxoer7Q7Nf1oMmLkq6MD4ab4GGAP9DgzLs2YIwVntxUm4P8DBa93sCeQMnBS
    Jh2gnr2jp4fN2eqvvBAnoayxuGU11RFslsfEIs5smbe1iw875rsGnFBgbxsw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IWCwXLvp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IWCwXLvp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJBiIftPTKcoppiis8m/icUijoRREmwEicGP4p4o5ey6pF6rTa/qkm4rheLBN0u6bPcwqqL23rfltihAruwY9LfuGTd6YW99pPFkWFPz5Ibfv7QAz2sA
    mP9gsN8omR+66E4Va1IJYJZpgEmhoOMPqS1W0ngOcsEFpK9m/E6DKX7H3umGJwPzGIrn9cavRjniX8UF+3mInWekUUwAhxzK8iHe60cBtZ/ckUWQrJ5JLynm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=Qwlc_dSzXDkvjYzUon0A:9
    a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755042AbeDIA3f (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:35 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:6816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754501AbeDIA3d (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 103/293] x86/nmi: Fix timeout test in
 test_nmi_ipi()
Thread-Topic: [PATCH AUTOSEL for 4.9 103/293] x86/nmi: Fix timeout test in
 test_nmi_ipi()
Thread-Index: AQHTz5kW4w5lHO0NoUa52798wyfRew==
Date: Mon, 9 Apr 2018 00:24:14 +0000
Message-ID: <20180409002239.163177-103-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:iHEGru4eSjZOYqedt+xgTzhBQM7lKGHHKJT18Ql45QqtCklnpMIxAdIsV/K76sHYM1SC8/a8menrmPLc6EeiVLBmsrzZICnDXQQ3yNxz4oICGwatzT0eSDCNwdSm7dV2bNUEFhBMv4RAT4ReCw0NHMOtPRZ1XoNNT6OO849QbqsGyJxmHGGrpt/hkCUlb51WISYTuA0qvXFNsxfjBz2a1BhteBrniv4ueGEOVQ8NLjr3axkkwJxHOAXxP1DPbPhh;20:xs+4OhgsYq2aqH3IbtIgRR7Uzw0rFCuepIzkD2kMa/UlNKr0swDBgCqDj9NC5aMIegqe9+zgTR0jH0O8dXZcjwqTHIWlF0EQNW7grSWuOai0xRaVYNw7xtgrcKA7i4QbkWf78N5Jg6oz/PsqY8t08L0K9GJbRMPAZ3n6net5iow=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d9b8941-fe12-497d-8d55-08d59db0f2c1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09673FFBD0A7DC4BD4BE9444FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(966005)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(6306002)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: CvEq3Hg5okf1JdLgx5MKEPdnxcE21TNMR0C7609BfsyKwX1OqE3lgKtLzxWemjBKlTUVaetQ7MvJu0hUFhMjaVPB7T/2nzwq3oIWrvr5ZoTGPo+5sdnHyDFgSEYLC8mE4Wj654dq3vbpgdK73PhxkekixXaRqWhHAwWTJ6lFtmRTmJrNf6uj8qIuRXMElrzLNYxhVUaIluaKUtXhzwXZLF8nqKvft5+J5p5iyEF7r6HoYSGEPuIeRUWo2w8Sp2VYGsvuJS3WU1tqPjOYqQdCzd1XCApQwj/3eNCnEcxPhtgw1/oDNIGVcOORGMwPhmnahTsmT8DWCPxXxc9NE32m3cYp9PZbTwHrxfKL7/v2vINb/52blphmqMA7pv57ZBMvxz3c812MDP34A7c4WthvdFMlvQ441uUqtkNM0I3WjSU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9b8941-fe12-497d-8d55-08d59db0f2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:14.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c133c7615751008f6c32ccae7cdfc5ff6e989c35 ]

We're supposed to exit the loop with "timeout" set to zero.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Don Zickus <dzickus@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Fixes: 99e8b9ca90d6 ("x86, NMI: Add NMI IPI selftest")
Link: http://lkml.kernel.org/r/20170619105304.GA23995@elgon.mountain
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/nmi_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi_selftest.c b/arch/x86/kernel/nmi_selftest.=
c
index 6d9582ec0324..d27f8d84c4ff 100644
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -78,7 +78,7 @@ static void __init test_nmi_ipi(struct cpumask *mask)
=20
 	/* Don't wait longer than a second */
 	timeout =3D USEC_PER_SEC;
-	while (!cpumask_empty(mask) && timeout--)
+	while (!cpumask_empty(mask) && --timeout)
 	        udelay(1);
=20
 	/* What happens if we timeout, do we still unregister?? */
--=20
2.15.1
