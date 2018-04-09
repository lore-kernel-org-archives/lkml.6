Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242545-2-1326984173100557024
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
    1523242544; b=OONtG9jzZEM+I/wYfAJhWQqQySxC8xFaHo1eSwMIKItVISQ/P8
    /X/Mx1vkJfjmd8t0SxA1k5698qaRFapApsL/YbjHpVBc39GllADqZfE0ICql4YKD
    rYR49QXrXsy1NxSJwVXucOanaqRJvmuUNdE0H6uaP/bha3X7heE9D4hjqBNBvrSm
    o41eHFEjwvX4XH+NTXh07rR/uI4L2BgxMdKv4GqePfg00QW3xNoq3xwJfyWyGGwd
    MpgA5pwBEjv0On64jmuWeKJPTsNBVSwWUZ8FC6oS8A6yQ710cniWE7L36KwPPYCB
    R4COc7DvIeXmZX/Hx7rwHPM9SQBpwjNEQQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242544; bh=kakoV9CdMk
    uL/glL+w+l5739qxSEUeGhjkDRELCkEkI=; b=cYdkN7mIqoz3U/fvbbwa+4q1sl
    vwcBlXrI7dnCEWr3KKPA4G9fZcPASALAG2vzCpCsYpi/7mb3pXV5Z+ULDKFZOxRy
    8grav85lJeBh6qfh5tOmc48MOuWG0DqgIoJueHJ0H78ZECIQjQeaw7JTgDJEcCb2
    9penD0vhZi7q1atMl38T4hy6r3yBgDYuXZag0nFtNq+HPMjyA0Uv/GvTBfLqBGgo
    RiywJP1c64LTBNXuLXsTVycfwy787lwjgJ/+AxtzGKdt/VmPi0PbuHBfw51jMEt1
    rW05+BJ8s1H0Nb1ZMr1mi+Cuqkiwu8t7nJsp9WDvtdGLjcACWSNB3YnLFGmQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LfpozW9b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LfpozW9b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE0PfTsf3qRqQdYVXVdYz1qo0VbkIIBaFvRPaXWPIlYg0ZRXjSkIbHEu57BSjy3FIe5w6RvkGXI87RisP7X8LTfM7BWbYcyPceXCVy3lYE/jk/fcbHDs
    fVCA19pzqGNOznvvzVYhl8f6x6XY1bPStgv5NhQDGXoq/F5LV40rsOasNsBuc3onfqPhtFF85fH4IDfZAG2f71rxw5WLipH08L6pkoNSDkIXkUqsJu/s37sJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=KKAkSRfTAAAA:8 a=LpQP-O61AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=8kmFWWlJgvVvTF_OhDYA:9 a=5Fwelb6nHmtaVCR9:21
    a=DL71O34kA9KsCa57:21 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22
    a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758138AbeDICzl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:55:41 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755228AbeDIAZr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 134/161] PM / domains: Fix up
 domain-idle-states OF parsing
Thread-Topic: [PATCH AUTOSEL for 4.14 134/161] PM / domains: Fix up
 domain-idle-states OF parsing
Thread-Index: AQHTz5i8U2QhzCmslEakZ+z4lRC8sw==
Date: Mon, 9 Apr 2018 00:21:43 +0000
Message-ID: <20180409001936.162706-134-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:Pi/KMvGFMl0TbZ1GcNYkGsi8YhMWw26ahBTF4dLyENqMTshly59q3IaitF3Reig3aZXfvNDXK2YSAImHQYxqb8zHC3oRwLr/lzwK47Dj1NYrQDHwsv7Q0GbavIf6uejJSoTO21ymRlbVZLpK1fo2MJTFvmMa5R+yFlStcMuJ4ZZpdlrAI+loQdqrVC3fTgqZV6IS1okBnfAMjTi0eyXEtVoDkf5F5Uk/+77GRjgyKagkrUPYv/oy1xaf1YnexRn6;20:W1GfnhtVwM9rS9iUW3FHuk+ukw7KYfqpxDjD1feWR9bAE3bylrI3hZ1p+M2wEbl5MqsyS8w69H+Um9hYMrp4XAh81Ro9m9GgKy/UIayOwXQdwZaL7625CJ/JVn9RCEd1PTi2WXGfsf6SiTGA3EkxUkGqnk+LK4vKTmtWlwnFGew=
X-MS-Office365-Filtering-Correlation-Id: 69fd2398-45a2-424e-6e8a-08d59db06c1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013C59A0F828A65B3F9B01AFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: s701McDk1IN1u/O3M58j8YX2DGoKX19seN1yXgYhXXusSRZdPOqx6Nvl9pRVmpFW2QFjjDjmWdf7CaEk62ZUQ8RU+qwae42nNRd9zI4Cj7Gw9YB5c1Ph7rG6tMm0+bGHr7/gQ2iBiHL1GQmUU0LF+meuSp0vwTDhzCpFz6LfxYA1xTjoIK+MZxKuBlogGXYfcpA+wZB+elQfHlLDpKFIY3kaTkO1bFPuVKJkZSr1E1guLF6+T5lwLCNUPVKfCa+ay5IE543MVslMgd1C8C6n5AsNyg7yUMAN8uXggKpnwiJ3WHaLnIVTDIW31ernVE6NV7wZLJ6HhzHPI3S0mleSxSaMkgeES4RT6dfJQgPIOES4ilO+ijQAKsjaip3g/9xZPMJ1bkB9u1poYi/uCMxnmnfZ/PmcPTcu40NK/dqp6do=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fd2398-45a2-424e-6e8a-08d59db06c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:43.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit a3381e3a65cbaf612c8f584906c4dba27e84267c ]

