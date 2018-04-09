Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236822-2-851083626923036915
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236822; b=saIQxb/qfD+Ax+u3Aps2z1APdwxxhvxvCUivJ6aH7AIVmL3eso
    M+/4AuP+YE/XRbTkJKclm85FKJQ9awfJ/OfALdFiecBaeKbtWijCDd1SuyUUi8EK
    Dg7gPkRv4HgQIRB9KVmBruN22qHL/zBfpAdVfq24eDxrXPEPl1YoLec5sgj3FMql
    T0Ls+oOYQkpi5I0WWKpUD4NpJxeJnNoD9ye6GMgkLiBnz+NHg0cZuojFUTdBFUok
    /n10sBa9fSJgCm0iakLBs65LVhDjoAYz5x1pyjIXWDR0A+fqZnz1DWNWpafbi/O7
    LtWBAPVc+SpvqSJTSqFQMIBf2j7FgqrFRYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236822; bh=MP+/8BxVNS
    GtHUGYQ/4K8QQsN5S5VCckL9bw8tbWKa8=; b=OrhAev2IIuOUmAyRFnJjP/2JVU
    raQZhnTDgPIvel4FSX0Wpmyedv9n5KSOv8NRIS5nuc9e9LDBwJGBujbzYlIMUkTx
    gMoq5JHrq7Lk+BGIt17519gqlMSzuGw0GWIWQ0hZR+ao+Y/rXTayV5ZnKjspR1y4
    okdZl+w+vt2zojaarR22jfjVMNUZSu655m0bO04qBffGLf0itgaFSUnXnXlgJQFB
    E6qrjbie5rJ78S3ZLTy4Csp6Lt47idQYkjH12iQfJ81121Y4ZjAjm4ZOjH96pZp+
    k5jm3nTi3ftArEC7jnd7XOMMxPheZU49Ox9sJpNepq8eMikBXN8tvSciojcg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JUWHZg/I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JUWHZg/I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOYCp8iRiyn3bEsMTmjTZ2qsSi9v5NnL3f4heTytfatAVmOMJpyhbT4mrDIo7Oz72BJq29SyQ5VS8gG8ih3mifBEO9zvIw5cHq9qAJarfGXdL2lLJLfO
    mp6M+yi1gbMa4oFGTvjd5LaPlmsCE/ILuYthOzK5EvLYfarzVmVY9quxM3EfdsJt8QbI3FcGw4YYk6LNh8bg7+84Z32LNsbISMpFDjAIHM3tz0y1C0ny2oO/
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=ojX-J6kMAAAA:8 a=FP58Ms26AAAA:8
    a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8 a=WDWmO1hkOOqwjw2rlA4A:9 a=wPNLvfGTeEIA:10
    a=BguqnwdstJzJTnLDEKlY:22 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757214AbeDIBUS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:20:18 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755949AbeDIAhn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "user-mode-linux-devel@lists.sourceforge.net"
        <user-mode-linux-devel@lists.sourceforge.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 094/162] x86/um: thin archives build fix
Thread-Topic: [PATCH AUTOSEL for 4.4 094/162] x86/um: thin archives build fix
Thread-Index: AQHTz5m9CVKTePg9LEyqf/SSW9e6pA==
Date: Mon, 9 Apr 2018 00:28:53 +0000
Message-ID: <20180409002738.163941-94-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:MrNoO/LES8EacR1M1afzPoxpeVsx8UV1TG10eGJdJm94WuJqaJhspXXrDblhKw2PXS8NampxycQePKw5r8pZoRy10mTbAfkYVYu8UQnp2mDtYukKGin/fO165zx5gsEDKmge9Vl3YslIV7bLITOBbgxru1G98nHu05VOoP3F8U2D+0smrOcBbGnHCr1vd+0cungvofqTRBgyKgIckCP8xLbk9dJrTKx2r/ZFmQHenJGfWFhPp+9Q3H93rpQSZkso;20:f0u0bnpa3VtV5vYz00iHYb4PwEUU5N5SFtvX2IL+S5LgDmwujSMpzaCBAVsmYi4k8Vafjrk1saTwSkEZ/+K2qhVlDA87q7Gb+PU/+2067LEJYxrxMei3OHKwf2ynzkn0Dm78z4Y7NTS5H3HdkB8otx1MkztePyCybhwv//8aOl0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f72195f-2b5e-49a7-1653-08d59db219d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031CECBEB3A8FB6692B7377FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(143289334528602)(28532068793085)(89211679590171)(85827821059158)(42262312472803);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(39060400002)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: A5bWf4PloVwbTNQXUiZXzPyDMiPD8gVoiSvq9OHhMFlX+lFQPOofPmsw03WnVdVgLo0AE2d7oRtT9GrhxJL/XYXWQUjhxf/k1Y63+wthO3bn2ikoj8Id5NDOj+lA2/0iM/8ge9Huwg69DEArlp2C4OTMHpNsOAj95R9xfIH2gmSRCsygLYOX1ilix1PQaIoLYllUk3IBu5KVp7IdavhOiP4I+aQyIH+kwBOdYQY0iVLdbg0zArZ1pNKBfdWGCm/QRrx6cF8uW6YztlyfW48sQqNvlR1mFWQgJ3i70Dw+S/msPxHQ3/gcjnS22sde0HkJakZT7dPhd6SXle1AQfq2w4mB19zjEJMB6YRMYqSephcrEoqA3P3xVO+DdthUFKP/Ojw0PWYujfd/jousXIcfbBM43L2kZOFwj4YoD5xK83M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f72195f-2b5e-49a7-1653-08d59db219d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:53.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 6c803ca49b5d..486f62c3bd04 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -50,7 +50,7 @@ CFLAGS_REMOVE_vdso-note.o =3D -pg -fprofile-arcs -ftest-c=
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
