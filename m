Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233282-2-17848014899804476374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233281; b=IAc7r4mzAZsx6Xn+Fd0a/x7iu69RVQ0j8cuzTWOrAbMJgGoENC
    5jlBfZ6qFXxBOnJiaDsNOAwkVqu58OgkEOxbK9Xr4b/jrwV8vVsjBlsZrLO3Jznn
    35sCfdLRg3o3jVHM30CbGVsZdlWJSxDAd3sOeZO9VZthbVIhE24el879px3xeCUY
    v3V3cKZgkfFmOK0/BXPTAYW5zTM1c4WI25pk+PZyroiNAo/bLUGLwrfYyXT3Gey8
    AziJPOTCSynAzxXsGGO8E/W8BtLxSG5ESvjY2DGf6oUnsGvkNXpy13uyRBx8bkaN
    um3HyZH2YrhdhqowkqkN4nabvp4BnYAy/7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233281; bh=stxwsgx9io
    ubXT+0D3lj3L37pu/Ovc9bsbxI7EacnIg=; b=rFatKsEYUmbblUJIgSbNCZohap
    3elLXnUKmLOZFQjGeCXe6Aa0IFS4qWPHB4I4tDVd14+tlfBFdKcSV0gYlZ/wtMa+
    hnLxpyuGwQ9GIvvlytFYIS4U/YUWkQDY0XC8YJVmGcrWeljoja+jRyMTa7iyGQQD
    /6hql7v7ZJot1pVIAOzojXW32YN7IFXhRRiCrMvxDxojnw2Oxz5OIoKELWhSWzQ1
    0vLuU6VHRupbU9i1r01v8/txEx7bITZ009ZU2JXKJx/Gd5STiR7wGs69XCZYyo/O
    Yr2yNR+ZteW5OfKU5jHsVqQsLxKuPTgd5KWYcmvmyvxsL4g9eTZANd+g4TNg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WaBHQccR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WaBHQccR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNCWKN9P0mrelPb4xB1+KgaxupfCZXFUd9AHDx++hh+lBfL2h0oLMX4VN1o7z3OgTOAl7QbLNuCgE5IAnT2L1VEr44Q1wn+Xu9wORc9NB1L+An5QhEOr
    9pLm7XeZwvuthPqyAXCd54ofzjmKODtPYwytOYBt+xWNEPZ/McaSAQO1IE+6Edxu/G1aOh+9pSRnFRg91ZReScVb1TRgnKdUFAtow/dxA45VFrfpdZz44yVa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=KKAkSRfTAAAA:8 a=LpQP-O61AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=8kmFWWlJgvVvTF_OhDYA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
    a=5Fwelb6nHmtaVCR9:21 a=DL71O34kA9KsCa57:21 a=wPNLvfGTeEIA:10
    a=cvBusfyB2V15izCimMoJ:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeDIAVQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:16 -0400
Received: from mail-sn1nam01on0130.outbound.protection.outlook.com ([104.47.32.130]:47481
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754368AbeDIAVI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 158/189] PM / domains: Fix up
 domain-idle-states OF parsing
Thread-Topic: [PATCH AUTOSEL for 4.15 158/189] PM / domains: Fix up
 domain-idle-states OF parsing
Thread-Index: AQHTz5hYc68iXFq2Q0+F2Jj40Togrg==
Date: Mon, 9 Apr 2018 00:18:55 +0000
Message-ID: <20180409001637.162453-158-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:TXIEWWtv8OiaDgTAfv4zxKJQ/teafIvgCo1XIOX3Js9iBejZtCKSlLxT1taIWEO/fCKmSR5y4cpGpW2jbn9IFkLd2ohH3JaIfVVkRHDfupA8bRyc/gG2vWGBL3Yk97VIKEnx+yJ7OffMGffGe1FKCR2vLA4/UwKym8aND94PU+GKts0l7CwoyIfU9ZUiC+AZsieTcH9GOpTXnzdrrjNeIBeIKtkFO618nztt4vM3ckt4u8ABhYpFZh5kMCJc1hj+;20:j9c2R+YZOCqaKNN6IC9eQsi5W9Ss05+cUso0oURvFVTgSpVKl/uyHsiPvUH+yMLdiw/dAsXU1PtgsGd3RraseQZoT/t3uQGKkIeoHCTY60R22M1FNqbIfU8Q6lAQU5ZQkSz5WsrpD9P082avM2srYS4Kt8QHU28zj0gA0z9mfS0=
X-MS-Office365-Filtering-Correlation-Id: 923574c2-2480-40cb-32e6-08d59dafc686
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920DFD4FBE61D71142492C2FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3FupOKxTxwJrs5JFnU1YJWR3V+lT1bjslPuEVHXAkZn6m0dc8SL9md5ne7Wk7oaJ8EvTAF7fVkVpHyAmIzUeP5duHkPc0nizxvvdWisWZYc9JK6nnVVC04TvuHG+z1Z9PxWxn5PiTNBVRvOkZG/tFUBBKWXWFSFEyYBZG9jPptIoK684TWKI+7oXrhhf0V3//UTwOqhcFIuQA6DD0L5D97ThN8tEi2FsDsvd3IgBnzYoO9QNSHCtUnBv4fz8tJAem7xXGvXBkQqMxMXP4bI9BCMJAOMjTou+l1Lj1uAGpSXNS94ZgvnSHv0d1zJ0zXMsg7DDihQ83hEhj+flLjIflquGKDK0J65BYBXKf/zabRYY9hTHxMzN7Pr2yAGSPj05HLpPoAoL6zwePKBqN/5Frpkc9dPuxAKv6W6lmuM5dSI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923574c2-2480-40cb-32e6-08d59dafc686
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:55.2526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 0c80bea05bcb..69520ad6f169 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2293,6 +2293,38 @@ static int genpd_parse_state(struct genpd_power_stat=
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
@@ -2302,49 +2334,31 @@ static int genpd_parse_state(struct genpd_power_sta=
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
