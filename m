Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244963-2-10373005774327778666
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
    1523244962; b=Um3h/eBzXFGrzZ1G9HE/l1mKUltq+y3sqTl+fb08Tizu7zZBem
    csEa88tahL1gVo48426ppLR8aehS7jA4tzeYf4WgIY+5BsyhSw6/hqDuM6eBLVYa
    XUST6Jfpv1tW/JavTP0DchHof3PJCnz1tmUKapdMqtVH+amqK5Bcrz1NIQv1jxLm
    FV036oxF1svt3Stu041GDQpbmQFethQ7vsreU3874Id4TfUrSTbXUToD4RANoIxW
    tsRGM+Ftd7Z9A92X2pFnQxiAoLsKT28dVKjhWWf5lZUjL8A2aAK3Tsg1TGhRuvfo
    LicbevDPxF4RBNaw65jGIDvrCd/o6NkDpZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244962; bh=jf4oRWtZ2W
    ak4hwLu/SSwqBSQ3StucjuEFs0HGbX2Ek=; b=dLor5y56hjbOUjs9t56foRI1Me
    AxLzG/tTaMg9T4do+u6AN5BXs2zDC2Jt/59LFuR/wa6h5OTR/1W6Iy2gg+PGKwS6
    yhzgStCfczHQhfOluKEjW+cMbuZ1/5+CzIMaM2k1vGhcvKCJi/L1RNKjb1m9yCsE
    uvYBiJhslss3EFMkEBXe+d2tFPWWhJNEhmYH98GN4IAQPywrzNVT11X8M5Qalqco
    4UdXuSOA3TZW6VTyJZQxwtJlxP084xoQyAUjL1ljnpjjmhYj9TuB8teYWEtiFs2I
    +LWm98slJotJpBAZ0K1wak4o5iv7URfsf89uWE/8WoQq8oGp8WFAUMm3rx4g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ogGhBbZa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ogGhBbZa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDpXWQPD+nzsdGTL/QllgX+Ns0GhhK2X89QpTcP8ifPMu5XZX7k48pNRQe+H1vJGwAFeR+UBnFtqPdimz+nnvBzjasyl1VCfJkcmNa/Lz7y5v36Gk+rI
    hxAmCxjm9MulYpTGBB6zLK+FLksDiyLG+Zjrkh6PV0qwWgZ0RqdsUTBdxPaB/MF5zyfjNG5FO3ZT0Oix7WCjWrBpguWvu+5jtyA3K59+QtTWVPQiMCDI60wy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=aatUQebYAAAA:8 a=yMhMjlubAAAA:8
    a=pXeBbtYkOXvbKU-YMDkA:9 a=wPNLvfGTeEIA:10 a=7715FyvI7WU-l6oqrZBK:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDIDfp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:35:45 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:4000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754411AbeDIAVP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chen Yu <yu.c.chen@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 166/189] cpufreq: intel_pstate: Enable HWP
 during system resume on CPU0
Thread-Topic: [PATCH AUTOSEL for 4.15 166/189] cpufreq: intel_pstate: Enable
 HWP during system resume on CPU0
Thread-Index: AQHTz5hbRQtn7uEcYUmTOqKGtEmP1w==
Date: Mon, 9 Apr 2018 00:19:00 +0000
Message-ID: <20180409001637.162453-166-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:qyNnWxPxr0Dqyrz2X/tEtCi0il9VGUNylxLFUa3mRSmtYWhWMBLnPqzy8iimSgNH3a3A3o+vO9Q4sY3Bswbyv74cDR9hYfq27xMSUbWivCCdtrpZrMzPHskElUGH7mpN3A7+hovrJpwBofdDjjGHFVZIOryecoXobJBNnddwCc1yxJtIln2YeLwrNv4WOhPHat34WCupxUomObNdf0rVOztwbrp85m+0B5YOWHxDJ/iGSk4YZMOyLshfb+or5jf4;20:iS+JY62/yr4N30IxWoBlM1PS8VxPSLlzOJC81eMK7vSZvbi8UAMWKEdIntUuPTKSuKo8oMNt0HTAE/aMQaQDwS3oPPSt6v0St22/1WardAdlmpqKXJIcUMewF3os9TgPen0GTUKYaEyRqkiAXQJZkcZDo4e8W0v2vUXP1pACmiA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8fe25d9-ce79-43e8-8d6e-08d59dafca50
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11103FA0C6631EAC865EE6BBFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(228905959029699)(54914632383503);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(54534003)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vX/JBSufBKGZk2xsdLRczdTuThomTyLIL20aVc3bYlFbXE1pQf6PCQn3VLXg+DIgpPJ4jkfoli2Qx7uun7UnHiBfq0dSI8r+IIj2Ye85Bt6S7pLBhTsU8B7imJrulhuLYaJFPjLscZKiJnHPT01MFGvLVx1eWyjpgJxwgIdae1b6k1U6gHGLwrV5XP85Kot+VlgZ6QUlFq1aKwysnsvOr/+r9vHm0l6pEwtHOHTeEN4QuLQAOD8e4A6Em5Mew+E0Dq+fdaXEKB92klnWV6E6AH5kE43ZbhArE/mijUvt8ScQQL5YDKMp2nLhKseO4nIW7K98b1JYu0JIuBQp8p0D+MOkY7KGSDy2HaITWm6FwilXcF3VQsBmrhEPuTQHQ1hQkZKscmiKR3oJBUbIlzgma7Fy9KVe+BoJwjrNzENBQNA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fe25d9-ce79-43e8-8d6e-08d59dafca50
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:00.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
