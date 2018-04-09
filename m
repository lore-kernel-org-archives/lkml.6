Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240428-2-5952110567839190172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240428; b=PS3xhNgRAb7aXatckHYsWXEYGiyWA6aajTX5+rpVM+/S8NISrt
    9hHwwBZUw3GPXoV6JFDq0wE4bjJbaRDwD9bBuX6KghRdyPeItM7TlMZu+6NNkmdY
    GJbj8yIFs5adM0wl3H8yT46ZW1MiZGxDGQzM76Wyw5sdfqK+y0kHJi5Vc1gHcupf
    tz4dfAnrX+a8Cj6cZc42smqQVObd29/Zul0MBd8C/W64A5EJeLP9KbCUNGkcJsOr
    LOM2FzkV1fNlAj/PpvUuv8rdlk0M5Kf2W4Mx4eNu1V1qSP3fuO/9cPGdbSqRbezs
    UQqNwQi4Eytc4PXd+KzRCQbIgaydtiLB7lJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240428; bh=Hc6nLPJVp8
    wu8SkOJXZj19L1h+xsTjdVFHXZuslMiMA=; b=ZIzhe6cPOyb8/OkM5Ro2NtGpih
    VsAXkRqYN+vGgewxPpkC89LdAZNLbcJ4IWEp70KLAZ4ivU8KsO9oJRt5IvymZ9Tl
    uKbbUoHs0mWt83pwzfx6rLK6KjNK8CAjdSruVUhrx/i8XhM1v8S1pvLAXRSxoQL7
    piqYtHGnBixR/1+tBFRzG4yGbmJW4nvZ6l+HCoCe20BafpoB4jq8z3d9zYOfcuyk
    9sKeXPyn28s9xv4ulqA4lWJrqOkkQI2U+O4NqyaKvhWKAtpLrZuMmsikieROPV4B
    SmhctJ83odbjxqx5QPk8+VKyMc0uZf8p/wKxoacAh6loYqllHK3xs1ptuTUQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gn3K2+nD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gn3K2+nD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG91COeMpaw7UOJpGBp7ritx4LhD5aVCWKjTFcUNvZBsaBqUWar7Gtgw6ymDbBGBa6l01pOOK43IHNPMuoXybFKbn+GjqFZHME/RiPcvEhNU/QuS4wPt
    vIzrxSHNU2NjjjWBooTc4XuNjPbjK0tGWV/1YH6qv1UJHf4il6sPqV7Tx2e8dNssbtrFHrvq/qhSYpkfygTFgASGQlxL/1T+dFE4nwTmBaIzrLgjoU2kmfKW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=xygDymgHokxLim0tc7QA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbeDIAaG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:06 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932128AbeDIA3s (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 120/293] arm64: ptrace: Flush user-RW TLS reg
 to thread_struct before reading
Thread-Topic: [PATCH AUTOSEL for 4.9 120/293] arm64: ptrace: Flush user-RW TLS
 reg to thread_struct before reading
