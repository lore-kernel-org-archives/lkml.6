Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485617-2-5597211121108295154
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
    t=1520485616; b=xCh65ZvytWPrG87nhufHTUWHsooTu8PbeGbUBNBCR84aw01
    0tUTcO+qNxyhmgFOsLGy+g+J0w43aQA+fqfip2STZ6bOfRifK7BVsUxst9Fvtd3f
    YBXzqMvpIyBcN4Z7V9J9MC0LIdoi1PCB/RK4BAM1ItaBn86+DvnppdyN06YCNaOJ
    KbIOgXe/hSxQgdjHcVzKVeQdICFWg+SN8RpNjpgai+FY3lHWPz9++LHgdrU+L3au
    K0oW01tBZGV0D0qy+g0hKa7YTL7/W3dipLjv4KA7ezOygjeu0R2tQCjgaQWB9EaI
    2r8H1dHh00BNQndzWsw03xMRdMRfyYiqd5NgKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485616; bh=aFLpgS
    d91/cNw0AvUxgd2ucgTygtTKs3YqvIKoodf5o=; b=ZH7sOdOuQqXbrSNvS/WYft
    XPRjW/RpI8vwJnuSxZcYrYWiI1SfXzoiSRiARIs80rYm9zvZHFNYwA4EbDi+WPWL
    YFJMRHnFK5uJ3bE/qqJbHhkTYc76ge50RRpl87VJ3gwlEvEagrSVhygeEeZbd8WK
    +yLdlIkQeLYmczwO5RMXfp/y7RmT0Jc/k4NUgz7iWEHx8s9f9z8YHPtz5hEL8fne
    Iy/aJGcpB8dGoc0FOcjGJo5FDE5uF8ULzLDsfjKXxw97FVEMnlJfLtb0bDl1DYTj
    lWct/lfDlkFc+2jXmMxnLR/SqmlaCKURC7a7at9G3yawZaMeJNbrriWEDm4LqOMA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CUw5uHUa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CUw5uHUa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755386AbeCHFGx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:53 -0500
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:21120
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755339AbeCHFGv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 063/101] ACPI / PMIC: xpower: Fix power_table
 addresses
Thread-Topic: [PATCH AUTOSEL for 4.4 063/101] ACPI / PMIC: xpower: Fix
 power_table addresses
Thread-Index: AQHTtpqVh5s+Z3DjgUyVQUKSdcMFRQ==
Date: Thu, 8 Mar 2018 05:01:58 +0000
Message-ID: <20180308050023.8548-63-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;20:B9rrMCRur0exx+x2A3dvhJT5OCyt1ftGj7jJSpsnU/Faarn1EKC/bk1u6yySO2huyfvk1a7nxAoy8hkejVDAARketTXOQNkTQT9J4fFpxggifTEP/u/1vdoTvcQ/oLDJucJXPZmv4kzeRwANvbHBybrKX0AMCNCERAmiLhRTVpk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72fbb434-e51f-411e-0e2b-08d584b26600
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1016F78849DBB69741775334FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(6666003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(575784001)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: H0jMmYXlXCtWXKcIjmfO8t2aDZIrcOKMtFPyZroo5ENecsCMvUqQP34xebq18Ef6JjdcaYHctGE2bGvmGgGiaDafx3H4CCbzri+4n7qj0RUcPiwgAxbAMVdXAEK5iSctTKx0AjzGXNJ25dguMhrsY9AN3/mZ5QuurpP0x3oXTSPYpaGFBT3anorbLihnLi29ah5hU9VNAOd0suMEcg6UNYgNFmjjwq/KZBqqKQ1VD+u2c5fXmT9GNo8Hk7Nbjl12RrRKOKozdZ0hHPhs1K1RAxRUWc3lkcPqqM24Dp04XmkaoR90t8n+eRWWalmKTXVQuUVqpEACKN9UOL0rKgwSNg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fbb434-e51f-411e-0e2b-08d584b26600
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:58.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
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
index 6a082d4de12c..24a793957bc0 100644
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
