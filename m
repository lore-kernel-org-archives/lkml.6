Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523237060-2-9340356860110984794
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
    1523237059; b=Wg4FN2zKEMPYmrbS8NQogH+IJvPYXIGJrszmdNs9REhXpKg9Nt
    NX8ONU4SEaJp0yCCaid0wr6wdklemQ59pkwPvl/ePUTn8IEZbiV31prVQETxzx3d
    c/zHr2srfXgfjyWvdk1AwwcJCpydLvG0Rg0Q1EmCCf0sr5CcuRI3kAaCr0zNly8Y
    lzUnNZtuvZ/ALp1c+JdcY4AwMQ3EYaAvLjK7Wv/dofwva4FJwwlBcBwEHNAUMg5g
    tqgWKhXNonko0CqD9y1A5YB9X3KGWLXgPXO1fgqhAXzTs8mRrcL4fzsEcWwGq9Cv
    hpKMWSdRqkNBDNH2ZH+wpDY+DGaDnNpyQcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237059; bh=12sPPtdHjy
    aK2+/d2aSvXQMmxKueudyiKSgayDhQMlk=; b=otJqXIooK775aGMOWU21wIYRsO
    b1rYlJRKRKaogVft1G4BWbIKOVToQ7wSouQfyxxvvkC8h9iE4LkZqksnTIiNY38n
    3SuohmQZtAkNxcuA5kIFae83Aijo/7yRSrFGhDR/csCnsjW5am/UvZo0ItBskjKT
    vVM8a4Vd3BD/ACN36KgGuuMOk7+u6PEqXlMpeECbZxzgaFwgJNBWTYaM3mVwUWiL
    NgTEAFQz3PlFOvawa9npVZXcbI06bIreVGSzhH5aHl/rR5F15nA2rs7bIpY1J9Vo
    yr5UbQd2F2ZD8v2HStjrEysxYLjKG+wlzAWj21jxOk5H79FKV2ANqZJGfOiQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iN9j46Ft x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iN9j46Ft x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFoqr/Gp2FTLnQvfIt6XgBM11ywyPVHgGqZ0bPbq3jJug0y0iQTkA9CjP+NCQPcmll11o/AXAkiIjSosdZz/jQFAcrMwMItXeimZaat/dlHj2keU3MjA
    +AnjDYN+KR/JknbQhOqsq8fDdo7/M4UMbhjJ3W0CaAUhyJ4TcezwFwNggD0E+P6knKR41FdYWMQHE43phEIkWZDGU45UyM3hnssJHWBA0wfqUP6XKLi397jl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=cm27Pg_UAAAA:8 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8
    a=rhxNeiErAOfp3w74L8sA:9 a=wPNLvfGTeEIA:10 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDIBYD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:24:03 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932707AbeDIAg7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 073/162] seccomp: Adjust selftests to avoid
 double-join
Thread-Topic: [PATCH AUTOSEL for 4.4 073/162] seccomp: Adjust selftests to
 avoid double-join
Thread-Index: AQHTz5mzUi5miad3l0Gl42aeiJo5tQ==
Date: Mon, 9 Apr 2018 00:28:36 +0000
Message-ID: <20180409002738.163941-73-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:8KIyS2ZoKyIUT/UckY7UXUvjG+sJ0kIeVU7zCq1tsjtTcfEDzPldcMM+iizI0pCJAmCJ4xWZYiLaqFoMQgkOYsP2xV3FDhzEkb0lZyTf0Zh9hbeO4TLYhT3s3Bcsj+beLgKhgvcRfn33/eslscTWhsHHRz4+ppdzWfIomEnZykd4BLWYe7aZKQDLGziqrTd2A6nSFnsuR+HxlQsqprzdu1VbCus+rImkpnwKvNKiVaU60yI0KWmt6pTfMz34Nbah;20:1IU81ziVQ3otBFcHKjiIg73eUHYGZ6ZleOR1tQe6LK3axVfo8lpDyyv14sGhR0pQvlSA3dmbDT5H7wYp1vMfE04tWI3CgMDcPM7+0nOTQUgKr5uE+S++afrF2D+BKzRPYAe4bEM0iSQfXNK95MkDeA4VN7IVI7KSSqib+uQqydM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9339dc1-a398-4176-a1db-08d59db20049
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08853284C83961E0E9FB3593FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(575784001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bKqNSbBwLyjx3LpVSvDBS0jtFEHGH/DzbCSzeRGkkXJbhTidghK8ah6TYaegwjV5ZLh8HQxXyjOEetS0SIPvPxqyiwIotBXOpJzWYWzLMee6w+sDom2Urg7sXPXXmyByu65Wv7/em1BQkR6Mb2fW53glxLXjSXpBThqJ6OxopdzMjYaT8QsyqDRhhIATtPbbKJ6sipIX4XK1ycbl+NYgWSHZ4VDVceNPO87YNjyT1kOYdY8vrULuTn3unfQSNTXQF8xT/XtIUNZarvrRUVu6dI37optZMhaeo1M7xV5iLEHS0LJD0kDky9sS00AZj8bioGIidn8i+t7ga+bIqPNtJLGp/1rA2F+gafnWlnPsK1s9yyHTCBTe1gETfqqV4ls63FuZUEF1OI6+EgrvKB8jGReZvnPDUGxRywgFM0sR86Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9339dc1-a398-4176-a1db-08d59db20049
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:36.9895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 882fe83a3554..821aa0a408dc 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1615,6 +1615,23 @@ struct tsync_sibling {
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
@@ -1683,14 +1700,14 @@ FIXTURE_TEARDOWN(TSYNC)
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
@@ -1780,9 +1797,9 @@ TEST_F(TSYNC, siblings_fail_prctl)
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
@@ -1822,9 +1839,9 @@ TEST_F(TSYNC, two_siblings_with_ancestor)
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
@@ -1848,9 +1865,9 @@ TEST_F(TSYNC, two_sibling_want_nnp)
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
@@ -1888,9 +1905,9 @@ TEST_F(TSYNC, two_siblings_with_no_filter)
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
@@ -1933,9 +1950,9 @@ TEST_F(TSYNC, two_siblings_with_one_divergence)
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
@@ -1992,7 +2009,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 		TH_LOG("cond broadcast non-zero");
 	}
 	pthread_mutex_unlock(&self->mutex);
-	pthread_join(self->sibling[sib].tid, &status);
+	PTHREAD_JOIN(self->sibling[sib].tid, &status);
 	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
 	/* Poll for actual task death. pthread_join doesn't guarantee it. */
 	while (!kill(self->sibling[sib].system_tid, 0))
@@ -2017,7 +2034,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
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
