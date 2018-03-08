Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490441-2-17581555543499389945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490440; b=elA9YDLrCuzNHFN0QdpalfVoSxIlamB00+XZyYjf4D7sVsB
    ZBvHcnmYh8TGvX1/V/Yyk8XYR2bE7R3/cvFEVbk6G33chBtMWXPkgnLtcLnmVEdI
    gbqd06FfbwbwrhbMDpHK1xBOP2jzMt4zOTV6jpb2VeUKnjZrSVDvpFTq7EhlvNIL
    qXwwvMzn3Nl3aHWdOwKTy0nddNyb6X1lWP2s7Ldd7Iyw58ye5E/z2yCqcel3BaHd
    WI67LuZlZTxjwjUByN0eu4LaJB1YcC7JX14VUFID01P6rElfNVF+EB+4g1wxhvQJ
    /bC0JAwR9HC2IvhK+WQ1kui3dhEYPfAHtrKmuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490440; bh=9HAjvC
    oeqvUBgs1dle7JQzsAU4JOSh/+ltG3tWazgts=; b=rjxU5QwZnCXA2akZZTrgIG
    msQfq/lvrXK6Y/i09l3C+Voui/I9ZYRBGBivDcxSUiEKS1ED112b20fQqPM8swBT
    llJoTfJntUIbd1Go102eCaDFraFVb0sCajatGP8UE6xf8cSZuvmpg8aq7IcjaG6L
    7zTleXG6C66S3cOv7gHekg0jsD9Ds45weIdiEWODhHb9sRF/ieRlIHYoBBYF+d8k
    mDWmQHvAmics9LcZmgUjnNuvpLOtC8bSm2Lx7Nrl8bSdwjkB8WGscMnsrzzePVD/
    1riUJDv5D5731sMCfHmb1t7WKJVQLBU+0T6tDRzlhICA9ftk3nuG2uAPpShrAZDA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z/8gaHzC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z/8gaHzC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965204AbeCHG0p (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:26:45 -0500
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:53598
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755292AbeCHFAj (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:39 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 033/190] ACPI/processor: Fix error handling in
 __acpi_processor_start()
Thread-Topic: [PATCH AUTOSEL for 4.9 033/190] ACPI/processor: Fix error
 handling in __acpi_processor_start()
Thread-Index: AQHTtpouS5+osMnjNkG8uILI+a42Fw==
Date: Thu, 8 Mar 2018 04:59:05 +0000
Message-ID: <20180308045810.8041-33-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;20:JzBu9IyRblN4TTvsoEvPSzWNedAzt8robjjC418trr00IEXEc39NYfJCufqoktFajVxJ1Uo+aLDxjQkZ87AU3PnhexCZNJwPRhmiZsVNG7doMKWLkL7mPwXdXUlx47u3hOiwepLv1T7X4S9UZrXK7+l0Oz09mkNiIPRx9i8Cbzw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0876aaf6-d389-412a-2ca5-08d584b18802
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112A1708450B525A4D763E6FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(39060400002)(6436002)(6306002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(966005)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(110136005)(22452003)(86362001)(575784001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(7416002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 43ew/VuYC51GLJ7Zoy2lOMk3EwVw3Ektd9TYwDd3RQCYfHGrAsHzVcYfXksynyFkcb9FfGnGw5BMgtrjw7hho1Sk04CCsPQbh+qqc74atD7lSmtuas+KciA6SUUN6WiUPPn1JHujyYZ6QP8FKxlqHf5ovfssEgscltACUoeQSKkSgYzztjmy7sLik6C5ppe5B3r5PD0WKr+I+wPf815XKlUtLJnZ+PZAU9LBuZXXaevC76DDDAGndEcJvghnxt34JeOG103GiLryjPR5F9lyE2NyjBHi3fNagvYLPemTXQ79b0DZm1PHr/eeGKVmcCAxbj3gYlQtBZGLQnvX6S/tTA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0876aaf6-d389-412a-2ca5-08d584b18802
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:05.2476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit a5cbdf693a60d5b86d4d21dfedd90f17754eb273 ]

When acpi_install_notify_handler() fails the cooling device stays
registered and the sysfs files created via acpi_pss_perf_init() are
leaked and the function returns success.

Undo acpi_pss_perf_init() and return a proper error code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-acpi@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.695499645@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/processor_driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_drive=
r.c
index 9d5f0c7ed3f7..eab8cdad7dc3 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -251,6 +251,9 @@ static int __acpi_processor_start(struct acpi_device *d=
evice)
 	if (ACPI_SUCCESS(status))
 		return 0;
=20
+	result =3D -ENODEV;
+	acpi_pss_perf_exit(pr, device);
+
 err_power_exit:
 	acpi_processor_power_exit(pr);
 	return result;
--=20
2.14.1
