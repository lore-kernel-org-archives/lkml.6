Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D9DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284A9208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NFQgjWUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284A9208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeIQIyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:54:45 -0400
Received: from mail-eopbgr710116.outbound.protection.outlook.com ([40.107.71.116]:59328
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729507AbeIQI16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYRudPjmBVQ+AS1K1M2weKG+jvUeHhwfOmthHtSdg14=;
 b=NFQgjWUaVYYwCQ/7NZZ1EFL6JbxhXBOVxwspTUP1dZcCYCaUFxOWQvEAxV+EtaNKx9MTNKA2yiDD73kUX+RHm1bELOEV1Kp+UVU9bHkEE3A5Hw5G6SurLgOaHz7MwDLPVl34q0axr3tH5OQO+fwIQ+F/hFILwqlTA+MK3yv741E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Jiri Olsa <jolsa@redhat.com>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 100/136] perf/hw_breakpoint: Split attribute
 parse and commit
Thread-Topic: [PATCH AUTOSEL 4.18 100/136] perf/hw_breakpoint: Split attribute
 parse and commit
Thread-Index: AQHUTjKy5/S22cS7QU+lDugIn97rcQ==
Date:   Mon, 17 Sep 2018 03:01:15 +0000
Message-ID: <20180917030006.245495-100-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:uej9Fx3tUomB4Frh3mvDZVBtkqN6HhvwNU4fBES8iV9tuDtLKRokxkVnBAnFH4kLq3n8uhelT4v1bYrPetQnaq6hbfpZ8CwRpEf38S+I4ucd/KnaF1l92vsz4eq+L2Eu1bkoP5pN/Behs9j22uk8IHaZsoRWI0+Cd3wxsxekqjEIWWIOdrUDnvh/lLbzp6SrkCLgN+nMpYiuyn/8D9do5DAp4J//yIxyGLopz9u4eWnNUveg0AucqJWjartzd2X6wle0A13hjXdQyUAPrv+iX2hUfuSwI0xoURKaqvD6KKCKvd0DQZGY/Ufg3FRX7zhEy2Ut4ECIwQNvnPU4ctKCFYNHC7PkNqDkRi12aDgJONk5KswHKSI63CHWVIuj9VcCzecf6fvHsk/IRT/4L7dd+ZrqoMfpPNP+lzAirHt5Ty7appc89JPJzoCHEfqYFpXiws2ewA2PotAp7smtPS37uA==;5:sBMfujWP7nJFO2tKSzsNgo+IaxCwsD/PLESGdGiX+l9yRjy2fIQBn7vx5axSlfzYpY76HAPWzeLRdJha752VcUiAlolQEDglKG6zc13wKdGsW2Ulg6c3UM+YrRf0NBika19YKteZ4l5FD2d3FyDSXZxy9gBtZMvNbt3WDAwW1Us=;7:sO5oSgEl29fViU1mIgmJTi6MNP1opCJa5UpFK7i98eJPLE+/+GvoHSX7V/zaGJUyHf6fveLcAsORAnwS/DIIAal83RwzA2emACcQLpnT3HezKGlysIJ6nruIte4BbwU6jMIKHaoCFEyJVgxSflN4copr3Fo5te3rwNvcSZN5NrogzlxwM0aHv11vrKAS8T+q8b17pt4eC/r6/y9D+qicOahM9Yp8icty3JjR3OUu+dRAFp1je/EzfJ8Aae/ZdcJO
x-ms-office365-filtering-correlation-id: 18f36669-ef10-46cd-1474-08d61c4a062e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790494C6ADD78BB1BD32BC8FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(180628864354917)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(6306002)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(966005)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(7416002)(66066001)(305945005)(486006)(39060400002)(8936002)(4326008)(105586002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: P/wSk44pB9XI/0a3EMvu60TXTYCvtYzNr3Qaye0xhvz7HnTNN/pWLBaRhTKOROHqpNLercdNNgWkkTrSlp+c98IWtNvOZNkNj4ZArC/9QB5ylUckd1nbr9pFFfS2GM9uQeoh7cARM+WL8ii+wl2egP4NmYM81sa8FfvC1bH+nu1j0nVBYlBO8sSVtWE55eI7Jtncv9ni63xp+oGQWq17txyn15NtlNSPgvztTJRd7FJBqwytDPOtalCeeRr6VdQNsTY5huhltZSawqSyr8rdxsHHk/mh1za1yr0AN8Vnx6OSZFTNoOjHyp0a3qCACdbQ4xUagLdjgPP1JFTR1c5Q+hJZJs1Lmo2XiHWzg7FLl/U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f36669-ef10-46cd-1474-08d61c4a062e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:15.6042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 9a4903dde2c8633c5fcf887b98c4e047a6154a54 ]

