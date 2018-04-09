Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242880-2-14238948233213987706
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
    1523242879; b=ldbwg2eXZtjmQNH+YDlEdrsVZ7cLJDTPQkecRou42WYnjG0NMS
    HWKHrtGYQfGMJieNkPvKHRVi/6R9o1+wdMhP+K/eMzj/DXiXACWtB1Cd5P4NRFhG
    yibuvpebTcGEhzE8p5zXztynjwp+fR0VkVMqpNOL3c7zqkL6L9saCkltp+w/Z+JQ
    CBXYL/JYyzBoFghkjFhxO/PjExnLQMSA+ZpoQrdHaZ1cTIIT2pQn9FyUF4HFiSTu
    ntX9A2PNfxQUB0TVBGMq1hh8PV/iqCtpSqdHWYUGoExoa14obAQY47G8xiGTMhmt
    lQyMsu3lNALWLF+17axWF8QafaD3YoFpyeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242879; bh=kEurHlD/iP
    Y2mxl4DEe77fiXuvZtXxJ65xvv92sFci8=; b=lCpj74qhDNwABiNTRSa2whqXRn
    mDTCH/ZJjqO9iA6RorI6ikHxQ03Dp85TyBekxkVJ1/NVS4A0efsHdeSAVfVrh4QE
    ndDP/9xUfWOqSl/atvWtxVZdLX0pLSIp45zHcwXibsdoIyKepDOST8JVx2sXT2hq
    k0yPAlP+zsR1TobJf17dmcHrqx5yoRrW/DW/m7gG7wPgk7rjGbb4Ka/HhV/PJE7Y
    uSIJB0Yu8ReZDBlW/1dikFzZO0Bqo2mDd0oBdVefKa7c8WjTZkeoNnkAyEBlQXYK
    WVk9hSiXTOXMo21OruCvEeB9Cnj9OyyoIGRUcSbOBWOT6phxJauzZRn7LJPg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=avEaSRhk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=avEaSRhk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMLZWP/BOGsUGx0cr7u3xif2I0jsgb/pD3lVTVo7RSZf4p5xugHjN+TM6LE1oDk+cCe6aajk6HskNisdaFr40YRGtL0a3YPzozH1gZcfQWAARYgR5nSL
    qmALBcVadjEf1URTckj6fpqx0H/3r6U0EG0RZ5pZyyU9qQkHp138/WH6rcC9l8BgkOe5Pp/FC3VXAzPGgY/WgmzkF7JONmpdkuUnI5HdvAbOxxBm9QtfJcwq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=B3FF5RL-cM_9xH5vuqsA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeDIDAq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:00:46 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:17920
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755155AbeDIAZb (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 121/161] ACPI / scan: Use
 acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs
Thread-Topic: [PATCH AUTOSEL for 4.14 121/161] ACPI / scan: Use
 acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs
