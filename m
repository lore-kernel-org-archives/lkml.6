Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235861-2-4629904505938562397
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
    1523235861; b=TMMxcMJkqvqQBqKY0v3F+C3whNyDd0s8R/AdleM1MrZyQ85OYM
    t51n+622wwbfuCkwQFuvKOnULPgFMzSTdW6yRzOi7Ko8v+S5ANYaJ+p+Vgj//hLU
    C1wurjRPu2xg1tC21HjGgwPRsJNVM3cVWW5OQV0Ksl+Kvc+/TtduNu/mKsHb/qL8
    c1ShBD0m6TnHIuDIxluLHIqptCGswijqyIfOTtp+GCklyiNg98iaDsmah3UqEXmI
    alMwgRVYDeUljdxfwyzRoia1nPtRT7vXUTvB/ZfljQ97TYPXqX5797PeDyWjD5Mp
    EVompXgwwsYQQZY97mwrzKwmsgezf5ILQvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235861; bh=fO5hYRPcF3
    Gc7qg+DmbRLNDSUBftWJoCoPGykGQY4MY=; b=AG8RCUTuPQkj8SxHnkgUeakpcD
    Vxds2meLNwjMxp0vChM/+iVpRKS9FPruzob4M/iC1XDFxBsEATYDDsSEkfKTpc/5
    zvE3ZoBP7MJ0bRDcSbCpXbIXiLB/2WvnzhaOJKiYZDFFTK8EkFBeeRrwnY212IqO
    nhzYn26KvL2qfP/pX1eMQ8BAFGvcmYAwsY/HXtw6D12YxcGzqE75VgRr40T/kNSn
    qNPM9cuapSokoA5Sbehr5m4q91awz2J8sWxY1bIbKpkPeiCCbGSmr/9Szuq68Lok
    1X/FFJfm/CZZg9NgN54tztecK37pUtgjIt/9UUH2jkykvDLdd2Cq5An0OXkg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N+Ik7OUj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N+Ik7OUj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLGPN91Y+wTXwse0FIxSWRpmEiNmOBWn7XPEH6f2xu5oJ/T6c2nb2eLcuekiDFPD1OuUYJ3Es5/3hh20L7BpqcNDgFk9stgVbwTJ6lzd23WVAo755G0e
    oRQaPj4ktniov7XedaqT79dvhBo9+dtRVvFHefrSrFZm+sGKSNxWb1VFmOHBY6ZGgKl7sJVkoXAREPffowvt3DoLfgU4BbwKG13+QzRdWVNLHgvGZVh81wxM
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=m57dygxWIdCukqG92xcA:9 a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22
    a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeDIBDj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:03:39 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933145AbeDIAje (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 005/101] MIPS: kprobes: flush_insn_slot
 should flush only if probe initialised
Thread-Topic: [PATCH AUTOSEL for 3.18 005/101] MIPS: kprobes: flush_insn_slot
 should flush only if probe initialised
Thread-Index: AQHTz5qfUsgOVinZNEKvHjOKmlVq6A==
Date: Mon, 9 Apr 2018 00:35:13 +0000
Message-ID: <20180409003505.164715-5-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:x8rolf3Bq3yEJcV8mxC2CFXsIXjmNjdTC7REt7HlMwU5dY1BrsC0GkvkgB7JOpIdSFJOiW9xw8RarYA5kzsTCw+yYR9HGWPchU0Wrn0ENQkxjszmQMAPxbL4GAhloX9UkcHX85p11vnbHIBwmPSmMZ0cS6Hr2BHkBCXgoYXwoclBQQxn8wS3OmKo3p54+V2FhpbroQabWXOksMclDv5WNywCWEXGyixW6gLv5LyaMHsuNyZj3U+BPqBZZnhve+Ne;20:DNrnktSuKV+x8ULjzp4Y7jV3fjBEU1jGIrq4FVIkEqrv2eg8f281Seggi9V0+lKjN9HY1b+msBCUZ62W/X3r5V9FozNXZKIz4EiGoCuIjALhgPwHnK67Z4JAkvPKSYt6gh9JwOwve8M2qO5cQtPbBTB+nnGIMm6hPxDMMoiMDTE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3996fe32-b19c-4220-32eb-08d59db25963
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10470ABEB1FBEE816404AB1EFBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(966005)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6306002)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: l9QGFSWYM+3QExfKtX6X9FjKqueWAwEzqcCpYdCG+B6rTVIbfvNB5DeqHnR4Rmk8KiRHJ60hq5ajte/AS88eJq+qbxvujnWhChflJlAjSz41sI02wpcGfJScTjvedWUlg62tvf5Gb7KiNZNiy8hf6TjhKO3jQOActk4suWj7FfhhAHlz8DW5Etm7IMo1W7yC4dSS1irO+55ivHHNzdklyAPhDvIq7O5/nji39FY4kgSUn63r5a2Gj6G8zrJHH8g+X9oDf+Ey6cVhUaLr4VW38pC10XNZWaTsfaLlcmLoL8E+AAlZU8PSulLkGVZUXzfrgcp2MVgo+k/BNwOiGB5rNkkhU39rvpqRP5e8nh/Pt4cK5VZgv5gtZKOs7ylWpg2jKPEmUKCMU7Z8/JHX3t0KNMGa6KYD4qfIQcrSFb81dq8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3996fe32-b19c-4220-32eb-08d59db25963
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:13.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit 698b851073ddf5a894910d63ca04605e0473414e ]

When ftrace is used with kprobes, it is possible for a kprobe to contain
an invalid location (ie. only initialised to 0 and not to a specific
location in the code). Trying to perform a cache flush on such location
leads to a crash r4k_flush_icache_range().

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16296/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/kprobes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobe=
s.h
index daba1f9a4f79..174aedce3167 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -40,7 +40,8 @@ typedef union mips_instruction kprobe_opcode_t;
=20
 #define flush_insn_slot(p)						\
 do {									\
-	flush_icache_range((unsigned long)p->addr,			\
+	if (p->addr)							\
+		flush_icache_range((unsigned long)p->addr,		\
 			   (unsigned long)p->addr +			\
 			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));	\
 } while (0)
--=20
2.15.1
