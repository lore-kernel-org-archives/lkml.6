Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490427-2-1400116514679022129
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490426; b=skSsi380xAtoFnJcAHi78v7j4xtYcvXL5FhhSmUnhR4t/Nm
    nE4Tx8dkv862cTmegT8hGYt3JsYPTJbq1A3X0nxhP+WUrQnP7DF3BxFnFULNLdJu
    L19Wygz1Y5hbi28cGHJmSKztpWtzZcQ1UA6DdEQSxD6zOF4NKLCqZ9Ogvl7byKpO
    MSe1tLqk+U6pZl0PU+yyK5zTduuRq0rQPf/xYIuetD314o3QdP7GwZoAO2Lx7xTj
    Gmup5vebYbuGURDlXZE4W4XTjFMbrGGeKE/vdJsHK5W7fPMC9Cy81iQjr2H5lT/6
    +YQI08rhf0gi0prRKjPS3rUaXhjS5QVlCZrkH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490426; bh=b/8pGU
    18QPmwsKf9rPTI0fNj55+spuuNnCfixq8iFnM=; b=ZYrNwjp3v8tfr6dN+89FqM
    bGSbKjxOb0DtvoG7bconU5V9DAsILkSeKzi4TwMSJuFR7PNIwaqEhpc+CXl5JBDI
    1326gvoUb+hwGFt9nHMliLdUthl5FbAyLUigj3TKjeZ0Kid1xizU9KySPcL17xXD
    0hJj1/cJtM5Z7XqgrsqQ23HEypgpaVHi+7peaxE6oT5t6dODByNKw9kz3ckZpgja
    3m0WsTafLDcn2BdrteeJfeCqgpOYwvz3NBonWDTaxHDqUawdAgKzn6ma3lSsfJT5
    lSl9yR4+af07inm+pRCR5Qcb1F4432d1JvXutkJaDiICHZukTab2RaIH9GevSMOQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A8HK86dL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A8HK86dL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965663AbeCHG0q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:26:46 -0500
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:53598
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755291AbeCHFAi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:38 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Deepa Dinamani <deepa.kernel@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 032/190] time: Change posix clocks ops
 interfaces to use timespec64
Thread-Topic: [PATCH AUTOSEL for 4.9 032/190] time: Change posix clocks ops
 interfaces to use timespec64
