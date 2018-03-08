Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486355-2-7003990544500801393
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
    t=1520486355; b=p724peOE3aSA5TGecCeEkC20P/nYfLE4UXf0dmsuAx/7erB
    EKfvXUhlN9VEzGZIBtP+F/+llrrE9Hmut/T+w3gxg3Edt5WbA+oGY6AYGqp/Jd/G
    4gH8XxrU3Pl7GpuM4EFVxMEf7Dq/+C+KRcdQtxnFbnpxttBRwwDUq58XkWEW7mhQ
    btKdsG1QjIzYVegoh3cvpVDLvFWzIsdv5zLp2LCC8kgEcPeUWPqbnbv1feyvWOlD
    Di0Eb8mLXdYofcSDwf6AJj1SFVRijPRtA0Ms/izYnvTG5vaK4TCN0E5KFoLsHzjM
    x9NUsbYMoKJgRaVpnRJZ1rvTaOrK5o4+n02Py/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486355; bh=iDB/LZ
    ObjX2dkIXJvgdiQ7r4Ux8Pg9dd30LhtwMLHG4=; b=ubzv+hs1xH8SulMeqZowVL
    2fsc5d7BX6cQsz5pTvgjkxP28qiI8xTJWEznBZs9/Qra+Z0JMzj/6iAmd4Kjvwy6
    npRIsq/9BkwwdyR18Bwj9iC0THFShjyeulWVsviJEBDHwlLHqrKwpsjOz/kLyKyE
    TvqKJKBZbXTAyhc9QFW88yLNjt3TO58+65rgrM66/ZbeUR/K89a5U0YEUiZNYiws
    QxT2JoEtR24wHmiDg/4MuVGte2DSrX8SYCsj8pql90+cwSClAk26oB1vizLFfJYN
    oeF9QdAuoUfmkJhkpmR7zqoX7FxBHc4aeGxfzP2DWXM1W2gNwlhficwXTPt19gUQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H921L/qu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H921L/qu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966674AbeCHFTM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:19:12 -0500
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:43456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966714AbeCHFIK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 05/53] kprobes/x86: Fix kprobe-booster not to
 boost far call instructions
Thread-Topic: [PATCH AUTOSEL for 3.18 05/53] kprobes/x86: Fix kprobe-booster
 not to boost far call instructions
Thread-Index: AQHTtpq/9zkv3L/oskSGN4VRqWSDrA==
Date: Thu, 8 Mar 2018 05:03:07 +0000
Message-ID: <20180308050230.8876-5-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:NzT1wZKb6DFDGF7XG6y77t6I3oTzWPR55uQ8VQf1KjXj1O49lgY9suLF7cJX8Oci/JQmMiqezJMZi3HG5yIBBfyPrJMkz+it5px/KVZFbkYFsIhLWp34PG461ZcPVm3B76LLwvxsqQGi4cUrrk6BzcaK87ykho7mWRtFvKQ0q0tXQBVEKJXaiAr8v4kPHWifOYSvEGObKRIu66+UHT0fdeQwj0X7btKq5MmDFYNYko0ZrOAMzd7pSB7h7uqyA2wY;20:O8jBxA5dLdS5tq40xAMsi1d22uT7raWJi+OYG8zncLiDngmP4e4H0TG4w5/H+zFdB5sPg4TKLlSmOgttPJsdecdyCz6tzsv0uamx5C2CFlfPnEge5K7oAfcVyhxnU9WJid2Ok+sabHze5tjwXPsOe3sAX9KBX1n0Ax9h9PVTBA8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a31f6fe-81dd-47d5-ef03-08d584b29199
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072732E2F9CD47FD4F830B0DFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(7416002)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zbN4WPZjHQ1LcLVJ+roD3Xi50dWdsrGNE3LOeF1UCEzQ6mhJFVu4gUfeeraxUhTe69/A1F2eSCY7Cnd+FLofODoDP83UJb0Q+R9UrhxdXR0FbmiqQPYeOe0NacxT1N7VfO2LO+EWhLlX/vaAh5jaPdDpiJLhIu4Bmd7s2c10kKLDafhq02Hc/OaL5pSNapKweDmkAzhVwhSUMm0mzKYfvoe9PrhKLFoeC8CWWzXPdNIpm5WtNUEilEGJOzYFlqRnnmuzN8j5nNMwWkctYAg00Xs4VGbekzgZsX89BHASZAl/EUYmIReEhfcGPw63Ucppp+rQL6v6NQt8O/pSix38WA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a31f6fe-81dd-47d5-ef03-08d584b29199
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:07.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit bd0b90676c30fe640e7ead919b3e38846ac88ab7 ]

Fix the kprobe-booster not to boost far call instruction,
because a call may store the address in the single-step
execution buffer to the stack, which should be modified
after single stepping.

Currently, this instruction will be filtered as not
boostable in resume_execution(), so this is not a
critical issue.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ye Xiaolong <xiaolong.ye@intel.com>
Link: http://lkml.kernel.org/r/149076340615.22469.14066273186134229909.stgi=
t@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/kprobes/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.=
c
index b6547a441bad..422b76ab0374 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -196,6 +196,8 @@ int can_boost(kprobe_opcode_t *opcodes, void *addr)
 		return (opcode !=3D 0x62 && opcode !=3D 0x67);
 	case 0x70:
 		return 0; /* can't boost conditional jump */
+	case 0x90:
+		return opcode !=3D 0x9a;	/* can't boost call far */
 	case 0xc0:
 		/* can't boost software-interruptions */
 		return (0xc1 < opcode && opcode < 0xcc) || opcode =3D=3D 0xcf;
--=20
2.14.1
