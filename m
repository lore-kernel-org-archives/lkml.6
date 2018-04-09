Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242874-2-1051152874321524110
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
    1523242874; b=FhEBW2Z9VPKb1msQvIWZv3+uCZtZvfc7OXvjrmt1MNHP7kDJLy
    KsQ0jCQ95ly4cBLp+uh9xhuwxqp8N2GN5ackNXKWDSqfF4Xm03PE5LUzttwCwc4x
    ivSjZNpBAxzjYDPN/ytG7ZaBan/cqAkxJt27yi8ZAJARTRMxjCZs5ztH3YLtRDLF
    cmDrqVCTBPx0PdHNl8vbi6L6lRiy2GolEG+obunR24OlURvwngQLbsUZzymOPuIo
    /WfEzWXrJel6HZ+A47/JZtviT7dz2lbLT9J/2MhQgcOWz3lupNGJFHayyOQm24SF
    7IdjXfJQIn4tWOlNgxUCJ0gnUorbJrvYNBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242874; bh=SZh3vgQNdh
    Ags3O49TL/pKdFdGIycwFjLiFi0xOnDfs=; b=wRkIghPkiP9ZlA+MB6/PZlLGtC
    RwxTwR9DcToJoq+2qj8MWoPBmjE2NO0xyANFaZTGdxg+qrwPDcdiEc+R2ZQtozp1
    W4D+gmExqQWpJt73qBbEixj+UmJMfA9CHiUohGvMCimJ7ajeSDiRxiwSbzxDXRoe
    WkTyp8c5Hxi/u/eaiyg2camAVmJ6Jh3+FzQE5xl6AF8USbaYWbSvZljrr90qqGdI
    S2sIuyfbA74IbkdM6ka0YL7ZZAGgQKKPVSIxTwcz//dCB+/NT5m4MFr3UD3iWFiq
    Hq1R4ocN3z13BlEAIDEQ8O1fWqdzqrp8Jt5/CiidgcKVX6nHTE6zEaz8Ecog==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GeyydgPe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GeyydgPe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO+xldS8Pd0aqgVdKrBat2HFJVD7WIyjqISxYIA6rPm7KuDQk68kuKTOD+wxtOzhnc4+L6ANHPZQ+EZMC9o0f/TPRfedjiZIPqGFQmifpIlYVjujmzzf
    ykDZIEycweVEAO9dCY9rT012TIbRzh7GzfpgqTrYhZz49uHNtJRmE4FvQPaULfsP0UjByudrFPpPraAaRw7ql0Yq8hxis9m1mJ7NpGMGPhXX9gtFa+ffU+Dk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=CYiJnlRfHjPKm4RXAi4A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeDIDAs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:00:48 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:17920
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754338AbeDIAZa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 120/161] ACPI / bus: Do not call _STA on
 battery devices with unmet dependencies
Thread-Topic: [PATCH AUTOSEL for 4.14 120/161] ACPI / bus: Do not call _STA on
 battery devices with unmet dependencies
Thread-Index: AQHTz5i1wqT1oDsV8EGuNNwEfxthCw==
Date: Mon, 9 Apr 2018 00:21:31 +0000
Message-ID: <20180409001936.162706-120-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:4ynYo4vjtINKbtXQQ2rCf42js+rarmQYKINMwxlJWFfsqtpYHV2J0LUA7CNAnHm7TNEZgE5a/5PLBtzTqzH/NffBDyFQROJecGQQrKKeJA/R8O2uN2rnDawleIXQ3mztYNjx+tGADwZaqnNS6Rvw8DrMOSj74FswQq1rJ0rn2/TF9tG0SSTYrqU2tD188PSohDAOLNMRr0oFtNJQeChIRhtL/JiVADzk9pfrkYbZnwdNTbli/GxgDmOUhNHeZ4UK;20:5RbTacDR/pxY6EQQoEI+S2JDh/gepnX34hQawdJrA74LaDgOG0uM4K11I3nucyDe1JJjDAfb94maANClBBbNLOIYiV8Kt3ZhS/y0UAlG10equ36jEf9WYd5z3s4jsCTmcssHQO/o7MJf9cMIsfMHPeBucPsjv7maN6mDaxvLag8=
X-MS-Office365-Filtering-Correlation-Id: abf7c832-9ff4-4ace-cd64-08d59db063a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10133204BDBCC48194690941FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sbwBEQxJzSjycNxkSc2uoPQbPI4M4LPpoqdSpb+HTQBp6HI1ts7DIH1j2UaZcnWsfK2aIuFdEo01VMZvmg4BoVlmatsr4gzdve/kyA7Qhb/VX96Zc5qsoNZftyWelDLBdEVv2TVwiO12OpuPPVTk6oP0Ws5AvDSEUfbA78ZJ0suBZM3qO2l74WRqysy+7VDhnhLCAlboBuruElCsirFvhedp4no+/3Q9DNs52WopGD/rYmyYeQ+xFNUWmWoQqpZf+SJFg91o4n0rsP7p6ewgc4CeBSObYG1axRpwESIquG1zs2U835zTF+VGYAEsau7gaYZbViwM3sXzbSEEveLnoyfhLtTgdGuVgqM5QsCVwlq2+Qn14ilf1G6grnWPmI+Q/707GGx4gBpGh/aj06KEtuwQ+BRAY6RtnxCgTrWh+aE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf7c832-9ff4-4ace-cd64-08d59db063a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:31.6593
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
