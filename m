Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238362-2-3807267245956703370
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
    1523238362; b=rxROAxcIjLY5hYBYvez4bcLDEoIjqys8cmai6qSBkBZ92ZB9Of
    uPbLHSTUDDrAKQSLIVqKTGFp7GjkkBbmqtNZFX3PDw9sBU3vzsO8Tf3p8bq+7m2N
    wNMsexwH9BagIAqU9OE5VnRr+/gmT4HzKfSqyOjYFDh6dAjMsJ7pYR0soR1OEG7h
    QnxHBgYMFRiFFhFWGIIJmduJPHTxSbskTV+CKMYHlAwchzQbmVvCToJS8XF3He1v
    W80ohxs2EnOZJSe8JmhO6rK86elID5DEZIDETUhJ2AFxX4ffNOO7dXR7ZIyLk8lD
    90UdqTLzznUBx5357wWQ3+K3P+2ublpSRehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238362; bh=AmmNcf22jy
    /D83+yWeyCpXNfrmBHbmH8R1od0zxWFWw=; b=sh6QUVk7wWvpMHrd7nHntN4Q23
    SgWi9EqAIYYirz6l0FQkDeCFcqkiApHYr0TNqOx6ZmDoXe1DsH2XeZW0UK/4Xky9
    UpwJa0D9t8lRQwj0m6QlXJc2rEV5qCD0KeUqewqP05Hb6QYHmmikSGAF47M1bZkN
    Ul8EyBRPmjPLkfVTlSmgQX6e+QZ057tDf/bxKUgA4W8JgiKvXvme0VsYA+SwDa3r
    PZL/FxUG2xEuIIYhnOHD0H1aRjLSglKHpBt6TKUiZHD8zFvy6SGcrY/RdlkGoYrB
    f+PCCV3lrLb2wqM8xrzSPQaQGglIe2A/Hv7aOk4UWYuuf4Ees3LBpJsypktw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iu1CYwDz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iu1CYwDz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNKILV2vjC+ZsmYoD2TJHfAwdNeTNeqdTLgD6VoFQ4Dp5IP4hQgZPTKYaHFJiOcpEnJdRITjtAUIQD4pgGPhMzgcfCUIa2fRbT2lTQ9ykfE+goivk9+E
    58cHRNA6D3l+gNKbamoxNue2iit6ZBshD8NvEb0sIndA7RmjGy4YDKlovH3XLK0S30f71HQ6/11bxHAjTB6dNGVlK9gVkAQmUrTCZHKYTiEwVFR5Do0w6dJS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=B3FF5RL-cM_9xH5vuqsA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeDIAel (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:34:41 -0400
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:14317
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932258AbeDIAei (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 271/293] ACPI / scan: Use
 acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs
Thread-Topic: [PATCH AUTOSEL for 4.9 271/293] ACPI / scan: Use
 acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs
Thread-Index: AQHTz5llt5ixVzwoukGKqUfzAJzjyw==
Date: Mon, 9 Apr 2018 00:26:27 +0000
Message-ID: <20180409002239.163177-271-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:3hIxYZ0mDJf4Ld0dC5HWg5LiZNyHupHOmp0OcZWSFR3mVftt2g3GGG4Xntab7w6h/b56URwGu5xhpsPl09oGEJUEyGLkZ78LULHe/eUrbwAyglH+a7y8uHDwpj8zsevwJ43B0XW3qo77o8ARRuSlK68lxf271ghf1vnX7rLtfvara25HdM5HEA2btHffBZt2HU7vUFhg7AkZ3D2/x8AJxSBjMy2luNof2DX+lf664+oOKKw24Tyvm2HeUbur9yjM;20:XDXtLutEjsfIhDv5LiweIiH0asjr+0FS3HmwT3N8ySF5m21qpEQT1snnYqP8vwT8ek4w9UjKVYAKPn46bOw6cbL+2gjuDSDadD/3fgufa2GAefmrJcT/YLnS8kqFRjoLosX9ecUiWrf9Smo94jAyxLFAW++U+w3tmt0S9LdI1tE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e83f866-4b5b-427e-564d-08d59db1ab71
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09843B600DB3D91E8441BB24FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(5890100001)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(575784001)(86362001)(305945005)(2616005)(476003)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BmayWDns+gekWDKZVP8VZmczx+6C4lkNsl/rwkjbkwnp8TirpV5B4xiTwwQwF0jyY5utYYJNzRnoVdCKyjkh3ZGRZyy9DAAkpOITcjGMlM8alrYFoEmJkyTbg7daVwWP64XLIpnCz8owUKoO9k5qG5F+6fXYSvyhC9yTiNmDKVLLJFfqmbutGOTlGH1Mbl80yZSZht7fKmnRqKntSj5oC/68zCytiCpPsoYm9xqRMBJPsgVVXyPLCHzPiTWnFVgsvJpoyEO2RSCq2Gda8sKBC3Q/3JIZVjY0bTS4KswGChcI2IzBp+201SdKK3N2WVkqt5+z3GeMSeXZVM7amNgXNuCMCXFSmN5L1ZDmTt3VaV5bWDwNAkruNcaDBPLg9aBmh3XLfAljI3nK5XGymQiybyA4+S50JxZjkuIEskZgvPk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e83f866-4b5b-427e-564d-08d59db1ab71
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:27.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index cf725d581cae..145dcf293c6f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1422,6 +1422,8 @@ void acpi_init_device_object(struct acpi_device *devi=
ce, acpi_handle handle,
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
+	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
+	device->dep_unmet =3D 1;
 }
=20
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1445,6 +1447,14 @@ static int acpi_add_single_object(struct acpi_device=
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
@@ -1517,9 +1527,11 @@ static int acpi_bus_type_and_status(acpi_handle hand=
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
@@ -1621,6 +1633,8 @@ static void acpi_device_dep_initialize(struct acpi_de=
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
