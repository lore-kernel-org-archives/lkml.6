Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242519-2-44367541084753717
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
    1523242519; b=A7mgUjnxc1CEzDxkwKBG3QG3Q5RjUj77H0K9QmdTHFlfyV2bER
    mKumGaQ01qUjfwRGOBXpc6mjVx7IbfvyyxBfR0jXrOCGm9qhwGOj8xHqrnqiUBaJ
    gilXHZd2x3ezd2pqtALtga7o2MGuMHHn0MFYrlHv+v/PLoQZo5/AGdXafiUTjfLx
    tNclqYCqB9WOsMkmyhl0unBXOW03SP5Uu7zCxXD9OkVrPTLydn6dDori3cw66ChL
    EFyzsJe9Xb9f6QHwkRPH2jAWxtBcOFf2k0sVBykxI+FWH+fWM8T8lmB/1als4Ba2
    Umm5lMmlShVUP5e7MZLeo+l9cyX819PZbSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242519; bh=jf4oRWtZ2W
    ak4hwLu/SSwqBSQ3StucjuEFs0HGbX2Ek=; b=NqsOwhE6LfD9LUjsW+EVDcill+
    dJ43qZT6xfftynQB31hu+pQerPrqnCAx3UeleaFHsr6gb+iGBVvwFu0ek6E3v9n+
    vXtC32ShSI4D2dumLpZNe/zLFLahoo8S+Fh9Z/V1SycfxOoqqBWAvMU96yncgQhQ
    foBRNcYO1Gpl5CixTTTh+MJSldK13ORgqcFPjQtRicN6gnt030I/2Om5ALktGFeU
    8rm0HOaY18zRkY8PnZyldhIhhuuelZb6apmG8OL9sPeCW+dSnUUB4Xnosv0SNifP
    BdchxQnSedcWkMBZPbcmoI6fSvlw8NZLLbpp4r+KSqANtzeSggV0undv+1iA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CBAD1DqM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CBAD1DqM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPavLDD+KcuNZM5aDqevdOHmiVxjnL3Wgcf4IWEEKXxLIYpATcn4LBnGdqxGDZUqW/c/qIJHZX3007fXUqv/cXbtxWUDFdRGXOTztMHCZHPDN1FZyjvV
    rTYl9/ZbuHP2fV+PteXiB7wTQctV5HBYRrDp7HS/NFkkMMKzxhTEWgOsw7QOTSvjklx7NHd/k0sDJhd2AZASDghoIWvyay84IWnY2NQaqOlKcP33pBSI9HzI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=aatUQebYAAAA:8 a=yMhMjlubAAAA:8
    a=pXeBbtYkOXvbKU-YMDkA:9 a=wPNLvfGTeEIA:10 a=7715FyvI7WU-l6oqrZBK:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeDICzD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:55:03 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:42928
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755249AbeDIAZs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chen Yu <yu.c.chen@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 140/161] cpufreq: intel_pstate: Enable HWP
 during system resume on CPU0
Thread-Topic: [PATCH AUTOSEL for 4.14 140/161] cpufreq: intel_pstate: Enable
 HWP during system resume on CPU0
Thread-Index: AQHTz5i/bWgaD0z9eECdLJBPnbG9tQ==
Date: Mon, 9 Apr 2018 00:21:48 +0000
Message-ID: <20180409001936.162706-140-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:i4hU+qOvxZay8ehh2wbWfTZx/6Lykj7oo1U36qY+KzW8ruK20+qtxhRmcPZe0hd9EufAr5/ATJiZk2XXkR/0gHoinvwm6YLjPx995+scb10Ow62QbhegBgO54lIdn1km/zW4RDyuLFuiSrSBlrSp6kEt0vksDfKeR6imnHq0NMpu+kq4bFBEeB5/W2YL+kw/F2keyYtFx++v0yxpl2qf61CpqNgJggBZMetEPFfuEnJ3qY5kf2BLnvFS/P2Z4m6n;20:d4ytSjl1K4Xk6A9P+MVLW8v8nQlDA2mN151KP0SSwumbcCasFtYA4RB2JAN+N/5UCNzPu5aobGeBrMSAH3wRPrZp7dX4wVjy/liPMAqI6g7k+5IA9/tm4q791jLA1pWp7r6kiWOwzSzwLk48i/Mx8HPv2VrAZr8mdaDSMhPfIjk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1308329-bc5d-47f9-26e8-08d59db06f00
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07250D5D91160E2F2C9BC715FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(228905959029699)(54914632383503);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(54534003)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(575784001)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: leFqJsbexc6HRi3vE/P3P9vpB8Nck7rHwd8iXKNqplmV1ttQ6BfIO7MwkHjh6IYt/pLk9vG/qKo3Ct0Pj7TT4nYLwO0HU7bUr+MSNsMcuT7oE1IWYT70+d8OjNaZi79W7v5F0iEED0Z/um9qhb8G9yxGNqmCtq70FLlKA9puTaL1CxcCE9bLpSK4JEkF+jZlBBaJI9BXdOHIn7L4WIgeMsCX1BmYocR1eQcsdXsHT95ZtiqMy5xYSogSSH4CUU4hCIbvXJk7oOFjFDCdvOEYYFYXL22TfJULP/d5B/CVmmy/hzRLRo5PTYCG4v+W11U3Ot3gNyGC/bpCSu9tNyoRdeHegZu02wGsHr4UR+Ex5HVLFV4+Ff+1OZLLS3WFsLewp8rX53oqw1MTzzaBP1ekeOH4G2/oDuuJoO95HVmGJFU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1308329-bc5d-47f9-26e8-08d59db06f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:48.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 70f6bf2a3b7e40c3f802b0ea837762a8bc6c1430 ]

When maxcpus=3D1 is in the kernel command line, the BP is responsible
for re-enabling the HWP - because currently only the APs invoke
intel_pstate_hwp_enable() during their online process - which might
put the system into unstable state after resume.

Fix this by enabling the HWP explicitly on BP during resume.

Reported-by: Doug Smythies <dsmythies@telus.net>
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Yu Chen <yu.c.chen@intel.com>
[ rjw: Subject/changelog, minor modifications ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.=
c
index 93a0e88bef76..20226d4243f2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -779,6 +779,8 @@ static int intel_pstate_hwp_save_state(struct cpufreq_p=
olicy *policy)
 	return 0;
 }
=20
+static void intel_pstate_hwp_enable(struct cpudata *cpudata);
+
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
 	if (!hwp_active)
@@ -786,6 +788,9 @@ static int intel_pstate_resume(struct cpufreq_policy *p=
olicy)
=20
 	mutex_lock(&intel_pstate_limits_lock);
=20
+	if (policy->cpu =3D=3D 0)
+		intel_pstate_hwp_enable(all_cpu_data[policy->cpu]);
+
 	all_cpu_data[policy->cpu]->epp_policy =3D 0;
 	intel_pstate_hwp_set(policy->cpu);
=20
--=20
2.15.1
