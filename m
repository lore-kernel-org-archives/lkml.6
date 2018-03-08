Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487811-2-963803964914748344
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
    t=1520487810; b=mUbCCmibotnXyHV71Cqaz2KB/jHi24H5/PHLfzNTkJcmCYo
    xZgogJfKXaD0uxFejMAzDUYUxFaUERAc3KvwcdVl5M6seDHmThmNIudNFCWm2rqm
    ksBxOK2Ul6oiznEJ1YcIaQ3soX1i0f6V3a9TMYAtelgso6bfY41VhaupzE8WNRG1
    jCnbZFJjDnqUXCzJOyRgBGHHKBHl5hLSI0ue/TGqmZVG0qKA3N0DRZHRBeONMaSU
    mCq9p/KXrLwYcfIkCJuBAVPnkW//OavU2ecc6m9GbROz/IKr3k/7rKwenYRIEMB9
    7tALOfPpligMJf+/jNspNZpGBnf3w6nBBerXeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487810; bh=TFQd3E
    uYBfrpL7YX6OA09oXIPksD57hgLKvD+VPVW0I=; b=VbGRdRqh6vlYuuSMIYbvfk
    8tCwffHcsH7FKcZ2JpHAvRoLV1O3f8sx6mXsrwUgoaHse2cezZmEuJ6szut6HOKc
    2XL5W1zxTOa/2wpzX+8MZYQD5ICQ65vh1EIXjN2ms3f3tW9XvbZxy/j+aocNsFVn
    sAeNcEjFQJbvWAQULurzY9bOu+9wDRmujwmiHI94ph9XmdFYNxAhSv/MGRMOfr/o
    ZO3spUXiCOnTUPUNTuoH1S3Y2nbVdgtwFDrzeB+VWCtUYlh6r6R4acABUlSglsc9
    3qcDCTi6TbdbRzFyY78yUyNpLCPMGXbxgYYWMQXSeTE0R2M04/bNrmJyiVV7IRyQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QxKcv9ZP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QxKcv9ZP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965886AbeCHFmz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:42:55 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:58876
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966210AbeCHFFU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:20 -0500
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
Subject: [PATCH AUTOSEL for 4.4 017/101] ACPI/processor: Fix error handling in
 __acpi_processor_start()
Thread-Topic: [PATCH AUTOSEL for 4.4 017/101] ACPI/processor: Fix error
 handling in __acpi_processor_start()
Thread-Index: AQHTtpqFnxC+zTCB5EqAA480gxeADg==
Date: Thu, 8 Mar 2018 05:01:30 +0000
Message-ID: <20180308050023.8548-17-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:oeGtoWwXxi+Aj/83Z08T7FehPfHGQHlu4rwfsg1oH69Wx6y+bx8DN2/fPb8LGGhCAH2TysXVgPsYPx+2v88Tlomewc+KbtrR2Bs5KUS6nGa/X1xqvnh9u31nx9wJBC6mIz5Wkf/BXd+4HsP29G3pKoXIO/VSc1NAPHb8SehTjXs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a46a396-b24a-4671-f790-08d584b22b77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07276B336A4E04A68953BA24FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(39060400002)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(7416002)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rblzR7hbS5hkVdhBtSOPcq2lDyCm9aQSBJjf7cb26wdrpi2w2A94A4kWznkkUglCvQFvDSMo/BthQPXT72gYcdDrFjRr77k5fLFsj6dL+r7KAs2bd/6VNymUrRchFaLDoK4MXFd4vUqq5u7luu/4tiQQWPP0piZcSvc0zR4N58JPjZN6fauCwkOWC5O2OFDE3/25UlXvt0Tgzir+cCu1YUmJcwrqwgao57G9EDt6GurL6/COTdz4sQD7vHVYFf1v+oUxTHpE/x+ngB+YXqs1aWV2EB7NMq1HFVWLyFI/ATjTsI2wOb0es+ulfPltUB4t9B/SsbrLUiGErdbhCo7W7w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a46a396-b24a-4671-f790-08d584b22b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:30.4023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 11154a330f07..2c086859a0bd 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -259,6 +259,9 @@ static int __acpi_processor_start(struct acpi_device *d=
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
