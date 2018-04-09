Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238267-2-3319159843373476213
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
    1523238267; b=V9WTMFyyF2UTLsVgEWYnZ2YoIHx5wA6AzM0KE0Xm2xsp9vUkDq
    Udy1H5aJZDbM+sEG9fllo6n2AvsIUWRaU+SlTB6+4oFc6iYWm89K9wEomeRMcfoT
    ssk9TeyQf74J/b2YPwreqAEyc2I4W8j94ZbC1G5JqfUHctk3rkSZvf/woqEVcDmL
    WlNm/NsMA1eFp9YX6TYkRA5LeGCPIYf9SL04AW2Rwmr+5yDRjVybKFIXoYdUWSrC
    hp6LxdqIBwE4gmSGlSZRXviUneNe9Ye7u5md3UZ/eyAT7X73aY8YrZ21IIy2mHB5
    CLpYGdjC4cuB+QrKWt70TlUntEasdI4I8dnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238267; bh=riR9+2EfND
    X+3EEEA5aHSc1bIT1AsXhBrF9Tc09yC2o=; b=NzIvGEmsawhQ4XSnLaAAuJlOQq
    xaOEHJn4T1PTDL8ajWshOHDD/eD4t84VIxjBMxH/CnJwxkByonFSfCsSYy9E5jtU
    aNdu3uNOm5aZTvA141mZnl3naZ6UAN5qsG5zUtF66aIdgVy5OvNbZ5ioGyKJkK+p
    ueXlxWv1AcnKohb5hppQ1bioiUef1Gix5dvJzJdS93X2T5SgGuQWvR7IWiuyF1yG
    M+6E9icITZqG7q4Mw9BEFJWkStKJ9XkzpE9d13aucqQwQjCKQo2mV15SCCAevq40
    ZguJPzRQr3b1mjfutb+iBDdrt9HpyuqciQbb2cUX/KyL6SWtPrWQJTIt6tbg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JeFqNDS6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JeFqNDS6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIfs4u7zzEAp1f65l/yxx0wXSulM+WDISa4NKhhMxrlo4Zct7tjCG2vbMfZXNkxwmLtDZjac8jPlWQg540Y7f0C6szNkhyrfpUNW4DnaMsoXNMV5heDj
    4G5YGHGbbkwto80bEwWfAJXWUVSSOg+7WVfmhwU7P8+n47gHuap3bRhN/YEMBWT3c00ryLQauExYccwBIgjvx9SMtrou8BEnDBjtJzhsr01KdTmgQonFbCJc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=KE6AYRTJDb_r4OeTZP8A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeDIBne (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:43:34 -0400
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:14317
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932507AbeDIAeo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 278/293] arm64: spinlock: Fix theoretical
 trylock() A-B-A with LSE atomics
Thread-Topic: [PATCH AUTOSEL for 4.9 278/293] arm64: spinlock: Fix theoretical
 trylock() A-B-A with LSE atomics
Thread-Index: AQHTz5lpxhT3G2BR4E+4+YbtX90x+Q==
Date: Mon, 9 Apr 2018 00:26:33 +0000
Message-ID: <20180409002239.163177-278-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:OeMpJNifVrRG/4u2lSxZWiw0nMwwJ95VQO+qKkI0xsn+3ea5rKx6MeR7wgw2HWW9S7muE1mHl7T/ox02tdOe2v/qDuqEj6+lIfHaUxxmHuZxtNs/yFV5jR2TLZENGpd1j5m1FEHHhPhz2QRYNyRdGEIA1Za4kX0KZqp9+hsTYOhXsiblFFdxUnnVud97f1VURq/0eywEI0+e3XopGWVnAvsLHi5TYKRpKe63dGwzV72eyLkOupPadEbL0+YbBZGc;20:PaaPPMK7PEoYROjjbRrHuWywT/tPt4wJ+AdYIEQvS2ZU0Sia1xf3a5EEeBH8pfuZqAB+qdkW7zHRPGBP3oybo/xqVIDeNpMZhHzvIphnRXCAaT7jt0ApgqqAbeXBAQRRT454kdjsx/0ekU0I4JZoZLeQfwtw9qNelysEcXgPY+Q=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49ffd854-535a-4edf-72ec-08d59db1adf7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984E7F5D01A9B2821D67B87FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(575784001)(86362001)(305945005)(2616005)(476003)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XBWUnvs7v9zjHHSgihf5OmWbUYH+zzQPwUYL/WwxyS1x1faw2gwre3VCVt1NmKbZEZAEtz7s7pkURjxV0ia6Tem/DZENX9DZjIQqHpg4hBOdy1gql8ZdI4qscGII1TFxWnUmznME+7ELh4yQlCQ8P9xpomUyW4FmsQD9d3gqs4lx2Bd8zYew+lZ7+2lPuKmRWRQkur+rlp6yOtmvlK+PwGDEabQzef+5z9o4wCOBM3WscS1qNDcd95gW+64epEjsLayIYdzCTiFEpOyi25EJa3qss73WetB17oMmMMN0YCaLwdo7AbJO0wGMvXe9wKO355RMr2b491jXdIL45lgVpAZwLf8+d9y2eR+30KVpQS9dsV6i35RLSLNARTjzBHA5qQd3LeZz4oc066GR5lb1GqnaeBt7CDysWwUCnICRfx0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ffd854-535a-4edf-72ec-08d59db1adf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:33.1289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index cae331d553f8..a9d2dd03c977 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -141,8 +141,8 @@ static inline int arch_spin_trylock(arch_spinlock_t *lo=
ck)
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
