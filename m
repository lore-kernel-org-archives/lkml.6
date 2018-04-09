Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245293-2-5866133692178230861
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
    1523245292; b=S2yPD/LoO0cub/Mk0gqPuTjHeRQExe647GWOzV9c3HtajezMmN
    RcEJLY8dE7PPnJNIJDJiCROx/8EuyQJn6JzI0S5xtWyyRAnQc9PJbLy9cBQ3PXJ9
    e29fksJvuX8YhuU2kilwxJ7kE7OQ/6wscq4NUO5Oe3x91X+19VFfI6UIRwdiJrkl
    4iSzb5KkoE7pllLTOb2WJEjlyumS/kaLRMxINFUqvXSUWwVVsuqf7G+WoVG8UAWK
    yhg5plVmMC7kZJ98d2nJzve22I/nYkRf1eQuvbduVqYnnN4OOEGukfVoLpaQUugG
    wkzaRvB+DNRRbTlI+JIGGAgymKpJehUsoR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245292; bh=EI7gpy5sJQ
    CccRlKHxeKKWWWMnOip8HrDdweQE4PcNc=; b=u7JI1HUiYb9U+PzamNCXSHUo8t
    6EVXrAmC75xh6i5tcilEyVjg6ziy+vHuyGC7CQNIfRpNW6YVuA2REyLVBVurOJG4
    L0gjVsrs/XbTH3CUe8v3FYH4gqxlScooYVlNTUNh8/r88lRQDEHxZvr9jTszNJXs
    oy80Uk/mKXe7q+KAddMGdFJMT1ArT42sRyCuqK73et95kk2kRvKpzPJMxJNvkC9N
    0JTvoJgUIRJJMru6AUTNcenlMTQ+CHvki/4bk4ypXvduo0IP7pHEVygwPLbRNxVU
    EIZg8vTISORlM8SGSWKbYD7E/vp2SoekpfQ+YxxqD3XrKMNlHRQD86tYICcw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XmwsSsUN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XmwsSsUN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFr9pHUH2pxyh2dYSjtznPf0Pf27JhbsCLjpu13YERAWFzklmH4N+k9n+TqtZmONZpVu/SmFD/+hVN/rjJqy771ZE3oLItbM8+Krd4UVfQsuO29R9HHP
    yk4Nwh+WA7EpkeXTMVHrWRS/sEHRg6HISPuAnFWToLeYfoctKGV5wONLhy3Te2NBXDCIm10H4Yj+erTnxOsvZatsPDKFmNZDbv68bwFaFgKzPle62m6jg+12
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=KE6AYRTJDb_r4OeTZP8A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754358AbeDIDky (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:40:54 -0400
Received: from mail-sn1nam01on0130.outbound.protection.outlook.com ([104.47.32.130]:47481
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753095AbeDIAVG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 156/189] arm64: spinlock: Fix theoretical
 trylock() A-B-A with LSE atomics
Thread-Topic: [PATCH AUTOSEL for 4.15 156/189] arm64: spinlock: Fix
 theoretical trylock() A-B-A with LSE atomics
Thread-Index: AQHTz5hXrnHqT7NipEi+j2IpHQkKWQ==
Date: Mon, 9 Apr 2018 00:18:53 +0000
Message-ID: <20180409001637.162453-156-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:KSL+az0CvQISkJdcK3UohJ1kYS+DJNXPsk+F8s2ijjZYt/VngH1vRUDjcqpSV4JlD7E6fzBMmQ1Nx0hG0ckfX2U8IRaEpbHuz6FlJGUou2mpR1Af7uv/6I/JCgY7qZOewYrEjDK/Qm83LJGCcmfKWNcCnn5NvXvGU7zFrEiLEQJRARclwuQyozL87aRcZ4f0u6EqBXLgIQQOhjn9RFBtKkvHRcAKSFeoKg2+8EJVWpvfIP/AEb9seXaCfdi7kJ4w;20:HlFQHDpy76vi/y81noRsdiR/MGHg1CswWc68oYq6JxKKFchHlOfkxUnNzI+ERMq2Bwjst7RJro9vC5tvGbZsA5QJ/0iv5OWWUDAv9ullZ+XEiCjxHHwfnUap/iaaA4ESKwdm+EMjMw2CvmnqdXwGZMYVqRJZN/J3f4YDdIlR/A8=
X-MS-Office365-Filtering-Correlation-Id: f48875b7-4507-4501-b416-08d59dafc5a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920FF2CA576C29B97FCFCA7FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: WyjfvOSQtdTAI7yQScZF0qo/5LXZ/4+l3RxFaop5EXBuOBMqoToaCgzUPZm3REhM/QdGf/ksBc8ItkU2Lbyrr6v8f6mNQ3tusTfI23L91FZmv9he92axoWQrFn1FJf4lyZQeAX2rAQRf4hxUWQsKPG/1ZyHCKxHKBsAMboBFmEmed9bvB6nhGZsZkLivkiq084SbYvqFteEzdDXzCMRqTui9ZN1Fm2yc0oCWuJuO6VornsmcP5ZxNVQP6hNVwUKbMzxR5nEQbDkcCSDtuHfi4yru+FoPDlys48M+gUUIT3oRTDRf0f4cCuHPiRTy6GD8Ln6fD9/iNbsN2u6HECpBoJCPD3qZo0MLmC3m/1LWRmgNo7R4oi+PoXbkVuG2pevQWDTAMzdGct4cM64nBCZIYlw+pOXUDesLa+r9e1Kd1SM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48875b7-4507-4501-b416-08d59dafc5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:53.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index fdb827c7832f..ebdae15d665d 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -87,8 +87,8 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock=
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