arch_validate_hwbkpt_settings() mixes up attribute check and commit into
a single code entity. Therefore the validation may return an error due to
incorrect atributes while still leaving halfway modified architecture
breakpoint data.

This is harmless when we deal with a new breakpoint but it becomes a
problem when we modify an existing breakpoint.

Split attribute parse and commit to fix that. The architecture is
passed a "struct arch_hw_breakpoint" to fill on top of the new attr
and the core takes care about copying the backend data once it's fully
validated. The architectures then need to implement the new API.

Original-patch-by: Andy Lutomirski <luto@kernel.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-2-git-send-email-frederic@ke=
rnel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/events/hw_breakpoint.c | 57 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6e28d2866be5..314e2a9040c7 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -400,16 +400,35 @@ int dbg_release_bp_slot(struct perf_event *bp)
 	return 0;
 }
=20
-static int validate_hw_breakpoint(struct perf_event *bp)
+#ifndef hw_breakpoint_arch_parse
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	int ret;
+	int err;
=20
-	ret =3D arch_validate_hwbkpt_settings(bp);
-	if (ret)
-		return ret;
+	err =3D arch_validate_hwbkpt_settings(bp);
+	if (err)
+		return err;
+
+	*hw =3D bp->hw.info;
+
+	return 0;
+}
+#endif
+
+static int hw_breakpoint_parse(struct perf_event *bp,
+			       const struct perf_event_attr *attr,
+			       struct arch_hw_breakpoint *hw)
+{
+	int err;
+
+	err =3D hw_breakpoint_arch_parse(bp, attr, hw);
+	if (err)
+		return err;
=20
 	if (arch_check_bp_in_kernelspace(bp)) {
-		if (bp->attr.exclude_kernel)
+		if (attr->exclude_kernel)
 			return -EINVAL;
 		/*
 		 * Don't let unprivileged users set a breakpoint in the trap
@@ -424,19 +443,22 @@ static int validate_hw_breakpoint(struct perf_event *=
bp)
=20
 int register_perf_hw_breakpoint(struct perf_event *bp)
 {
-	int ret;
-
-	ret =3D reserve_bp_slot(bp);
-	if (ret)
-		return ret;
+	struct arch_hw_breakpoint hw;
+	int err;
=20
-	ret =3D validate_hw_breakpoint(bp);
+	err =3D reserve_bp_slot(bp);
+	if (err)
+		return err;
=20
-	/* if arch_validate_hwbkpt_settings() fails then release bp slot */
-	if (ret)
+	err =3D hw_breakpoint_parse(bp, &bp->attr, &hw);
+	if (err) {
 		release_bp_slot(bp);
+		return err;
+	}
=20
-	return ret;
+	bp->hw.info =3D hw;
+
+	return 0;
 }
=20
 /**
@@ -464,6 +486,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, =
struct perf_event_attr *a
 	u64 old_len  =3D bp->attr.bp_len;
 	int old_type =3D bp->attr.bp_type;
 	bool modify  =3D attr->bp_type !=3D old_type;
+	struct arch_hw_breakpoint hw;
 	int err =3D 0;
=20
 	bp->attr.bp_addr =3D attr->bp_addr;
@@ -473,7 +496,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, =
struct perf_event_attr *a
 	if (check && memcmp(&bp->attr, attr, sizeof(*attr)))
 		return -EINVAL;
=20
-	err =3D validate_hw_breakpoint(bp);
+	err =3D hw_breakpoint_parse(bp, attr, &hw);
 	if (!err && modify)
 		err =3D modify_bp_slot(bp, old_type);
=20
@@ -484,7 +507,9 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, =
struct perf_event_attr *a
 		return err;
 	}
=20
+	bp->hw.info =3D hw;
 	bp->attr.disabled =3D attr->disabled;
+
 	return 0;
 }
=20
--=20
2.17.1
