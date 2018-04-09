Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237093-3-6185629444362463924
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
    1523237093; b=Dupc5Mbc5/l2OEnfMN67xkd584zyIVZrkS8DhxTMBaB+DTbxe1
    yivnVNBZhgDDC89cm0uE5dZ8oxb9x4bmof6pJO4JLXXdUP5qjUDSPiJ4NJyMgBpu
    8rA3aJLaBNpWwrIIcvdvChERQ1kK0rrJmin4/lZqFu5Q5Dm/GyPxuniwekNNFFnr
    GPlgWGovDArqCRJM0+uMw2YuXLEEgL8kG6hv8N6CZ79GSFyUKF5oZLSJv8Aliofg
    nvW0VZhJiUSppZbfjeu5BfpIdBGBxcXAobpLV6mwTHzS9f1Dd9IZdZVVBTaEYbgl
    a9cis2rBt+TVT1SzCUaTox8ZZ5MdxYZZdezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237093; bh=fh1nGx7r4w
    KHQJciGz9ZmgwRGgrq+L2or2lars2iZTc=; b=UYk6WJaTeiPlhpuYbnCrpTEohZ
    wn7MnrSiwEyBReKSkIEc/Ufr2xecWPrQnF7Mu1CKWRhZ3+8nhVwZCUkhRuJp4Wtb
    jCegcNn+Y5g6SeB/N0hHxv56iY2+roBLzM2dc0fBrF1Rv6HtDWPs42ePe936FjYF
    Lk9/dJ5Wdhxg9ilwL4FHzOlza7vTJtiywNlovAsz35Ma8akA7HIHTsJKLUQvJzrp
    p/fCQ2KrtbPJIQp2YE8OGGWTWmuGIyETfCHtRixze+jhFYLAy3EJovG9njTYaBtB
    LDWilMvwNBGW+f/Uui3L8A7dEK0TSiatphAf9VQN/f6OMpSUY2npwVcg4u2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PSeF/wlA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PSeF/wlA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMO+Djn0i2tKUw06ILlC0GRZnIlsztA7OnXajrVCf4e9KKzfrmZnAuy4HWxGTrgMNdzKdeHA/onfW8SbsoQvVu1VUI1mfd00aU8SMmBcD3FnzKajdvex
    uD/Vmj9w4C2vTdW/WvDLrzvVUPeyOofxxTceU5o3KUXyy8PPJvj6fadPUY1iUaRezyuYpz8STILPsNayoQost/68RQkIjrpr213fY7N3fMdotnV5eGayUBSH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=pt_rnBhcAV2n6HQ7sq8A:9 a=wPNLvfGTeEIA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756856AbeDIBYV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:24:21 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932708AbeDIAg7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 072/162] arm64: pass endianness info to sparse
Thread-Topic: [PATCH AUTOSEL for 4.4 072/162] arm64: pass endianness info to
 sparse
Thread-Index: AQHTz5myOU6SHEILQk+uRKLvjTYTsQ==
Date: Mon, 9 Apr 2018 00:28:35 +0000
Message-ID: <20180409002738.163941-72-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:F36gQKHhbSG+31V8wFsmDwD52GxdLloKPWffApEVdURLyyJguc6t7ZeRYZ73dXnmVdRl4oZ908r+MxLMn+51j3e3tHwgK5C6ZkD8aunb52aL8QdYCsL6CUssEbtCl1FICydTSJ3bFH9IWa29fwMCZTSyJjMrK2u0frxFqUzRqndg/v924cztgC71+k3nNRd1nEDNYDD7pyRJLI83PVXpOKj0jsnoR6CxSkelBQwowDLNajhSCt0agLDEppqYT3BS;20:AJrfOeXDal87s9znLyFl1BXrBzb18O8z0Gss8gEc5Y0CJK6lnIR/EYGxoJ3BIaz4iTAiVejlf63ykbii2IDT1084xBOeT+Ue6qBgawbxFVHuWDLRvhM3S30ctCQ0h5eVgtlYiVPpwT9ruW2byCi979Po1zV/0ZcGflq7naPKqwc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 347467ca-da5e-4000-23c6-08d59db1ff48
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885E34CA585D593F57C597FFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(39060400002)(3846002)(6116002)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: W4CRGzR7DiMwU0Pr20FIFAuxikP6hUa8xg/tPnm1CQluf3wMOTQcXJKMD9ES4FUr/qxcYojW5N5QL5Uu+7mLnltnFY4AFjcWXfssLIiahQ/7L6aytV35BH7ZY7qO8/tgWwnNZCNZK4jwfTZPRkYPCNqFOGTEqMt8Xr70bis6WoBku21tQ/s+T9HXFefTiR51Tk8uvQXrCA6Uzw8bRRAU9LaQkm6/GT/Hps9gg3CNVokjksOugeGTOKTuhRy6swdu9wCwNAk8Gxi3vSsWu2txBEb4L4ieZ6u62KYINPrWmTlop43HATcDL/6i+tdqyNdotUkuNQ1V+rEwMPmgJ3bQ/SG1iovpuLL+3+AI72ZXnT7oOPI0EjdvCe/ktm8toW7QWqz8gcfxJCGQHnO2sgEbTMt6cLS/eRoWdCbASYMstEg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347467ca-da5e-4000-23c6-08d59db1ff48
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:35.9270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit bcde519e8c325f3cc1fcf443eb6466e6bb3a3aca ]

ARM64 depends on the macro __AARCH64EB__ being defined or not
to correctly select or define endian-specific macros, structures
or pieces of code.

This macro is predefined by the compiler but sparse knows nothing
about it and thus may pre-process files differently from what
gcc would.

Fix this by passing '-D__AARCH64EL__' or '-D__AARCH64EB__' to
sparse depending of the endianness of the kernel, like defined
by GCC.

Note: In most case it won't change anything since most arm64 use
      little-endian (but an allyesconfig would use big-endian!).

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 119d1885a3c0..95c667328b5d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -32,10 +32,12 @@ KBUILD_AFLAGS	+=3D $(lseinstr)
=20
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+=3D -mbig-endian
+CHECKFLAGS	+=3D -D__AARCH64EB__
 AS		+=3D -EB
 LD		+=3D -EB
 else
 KBUILD_CPPFLAGS	+=3D -mlittle-endian
+CHECKFLAGS	+=3D -D__AARCH64EL__
 AS		+=3D -EL
 LD		+=3D -EL
 endif
--=20
2.15.1
