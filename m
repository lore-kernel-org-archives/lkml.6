Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239498-2-4470861271856424662
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239497; b=Lzl0nBxK1/lh3QXdWsBCJHPHJ+wjee+bpSqbvOsz88SnGSApKc
    mzZUoKYkIt/XVvDHH3WkOiBUf/WPR1z8dn3mKBMXnfB1AK9BmUWWMfhgFAkDkXLB
    sYe3utpk7bVLK3KPWvloEDEQRGYfxUrHwr6zySyOxmhcu1aTh3L/vxkPhZeGW8QD
    KrFE9Wpln86NwHFluc8kbOVkRq3dLF3lQxpCX9BVoLVcfuX4Jey/Pcc1a/sTNzwn
    MfuAOttonS+7KN3hY9l4QnueILF3SOStKNQbu+hSPDYH3808mzg27zm0keIlEsF5
    QC/37dua16BVRysKDH0ncM4vgEhY/pIsApoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239497; bh=kRi7SD9mUA
    hZnbYGT2QMQiLJAd4tRqQdnS0YTPYMWZ8=; b=DBDZHHmy4f5+hjfi3vQft7l3GV
    KShfWmZHxJ1JfdhtBf9ZfVLD3uvHhuTcGQO2k3wFEyk5NhGGcLoM4Qaai7+LIm3+
    HHOBSf81nkn1akGENmqsDMSCbXbhcZSAWR9UojIERkQ5X9wOvQ2JTo0ZBgWZR4S7
    rTeEPnbYfkxpPlamZGDajnbkOOGYDlpBcZQCskKCstrFIxIL3oRHCfvfzXUEwqb0
    R6P7ABbIc1XUHPEAouuRrGXO6rRviZ4DOwuK1jruKGIhkgZrtIIXQLAJ8dfQ4HPn
    ejOEo8Hr9ADapCnCFKvSind5YC3SiKRRZya+UW7zCJGfvHx4MxxQQYwLK+Ww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=giRUKNrK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=giRUKNrK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC0qt56/9IyJhRK5kFCnyUR0gRj88ImIuvSoo49nDCSuyss1oAlGEH2F1ywX51c/8SNIntPNM2k+OlfiPQqR3HWPryJ1C9HHtNZ1Q/Oatl+4XdVA8/cq
    NnralfADBx7JcDbqHMSrzMUNF6UsMOuUUG/eHM2+s0IDMAlzhGkW+/wMA+LrnhZLIQiJvf738lVCQInbyFgTqQZHr7Ancl95oRUSu/92uwbIxhcCplwU17LW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=ojX-J6kMAAAA:8 a=FP58Ms26AAAA:8
    a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8 a=WDWmO1hkOOqwjw2rlA4A:9 a=wPNLvfGTeEIA:10
    a=BguqnwdstJzJTnLDEKlY:22 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757115AbeDICEl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:04:41 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754093AbeDIAcC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "user-mode-linux-devel@lists.sourceforge.net"
        <user-mode-linux-devel@lists.sourceforge.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 187/293] x86/um: thin archives build fix
Thread-Topic: [PATCH AUTOSEL for 4.9 187/293] x86/um: thin archives build fix
Thread-Index: AQHTz5k+jUc2nlP57EWXofp14LuuDA==
Date: Mon, 9 Apr 2018 00:25:20 +0000
Message-ID: <20180409002239.163177-187-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:J38yQygxeUr5r7V7+3d7tcEGrIpiOFHN94d7FtJhlxxJVpaU7Od+Q6q0Zq39WX5/oEsDA/c1O78cSGv2rtRw+mtlI2KujJHk/qnvmreqcW8awCP45PT54tkc3o2/hWuBoQmbSpVBrWkluMX6Lcp6SP71aT62YeBKJyvpPgJMTWcdD4WyikycR0pg7F/5oFGnb+2ckV69LoOvhIuFg4WVlae3Sj1p5kI6ly7TE6WPSzm63+ilamJN23ByQ2sRNKjp;20:JLIv3Z4d3BsuGxvcGjlP6RtlbE2Nx+2c31lfjxGV68g9tg+afXV8olcEDnzFW6AwRFBZUhW6DQnptuEjAImghpFrWW0sbvdKmGqN8K1esjqxRJNDBRKaCd5T/bDYevw9+HcddiTsHwzMEv19jrSAQPnnj08QbFCdDG0HvNNucWQ=
X-MS-Office365-Filtering-Correlation-Id: 1691b48d-c348-4b3b-a384-08d59db14e1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1126935EB958E797E2ACB865FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(143289334528602)(28532068793085)(89211679590171)(85827821059158)(42262312472803);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(39060400002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: v5J1CFfUSU8btdrX63DhY+nVlG5Wc7wi1bFVSIRBG91fzGb5KtmArzwFnQIk78FSLaHC3RlX5DxWBbkgBstHL28//XHM7F/cuduEjBgUBePOBhV05Hmjw/ydlQrEqDG+EPWRy3fkMGuHVgJyLH8RGRC4BogWF2XvTekN9Pd9d1qkuechkX004zjFitaTTjJz5abUtADQ1uHSD2zTl3V4bRMaE0FBy3hWJ6JmCDObB62kHgstAnsZKduGwqAc+2KWdBQvSf9GPyY2c+JRsalaTbjtz1CGwMXxkR5ZAmEHez08skKBlW16Nm/A96lXLBQrfwcpGJKzNpTx5SOfiIWYrN5C2qJNEjYN+UymecucewCdV8Sx+rfrwVirrJcdqN+8OSHPROk7TBVn6NpGhTlmxGVaS25UF6cxI3V5QQRVNKI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1691b48d-c348-4b3b-a384-08d59db14e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:20.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 827880ec260ba048f95fe646b96a205c394fa0f0 ]

The linker does not like vdso-syms.lds in input archive files.
Make it an extra-y instead.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/um/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index d72dec406ccb..329406224330 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -53,7 +53,7 @@ CFLAGS_REMOVE_vdso-note.o =3D -pg -fprofile-arcs -ftest-c=
overage
 CFLAGS_REMOVE_um_vdso.o =3D -pg -fprofile-arcs -ftest-coverage
=20
 targets +=3D vdso-syms.lds
-obj-$(VDSO64-y)			+=3D vdso-syms.lds
+extra-$(VDSO64-y)			+=3D vdso-syms.lds
=20
 #
 # Match symbols in the DSO that look like VDSO*; produce a file of constan=
ts.
--=20
2.15.1
