Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523247192-2-17613710790651785781
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
    1523247191; b=oTHypdX0jx3AZqImuHZUk64q8B98gc+SOJMybXuCDsP5zNPcJr
    jH1WRSwGeNTq5zm6FykGsAF0oM1dojVfkIeA0dBddZ860JEosUVsu7L2tWX1UDsW
    ht+1HFVn3zU/ADRlmvACCwpMHPQEeusjnbWyp1Yl8DFpwvdiuv5Y+OlTo0gUGTo3
    4D9Ps4Y/DG6LtgaGAflo7nsySlTHLVzY3g0ncekirL5VxyQiLjAI8Tz+nlv/Nghz
    P3sGFQIM2vlSLhSHm0rox03ujH/VnDXoeBT9//JwTTwThnUjzh1NuXZKS9zvxFz5
    mouCvHoIr/KymZedyeyJbjpRPziSvnUMwc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247191; bh=9DmJafAQpk
    pgi4qMJ9iAScXaTGyCINoVqYiVtbaGXTc=; b=AridJX49SSOkkrh4xJwPdxZZNk
    U8Ie/7GBtzK5+Uvg1FmuUyfnWDL14e+YIyXNoSoZ0n/MmK2WFieUgT3AI3M9reJe
    ZdMD9Iw5n9SWOXxlmxo+yZ0lmyPxkqk1gqWGAejTgOequ43xpYDPm5sWmPHKThYR
    jyARe/nrX1qPgq3J40SblQ8TAwyjjlzPmgPtTel943kfeaNhCVCU05JjLy8sChF2
    KDawC+wBMkcR7dZPRQMdnbxeEi0t/z968bPR04/lHBVupwXHAobiMmBmB5aOoRe2
    L5pwENrW7UpV72Zt3gZ2WnKwqCZg47pYwSFV4DF21IIjgzn1wTsvET/0dATA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZsxLEK4L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZsxLEK4L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJgNp3ZGC0BT27okiMHdSqOPRhO/fuunBbKfkrWID9ipkudqoYqTtOwIwg2utfIQ9k40oB5OhKRmN3jMZ8L6eSmbNUGNi3ieQyW2K2hAIZtYTB1LDCzG
    +Y8qwFNNmCsOxldeW8DCKNuJbGTVX4G/X3jtsvi5Q9pgm1mTa17hIXzQF3AhrVRFcRi4LEFQp7ywmRlDzdUv0WuD7SoOPTJ1DlNK+Y81Wru2bEGAN27BDdwu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=LJ-5F7uA5V6xs_NIBFAA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbeDIEM5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:12:57 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752813AbeDIAQw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 006/189] ACPI / LPSS: Do not instiate
 platform_dev for devs without MMIO resources
Thread-Topic: [PATCH AUTOSEL for 4.15 006/189] ACPI / LPSS: Do not instiate
 platform_dev for devs without MMIO resources
Thread-Index: AQHTz5gMmgJzrprInUqzTs0kheGniQ==
Date: Mon, 9 Apr 2018 00:16:48 +0000
Message-ID: <20180409001637.162453-6-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:b2LY2k8f9EdOlC3wcnkVOq1uO5RlLkwcWwXeIudj4JU0kmIEDrGC43lEIYShM17ZYdyfAMxjMwUf4YfgoGgq7ENSR3s7UZHvwG+IXra1s3qBW1Xbq3HUPY/AGGMV7PhQRqLvevxMqPMYSxD6IT92vkgR0/007EpntdBrF20dok6TnOyrcMDjjTrjpaN5zaql8vtxLYNUe74RMcVI7xLcm8RlY5rejLYPfJAwiWixz5TaLjQHRuyW4QJsO1FP1jbx;20:sT1Gs1UigEcy5ujqv+hO0F9R4Aim4V6GxfQc7wzwZna6LRsi+4p06RhPB6kddagbgiL9TX5wgQARquSVNkDCdVVfz4EM/Pt69k5aaPTHWG5TJb3Hsew8mBuZbwT6hwi2GtphFZVqID5WkXh37TiojQ7vncU+ikE3Od1O8uW7/l0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: fdece8b9-f4b3-4264-7ae9-08d59daf2f99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096862C694DAEEAB4484DC28FBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(5890100001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(446003)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pu1SWEh2CZ9XXT1e4wVdu1R2xWLkVXzsCWoiZAQkmHy7Z6P0+QabVAbS6O8z3sVXtwKXIBr6rkeO+8Ko2T4O5gcPSSjCj3MGOTTgaiovMyy3HQ2ytKm4Hf084GdUtY+CQpoqeI0f/6MHL74YJyRuahVPGeyMFpfe93Bp8LHNpTeQM5RW5kidW/KRDi2oS61AzP0iKm/VaaDe4qKXTPU6SBLP9g+0VIIJPJ5dKTSG3vVNd40iMlGRzHRuPRQ5DW+VAKUsrmqlBqr8oo80qpyp4GoaLjNhkVhPuenrQok65YDZ9w0PK9SwGOQkBtIyndnsqDtQFNMs9E9sbCJez5f+/q5uFVXz5qi9fw+a1JO38tIvdd/lGAqmn9eugbDbFn3x+76/JYVPbRzn5+zqP1/9JP1bf51ih5fbVhqeVZRD2KI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdece8b9-f4b3-4264-7ae9-08d59daf2f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:48.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e1681599345b8466786b6e54a2db2a00a068a3f3 ]

acpi_lpss_create_device() skips handling LPSS devices which do not have
a mmio resources in their resource list (typically these devices are
disabled by the firmware). But since the LPSS code does not bind to the
device, acpi_bus_attach() ends up still creating a platform device for
it and the regular platform_driver for the ACPI HID still tries to bind
to it.

This happens e.g. on some boards which do not use the pwm-controller
and have an empty or invalid resource-table for it. Currently this causes
these error messages to get logged:

[    3.281966] pwm-lpss 80862288:00: invalid resource
[    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22

This commit stops the undesirable creation of a platform_device for
disabled LPSS devices by setting pnp.type.platform_id to 0. Note that
acpi_scan_attach_handler() also sets pnp.type.platform_id to 0 when there
is a matching handler for the device and that handler has no attach
callback, so we simply behave as a handler without an attach function
in this case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpi_lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 7f2b02cc8ea1..c71f5a2a592e 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -465,6 +465,8 @@ static int acpi_lpss_create_device(struct acpi_device *=
adev,
 	acpi_dev_free_resource_list(&resource_list);
=20
 	if (!pdata->mmio_base) {
+		/* Avoid acpi_bus_attach() instantiating a pdev for this dev. */
+		adev->pnp.type.platform_id =3D 0;
 		/* Skip the device, but continue the namespace scan. */
 		ret =3D 0;
 		goto err_out;
--=20
2.15.1
