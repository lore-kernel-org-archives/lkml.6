Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122311-2-14433564085635020914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122310; b=VcGSGcn/WruRDoEC4SBfcfmH4xRWu6gKv5X3M1w/Sxsh2Pd
    IdtT/V4hZC1mKsXzxpk9JNIUrWAc0OvexK4BeF8ph6cxSttNsfm7bpj14mzY3ryF
    lu2S6gIglNo0h2HYXP9iqLs4vXypJ6ULbHIA7ujWxZlCPuy1UfmTG6wUPPI3j15C
    T6OlRBzqDJpxjt8bUCqSjoMBhJRJxsZv1rTSivtCIWdZEM9mJ0Y4jSsBS+/ecmgP
    vR2dAoDecgq3YKaAJdHM+NcOkmqg+Srzl0yzBJAgbyJ/R9/mwPrXGBWOiaMHNh04
    Qe3gZPMFnWOK16R/Mso0Lyn/nKqoNCUqXi8ToHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122310; bh=prCqeT
    QHkNhT4C8f7BDCDXf0THTbnq9xyZ0kUMc34sc=; b=oOawt3HXQMbuzBQBiE8KB8
    3xqxMvXCBH+QA9FWyUrPK4Jy9SH++lG1ovI/yaa+ubsj5HLMusk7uVgAPs+fFRZ+
    zVxro3FKpiEHM7E+4okLtDGvuJOxoM/CdXI9XmkY6tfRMCADMDpQ4WMwnEdDXJJa
    j4cljrSNVI5zeL3HidjrzVVJMOQ5WrFVnts7LyUw+PhGFSCNz6whrVXNsZqGKf2o
    oIZa0c9KANhSl9+c5GtNcEcqQheL6cjVG9+mMjrqA43Qhk9aOkS6VWruiVZuKWPG
    zW/ieHkRdLl1ReUZqEj+zwBQfWPsiJfpSjLgAkp3EmNvR8aVncKltlbaPZgcBXvw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=arWBpAkX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=arWBpAkX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933175AbeCDAL1 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:11:27 -0500
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:51749
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933500AbeCCWaz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 81/84] locking/locktorture: Fix num
 reader/writer corner cases
Thread-Topic: [PATCH AUTOSEL for 4.14 81/84] locking/locktorture: Fix num
 reader/writer corner cases
Thread-Index: AQHTsz63wuJ8Ao8VikKx1t4SXURmOg==
Date: Sat, 3 Mar 2018 22:26:47 +0000
Message-ID: <20180303222518.26271-81-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:FV4fd0Cx4H5C7PjVwf8pL+Ayp2gXWEAsFHnh6+NNcomk5hPSMsdD1F455w9vMpLJiiNbAE6jV+G37gL4y7ic4YkRIMI9I3Mh56LirwIkAPtppenfjvZr7UHhPn4fwcwSN9PswPkwC42B6mXBLgU68Y29FTMBixrhRPf8skr8i27GBbzCX8YhIIzcN8Q9xL2NhGHKa4tpWq+LBxCw+cxVamB2JgxhYzu+c8L4nL5EuTufRVNCES24esqGWJ6XYgAV1wOqU0QmuUYFZ4qjSQ61jKxzElBWcx4JICaWVbSxZw8kYQdwuKWH7nRM9RJm02Zv6CVDQUa+13aIRVITCaehu4e/WZVLECbaldCKguZkppudjH72Kemqh2scowHGaIMi;5:d3BcBqDJo6RTvOm/mVBMjRTNWztV/opF0ZyWZCpYDDQvf922Q2MhsWSkwwpiJD+cSH8MRW8bLSpxuSdP+VoUq+zuOwFAj46Ft2TWNa1daBuwRCrh4qp7vuv59WqqCLwnQW10RONxBYJNVbjSTnxa8PmRKcAGUeRKud4SSiHYMGs=;24:/VmNGSWjsYEpVfmRD1ADqmZUvP7QnNmKigAOfCCwVDlBjij/Hv4PrtEY1QbiDQYp6rfvDkbzYhRNjepINYKNF7SM4zgW9LY9rrElVG/fPKc=;7:JsHlf0lMiEaDswv6xMG0QJlMiJcz/q1PActJW3eh+XSVqI0MgoJhbPkxc6k1SkAC4UigHStBVDBZtFOz0/TlXdVA+pThi+zzqBtcS42MshMXxBX1Oo4QLK7B2qFGHtpW8BYFNPlNO1o+2dMPwwcjifqETj9eTPuCimp8G4n1LzuRZDi3t2VyadobPvDicg3mw0tUogl5Wt0OZdNZm0x6+4uiW0FX2EETgLZbydoyds2oytyVutadLVHiHUhcrE7e
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99eb4537-f44c-48a2-bcd9-08d581566c5b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970DD8297FFE0451B9DBF59FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: egwrTQfTy4ubuaVpQZTWIrixkrvUwXbNekc4ImM//cgAg66TjP39UAbtwqWy500yYOeTPCxcfCqnJL54CDqXp6lkjTDS8scLqaDioYz1qaNB6GeUXR/gxTGtvsKdQqFe3ADlm2H8AFZ0JeRBj8zXPl6EUHyf6UqaEmWjqwpik5w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99eb4537-f44c-48a2-bcd9-08d581566c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:47.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit 2ce77d16db4240dd2e422fc0a5c26d3e2ec03446 ]

