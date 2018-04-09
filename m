Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240059-2-16448993013198068044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240058; b=tZjQrWC5DV4EcQarn4uz8bTsjk3IqxIJdcWujSJ5LmoAZWLjWN
    IpEHN21g23QEHxWv2hiAcdp3kjQmYbIpRKPeudxuSIV6xkRnbUoJZMSJG/UiDDDk
    ura4r6HN0KBg2VG0xm97MgNygQDS1Wg2QbUA9qkcG+yRt+ohxczDFqkYputGj4Nf
    G0PcwgC+h8LAGuDyaAXyrHXgvdwJwDiNh5b+FMRTXlbqN4o/DQr8tZHiVZGnIIKE
    ufJj6tEWwNtLy5kF38e5ERUcHLGm3qmAlnAUo2gCurQCqOgwUDEInJDmHrtAJEUa
    fGxL867maiOWO3xRODNwcUtW3dnL1RHS70Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240058; bh=9FfuBHu4Nj
    UMmuSxo5vAeMYV6iMiW0w78li3yUp9zjQ=; b=kLVipMtZhykNeUh/RtADJH1YP9
    92d3e2H0mhfZwjfc19jHaLVcK5Y7LEZ1Ih1MA0vBBTi+X3JX+7kylf7+kUL5Brwb
    5s7LdZNQG7ILqzbNvL5TKf72ZuyOQl+C2GDLipzjWEK3PZcQ8jzXzwPoihegy1/3
    V87g/xNudZi4pTcPaWzxxoaXEFnv05gTzyZM9pk0LxCTARKeVjTrr/DGFL6TLdE/
    SXJFXhxfg9GF/ek/OQ+u3PlLblZhAB5K3XQR7s4CuCa5W8ber9VBG2UcTeeAQ8+O
    nvMrjjc90P6VqfMvv+FJecxSloosUTMSTxfwukUU1jldJVtKemz8mwWCPn/Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OPsUpfb7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OPsUpfb7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOUCTX25GpQwRU861ukHUZAA+es1YpNHRID0eCGGF0bp6DN41LzYMxWNtJW0x7NnJQqaJctcRqHaDVHOagGk2t0VjJ/A3sP6AfhhxdZ5gBiT1noMAzFd
    JFOzIOs2R+QzAzPyLnCpMa+jGxK05A3mKopdW9Vee4iYxU/B+GZNYMO7QG08tzvEuGO94WA4vbjc2yFsMlGihgwkJjGPYfO0J6AzaGpTRHMKkv12lv2tu5FU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=cm27Pg_UAAAA:8 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8
    a=oTuVm8JtTSObf2eOfUkA:9 a=wPNLvfGTeEIA:10 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756151AbeDIAap (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:45 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756118AbeDIAah (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 147/293] seccomp: Adjust selftests to avoid
 double-join
Thread-Topic: [PATCH AUTOSEL for 4.9 147/293] seccomp: Adjust selftests to
 avoid double-join
Thread-Index: AQHTz5krlpSY+BGPCUWisNu9iWn2+w==
Date: Mon, 9 Apr 2018 00:24:48 +0000
Message-ID: <20180409002239.163177-147-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:FxnRBJTBh+ill1zzyoZI/Uq9Byi9Ttj2lCsieO2VaYistgpg+kcmf/jjSfPzxpHwDW2n+HEWIAer4kqsSTsyo/bajCaE0D/SLDnq1tL8Bi219hQzS2sL7apPJDwFSKfexbMXgncrJTF7Pr0IIMuc2OkFTQh8KjO3qUS08uxWXtuEwncxQHfPtIi30wzHDXJh0Ylkznln3T2uKHJO09785KW+k8/1l+V2Rf1swkjkYtjCIIKIeQvbzho/eyoIK7ll;20:oxUn1ScP4urOWNI/7E02FyUJEiUo3+ZE/Vbo33SAB/OMUP89bZYdPNRx0vy9YufmBfDmNPFhP78pel+9kN+g97GsPYg7YHawYtaX9Tw6miAzOzfMtDfC+N+2Ji/FHHDbW3VJMrmrCHAvGZLTBqpg1j+ksSa/WFydxsWAZ6TWEfs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22c00ade-88e3-438e-5975-08d59db11aa0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807B72CC05847A6EC1E647EFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3jNYrZRaLy0LniELfy7AZCk/tyc8Dir4yvxJB4gnk50dgVtlVzyS8UhaF9rwt6zh9EzTVIJ1oDrd300pSDXkuHgQauc7+WL8689AhlVVRXNZhE/FiT4Kfb8+XSVEc3K+FBgswTu4aDCp3kDdEENuSpsFXBmpqMYP8fSG7G1cyXOJxdwfyLcfnNBHDkUcq5gOZegNlyXaVBYnL6nkabWylex4GjYs7rzjLkXkqJLAMR925PgnBcsIqaKEyr8bNq8RjFhd4C5F4yrFTqZVaS2yWZS58y56fX9DyIzF8gFfC4c6XdL3hOSkeTwPF2qBv+Y3Zjta6lgbaSMxOf+S95th/Qfwc5JnMWQNQ86jo51+Iuc2FGoYK323/dsvd8ttcT2XCCTw2UVaFtW8hfqFFUrwi3X/K32vEcjVw1dC9gflSHg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c00ade-88e3-438e-5975-08d59db11aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:48.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 93bd70e3330be45542c455dde11d8dc657ab3044 ]

While glibc's pthread implementation is rather forgiving about repeat
thread joining, Bionic has recently become much more strict. To deal with
this, actually track which threads have been successfully joined and kill
the rest at teardown.

Based on a patch from Paul Lawrence.

