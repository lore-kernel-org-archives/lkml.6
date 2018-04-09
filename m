Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242031-2-4981150339410932232
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
    1523242030; b=g5WL3QvMU46MJ3be3Sdn86i+TKcpPAMTtWjpmaLx1Rc7iQqz88
    7FmuMrvBGN0wsOqgVbLQD1j1/+nla93XuJ5mJLGrEPYCEOB6qxI6YO1WFCLKLNpO
    cK4vkDiUmEoCbegukAHwVj8mZdmTRci1OpHdls/g6KmahS02oQJRq6JSu73guE0u
    xop3uOlE4kqAH0eW/YkfBizqQWjcLJxRDZZ9PP3DnUdhkbdG6X/awAHwjBGyEb5P
    oV6HLMBcusK6Q/+EF/n+XSe8McxoqlJic6kuiYHAu89IFNqrHPuG6pEiLbZZl2q+
    95nMY6aYSWJNf5O1eaJEJHFAkO6nOVuULK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242030; bh=fO5hYRPcF3
    Gc7qg+DmbRLNDSUBftWJoCoPGykGQY4MY=; b=meYyaqrP8HAQhYSCifTYMAKbqf
    IkzpA8gWi/XY0eSGYvNhut+OYs69BQHNIoQSxFtcrCfWbG3bf+Iv6XJU+mnd3WZz
    +3axDS5G6jwp0Mc2ZZI68aP36RfWI7/Ne7BIkU+VWAPMRZ136iyuSZf71bHFZuXi
    NuAcrNOrJmXUdq8oBtgDEqbCU3+cjAJ5peV/tf/JyvwcMrmpeEq7+4IAWZPmbS8v
    dW4rf4pTrihELrwLxxwGA+HCSfkJUQST5Jf32zvSvDZWYN79uebnAt+/MIDVx5wB
    XgQvFQeKC8H9iLCExzGnuYKuICDWQXQN9jHRMBQ+sXBB8R0XY2GnRE7mbRoQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O8xlMOaR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O8xlMOaR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGbpd00xOy4mk5TLrJXYko+VrwSVHS9qGxV3DP+TNPSZQ1uK7uR7wIdnTvnBXQ8EmOAjelAaOncmypn2DhMhJ3Ndb4o16EJsUuV/8xb9eiRf5A+TAt1U
    ao+YfIyvuy7cy31o4BHL/Ka0DYLNvBvu8FJSfXmKptmVtPS6bupQmoDgccQ89dcXoYS8JcTSN4/Ufs8A6h12EM4KrMhjYCfjZeMFNyTfeosfQGW/1+x2xafk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=m57dygxWIdCukqG92xcA:9 a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22
    a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933011AbeDICqh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:46:37 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754613AbeDIA0l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 009/293] MIPS: kprobes: flush_insn_slot should
 flush only if probe initialised
Thread-Topic: [PATCH AUTOSEL for 4.9 009/293] MIPS: kprobes: flush_insn_slot
 should flush only if probe initialised
Thread-Index: AQHTz5jnNpNo6d8vfUWSLB18nGrY1A==
Date: Mon, 9 Apr 2018 00:22:54 +0000
Message-ID: <20180409002239.163177-9-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:Afu48+naUoc+ZnViNY+20BGvYAiQiDdwY1vNwZ5SC21xywmY/esUNUziaW80HSLqSvedE5+8VqTonFFIfc6QmMSkLMRCti5q3WUwJBQw1vmmzBH09eneJwXULEEwta7PrEMsgbTpiqAQFPT3wyr3lt+kv2dG4CdWgEB2Fxt1LeKaSBwOXC2/u1l6olDyruGZ/Ye0OVz11SxJjxDxz9WZfCt8UglXNoRU84Ofxevgzwde2Iw7Zhybrlj+S7vhKIG+;20:LZC32FPyFh2qtOfJW08ZGHGYMm6e9EmqUStSyMfZLOUcXlYijNPVEIhLNp7wmqFnsUw2W4XaE5J9rjEY9fjVlDJNZbs7d3BYfZPPWEWdTr6psREW7+BWs5SZwzplEeCVVJSyORDU4iJOELT5WzRv7k1c+ySh7nSnI/O+E0Gdp3c=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55e7b2f3-58ad-47b0-ad7c-08d59db08d3d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015349DEA9E65E0FD48C18EFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vfFjxEJSNoQlpX3fHMXq15DyCZAX/ymYh9KDczFH04tiPF5/5KyHlVbYNwy2ZdaZ4fOFeseS8nYpI+WxzBb3Mf+Im1tTi0slGA3eztQ4tULGgNZaLxbv9/v4+9ZKMIVtbmCP5atTkK4XXzdzB6oG7V2NNpscjKMrVQucG0ldY05GGjeBHR0H8anY0nzB5+anHPfz61l7riRBZXfncO87avxuE0NtrK1PDH2OkWWMOHlE4Ihbi61XN5pCqam9nSyls4FnzYkbBXZL0aVsLkbB+C3euQnhlV2FoHRX9QTsUIi/nbhRFxEvRPCkL1pCLemqy5CSCX27NIlAyZ1iVQMYL3p67LHTx69/2L8TSlaHe4X32L9NE1vl+bG9ZSjO9yrQQtNNJbnSZTSktW8GQnj4KRe3RF9J2VLnkkjw0ewFHFY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e7b2f3-58ad-47b0-ad7c-08d59db08d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:54.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
