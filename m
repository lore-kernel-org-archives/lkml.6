Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481918-2-9017644195823702934
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
    t=1521481917; b=XYiQgMogdAaDtOlro79eHBQsXUbIpL4G/yGl4Iy7qW1WZtk
    8tgvY7lj7a98pkZnTMwmXPyBU8W3CciZUBj9RQM4IyJ7f0bRQyz9FB/YxbNaT5rC
    Qzx/q8UGpkUktR7hrixvm3o1/x1kfD8NZE6S9zWOzixIH7YqGI0kyi67Mf4nTuo+
    PCt5+ClmpWhAhv0+qURN+6PDzQDxmXWFFaHerJYWqSrWJ0adXOe/MfK5pn5YBx6l
    nESpo75ShAGSl2+RUtraqOE2PAUTphmFA5j7z9AtY6Kl2lWQ0d8oItLhBsGJRmeY
    nVtkExVeckyju+MRdbCp42hH3XhP3Bvbv0K916w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481917; bh=v+jtdn
    0Uwr5G6Qn8WcBX1sJYgkqoZH22tROB7MuJS/4=; b=GE6Fj7oawGIynJSH4Uo2Ue
    Qh8CyV1Hid6jFpNB7b1sJHLZtzuD9bO0uzBTIrWzyb4EAE3DiQBfBp+yJFHT17yg
    92ohZH54sLuxa5DGoaqoS+nBSwf9NdAfZSXg8UZgF2wE0kYlRTYUMjPb6/1HHE3Y
    IxPOW4BA1cbclLf96816d3ab5aNQCotlYRgSNM3ixfvOe2KZQTGFw+ouQxcOqKvP
    bvC1pJ1jKMTvRYbO3ufNclnK/ydtBAjFak7OmU1FiMhsHv3waQNN/fgV10xHnZ/4
    YwT/LpnbSP2pvg0YdoVMBIoK7qjPlkKaEUrMVtBeTds55fmgbw7NHI5FPY9Q+M4g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RcHDbnzt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehlihhnuhigqdhmihhpshdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegledvnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RcHDbnzt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehlihhnuhigqdhmihhpshdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegledvnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968294AbeCSRvE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:51:04 -0400
Received: from mail-dm3nam03on0105.outbound.protection.outlook.com ([104.47.41.105]:45007
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965657AbeCSQE4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 225/281] MIPS: kprobes: flush_insn_slot should
 flush only if probe initialised
Thread-Topic: [PATCH AUTOSEL for 4.9 225/281] MIPS: kprobes: flush_insn_slot
 should flush only if probe initialised
Thread-Index: AQHTv5upniigmZm0r0+BR63Q5gpPgg==
Date: Mon, 19 Mar 2018 16:02:20 +0000
Message-ID: <20180319155742.13731-225-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:DOmnijjNpPK2B/Wa1wbvr7HXzhTc1yQ65GDA3vogcapIBgk/sNtrix1Aup1/0w5LRpkT8W9JDHnrJrDGeMs1xL+dXoVbLJPcjFE2cfrMX+owblg2Tyw7UIUWPWydJzjO6ITvdUk+VZao+DUMOc+obqmk290a1eDlqscTpamSA+excDniUR1NKl8fvZn+8WqQowCK7Eisi2bAakz6hX41dzBARX0nEdei+4PTOaJv2v3CCltgVNormjeNKZyg/V06;20:p/04SP3YnOSWzab86Rab4OB1woVv+x8uXkkolEpn7VMTPVWqM0MrI+0EJdOU5cdi/Qd0+hWSfQlJYwUel7Cb7RxuuDAGB2/diKQV6UkSJbt2MHvVmBg/4jG5U4e5EhLoX2cSH4KGIkb4hzixok3Y9ksEX3HoWH6kPGggB68hSak=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6d726d2-4127-428b-ac17-08d58db323ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08053D72140433E5137D1FB6FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(966005)(66066001)(22452003)(10290500003)(4326008)(6306002)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(3660700001)(5660300001)(6116002)(6666003)(6506007)(59450400001)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QwFjBul4ehHi57V0S/1+AX1X7xCPHrv1KhuBSVB3y/82Y6fZVaqw7oGuwzA1RMByjyvR6n1rL2BCy3p+u4GuQ0nT0Lk0j5ESVnShrgnnowL/03cyvAHpzALb88X64nVyyyZ7wORstVoXvIsmsogcDEmZck3MrRsJJYXHvnCZv7ql+1xWmrMw9/2K7n2C/nrXwTGpxTPjod8uAH0EsFkL8MqzFeC52Qwai1hxrDD8TfJnll/wRJuwcPWUbjhWl3gkTkbUbcZuF/LchJCLTY3ky/qyIjJXxPlEFLHQoASXB4asLcXCrNZ7V6WBOzoEjgHJmkgU9hjrTbQftAop5+r++A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d726d2-4127-428b-ac17-08d58db323ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:20.5895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
2.14.1
