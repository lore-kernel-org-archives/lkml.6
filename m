Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118935-2-14726293613401670458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118934; b=NKi/ZH5hzuzKO9O/6G8sGuBdXkJ0B7ehkgaDmN2HWilUucP
    kOCryJGWN/TLo5tuIbpyt5U1LJpIHmA/JOvSwXt8pqYctv0FKXkIOv+rAgRrGMyc
    pWg+jxDf4/nawjEE6a8pHOEFENWKhzyYhHtTEb3TVTQb9PqFTDAT8IuCy+FypcSf
    OM7vUYqLxHHjQ/nut1hQPg+AJ1t1/Ux5DN/ZjegQo+zT2sLgAims6hmmS38aa4tR
    Nu8aRuiQJVb5hnvvEhLKWnF4D0ExQdpforeCTTENaENkYpozGv4086m8er11A6W4
    8soYCmhpKAmhr7VewYPu+p408bQLhDeHSA21tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118934; bh=2GDn/Z
    pwbXQ/22TuKmHkhzu2djVqpysBUX6TbpbMOuE=; b=kUuvGqrTl0tq6WipjpykXc
    a+PMdYjPfcek0HIikByceeq9PrBafXU18akiL/GTEk4RNcyORIdojkldqUYGNPqU
    kaJy7wtG09KJYCmDUOO/MfBRRkmhw9YLBrE1Bc0Sy/UgK0DepApoX32PsUUFypLu
    YtBIEnk6TigYf9o884Zgpb2BPzz2KG6FMLXbJhUPDBNCS4ESb49byZbL+cllvqAI
    EzruljSHSLdDrfX5eTamcmiZYVFgeJHWgoV+NQhhqddyXjtLJ28q5ebeuwBnrzI3
    kNCMtn0m9zxzg1bLZifT6vxAOXokD05F0qXvS16zrXZ+D93CIRhnL3QOQOcGxP+w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lOX1GPbh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lOX1GPbh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935004AbeCCWjH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:07 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:65056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934392AbeCCWjF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
        "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 035/115] powerpc/xmon: Fix an unexpected xmon
 on/off state change
Thread-Topic: [PATCH AUTOSEL for 4.4 035/115] powerpc/xmon: Fix an unexpected
 xmon on/off state change
Thread-Index: AQHTsz9TEheLrRm5P0i0OvMLjOUnhw==
Date: Sat, 3 Mar 2018 22:31:09 +0000
Message-ID: <20180303223010.27106-35-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:Vnw2+Q3iqw3pxXSe417XPsvaYyZSz2Hr0fpCz+OxQrVHRf5Ay3rkQ3jlOW1ptLzMQW3z0yC76vYao0iXmneQq0YwRj3Aq+mwlUURyQ75vxiWh9MZhbmxdm3qZKApRHd0It0jhxXQmgb5VXzl8A3VqzV5YPaW5zNSQL5SKDahtDdRCraJ1jX7WW5coWBg4GoeRz2ph/kTHvp7Pt7RfoMf62vvTrwUvHKiXroxaDc0rSFyQeDvntT+rQZOSnNlrvSx
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58daf864-1877-495f-0845-08d58157890d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09385054D6B71CCC160EF309FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 3eTqp98Az0+E0xegOL6OW5BKLo9luGOlE6NyUB9MIT1qnwBOqtb7p/t4D10/bdYQvfrcrHARLmfBWEzzPtKNkZG+q6Hkn6rHgTyoE9pIGEMq5b7tolChzcRk6rR91mw00vgU9He+rGWKBpc9kgaHxQow5qRhgIdga33J1e6ON7w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58daf864-1877-495f-0845-08d58157890d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:09.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

[ Upstream commit 3b5bf42b81d56085fd58692b5117f69aa77fdff7 ]

Once xmon is triggered by sysrq-x, it is enabled always afterwards even
if it is disabled during boot. This will cause a system reset interrupt
fail to dump. So keep xmon in its original state after exit.

We have several ways to set xmon on or off.
1) by a build config CONFIG_XMON_DEFAULT.
2) by a boot cmdline with xmon or xmon=3Dearly or xmon=3Don to enable xmon
and xmon=3Doff to disable xmon. This value will override that in step 1.
3) by a debugfs interface, as proposed in this patchset.
And this value can override those in step 1 and 2.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/xmon/xmon.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 786bf01691c9..9f08064324ce 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -71,6 +71,7 @@ static int xmon_gate;
 #endif /* CONFIG_SMP */
=20
 static unsigned long in_xmon __read_mostly =3D 0;
+static int xmon_on =3D IS_ENABLED(CONFIG_XMON_DEFAULT);
=20
 static unsigned long adrs;
 static int size =3D 1;
@@ -3041,6 +3042,8 @@ static void sysrq_handle_xmon(int key)
 	/* ensure xmon is enabled */
 	xmon_init(1);
 	debugger(get_irq_regs());
+	if (!xmon_on)
+		xmon_init(0);
 }
=20
 static struct sysrq_key_op sysrq_xmon_op =3D {
@@ -3057,7 +3060,7 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
=20
-static int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early;
=20
 static int __init early_parse_xmon(char *p)
 {
@@ -3065,10 +3068,12 @@ static int __init early_parse_xmon(char *p)
 		/* just "xmon" is equivalent to "xmon=3Dearly" */
 		xmon_init(1);
 		xmon_early =3D 1;
-	} else if (strncmp(p, "on", 2) =3D=3D 0)
+		xmon_on =3D 1;
+	} else if (strncmp(p, "on", 2) =3D=3D 0) {
 		xmon_init(1);
-	else if (strncmp(p, "off", 3) =3D=3D 0)
-		xmon_off =3D 1;
+		xmon_on =3D 1;
+	} else if (strncmp(p, "off", 3) =3D=3D 0)
+		xmon_on =3D 0;
 	else if (strncmp(p, "nobt", 4) =3D=3D 0)
 		xmon_no_auto_backtrace =3D 1;
 	else
@@ -3080,10 +3085,8 @@ early_param("xmon", early_parse_xmon);
=20
 void __init xmon_setup(void)
 {
-#ifdef CONFIG_XMON_DEFAULT
-	if (!xmon_off)
+	if (xmon_on)
 		xmon_init(1);
-#endif
 	if (xmon_early)
 		debugger(NULL);
 }
--=20
2.14.1
