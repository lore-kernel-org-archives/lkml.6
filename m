Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236048-2-2314660697052907548
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
    1523236048; b=FEK6VtE9EeKBOQHieX4sOTaZtObVwK2km3JZaacBIkP3DTxNpm
    92H3T6s7KMUtulUeU6PND8MN9qtXbo/Jd/iL/+fGKII3t3QuXqsgF7BMe8TxJDdH
    vPyyZIcrh2dwbO20zs2y47noh3XUDenJx9Hey7mtMYuWU9gpKY3x6xi9wJXiGEzE
    P6amjKA2leonxJVhsBwWZR+iXSRsHIflfyu2pBx5zdquG8IVTwdlqNEk+bMa+GSN
    QDGPLBiAlosdCNHcXZprrO76tEHwV8gzrC5wxSuKzrtiPEwLlEtIolwbmvf9Uq5y
    tmfHDCXijttdwoIIYC3Rc25hi/CvQDkIK5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236048; bh=3CsGGYx3UZ
    A0JDYv59+IeM6eL5AWmAw5uJHtyZGlZQ0=; b=m4cFoSqhtoJ2i+HA90JrvImSd6
    Zd/eBLSnsciPKC+dkEdm2ZbSht2gC6IJPGsHGfqOPoBCm6Edbd+zv2mW5vJqdx0K
    OfVPRkcckC828SMmcFVw1Qs+F4eabYyjdddVzVYhiclSFTC4jzUFofr7Q0c+KYTy
    +PpBAZVggYddfpD81bh0A+NthoUdqmZgJK3qH4kwR/4ci36wn84g7sqiSPzNOqr7
    yGSkFbYIxkExS4zz98bSVlc4cwpcAI2vXijBCxMLqFDUp1TMeU0Wcs8EAtAXo/xG
    xaNdq18s6cTtq2MsPSiDsjR0oZJ1VJueorQmZOcm6qPIJruefwiPFz1B5hZA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WKLHT+sW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WKLHT+sW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM1KBOvGa6ApoUrqKgNtfw3mCoK0LRRJI+wyiJujesOnBkaYCD8XMeJsfdWk+9UuvhXo2EObBnSCxNeEbv0cAqu56LGjLyivQDISy4BCgqPHEPC8WAQg
    F7r6MdnI8NoS8wgLW1KzpBHFMQ48k9x7B1UpsOQwpJgaHpz0ibK1S+cohLOfHo2z6vEsXfKiB0XJCFTvIXmg5i6xZav+9eN6Mn5/oL1NcddaXLfWdFaP0TMv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=KE6AYRTJDb_r4OeTZP8A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeDIAjV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:21 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:37663
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932150AbeDIAjT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 152/162] arm64: spinlock: Fix theoretical
 trylock() A-B-A with LSE atomics
Thread-Topic: [PATCH AUTOSEL for 4.4 152/162] arm64: spinlock: Fix theoretical
 trylock() A-B-A with LSE atomics
Thread-Index: AQHTz5ndWKyNBLBiO0KmDVG9mTfa6w==
Date: Mon, 9 Apr 2018 00:29:48 +0000
Message-ID: <20180409002738.163941-152-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:phFJrejoBIx9YOkIsOY/oZwNTQWYNQ5K+6+VERVXLn9e20vRbHzR42SeSvKehpQAV0VgN7AJMkpY7qVkm/xGH2u7qqIpplD0NjVdw1Txt4OaKSZ7DHMYl2h3v8daefJkFrCajvXdFJaKCSycuM/7OZxXWEbF5k+pbKwUeN50j8g6WGr/mpH0/+ZBNjNm8o74f0MDvMg+c+diZ7H3c88LTC2tG5APDhi6nEPPgZPRsV76/ixOV8t5w6US70S3Roni;20:DPrGhEGipKbECNben+rSePzk4cGjm7H6ai6kcQC8hbseviSGZ5ItZe1mr7iQPIoyU8T5878vftveFR1DrLdraONc9cmuv0nwKATivNYBTs6PEzwtqf4flSBrL/Z/Cpf+xdTUBiQfcvFEMs2fS5ru3WpaeY8zNkcXjwM9ArKpjQg=
X-MS-Office365-Filtering-Correlation-Id: e720bffb-60f3-4df4-6f7d-08d59db2542e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11253C8C09E2A866EFEEEBEEFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(575784001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: AtGrAFekcxKhLAPdEX2lPn/NyDDCYpAVc8suW4uLMW6Ernh3bb/gwQ3/FlpURu9My5/M26EWLRrf6KYlwawK1w0xwKtkKZXbofhBvF6eeoJEvV/7kp1g5wU2e7ewzeIbR83o2MhDrvcqb6/Jj8bAkbKfPhwhcyv0vEf+dwEQv/P8nBpNT/pwCmptzsdb4GrLj3iXOEYkaOvDFY69LiyIiFfq2SbMMSlAuo4kAyrms1AQ5xKPzkK96dOdQJeWksIg9n8EJqFBRezjrt95PgymGzyTe2Jx1sH0I+rvIRZ3rD1gu0DBdZePd7u2goXoZeeM+MxJweK16Q7VbfKvaEXIb1hRn+8Y7DkntVaOjH2D7m+9akYD9tPYJ8vyTZm2tvVYcj8dEKPMWI5YJlIH6BZ8L+JzNUanis6gjQbQxjRSH9w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e720bffb-60f3-4df4-6f7d-08d59db2542e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:48.6933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 202fb4ef81e3ec765c23bd1e6746a5c25b797d0e ]

If the spinlock "next" ticket wraps around between the initial LDR
and the cmpxchg in the LSE version of spin_trylock, then we can erroneously
think that we have successfuly acquired the lock because we only check
whether the next ticket return by the cmpxchg is equal to the owner ticket
in our updated lock word.

This patch fixes the issue by performing a full 32-bit check of the lock
word when trying to determine whether or not the CASA instruction updated
memory.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/include/asm/spinlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spi=
nlock.h
index 499e8de33a00..fbbd7fb83fd6 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -94,8 +94,8 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock=
)
 	"	cbnz	%w1, 1f\n"
 	"	add	%w1, %w0, %3\n"
 	"	casa	%w0, %w1, %2\n"
-	"	and	%w1, %w1, #0xffff\n"
-	"	eor	%w1, %w1, %w0, lsr #16\n"
+	"	sub	%w1, %w1, %3\n"
+	"	eor	%w1, %w1, %w0\n"
 	"1:")
 	: "=3D&r" (lockval), "=3D&r" (tmp), "+Q" (*lock)
 	: "I" (1 << TICKET_SHIFT)
--=20
2.15.1
