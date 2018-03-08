Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520489091-2-14256173121879295440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489091; b=RDlFwzopMOTB+H0DlsV4wfPQ1fDe5CchGKDWU3Fd5dtlrzt
    0WWgixiBsaTYdRDeSZwTZ55HjUQdIJSsnquu1GLfY+mGmF0ip3zQ8GaMjW5LDWdz
    QBu9UIf02FB+U1NXst7pMQr5xLFal5jSE18N0Edm+PAcsh6n1c0yl3qgnJwPtgUC
    Xwu54ipPpoM3aTC4U2vH8TgS6QrZ2RHAFkL4iPsOa9Y0akRDnvlpBhjhjKcNWj94
    ds46XGTY7NmaZ0zIYrodfzCUNbGDNLlouqv9s+IVeLBJtu16LvPR+pP0sc1H1Lz8
    JKW/x8uJCJnBkYXhFHwaaHTt5EeCPF+NnPgB00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489091; bh=5b5peA
    uz4rETuIZ48oKADfi4UMLkbWUgdz8XdGCymLU=; b=ry45UFZYmPKy/4G5CT6Uj5
    9Vhdni8FiWPHzhU+MAxAwG4Y0+G1u0QdcFRjYC6KfPQFE4Wav7zYnWX0XWlIsrBO
    KZMCoKHacGJn2ruFlQD270TrL3WwLO+rh6cDnTQc8+IbWmrAvyQWGD11ppvZG9m/
    0ZaRcKx3tZUenYwJNwUTfHRMBr1t0p7MaisYukJgpBEdg8jExR7odXvWlogOr/Z9
    n27G+1dhNBd5KTwmdo1EgdNiarxVVlCL68okyhfM1SpIuHTNvCcehTfqZGZNQKtt
    G7GOfi1/nEwIX7wEfti6Txapdd3G1trNuRxkaIg7mTHtjFNFzybohhMpgQS9eYxQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zq2LqlxZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zq2LqlxZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965249AbeCHGEp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:04:45 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965849AbeCHFCW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 116/190] ACPI / PMIC: xpower: Fix power_table
 addresses
Thread-Topic: [PATCH AUTOSEL for 4.9 116/190] ACPI / PMIC: xpower: Fix
 power_table addresses
Thread-Index: AQHTtppFDfNUBc77cU66wb2/0wyZpg==
Date: Thu, 8 Mar 2018 04:59:42 +0000
Message-ID: <20180308045810.8041-116-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;20:LhFnfdUx1I6Y3rw4nRk7X1vKCPSYcPROV+zTyD5SGamaXoRpBuEC+Ts3ouMmY7C757VOFEtAWpzn+kznFIGysn5Cc6TVvOkL377Odb0xi87eW0P6MtWi4yUUGxfdBMuZcd2Zg4saLriP4EUDcumUta7NcUbA/0BJPhr3+4m6Szs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3ef2523-9db8-486b-1704-08d584b1c472
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10638449D1635CF860E3FC4BFBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(39860400002)(366004)(199004)(189003)(59450400001)(107886003)(3660700001)(105586002)(81166006)(14454004)(6666003)(72206003)(22452003)(2950100002)(478600001)(97736004)(5660300001)(86612001)(6506007)(305945005)(8936002)(7736002)(316002)(66066001)(10090500001)(8676002)(53936002)(81156014)(6436002)(110136005)(3280700002)(102836004)(25786009)(2501003)(26005)(54906003)(5250100002)(99286004)(36756003)(6512007)(2900100001)(186003)(68736007)(1076002)(106356001)(4326008)(10290500003)(86362001)(2906002)(6486002)(76176011)(6116002)(3846002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zcVDVyKSqzQ7N5eABB4Oojm/j6IoFN+L0kM7GgwflUa/e5So0Ma2j80DZk8yesHDJX9nNXhxHNrav3uG6MQ9fYPQ9VvXAAcWjoidKfdpNYI7f5R/x5zomngeHYrhuibD2PV/XmQKB8MJIpDT9+7Nd/KqOVkDwW8aXRwjEviy7kDw7mg6dQPES+TnZl2o+gi8PlpTP94zcse9qM3M58RvcqQJ9a8xWf+Cjwn7Be1BVHaU8sLGmjZ2Evr2eBsXmIbsW1Sjz95PeuTAOdh8qXFKOZHh8UWeYhp91vISYeZUs+3h1DNsNeWcRQntgKWUJ3IjvlGzmvJhAQb1QN01tFHILg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ef2523-9db8-486b-1704-08d584b1c472
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:42.9653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 2bde7c32b1db162692f05c6be066b5bcd3d9fdbe ]

