Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245343-2-8316571273567456130
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
    1523245342; b=PFwwmZ4TD22yxJBzR47d2z5AbJiBV33oasDzdnmfLzk7anJ2d6
    BiqEFecrd9v2jkQdoi6UKkM4xJ164X2QaE6aw3pS3/Qb4RqMwvTmciP7BWpBGCL/
    C21ophm3LqCqrFhb47PTZi6U7pP/Jnn0NwVbrJexAsUR5rT+yZ7ydp0JUZfVgxqu
    1A0tqprliEKbpueVO09H2k2+PyAM7og4efSghc5HwVGHXIppGvxq4W8KoX9pTahd
    7xausZ3C2vNQTvwXiVuo9/tDqpVNQ+BA5nK+W739FLXKRBrjUHifXMSL91QqQ2Sx
    1IzdJlVvtvfiUY9V4b2Ddbsag91Ulerz5lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245342; bh=nzAqqIhkFo
    2PGsiiN/P5wZqdp8u9ScI8tJ509RF7mAA=; b=JFO5V/OwP8iUPvbnasSDBWGb+z
    DSDszgj/0fgZmYx90MLh9nNCB01buulWkYeTpL5Tbjr1bca0afvw2csORcsu26rz
    FXJH52kpgTEB3W4FWe3cfyWq6+QphAb5l+AVamT65SClCyIWEGMJwH0kDRrjWC6d
    p8kk6bVh+kJUVNKd+pr7hJ5T5hAEIeNDRcTlDccHiejG+ux4ns5ReoYs76p+TXAs
    Sesz2OnvSUy+hMyyhLWwRWfztbEO1g6f+GfVUz9/IxAAtojiijlTx3st+thAkIqP
    5/6NrnQMkOakKh49RHaEpClOmhJoxHIkhWEFcDBvyus4K5q88bpdyoWHzljA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X3R4I7Av x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X3R4I7Av x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDrYOmva+xqxu80kQucdaDBrCoZ7e4pEhurzanJYgs1/l5QAWh1YdX7t3k3vn3fiqpGmh7n9PcfEE3tHfOKzDaptFaCR9TGchMv/oLsKxHIYvexrf+E3
    5MxXoE1hCaXadkkV7TtmWBNkGIvBuzacxyUUd+UArK91BgwUeuWNx960vyffBjKyvWuC1vEG5FwS8s5IfBYvktCimGz1rQ8xf1KdheTWMiecvzX8uYBdBEn8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=B3FF5RL-cM_9xH5vuqsA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeDIAUh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:37 -0400
Received: from mail-sn1nam01on0138.outbound.protection.outlook.com ([104.47.32.138]:56136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754234AbeDIAUb (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 145/189] ACPI / scan: Use
 acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs
Thread-Topic: [PATCH AUTOSEL for 4.15 145/189] ACPI / scan: Use
 acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs
Thread-Index: AQHTz5hSrm75GhSMB02dvd5D0GtV1g==
Date: Mon, 9 Apr 2018 00:18:45 +0000
Message-ID: <20180409001637.162453-145-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:rVQMtuZOHRZX0hY6FIsafBsnhHbJJZ6TTQrR6695u8NUEmGOg9bxWUeAzjVwd9ip95vL5OvKCQWQxjRdBKsU4o3IKqp7D9Qb2bTAzgINtpVzc+7YIYdITphG+IGfkKLOeojWjRsPx00/1qlRsD4loQ8oMZlyEy/lUHD3HVp+MFXBlvS2FgtWM2XF18rP9Rlo11NGu7DBhfDq/2mOKCNQ9f3k/FBVHOKfSz/mmrWVeR/Da0gZqXQvgQ+GNDVOPDhI;20:4cS+U3LmoATM7ES/gTMhL+mKTfKHGJV5a+mpUqJ+aITMmWZmhIdGcWVEI3tjOMmdASiapN4ma47IhOTad3f0QiHUbcOT3I1k2BMJgdis0AMudJxeJpsxi3loGiLPoX4MxpyoPh0+MtIN0gAIFYHIdh4MCOrCVilp+Du1VdBeQ5c=
X-MS-Office365-Filtering-Correlation-Id: b654cb2a-8d6f-40c4-9845-08d59dafaf04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09209E8AD2520C690109E5C9FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(5890100001)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TdbpYjm7i8HohRgyoCNDDII6Mm612qDk6VLKEmvXqlPECbcB4cPoYGhY3qKDpXXQWJjeVvyCXXpHR7nxxvxl3KLGpDhPkQckEK/HtW+GXquDL6MUT8t1M/iCbZVs4an5KRwRtgHVWnujd+T+T/DTyxeTcJZBYEdBRMo5vbOxBkF5YymHmoibaUQ0U3cTFSz2eIXvL8cu9XZ8A4SCayX/0YBYDM5byUFfxhd/fCSKs2FaOtPxhxK9R/MciPTLxzos0h8i0w7N19Cma7Od8qDx+4kyE64/p5Z6ijP4JunJ1+zRVEUi42mWidwLXI6k2tEKpc4ho8Xc3fgyXumVGCPnUqqe4ffi2hK/XNU2i59j/C0thqCp68O+d1HEO5Gc3ZRGUQUvcaT7L6yV+n2cPNTbqPPcC+en0pC26rlGAE79gEk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b654cb2a-8d6f-40c4-9845-08d59dafaf04
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:45.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index b0fe5272c76a..8e63d937babb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1565,6 +1565,8 @@ void acpi_init_device_object(struct acpi_device *devi=
ce, acpi_handle handle,
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
+	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
+	device->dep_unmet =3D 1;
 }
=20
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1588,6 +1590,14 @@ static int acpi_add_single_object(struct acpi_device=
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
@@ -1660,9 +1670,11 @@ static int acpi_bus_type_and_status(acpi_handle hand=
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
@@ -1760,6 +1772,8 @@ static void acpi_device_dep_initialize(struct acpi_de=
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
