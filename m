Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487874-2-716348293736860400
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
    t=1520487873; b=Ryra+kRJu0t72Pr5znI2wBbyL6C8t1TtBUvVqb8XSjErgYC
    8hvtlnZxp8zma9Jyia2CGB8fiEdzX1+G22t7JIzmF6QNZYKLrQBIVqaMLPg+OyvD
    0GN40fge6ed2Vih+ZSHcdeuosqhaOsQCwUMh62Z4sjq0vxDGkpE952kr3YcfOwQK
    Vps/u6DHZyShjG0TK0eP4yO4yfSzBKhTgxpNm6Pqen5XC4IS+jQlGf8wdqrlPl8V
    luHMqXtNMHCnCJa2L1GjFGzdWiTRXat1C0vpLRAVwFVXaUoRteWVS5krrchkTyAQ
    6MsBY3FOhCi8vJQBa56Gtny2jzMetFmZtzA7xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487873; bh=sifkMA
    1g8A0w0P3XMg7xtOvjOOk8L0OQsIPGXNUW2Ms=; b=U58wCJz6OVtm9p9l3hyJLL
    tVhm3jmt8xwy4wLBWwQu9b6cCy+2z33Sm1vLudwUw6718q9dOFrNJF1iJKo8UBGn
    mzqojyJ3qUA435RGNN3+tI2e7mOCGE1/8QbwWiLszbn0dCQ0L3A2flKfKI6FKJZs
    bPVeuaV4W++jqObYmdIENXwB5Dtizw+7XcREsBcj7cbtYdkdz9cjCa7fP4EhJOLF
    ldO2y/50hx1fv5tdc4yFilalUW7onWwDNiA2MIiYw9q9RfchncfNK8aKlPN8NIdp
    0xBByAya5EgQGt3bSdIdiVVZrFdSVyPJ5r32362e3mfdx18PG0gSBFzwHdFOFctg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X2B3QnnC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X2B3QnnC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966413AbeCHFnq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:43:46 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:57824
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965993AbeCHFFS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:18 -0500
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
Subject: [PATCH AUTOSEL for 4.4 016/101] time: Change posix clocks ops
 interfaces to use timespec64
Thread-Topic: [PATCH AUTOSEL for 4.4 016/101] time: Change posix clocks ops
 interfaces to use timespec64
Thread-Index: AQHTtpqEBDIZRko9Wk+UQebCLAQO7A==
Date: Thu, 8 Mar 2018 05:01:29 +0000
Message-ID: <20180308050023.8548-16-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:C3EQJXXm6f88bmTUTfCiNZD/HG9Qb2yS/EU6gmjsBj3cimmbkP0HHjIx0PoFDI7u3irLyZo7uYRRzvA+BgLG/ZUaSIB5x/xxJyL9XGoosmQJrouWNATJb7MRnk4WiiCb46/JRVzCbT6uFXCFBFPvV9zIxb2jamSKSeEx1vkpxm8abdhIWeLgbPZuCFHPGgsjCiLIgDbv9zikZmv2tPTdM22MyNd64wzjPlbU+ac2ZlblUwmKHLp1hvYpew0Yysxp;20:FMcQYvwFDGX+cwn3PIjqXP4GVffzKlmsbfjRnZ2E1Qt6sPvJMZGCr1vIdGTXmjHpC7QbYeLspC2cUui6SlAeK7Enxp+cNDvot4DDdQasWdkGaaMQkTavOQyjKmUuDGKkp0lRcFrCMYix3uVwkcV/OMmK+oEmWPEA7M2GixRBMEs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e0152aa-c299-48c2-60ba-08d584b22b18
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07279FFDC003662DABC7A8DBFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(42068640409301)(1553240931313);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(325944009)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: qgVxibpnphs55DCJqfL8jkB7jQYCHzyWXbf0qJcXOKdsChL2/d4Qaa+ka7FzANdjyRWIIxdgnSee9b4HX7c9JsSR2FAv3QpK7jMbgb+Gf2CWA7YMPXZDBYvRsrH4HfSheYRvOHDICzaVh5MdEMPsqSpRrYPlsCTpifZxZV50fyWCGRV2JOPHZBsBcxazb0q5BS5jYA8p0Z+C4YXzQhI6v7NJs8oSw3IX/fvYh/OUb0CEBTX0ggQj95GQY4lLF2gmlD5OYHpohiiTalcu4h290G1gf1AprSvtl3II+/6y6nYMEW4kGVe2/piEfo5lelh451qkhTT63hbI2tGesFu+RQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0152aa-c299-48c2-60ba-08d584b22b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:29.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 2e481b9e8ea5..60a5e0c63a13 100644
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