Thread-Index: AQHTtpouz9kHdooxbkSfJJvmUIyo3Q==
Date: Thu, 8 Mar 2018 04:59:04 +0000
Message-ID: <20180308045810.8041-32-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:FEEqb/xj8zzAcA6rmxBmMymoHn9UsS6MLREgHp2JN7dxvUnsDW02QUbAH+x4r/ZyC4eSmiQnyl9pSlijE/hyjHtKF+cvPB8JsFn9ExzQmon95EmlJvLnZpslrJlTHgOk6vXy9UUSxywMAUxJfRjI4Fy7USKxEjhki9IEEPe1s8THfypOP9dMQjNLh915VppR2GzIPMSo7yuOke4/vHq4FwD7gu/K0tKBEMtCy3B/5sylQFZE737WTuGELBnTU0uD;20:qGhGDMYaL0MoPTGbfsBhERRCiVjEmyVgKfGz4QE3DsL/a9GckQK1ErQB+FdFotdzt5dSPPNr103C/78soQoboV7fgn6YALh/RZRlqIyW/SLpdw5LUivdP6Cj7DiHWdnRlZvp9OhUIen+YKVJjk2e5zn/aHPoNVQe5fwpJD8BNtA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2099363-79a0-4642-2714-08d584b187a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111213B72BD31EB8F0052F79FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(42068640409301)(1553240931313);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(39060400002)(6436002)(6306002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(966005)(66066001)(2950100002)(105586002)(68736007)(14454004)(325944009)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(575784001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: la6dtGg56jpbYFKiDVo5v8JpMxAZ9i7qf+FD3Ac/ezloeNEnklDnPzrOMb4hLYkoSLouw/wsd7Sib3nlehsZj3GCBxRWnAdif9V8lH9VOuxaetLXi8yU+oHMEZ48yVzS4XzQxwjEcT6egrU+vfXDycv++vTkcIklfp4Rf31z0zCdyX3yUjdvS9n2cAaRCTRmN8ygsOEvMd9EN2wqR95k5DObZNv86zr1YndTfQu32neOl2ESNBGoANVilbFgkBJ0QQgUE51IrGc7Fmik9HqZdDyQEuoFi9/cDaxZhbvjmhnQCCN2L3sXjNJP35C+NxpZQUO+cINTyU5zDxPQhtgwcQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2099363-79a0-4642-2714-08d584b187a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:04.4861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Deepa Dinamani <deepa.kernel@gmail.com>

[ Upstream commit d340266e19ddb70dbd608f9deedcfb35fdb9d419 ]

struct timespec is not y2038 safe on 32 bit machines.

The posix clocks apis use struct timespec directly and through struct
itimerspec.

Replace the posix clock interfaces to use struct timespec64 and struct
itimerspec64 instead.  Also fix up their implementations accordingly.

Note that the clock_getres() interface has also been changed to use
timespec64 even though this particular interface is not affected by the
y2038 problem. This helps verification for internal kernel code for y2038
readiness by getting rid of time_t/ timeval/ timespec.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: arnd@arndb.de
Cc: y2038@lists.linaro.org
Cc: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: john.stultz@linaro.org
Link: http://lkml.kernel.org/r/1490555058-4603-3-git-send-email-deepa.kerne=
l@gmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ptp/ptp_clock.c     | 18 +++++++-----------
 include/linux/posix-clock.h | 10 +++++-----
 kernel/time/posix-clock.c   | 34 ++++++++++++++++++++++++----------
 3 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 86280b7e41f3..2aa5b37cc6d2 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -97,30 +97,26 @@ static s32 scaled_ppm_to_ppb(long ppm)
=20
 /* posix clock implementation */
=20
-static int ptp_clock_getres(struct posix_clock *pc, struct timespec *tp)
+static int ptp_clock_getres(struct posix_clock *pc, struct timespec64 *tp)
 {
 	tp->tv_sec =3D 0;
 	tp->tv_nsec =3D 1;
 	return 0;
 }
=20
-static int ptp_clock_settime(struct posix_clock *pc, const struct timespec=
 *tp)
+static int ptp_clock_settime(struct posix_clock *pc, const struct timespec=
64 *tp)
 {
 	struct ptp_clock *ptp =3D container_of(pc, struct ptp_clock, clock);
-	struct timespec64 ts =3D timespec_to_timespec64(*tp);
=20
-	return  ptp->info->settime64(ptp->info, &ts);
+	return  ptp->info->settime64(ptp->info, tp);
 }
=20
-static int ptp_clock_gettime(struct posix_clock *pc, struct timespec *tp)
+static int ptp_clock_gettime(struct posix_clock *pc, struct timespec64 *tp=
)
 {
 	struct ptp_clock *ptp =3D container_of(pc, struct ptp_clock, clock);
-	struct timespec64 ts;
 	int err;
=20
-	err =3D ptp->info->gettime64(ptp->info, &ts);
-	if (!err)
-		*tp =3D timespec64_to_timespec(ts);
+	err =3D ptp->info->gettime64(ptp->info, tp);
 	return err;
 }
=20
@@ -133,7 +129,7 @@ static int ptp_clock_adjtime(struct posix_clock *pc, st=
ruct timex *tx)
 	ops =3D ptp->info;
=20
 	if (tx->modes & ADJ_SETOFFSET) {
-		struct timespec ts;
+		struct timespec64 ts;
 		ktime_t kt;
 		s64 delta;
=20
@@ -146,7 +142,7 @@ static int ptp_clock_adjtime(struct posix_clock *pc, st=
ruct timex *tx)
 		if ((unsigned long) ts.tv_nsec >=3D NSEC_PER_SEC)
 			return -EINVAL;
=20
-		kt =3D timespec_to_ktime(ts);
+		kt =3D timespec64_to_ktime(ts);
 		delta =3D ktime_to_ns(kt);
 		err =3D ops->adjtime(ops, delta);
 	} else if (tx->modes & ADJ_FREQUENCY) {
diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index 34c4498b800f..83b22ae9ae12 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -59,23 +59,23 @@ struct posix_clock_operations {
=20
 	int  (*clock_adjtime)(struct posix_clock *pc, struct timex *tx);
=20
-	int  (*clock_gettime)(struct posix_clock *pc, struct timespec *ts);
+	int  (*clock_gettime)(struct posix_clock *pc, struct timespec64 *ts);
=20
-	int  (*clock_getres) (struct posix_clock *pc, struct timespec *ts);
+	int  (*clock_getres) (struct posix_clock *pc, struct timespec64 *ts);
=20
 	int  (*clock_settime)(struct posix_clock *pc,
-			      const struct timespec *ts);
+			      const struct timespec64 *ts);
=20
 	int  (*timer_create) (struct posix_clock *pc, struct k_itimer *kit);
=20
 	int  (*timer_delete) (struct posix_clock *pc, struct k_itimer *kit);
=20
 	void (*timer_gettime)(struct posix_clock *pc,
-			      struct k_itimer *kit, struct itimerspec *tsp);
+			      struct k_itimer *kit, struct itimerspec64 *tsp);
=20
 	int  (*timer_settime)(struct posix_clock *pc,
 			      struct k_itimer *kit, int flags,
-			      struct itimerspec *tsp, struct itimerspec *old);
+			      struct itimerspec64 *tsp, struct itimerspec64 *old);
 	/*
 	 * Optional character device methods:
 	 */
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 9cff0ab82b63..e24008c098c6 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -300,14 +300,17 @@ static int pc_clock_adjtime(clockid_t id, struct time=
x *tx)
 static int pc_clock_gettime(clockid_t id, struct timespec *ts)
 {
 	struct posix_clock_desc cd;
+	struct timespec64 ts64;
 	int err;
=20
 	err =3D get_clock_desc(id, &cd);
 	if (err)
 		return err;
=20
-	if (cd.clk->ops.clock_gettime)
-		err =3D cd.clk->ops.clock_gettime(cd.clk, ts);
+	if (cd.clk->ops.clock_gettime) {
+		err =3D cd.clk->ops.clock_gettime(cd.clk, &ts64);
+		*ts =3D timespec64_to_timespec(ts64);
+	}
 	else
 		err =3D -EOPNOTSUPP;
=20
@@ -319,14 +322,17 @@ static int pc_clock_gettime(clockid_t id, struct time=
spec *ts)
 static int pc_clock_getres(clockid_t id, struct timespec *ts)
 {
 	struct posix_clock_desc cd;
+	struct timespec64 ts64;
 	int err;
=20
 	err =3D get_clock_desc(id, &cd);
 	if (err)
 		return err;
=20
-	if (cd.clk->ops.clock_getres)
-		err =3D cd.clk->ops.clock_getres(cd.clk, ts);
+	if (cd.clk->ops.clock_getres) {
+		err =3D cd.clk->ops.clock_getres(cd.clk, &ts64);
+		*ts =3D timespec64_to_timespec(ts64);
+	}
 	else
 		err =3D -EOPNOTSUPP;
=20
@@ -337,6 +343,7 @@ static int pc_clock_getres(clockid_t id, struct timespe=
c *ts)
=20
 static int pc_clock_settime(clockid_t id, const struct timespec *ts)
 {
+	struct timespec64 ts64 =3D timespec_to_timespec64(*ts);
 	struct posix_clock_desc cd;
 	int err;
=20
@@ -350,7 +357,7 @@ static int pc_clock_settime(clockid_t id, const struct =
timespec *ts)
 	}
=20
 	if (cd.clk->ops.clock_settime)
-		err =3D cd.clk->ops.clock_settime(cd.clk, ts);
+		err =3D cd.clk->ops.clock_settime(cd.clk, &ts64);
 	else
 		err =3D -EOPNOTSUPP;
 out:
@@ -403,29 +410,36 @@ static void pc_timer_gettime(struct k_itimer *kit, st=
ruct itimerspec *ts)
 {
 	clockid_t id =3D kit->it_clock;
 	struct posix_clock_desc cd;
+	struct itimerspec64 ts64;
=20
 	if (get_clock_desc(id, &cd))
 		return;
=20
-	if (cd.clk->ops.timer_gettime)
-		cd.clk->ops.timer_gettime(cd.clk, kit, ts);
-
+	if (cd.clk->ops.timer_gettime) {
+		cd.clk->ops.timer_gettime(cd.clk, kit, &ts64);
+		*ts =3D itimerspec64_to_itimerspec(&ts64);
+	}
 	put_clock_desc(&cd);
 }
=20
 static int pc_timer_settime(struct k_itimer *kit, int flags,
 			    struct itimerspec *ts, struct itimerspec *old)
 {
+	struct itimerspec64 ts64 =3D itimerspec_to_itimerspec64(ts);
 	clockid_t id =3D kit->it_clock;
 	struct posix_clock_desc cd;
+	struct itimerspec64 old64;
 	int err;
=20
 	err =3D get_clock_desc(id, &cd);
 	if (err)
 		return err;
=20
-	if (cd.clk->ops.timer_settime)
-		err =3D cd.clk->ops.timer_settime(cd.clk, kit, flags, ts, old);
+	if (cd.clk->ops.timer_settime) {
+		err =3D cd.clk->ops.timer_settime(cd.clk, kit, flags, &ts64, &old64);
+		if (old)
+			*old =3D itimerspec64_to_itimerspec(&old64);
+	}
 	else
 		err =3D -EOPNOTSUPP;
=20
--=20
2.14.1