The power table addresses should be contiguous, but there was a hole
where 0x34 was missing. On most devices this is not a problem as
addresses above 0x34 are used for the BUC# convertors which are not
used in the DSDTs I've access to but after the BUC# convertors
there is a field named GPI1 in the DSTDs, which does get used in some
cases and ended up turning BUC6 on and off due to the wrong addresses,
resulting in turning the entire device off (or causing it to reboot).

Removing the hole in the addresses fixes this, fixing one of my
Bay Trail tablets turning off while booting the mainline kernel.

While at it add comments with the field names used in the DSDTs to
make it easier to compare the register and bits used at each address
with the datasheet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 50 +++++++++++++++++--------------=
----
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/inte=
l_pmic_xpower.c
index e6e991ac20f3..0c6874e6a9b6 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -28,97 +28,97 @@ static struct pmic_table power_table[] =3D {
 		.address =3D 0x00,
 		.reg =3D 0x13,
 		.bit =3D 0x05,
-	},
+	}, /* ALD1 */
 	{
 		.address =3D 0x04,
 		.reg =3D 0x13,
 		.bit =3D 0x06,
-	},
+	}, /* ALD2 */
 	{
 		.address =3D 0x08,
 		.reg =3D 0x13,
 		.bit =3D 0x07,
-	},
+	}, /* ALD3 */
 	{
 		.address =3D 0x0c,
 		.reg =3D 0x12,
 		.bit =3D 0x03,
-	},
+	}, /* DLD1 */
 	{
 		.address =3D 0x10,
 		.reg =3D 0x12,
 		.bit =3D 0x04,
-	},
+	}, /* DLD2 */
 	{
 		.address =3D 0x14,
 		.reg =3D 0x12,
 		.bit =3D 0x05,
-	},
+	}, /* DLD3 */
 	{
 		.address =3D 0x18,
 		.reg =3D 0x12,
 		.bit =3D 0x06,
-	},
+	}, /* DLD4 */
 	{
 		.address =3D 0x1c,
 		.reg =3D 0x12,
 		.bit =3D 0x00,
-	},
+	}, /* ELD1 */
 	{
 		.address =3D 0x20,
 		.reg =3D 0x12,
 		.bit =3D 0x01,
-	},
+	}, /* ELD2 */
 	{
 		.address =3D 0x24,
 		.reg =3D 0x12,
 		.bit =3D 0x02,
-	},
+	}, /* ELD3 */
 	{
 		.address =3D 0x28,
 		.reg =3D 0x13,
 		.bit =3D 0x02,
-	},
+	}, /* FLD1 */
 	{
 		.address =3D 0x2c,
 		.reg =3D 0x13,
 		.bit =3D 0x03,
-	},
+	}, /* FLD2 */
 	{
 		.address =3D 0x30,
 		.reg =3D 0x13,
 		.bit =3D 0x04,
-	},
+	}, /* FLD3 */
 	{
-		.address =3D 0x38,
+		.address =3D 0x34,
 		.reg =3D 0x10,
 		.bit =3D 0x03,
-	},
+	}, /* BUC1 */
 	{
-		.address =3D 0x3c,
+		.address =3D 0x38,
 		.reg =3D 0x10,
 		.bit =3D 0x06,
-	},
+	}, /* BUC2 */
 	{
-		.address =3D 0x40,
+		.address =3D 0x3c,
 		.reg =3D 0x10,
 		.bit =3D 0x05,
-	},
+	}, /* BUC3 */
 	{
-		.address =3D 0x44,
+		.address =3D 0x40,
 		.reg =3D 0x10,
 		.bit =3D 0x04,
-	},
+	}, /* BUC4 */
 	{
-		.address =3D 0x48,
+		.address =3D 0x44,
 		.reg =3D 0x10,
 		.bit =3D 0x01,
-	},
+	}, /* BUC5 */
 	{
-		.address =3D 0x4c,
+		.address =3D 0x48,
 		.reg =3D 0x10,
 		.bit =3D 0x00
-	},
+	}, /* BUC6 */
 };
=20
 /* TMP0 - TMP5 are the same, all from GPADC */
--=20
2.14.1