Thread-Index: AQHTz5kersbuDb7X0EWcileNz7K5cw==
Date: Mon, 9 Apr 2018 00:24:26 +0000
Message-ID: <20180409002239.163177-120-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:TQqY1ulQEa71DIfNi8UUJ58bHSTUpAKptRFsnYONNmzL07cfUnkv/6Zq7T/VEAnPHQp9Xn3JDoIrqooD4VZl4iYy14GKcniG1Utm6evo+k0D5KxnYynzWkbExNNo//kvumeJzUWBOhLykRoACRDnDmyYe3m1dMwekhfJxsMggD5ojTYHM7Xe+iAqGwsL4g1UNA812dzJWk9DzinT9t5f2fX2o92EMQqVQB/t32f70zgc7qrU1Y30gIGTAWkniYln;20:iaQezoq1jj3Ka9D6W2Gu6if0bX0+IuIuTTXvjexGaFenKyMTxqvG2HBxcDhYuTX99X8k66yDQ0oFIdJNR5EoI1IKNeoR9MMB/dP5fcyLAZlRP94u2Z/6hQoLvXOEAcxPhUne1Mb3ZEk2s92GxsEy8MRSLjfZ/hyEbpjeO1B94Wg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ef8733c-dbcd-492c-52ae-08d59db0fd45
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10323225627CAFE9399C181EFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jM96s6lPQbFt4vVwGLZzxXSu/9p/OElnkEGdTIIWUBdmvXcMsFQ0dB00p+IJ1VsnwK0riHN078Xsvdz7s0YmUsMizDm5UEIFwDx1pd0nsgJN89LMkcE6UYJ+6XejTnO2CrcqAzOmUqfRseLMirhM57B9nnekj62zuGDl4DtsakjNv/+hZt4CrHMMokPs1QxoSMNQER8SbUsBMq6EhAdgS9H0lDL0cvIaL0cpHozGLJQg6xmkdQQQwARUo/jr+tL2SW17BKOZfuUNZI2xBakkAZJmNKV5roHyMdF8ao1c/R/FlcZaNpB8/CxLE9rgzguDBJ1BEu4sxx8qN4yLNp/kwa2SY25gunisORvR5KWWtfLJXvMp6XB11y4iaTJwq1EWBMUsR2LdVdiBLD4Fk6S4fSoqCxjriX6CHXcmjsaP+1c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef8733c-dbcd-492c-52ae-08d59db0fd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:26.5656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Martin <Dave.Martin@arm.com>

[ Upstream commit 936eb65ca22ad856cb3a995e8cd742e982dc2dd0 ]

When reading current's user-writable TLS register (which occurs
when dumping core for native tasks), it is possible that userspace
has modified it since the time the task was last scheduled out.
The new TLS register value is not guaranteed to have been written
immediately back to thread_struct in this case.

As a result, a coredump can capture stale data for this register.
Reading the register for a stopped task via ptrace is unaffected.

For native tasks, this patch explicitly flushes the TPIDR_EL0
register back to thread_struct before dumping when operating on
current, thus ensuring that coredump contents are up to date.  For
compat tasks, the TLS register is not user-writable and so cannot
be out of sync, so no flush is required in compat_tls_get().

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/include/asm/processor.h | 3 +++
 arch/arm64/kernel/process.c        | 8 ++++++--
 arch/arm64/kernel/ptrace.c         | 4 ++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/pr=
ocessor.h
index 60e34824e18c..b3ac6e5a70b9 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -102,6 +102,9 @@ struct thread_struct {
 #define task_user_tls(t)	(&(t)->thread.tp_value)
 #endif
=20
+/* Sync TPIDR_EL0 back to thread_struct for current */
+void tls_preserve_current_state(void);
+
 #define INIT_THREAD  {	}
=20
 static inline void start_thread_common(struct pt_regs *regs, unsigned long=
 pc)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0e7394915c70..90e2823e5081 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -304,12 +304,16 @@ int copy_thread(unsigned long clone_flags, unsigned l=
ong stack_start,
 	return 0;
 }
=20
+void tls_preserve_current_state(void)
+{
+	*task_user_tls(current) =3D read_sysreg(tpidr_el0);
+}
+
 static void tls_thread_switch(struct task_struct *next)
 {
 	unsigned long tpidr, tpidrro;
=20
-	tpidr =3D read_sysreg(tpidr_el0);
-	*task_user_tls(current) =3D tpidr;
+	tls_preserve_current_state();
=20
 	tpidr =3D *task_user_tls(next);
 	tpidrro =3D is_compat_thread(task_thread_info(next)) ?
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 8eedeef375d6..d1fd560b3a2a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -646,6 +646,10 @@ static int tls_get(struct task_struct *target, const s=
truct user_regset *regset,
 		   void *kbuf, void __user *ubuf)
 {
 	unsigned long *tls =3D &target->thread.tp_value;
+
+	if (target =3D=3D current)
+		tls_preserve_current_state();
+
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, tls, 0, -1);
 }
=20
--=20
2.15.1