Thread-Index: AQHTz5i2Gz/7bt33BkCVgPsaFIoAAg==
Date: Mon, 9 Apr 2018 00:21:32 +0000
Message-ID: <20180409001936.162706-121-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:TpH2TfKeZcrtzbXp21k1g6jJT9g8/BDAGfF2Ny0sg+tE16mI+nCQeLPUuGsH9Uqz3dXbZZjvWnxQK8lxgit5u51wMQDmcwzzXWI1NeGhrRg2ogI9G+zna3t4qW3FAH1miTfvhzCO+vFmauuZJzatbMZJ4m9BM43XGJ3IQQjV5Sv2SERrrCF/pTHiLTxsXmx45HBfFxozjKJIC/SyBiMKplmARcnB4TM8CiK1CHgVSCfjZA8GoV5CU4NruDJU9GZh;20:JAHKPI2msW/GF2OrCAJV3w5jcqoM3nrKOlmrP5Q04FTjsWSo4VHnlcQLOkZ1CZ7k7iSQ4JOOo6yJWmNNoJwGMdKgR+FK+2PHP2P0HGC9xeOamhSXwIB0hPhOpQ0kTtAUejTR3gGSDmpjj0HDHz4lt+YHLy7ozwajmQaomdhNpGc=
X-MS-Office365-Filtering-Correlation-Id: 25b41ee6-7225-4f9f-f9df-08d59db064f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101364582BB6D13A5364D51BFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5890100001)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: w//dxRMkb/pBEdyr1zczuyB5M9EQ01BBAGE3gcPfBqvM1i1owb9J7hj+8hk8RHV7ZrDbYgyEbyH0eBwpu6MBfl6oS587s8GygKHD6fEogfh3U2rqH1HtFbjeY0zm/uVfdmfHrfLb1LfSfQK4h9b1N9K57osogB3kux2mruzegzEnSpOPshzKVbcBrl7RCGQV6eHSVVWWUKq4DoijM3m111JJyxsjDWNLZCKjLJixui+n8XzC4NRvRlPvtW7qvBkZqZf4R875GjPHyzNaU9afNNNphE/6qreFtofjc74DZ9j4fqwyqjLUGPuWgjpdeG2RlnwEGucDQqnrwfuCVdx+witUHqZJxTe/Y79nBh1ULZHmTf378auU4roBX47hNbZN2mCbSePp5HOe3wHAFUmhKu7IhidMXUVXSUjwa4swNxQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b41ee6-7225-4f9f-f9df-08d59db064f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:32.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 63347db0affadcbccd5613116ea8431c70139b3e ]

The acpi_get_bus_status wrapper for acpi_bus_get_status_handle has some
code to handle certain device quirks, in some cases we also need this
quirk handling for the initial _STA call.

Specifically on some devices calling _STA before all _DEP dependencies
are met results in errors like these:

[    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
               [GenericSerialBus] (20170831/evregion-166)
[    0.123601] ACPI Error: Region GenericSerialBus (ID=3D9) has no handler
               (20170831/exfldio-299)
[    0.123618] ACPI Error: Method parse/execution failed
               \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)

acpi_get_bus_status already has code to avoid this, so by using it we
also silence these errors from the initial _STA call.

Note that in order for the acpi_get_bus_status handling for this to work,
we initialize dep_unmet to 1 until acpi_device_dep_initialize gets called,
this means that battery devices will be instantiated with an initial
status of 0. This is not a problem, acpi_bus_attach will get called soon
after the instantiation anyways and it will update the status as first
point of order.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/scan.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2f2f50322ffb..c0984d33c4c8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1568,6 +1568,8 @@ void acpi_init_device_object(struct acpi_device *devi=
ce, acpi_handle handle,
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
+	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
+	device->dep_unmet =3D 1;
 }
=20
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1591,6 +1593,14 @@ static int acpi_add_single_object(struct acpi_device=
 **child,
 	}
=20
 	acpi_init_device_object(device, handle, type, sta);
+	/*
+	 * For ACPI_BUS_TYPE_DEVICE getting the status is delayed till here so
+	 * that we can call acpi_bus_get_status() and use its quirk handling.
+	 * Note this must be done before the get power-/wakeup_dev-flags calls.
+	 */
+	if (type =3D=3D ACPI_BUS_TYPE_DEVICE)
+		acpi_bus_get_status(device);
+
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
=20
@@ -1663,9 +1673,11 @@ static int acpi_bus_type_and_status(acpi_handle hand=
le, int *type,
 			return -ENODEV;
=20
 		*type =3D ACPI_BUS_TYPE_DEVICE;
-		status =3D acpi_bus_get_status_handle(handle, sta);
-		if (ACPI_FAILURE(status))
-			*sta =3D 0;
+		/*
+		 * acpi_add_single_object updates this once we've an acpi_device
+		 * so that acpi_bus_get_status' quirk handling can be used.
+		 */
+		*sta =3D 0;
 		break;
 	case ACPI_TYPE_PROCESSOR:
 		*type =3D ACPI_BUS_TYPE_PROCESSOR;
@@ -1763,6 +1775,8 @@ static void acpi_device_dep_initialize(struct acpi_de=
vice *adev)
 	acpi_status status;
 	int i;
=20
+	adev->dep_unmet =3D 0;
+
 	if (!acpi_has_method(adev->handle, "_DEP"))
 		return;
=20
--=20
2.15.1
