Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245394-2-15446792073169115904
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
    1523245393; b=X9YCCpYiNRiIBz30f9+ZA/qEVOQkV6tevKVBqCaWk59ADHaXVq
    45BkinACpxJosArhsKwTDKfKWmYxxsj+7BgcYAfB8V8g55OEA4D8RUJ20ZaEeZAB
    CgrqxkvJzQ2z3de9W4o+urxLj+d8dyVY3LkmWqvKv+Nwl1V77X+iv0TJvzRwJJGP
    C5DV3dFpQPkwJg1+EVL80lAZ6EJ/Exde0Uv/z4ioEs8Mt8s7FJuA58Feoq/DS4Wa
    Xt2n7gG44ID1mgls59AdOMdWys/IvTKqstEzqwYHdEd27Cs5fPjAdNs07q5apMvB
    3dpkE/J+20867NXfiaCVigI6wZIcFmq/PSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245393; bh=SZh3vgQNdh
    Ags3O49TL/pKdFdGIycwFjLiFi0xOnDfs=; b=OqDSFvvp+Heq+udOeAmmYxqt5Z
    Nl4EWfh7TWUIMW/4tH/BkA8QHAyw+jpSgV+s23NeWbuEdHQY2fk+bIFfNRf0vOx5
    iugo1Tqp5bGJNI4TviHluPDtn/ehpuUgBvTuM1CyQh0864ylJeH2QR8aqH1IESzC
    QIGQ3C4wpnNdrSVg134IIV1q43j6U0TBmeMAZG1FHxeek55yDDl2Cj109um1utQH
    WPx3lrMSxW+b95O+SWW5M3gelxQSSiav0/IMGMHtO/xL23WE/6QmjNmBWErv9dT5
    obOr/46bIvli1OKk66uX9mvoJPJZc3nPTXotONOatf75uaJKx1w4FXNiDrsw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Diq9F1/H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Diq9F1/H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLp3xlhoF6+xnoy1/wBbdJuajiBtsjJ72x7p2AEhcylcoOoUOdlr08yWaV9z+GallLIK8j6ggzVPm/WXnOE0uAbMLNqi6WccTppqcxFefNQK9R5KBRHY
    drT2I80+mt1v0zQWI/zRMMefUQ3LWbSgdo5PXxXj6CEigL1IwXMbMzlK6/2XDOM4/IPtg4n/qivF+ClS3flB4YfenHBmBozYMOm/mKbqtn0+80c9h73l8Vh8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=CYiJnlRfHjPKm4RXAi4A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754263AbeDIAUf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:35 -0400
Received: from mail-dm3nam03on0097.outbound.protection.outlook.com ([104.47.41.97]:45238
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754233AbeDIAUa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 144/189] ACPI / bus: Do not call _STA on
 battery devices with unmet dependencies
Thread-Topic: [PATCH AUTOSEL for 4.15 144/189] ACPI / bus: Do not call _STA on
 battery devices with unmet dependencies
Thread-Index: AQHTz5hSTwdjrM1obUWEF8VnbFuX6Q==
Date: Mon, 9 Apr 2018 00:18:44 +0000
Message-ID: <20180409001637.162453-144-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:0Po4pOMIAYCNerjL15rLxZokkq1B1jbbKSpLRyBjYUf5tr9wTiwWeoEXK3k4IkYJPJ9if8+3D+C2CxVzDTkrnfuIRWK3WafoGmtoG4zPZulZqYovaf1wsBA9evMOOUW8dq0jwIqlU3S7WU7F33VwZIOgBtocd5Fnw2OY6SoRPlfmTBqAPrQ0mnfPCJdbM7qUJXe8egm8SWN1Z0e5Hmcok+zqrUge16xGFYIHQp/y6v3aGnorqmwgC8RhlHQ/Cf8i;20:5OyA8MnRF/sfJH5GHU74vMyfzW97TU0QOD1i+2t5SfXNv13SY2aZpTpdiAblGbv2wCUwVr8bNpVbYicaM8bNgk3xbGIPh0nCFciGe22n25aj93uattODfk6XRj42jevHffzSQTRtOd4DXEMQMOj34DPUE9N7mMZATe1t6Rmrd5I=
X-MS-Office365-Filtering-Correlation-Id: bb15e9d5-87f5-44f6-fdbf-08d59dafaec8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09200252D686588248B83440FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4yxqhu8kpeiADUELxr/FMvfFjNV5Q0dKqjqJuJEOG3uYsf1GnqjalEUC0IgXfB1NWrF9mxF/E7uTfcRqAg/fu0I/iLiMr5VPQS4//EOZbknd1fFzrI945RpLh/sfpzCBKcmOcy9pAxKl7Mtt8cB7gp9ukyPFHmAWW4IfH4VlMEzeyO+ScOEfMFcOFSj7vCut7klsVwflsQSV2KXZ8vOZNKZ9347JEWK2VbFeljeu/7mbeBUPL2g7afE4q6gO0FuxzIoCIUTyb85I+aDr0d+UCfRLwToJEvKXQgNyH3yAnYnYw1/VvDR+AutPJJra1srcdLIL+imHrerJUGa910BSUK8wXV2J9WNDgzNbt7YHgoqaDkZhcxK8/+lj2KFhICOocyUnc53dhxXSpPOzjzIZMmzlc8R3y7MIIC3RS6f1Fbw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb15e9d5-87f5-44f6-fdbf-08d59dafaec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:44.3781
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

[ Upstream commit 54ddce7062242036402242242c07c60c0b505f84 ]

The battery code uses acpi_device->dep_unmet to check for unmet deps and
if there are unmet deps it does not bind to the device to avoid errors
about missing OpRegions when calling ACPI methods on the device.

The missing OpRegions when there are unmet deps problem also applies to
the _STA method of some battery devices and calling it too early results
in errors like these:

[    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
               [GenericSerialBus] (20170831/evregion-166)
[    0.123601] ACPI Error: Region GenericSerialBus (ID=3D9) has no handler
               (20170831/exfldio-299)
[    0.123618] ACPI Error: Method parse/execution failed
               \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)

This commit fixes these errors happening when acpi_get_bus_status gets
called by checking dep_unmet for battery devices and reporting a status
of 0 until all dependencies are met.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index b6d58cc58f5f..f0348e388d01 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -146,6 +146,12 @@ int acpi_bus_get_status(struct acpi_device *device)
 		return 0;
 	}
=20
+	/* Battery devices must have their deps met before calling _STA */
+	if (acpi_device_is_battery(device) && device->dep_unmet) {
+		acpi_set_device_status(device, 0);
+		return 0;
+	}
+
 	status =3D acpi_bus_get_status_handle(device->handle, &sta);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
--=20
2.15.1