Commit b539cc82d493 (PM / Domains: Ignore domain-idle-states that are
not compatible), made it possible to ignore non-compatible
domain-idle-states OF nodes. However, in case that happens while doing
the OF parsing, the number of elements in the allocated array would
exceed the numbers actually needed, thus wasting memory.

Fix this by pre-iterating the genpd OF node and counting the number of
compatible domain-idle-states nodes, before doing the allocation. While
doing this, it makes sense to rework the code a bit to avoid open coding,
of parts responsible for the OF node iteration.

Let's also take the opportunity to clarify the function header for
of_genpd_parse_idle_states(), about what is being returned in case of
errors.

Fixes: b539cc82d493 (PM / Domains: Ignore domain-idle-states that are not c=
ompatible)
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/base/power/domain.c | 76 +++++++++++++++++++++++++++--------------=
----
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 70f8904f46a3..b3b78079aa9f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2206,6 +2206,38 @@ static int genpd_parse_state(struct genpd_power_stat=
e *genpd_state,
 	return 0;
 }
=20
+static int genpd_iterate_idle_states(struct device_node *dn,
+				     struct genpd_power_state *states)
+{
+	int ret;
+	struct of_phandle_iterator it;
+	struct device_node *np;
+	int i =3D 0;
+
+	ret =3D of_count_phandle_with_args(dn, "domain-idle-states", NULL);
+	if (ret <=3D 0)
+		return ret;
+
+	/* Loop over the phandles until all the requested entry is found */
+	of_for_each_phandle(&it, ret, dn, "domain-idle-states", NULL, 0) {
+		np =3D it.node;
+		if (!of_match_node(idle_state_match, np))
+			continue;
+		if (states) {
+			ret =3D genpd_parse_state(&states[i], np);
+			if (ret) {
+				pr_err("Parsing idle state node %pOF failed with err %d\n",
+				       np, ret);
+				of_node_put(np);
+				return ret;
+			}
+		}
+		i++;
+	}
+
+	return i;
+}
+
 /**
  * of_genpd_parse_idle_states: Return array of idle states for the genpd.
  *
@@ -2215,49 +2247,31 @@ static int genpd_parse_state(struct genpd_power_sta=
te *genpd_state,
  *
  * Returns the device states parsed from the OF node. The memory for the s=
tates
  * is allocated by this function and is the responsibility of the caller t=
o
- * free the memory after use.
+ * free the memory after use. If no domain idle states is found it returns
+ * -EINVAL and in case of errors, a negative error code.
  */
 int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
 {
 	struct genpd_power_state *st;
-	struct device_node *np;
-	int i =3D 0;
-	int err, ret;
-	int count;
-	struct of_phandle_iterator it;
-	const struct of_device_id *match_id;
+	int ret;
=20
-	count =3D of_count_phandle_with_args(dn, "domain-idle-states", NULL);
-	if (count <=3D 0)
-		return -EINVAL;
+	ret =3D genpd_iterate_idle_states(dn, NULL);
+	if (ret <=3D 0)
+		return ret < 0 ? ret : -EINVAL;
=20
-	st =3D kcalloc(count, sizeof(*st), GFP_KERNEL);
+	st =3D kcalloc(ret, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
=20
-	/* Loop over the phandles until all the requested entry is found */
-	of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
-		np =3D it.node;
-		match_id =3D of_match_node(idle_state_match, np);
-		if (!match_id)
-			continue;
-		ret =3D genpd_parse_state(&st[i++], np);
-		if (ret) {
-			pr_err
-			("Parsing idle state node %pOF failed with err %d\n",
-							np, ret);
-			of_node_put(np);
-			kfree(st);
-			return ret;
-		}
+	ret =3D genpd_iterate_idle_states(dn, st);
+	if (ret <=3D 0) {
+		kfree(st);
+		return ret < 0 ? ret : -EINVAL;
 	}
=20
-	*n =3D i;
-	if (!i)
-		kfree(st);
-	else
-		*states =3D st;
+	*states =3D st;
+	*n =3D ret;
=20
 	return 0;
 }
--=20
2.15.1