Things can explode for locktorture if the user does combinations
of nwriters_stress=3D0 nreaders_stress=3D0. Fix this by not assuming
we always want to torture writer threads.

Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/locking/locktorture.c | 76 +++++++++++++++++++++++++---------------=
----
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index f24582d4dad3..6dca260eeccf 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -715,8 +715,7 @@ static void __torture_print_stats(char *page,
 {
 	bool fail =3D 0;
 	int i, n_stress;
-	long max =3D 0;
-	long min =3D statp[0].n_lock_acquired;
+	long max =3D 0, min =3D statp ? statp[0].n_lock_acquired : 0;
 	long long sum =3D 0;
=20
 	n_stress =3D write ? cxt.nrealwriters_stress : cxt.nrealreaders_stress;
@@ -823,7 +822,7 @@ static void lock_torture_cleanup(void)
 	 * such, only perform the underlying torture-specific cleanups,
 	 * and avoid anything related to locktorture.
 	 */
-	if (!cxt.lwsa)
+	if (!cxt.lwsa && !cxt.lrsa)
 		goto end;
=20
 	if (writer_tasks) {
@@ -898,6 +897,13 @@ static int __init lock_torture_init(void)
 		firsterr =3D -EINVAL;
 		goto unwind;
 	}
+
+	if (nwriters_stress =3D=3D 0 && nreaders_stress =3D=3D 0) {
+		pr_alert("lock-torture: must run at least one locking thread\n");
+		firsterr =3D -EINVAL;
+		goto unwind;
+	}
+
 	if (cxt.cur_ops->init)
 		cxt.cur_ops->init();
=20
@@ -921,17 +927,19 @@ static int __init lock_torture_init(void)
 #endif
=20
 	/* Initialize the statistics so that each run gets its own numbers. */
+	if (nwriters_stress) {
+		lock_is_write_held =3D 0;
+		cxt.lwsa =3D kmalloc(sizeof(*cxt.lwsa) * cxt.nrealwriters_stress, GFP_KE=
RNEL);
+		if (cxt.lwsa =3D=3D NULL) {
+			VERBOSE_TOROUT_STRING("cxt.lwsa: Out of memory");
+			firsterr =3D -ENOMEM;
+			goto unwind;
+		}
=20
-	lock_is_write_held =3D 0;
-	cxt.lwsa =3D kmalloc(sizeof(*cxt.lwsa) * cxt.nrealwriters_stress, GFP_KER=
NEL);
-	if (cxt.lwsa =3D=3D NULL) {
-		VERBOSE_TOROUT_STRING("cxt.lwsa: Out of memory");
-		firsterr =3D -ENOMEM;
-		goto unwind;
-	}
-	for (i =3D 0; i < cxt.nrealwriters_stress; i++) {
-		cxt.lwsa[i].n_lock_fail =3D 0;
-		cxt.lwsa[i].n_lock_acquired =3D 0;
+		for (i =3D 0; i < cxt.nrealwriters_stress; i++) {
+			cxt.lwsa[i].n_lock_fail =3D 0;
+			cxt.lwsa[i].n_lock_acquired =3D 0;
+		}
 	}
=20
 	if (cxt.cur_ops->readlock) {
@@ -948,19 +956,21 @@ static int __init lock_torture_init(void)
 			cxt.nrealreaders_stress =3D cxt.nrealwriters_stress;
 		}
=20
-		lock_is_read_held =3D 0;
-		cxt.lrsa =3D kmalloc(sizeof(*cxt.lrsa) * cxt.nrealreaders_stress, GFP_KE=
RNEL);
-		if (cxt.lrsa =3D=3D NULL) {
-			VERBOSE_TOROUT_STRING("cxt.lrsa: Out of memory");
-			firsterr =3D -ENOMEM;
-			kfree(cxt.lwsa);
-			cxt.lwsa =3D NULL;
-			goto unwind;
-		}
-
-		for (i =3D 0; i < cxt.nrealreaders_stress; i++) {
-			cxt.lrsa[i].n_lock_fail =3D 0;
-			cxt.lrsa[i].n_lock_acquired =3D 0;
+		if (nreaders_stress) {
+			lock_is_read_held =3D 0;
+			cxt.lrsa =3D kmalloc(sizeof(*cxt.lrsa) * cxt.nrealreaders_stress, GFP_K=
ERNEL);
+			if (cxt.lrsa =3D=3D NULL) {
+				VERBOSE_TOROUT_STRING("cxt.lrsa: Out of memory");
+				firsterr =3D -ENOMEM;
+				kfree(cxt.lwsa);
+				cxt.lwsa =3D NULL;
+				goto unwind;
+			}
+
+			for (i =3D 0; i < cxt.nrealreaders_stress; i++) {
+				cxt.lrsa[i].n_lock_fail =3D 0;
+				cxt.lrsa[i].n_lock_acquired =3D 0;
+			}
 		}
 	}
=20
@@ -990,12 +1000,14 @@ static int __init lock_torture_init(void)
 			goto unwind;
 	}
=20
-	writer_tasks =3D kzalloc(cxt.nrealwriters_stress * sizeof(writer_tasks[0]=
),
-			       GFP_KERNEL);
-	if (writer_tasks =3D=3D NULL) {
-		VERBOSE_TOROUT_ERRSTRING("writer_tasks: Out of memory");
-		firsterr =3D -ENOMEM;
-		goto unwind;
+	if (nwriters_stress) {
+		writer_tasks =3D kzalloc(cxt.nrealwriters_stress * sizeof(writer_tasks[0=
]),
+				       GFP_KERNEL);
+		if (writer_tasks =3D=3D NULL) {
+			VERBOSE_TOROUT_ERRSTRING("writer_tasks: Out of memory");
+			firsterr =3D -ENOMEM;
+			goto unwind;
+		}
 	}
=20
 	if (cxt.cur_ops->readlock) {
--=20
2.14.1
