Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242634-2-4664180536508718525
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
    1523242634; b=M8yOnxmsLh5UiXEJEAWo77hsZ2v78JBs+eHGp2LoAQm7K+yd3D
    CHURoDdOWTVXwbK69mkpV3RXRKVTNIBUt9iR15sf6shsYMt/3NpZphiqB6UhDmYj
    h5rK/Iuy9EjKtrDwRSiZencCavpwhVPaYBcw/p9tlQTODK22KApmVb+4Gxb1J/jA
    7S5SEgtQcN6wL16kAt3e2GeH388LfTP5xpama2848yxx0tWd8nMtr4lMuLnl/1NN
    HSj/bnsX+a+B1pVvWZBHDxEEC42KuRYU3q7HcwXxohhj5FU93sD1j+kgNgQMPFbC
    HrXeTKpuHdTUtuR4BGoqpfeL4g3XAtE2Oylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242634; bh=BlXNlAgTp9
    S8jEG37OcL/gYITfmNCpxgjMHumNTaHXw=; b=vmgTg274Ivrn4nS0On0eW8wYRH
    EpWMjqNEYRGGzMW6GoX6oUDL1lf2nQi7Bli+a3NVOZ8d44QyXePcu8CFQAETqWQg
    pOboPzF/8zBNzwZLjFg9/9y9Sws0TfvlvEf0ftUzLeHc6dadUtzH8fTDrEkzX4UT
    mmVZeiXlE4DshBLk6sx+p3/tGpB8ie/rPMkWNnOQB4FA0b/ytoPOemDqjP7b8Fm4
    5oC09klH7Sua+Z0yVfoQ6juqjJGJx3mtTxuBhnwLhYeIwJMHUzNMxnea8lZmV+CK
    O8iVZYrsgW0KbBQCgQc1rFE6TktjqhobK/t3QvA3Hp8j3AzZlQgZe4UQ9S4w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AZcFYk96 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AZcFYk96 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNrMBhDO4qCWD9rhjUR+jidrBXwQPaDxBLcT7JamMZhbgk52DT2Xqrl8impnNNk+SmOgYax9RnKZKBtiPqH4KrBNASMDbqk5+7lBJf9zwzm7ZRRpKbXv
    5pj7iElyDvTUPmLyARhLnxX0u26mF1IhSdjlWYVrCO9t0A6p9lhxH/XXHO9rjebHgyEvaReflfUBKvK6WmUg02lOoRXW7UEEFU08naUO9MalGGSjogRK7YHt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=KE6AYRTJDb_r4OeTZP8A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbeDIC4e (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:56:34 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755238AbeDIAZp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 132/161] arm64: spinlock: Fix theoretical
 trylock() A-B-A with LSE atomics
Thread-Topic: [PATCH AUTOSEL for 4.14 132/161] arm64: spinlock: Fix
 theoretical trylock() A-B-A with LSE atomics
Thread-Index: AQHTz5i7h+yz/e0xr063sB6Ji34vSw==
Date: Mon, 9 Apr 2018 00:21:41 +0000
Message-ID: <20180409001936.162706-132-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:4GYVwL0ZKLBJynwCHcJop2D7HvY3mdAd66tQnKaOJ/OhRIo9JJl9Pu+jwq6fDHWlcroPBISSrRh3/nWb9icIGMi85tM1L0XYhR0l2uXF5oS+weRv8XbH74Qgaax4fCTrUWF58TvKNZcoRHpJ8VyffDVSA/1NOM8psHdZELRiDQU/h1rPSyJpZVT2VCZhL91TtB5xznOLK4cGFS6hyJTZ6lCOJ2Vit+p5zAxY8BdqRAJ7t8azKLH4yRyet1JZZdz5;20:thGQQ521mgPDf+dbzLfIHQRbwQWCgmO6K9fUZglt+IGCt/KZxVO3jR5buFJVNYyuOvi/eVja0NI/osInU+LWyhGYh9dqjUI+CAG/tn4grI1cJciKMCvqmsrHNQvSC3frA26NGNZtu5FaMz+4zgWm8sugH9BzKbkc21X09JNfmoo=
X-MS-Office365-Filtering-Correlation-Id: a6ae9e19-711f-40f3-2739-08d59db06b76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10136EDC244E51D313EB45B8FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4bWFjG/yn3GsJRIfTMXjONhrMCf8d7hfRpMmgNLSfSnj/H74q+hmeMw6xKpxw6Mn9saqvXNJeX2CkY5ZsnQ/SnrE3h4XwkwRt+dZJj8jG78/q/WlOE1YOawjuY+J4lhVc8sgGB/y5Tbhhd7p8VBH4k81ic0Eym9gZEE/AkxmFZFzpBPInXMm6l+nc/xv0AxTB+RPdKAepovqDLjLEYoHsII8zBaZp1lwUzDops/P2+cAB7oMhtvxsxDLQU11Ku/zs6JVvkc9sL7dL85rtnVeAMamFvSYr2m+bDTrylkVsngZNjQCHzNcFDVDKLKbV4TRDbr3wH8TnUe6+CLkLCTPVdjsyakCE/XOZQVHWpLkBAU6/hjJrLknNmTXNwrJDiozAignNNsZmP0f2mDYW5hKYLI3ztnskDwKSAdRfK/43Io=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ae9e19-711f-40f3-2739-08d59db06b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:41.3624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index 95ad7102b63c..82375b896be5 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -89,8 +89,8 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock=
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