Cc: Paul Lawrence <paullawrence@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 51 ++++++++++++++++++-----=
----
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/=
selftests/seccomp/seccomp_bpf.c
index f68998149351..68d0a329371f 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1830,6 +1830,23 @@ struct tsync_sibling {
 	struct __test_metadata *metadata;
 };
=20
+/*
+ * To avoid joining joined threads (which is not allowed by Bionic),
+ * make sure we both successfully join and clear the tid to skip a
+ * later join attempt during fixture teardown. Any remaining threads
+ * will be directly killed during teardown.
+ */
+#define PTHREAD_JOIN(tid, status)					\
+	do {								\
+		int _rc =3D pthread_join(tid, status);			\
+		if (_rc) {						\
+			TH_LOG("pthread_join of tid %u failed: %d\n",	\
+				(unsigned int)tid, _rc);		\
+		} else {						\
+			tid =3D 0;					\
+		}							\
+	} while (0)
+
 FIXTURE_DATA(TSYNC) {
 	struct sock_fprog root_prog, apply_prog;
 	struct tsync_sibling sibling[TSYNC_SIBLINGS];
@@ -1898,14 +1915,14 @@ FIXTURE_TEARDOWN(TSYNC)
=20
 	for ( ; sib < self->sibling_count; ++sib) {
 		struct tsync_sibling *s =3D &self->sibling[sib];
-		void *status;
=20
 		if (!s->tid)
 			continue;
-		if (pthread_kill(s->tid, 0)) {
-			pthread_cancel(s->tid);
-			pthread_join(s->tid, &status);
-		}
+		/*
+		 * If a thread is still running, it may be stuck, so hit
+		 * it over the head really hard.
+		 */
+		pthread_kill(s->tid, 9);
 	}
 	pthread_mutex_destroy(&self->mutex);
 	pthread_cond_destroy(&self->cond);
@@ -1995,9 +2012,9 @@ TEST_F(TSYNC, siblings_fail_prctl)
 	pthread_mutex_unlock(&self->mutex);
=20
 	/* Ensure diverging sibling failed to call prctl. */
-	pthread_join(self->sibling[0].tid, &status);
+	PTHREAD_JOIN(self->sibling[0].tid, &status);
 	EXPECT_EQ(SIBLING_EXIT_FAILURE, (long)status);
-	pthread_join(self->sibling[1].tid, &status);
+	PTHREAD_JOIN(self->sibling[1].tid, &status);
 	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
 }
=20
@@ -2037,9 +2054,9 @@ TEST_F(TSYNC, two_siblings_with_ancestor)
 	}
 	pthread_mutex_unlock(&self->mutex);
 	/* Ensure they are both killed and don't exit cleanly. */
-	pthread_join(self->sibling[0].tid, &status);
+	PTHREAD_JOIN(self->sibling[0].tid, &status);
 	EXPECT_EQ(0x0, (long)status);
-	pthread_join(self->sibling[1].tid, &status);
+	PTHREAD_JOIN(self->sibling[1].tid, &status);
 	EXPECT_EQ(0x0, (long)status);
 }
=20
@@ -2063,9 +2080,9 @@ TEST_F(TSYNC, two_sibling_want_nnp)
 	pthread_mutex_unlock(&self->mutex);
=20
 	/* Ensure they are both upset about lacking nnp. */
-	pthread_join(self->sibling[0].tid, &status);
+	PTHREAD_JOIN(self->sibling[0].tid, &status);
 	EXPECT_EQ(SIBLING_EXIT_NEWPRIVS, (long)status);
-	pthread_join(self->sibling[1].tid, &status);
+	PTHREAD_JOIN(self->sibling[1].tid, &status);
 	EXPECT_EQ(SIBLING_EXIT_NEWPRIVS, (long)status);
 }
=20
@@ -2103,9 +2120,9 @@ TEST_F(TSYNC, two_siblings_with_no_filter)
 	pthread_mutex_unlock(&self->mutex);
=20
 	/* Ensure they are both killed and don't exit cleanly. */
-	pthread_join(self->sibling[0].tid, &status);
+	PTHREAD_JOIN(self->sibling[0].tid, &status);
 	EXPECT_EQ(0x0, (long)status);
-	pthread_join(self->sibling[1].tid, &status);
+	PTHREAD_JOIN(self->sibling[1].tid, &status);
 	EXPECT_EQ(0x0, (long)status);
 }
=20
@@ -2148,9 +2165,9 @@ TEST_F(TSYNC, two_siblings_with_one_divergence)
 	pthread_mutex_unlock(&self->mutex);
=20
 	/* Ensure they are both unkilled. */
-	pthread_join(self->sibling[0].tid, &status);
+	PTHREAD_JOIN(self->sibling[0].tid, &status);
 	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
-	pthread_join(self->sibling[1].tid, &status);
+	PTHREAD_JOIN(self->sibling[1].tid, &status);
 	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
 }
=20
@@ -2207,7 +2224,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 		TH_LOG("cond broadcast non-zero");
 	}
 	pthread_mutex_unlock(&self->mutex);
-	pthread_join(self->sibling[sib].tid, &status);
+	PTHREAD_JOIN(self->sibling[sib].tid, &status);
 	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
 	/* Poll for actual task death. pthread_join doesn't guarantee it. */
 	while (!kill(self->sibling[sib].system_tid, 0))
@@ -2232,7 +2249,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 		TH_LOG("cond broadcast non-zero");
 	}
 	pthread_mutex_unlock(&self->mutex);
-	pthread_join(self->sibling[sib].tid, &status);
+	PTHREAD_JOIN(self->sibling[sib].tid, &status);
 	EXPECT_EQ(0, (long)status);
 	/* Poll for actual task death. pthread_join doesn't guarantee it. */
 	while (!kill(self->sibling[sib].system_tid, 0))
--=20
2.15.1
