Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474622-2-5616528790642647886
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474622; b=oA2hTooKwmysQn/+D+NQsaaH+MpEVcKq7YbXjperCRUVtq8
    qkT3Xh+g7kui8aLrG0k5ovqTit2X6T6IcQ7GyvWeNWmZK9YEoETsIzk8NIp1rEZB
    3YRUz0AV2LWjoru8/b2ognpwKOlseT9PgmqS2T6FrMLVhXa6s9Tqzngdw1d+d9wY
    SZTjIRjSS4hhcjdBA5LEZD1TZmD9623WkuL41czlMGnJrBDKf5aqtr1TfFcJ9IOW
    7uG8OjDdeJrFXRuIgIOIhysfYU4g56CT3iDCYZ20hjxI4u7WY0iZmTviapxo6pM6
    XDuYbNpoxxVp+4GqCnxVMCKFnbZK20ijOZo8RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474622; bh=3OX0qA
    j5jfFMHYdFMlJ4KNhnPYVf6Gdp1J74x/CklyU=; b=ZWxyyCdq5f0DZj8PWzSJBF
    Mqv4vxlmASJO7VlXjzv3r3DNZ+hRZ9eJHTUXsnqbjonghWSbhWXhEqRBrmdatQUO
    AAWlXfh5qLNC47BtQ1y5TuYMCAt0FxoGPzaf2eGcqAXqa2vUZWdB5IrU4lTU2IZ+
    uT0xSNbXY5mt1YfT/OrmtUFf6yR9VdVPfHUimEl7tDijmYGcR0U34CZytYNr4obP
    b2c++huOLcMbB6uOkc6L2v/t/bQPahzs0UHxRzjX3wQdmXZp+w1iYXzVlURa/QbX
    jPgmHxNVQHza+yDYT4JTOufxgr48qFJlPlUksD4pwfu95wS6N6G81X73hyN6ws0g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZWlSS/RG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduudejnecuvehluhhsthgvrhfuihiivgepheeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZWlSS/RG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduudejnecuvehluhhsthgvrhfuihiivgepheeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934072AbeCSPuQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:50:16 -0400
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:57771
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933993AbeCSPt4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 105/124] PM / domains: Don't skip driver's
 ->suspend|resume_noirq() callbacks
Thread-Topic: [PATCH AUTOSEL for 4.15 105/124] PM / domains: Don't skip
 driver's ->suspend|resume_noirq() callbacks
Thread-Index: AQHTv5nKeduELtCd/0CXDaa1vCMwyQ==
Date: Mon, 19 Mar 2018 15:48:57 +0000
Message-ID: <20180319154645.11350-105-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:l8VyMlP9d+1s2MhqQOs6lf2vOE4IIoEKcfKm2ZHQvHi/j8GbznVOuwL3SnM/IF5SBMf+KgQq9/+DjY6nIKR7I6BtpDaWqdC4w4ZfxWaU55OS22a4auR+LWePR8ln560LU3f6xjKomt98Kd78aBM2WrwMpbUO9hwRfg3wFUcxUhEu3OfTSuTcBNZU0zGK9XMmfwGq1gi7ZecEh/lxFGd0wnWgcQu3El38jOvAX5JLtU4ptpuHHls3t47r+QpggKIr;20:PaSiPuTy010N/4Vc9eX1pva3u/7zJc+hezuOD87jaTezM5SrHWrSLfICK9LTmjhZXioVbNIK3vIg3U7RbRuSzHMye7B+7ZbfiQAJqfOKGaVIKS5TYAPDNwE+Gxu/RpvcPGmU/CdXcOdgnRs03kotoicEz0hPvObnF6pCo0ReBjE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe3bfe45-3746-417e-f7d4-08d58db10941
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109EE1426B349C0A47591FEFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(15650500001)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: S2+Yj1EJYh/FB6SyaGJ00/9sD+5JsuipbqTbk+RSm1Mwy3bqBrGwCnqgymx22PkLob+ZW+xAS5VOO58LS/5pHrsH/SG3EXc53SomTOSTrtwk3K1hE2JlwAHp0d+8BNOxRmxWfMkNKN498BHAAbvlHrV2kun7C9SNtUai/hurRr/Gpr7z63V7LI9luvO1m7MUs3UGoKk5t9tljjiyUgPBNOmiZnCvyq36rO0mKajYMcFxYf8T+5OhaCHvE6HKFGSp30M0bL+h6pVbqVy7Cfkux5bu1JpdOMQkcixzaDFGNwpsdsZdLppPh4qKgWG3/IKQ23Y0ff/BdqMGAMqhoQZRMw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3bfe45-3746-417e-f7d4-08d58db10941
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:57.3118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit a935424bb658f9ca37eb5e94119b857998341356 ]

Commit 10da65423fdb (PM / Domains: Call driver's noirq callbacks)
started to respect driver's noirq callbacks, but while doing that it
also introduced a few potential problems.

More precisely, in genpd_finish_suspend() and genpd_resume_noirq()
the noirq callbacks at the driver level should be invoked, no matter
of whether dev->power.wakeup_path is set or not.

Additionally, the commit in question also made genpd_resume_noirq()
to ignore the return value from pm_runtime_force_resume().

Let's fix both these issues!

Fixes: 10da65423fdb (PM / Domains: Call driver's noirq callbacks)
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/base/power/domain.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0c80bea05bcb..b4501873354e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1032,15 +1032,12 @@ static int genpd_prepare(struct device *dev)
 static int genpd_finish_suspend(struct device *dev, bool poweroff)
 {
 	struct generic_pm_domain *genpd;
-	int ret;
+	int ret =3D 0;
=20
 	genpd =3D dev_to_genpd(dev);
 	if (IS_ERR(genpd))
 		return -EINVAL;
=20
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
-		return 0;
-
 	if (poweroff)
 		ret =3D pm_generic_poweroff_noirq(dev);
 	else
@@ -1048,10 +1045,18 @@ static int genpd_finish_suspend(struct device *dev,=
 bool poweroff)
 	if (ret)
 		return ret;
=20
+	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+		return 0;
+
 	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
 		ret =3D pm_runtime_force_suspend(dev);
-		if (ret)
+		if (ret) {
+			if (poweroff)
+				pm_generic_restore_noirq(dev);
+			else
+				pm_generic_resume_noirq(dev);
 			return ret;
+		}
 	}
=20
 	genpd_lock(genpd);
@@ -1085,7 +1090,7 @@ static int genpd_suspend_noirq(struct device *dev)
 static int genpd_resume_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	int ret =3D 0;
+	int ret;
=20
 	dev_dbg(dev, "%s()\n", __func__);
=20
@@ -1094,21 +1099,20 @@ static int genpd_resume_noirq(struct device *dev)
 		return -EINVAL;
=20
 	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
-		return 0;
+		return pm_generic_resume_noirq(dev);
=20
 	genpd_lock(genpd);
 	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
 	genpd_unlock(genpd);
=20
-	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
 		ret =3D pm_runtime_force_resume(dev);
+		if (ret)
+			return ret;
+	}
=20
-	ret =3D pm_generic_resume_noirq(dev);
-	if (ret)
-		return ret;
-
-	return ret;
+	return pm_generic_resume_noirq(dev);
 }
=20
 /**
--=20
2.14.1
