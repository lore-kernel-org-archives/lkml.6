Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116559-2-13307771104996131252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116558; b=hZfq2QdtdxtlBjJyj9Id7fzN37Hw+qgdl39tDgFQvyDPmAK
    fkkTAXq3romGYJCnx/EmUw1bP6f0xJ+C5+BTZ+U8H0YHWmHcj/qfyLGOWIhKjGnC
    K2JqPiBZ3i6vOirjMUbMBonmuvXC0WKrnJ8lcw7SHyXz//fa807io8Q+G7OqwrUY
    ZREtX8FRmJftiUx6Id+VXOyAa6akAaRI654YrLDJhNu6FQqfl9npc1AUuODOlGm3
    0vLtpf/vBFxg+0DCiU5k3ZhRV0aOLp2XpU9tpPTrbeH4WyU2ZM7mQjT2EK54EggR
    bP6AfQwO49V9PbOUxZ+8u0HbeG2WBJHIWQ32Z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116558; bh=uWkJ2W
    WmP61TC6WbRyBVZHGckx5zhnvYgAzpnPfkIZ4=; b=Cu+AUfRwgEr/k8HUZBYDyC
    LCdNeuwz8O9Zi2MPAit9QRQaCMlsCrzUuqlWW12NCqChVLcwYGqLmurSNIUCTk7X
    8Xd+UC6UFp6xLkZhCzg2Fi6/xnmgbVLVa0DHTPhokwt/1cUvR4uhulHUptNncHkw
    w5lkl0LZTIgQ/ra1I0ZyFupwtPqnxvTraqK7b9YP9QJbA9FCv1ZYhbHoAD9NU0sE
    SF8auuhU++SWxk6RINroVuixtqUmr6sNz0X7gCtMeTGHM9aO0E6hIjyppAhdJktc
    i4R8SKRIwEK/BS2t60TUXwhXyCao/01yyfv+q9CUutro8JUyPK7u7Y2htlX/guWQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XxKT5NOF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XxKT5NOF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934193AbeCCWee (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:34 -0500
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:51939
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934191AbeCCWeP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thor Thayer <thor.thayer@linux.intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 119/219] EDAC, altera: Fix peripheral warnings
 for Cyclone5
Thread-Topic: [PATCH AUTOSEL for 4.9 119/219] EDAC, altera: Fix peripheral
 warnings for Cyclone5
Thread-Index: AQHTsz8Jg4A1+1MeD0mMUR1LJkYH/A==
Date: Sat, 3 Mar 2018 22:29:05 +0000
Message-ID: <20180303222716.26640-119-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:jBtg/y6mMQLp3JCn8Y4b5cqQJKek+ze3J9C1WHMjx7OEKnls3I/canXCMaWSNzrbUVPQPkRb9kldie2OzAperZDJwy968Hu5iZJwJah7Dji4IITutmka9oD+44EFZK6sV3Qljzx+ePHE4gRSffrEWEf7F/7Qp13XrrSymWIhe7mBRbyrBGLO3zj7rHq1wxtYFTMMC5QNFlZne63x/OeSYw6w64D/7Dzq6xMzVtuDr+F9oWrABWgK7f++BM4WYv0B
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 080ffcbc-43e5-4784-f568-08d58156e229
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1068C3C7720FD207E68E9858FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(966005)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6306002)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8NMSVKzCn8B5G0DwqiPGQW0ngZ7bs6/cVdP/CmR4B9LSyG92cJJjYCHy1YBmC6L2DTwpGuafA82p2U7+dHnx3b5fpsqQIPm5Gn6f3FSfkawlK3lHZ31bEp3GiH9Bk6S4eIyDVsOdyOmdo2ZXQCskRBNKKSN6W6Uw6qcAqkQECTU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080ffcbc-43e5-4784-f568-08d58156e229
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:05.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thor Thayer <thor.thayer@linux.intel.com>

[ Upstream commit 25b223ddfe2a557307c05fe673e09d94ae950877 ]

The peripherals' RAS functionality only exist on the Arria10 SoCFPGA.
The Cyclone5 initialization generates EDAC warnings when the peripherals
aren't found in the device tree. Fix by checking for Arria10 in the init
functions.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1491415262-5018-1-git-send-email-thor.thayer=
@linux.intel.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/altera_edac.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 58d3e2b39b5b..61262a7a5c3a 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1020,13 +1020,23 @@ out:
 	return ret;
 }
=20
+static int socfpga_is_a10(void)
+{
+	return of_machine_is_compatible("altr,socfpga-arria10");
+}
+
 static int validate_parent_available(struct device_node *np);
 static const struct of_device_id altr_edac_a10_device_of_match[];
 static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compa=
t)
 {
 	int irq;
-	struct device_node *child, *np =3D of_find_compatible_node(NULL, NULL,
-					"altr,socfpga-a10-ecc-manager");
+	struct device_node *child, *np;
+
+	if (!socfpga_is_a10())
+		return -ENODEV;
+
+	np =3D of_find_compatible_node(NULL, NULL,
+				     "altr,socfpga-a10-ecc-manager");
 	if (!np) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "ECC Manager not found\n");
 		return -ENODEV;
@@ -1542,8 +1552,12 @@ static const struct edac_device_prv_data a10_sdmmcec=
cb_data =3D {
 static int __init socfpga_init_sdmmc_ecc(void)
 {
 	int rc =3D -ENODEV;
-	struct device_node *child =3D of_find_compatible_node(NULL, NULL,
-						"altr,socfpga-sdmmc-ecc");
+	struct device_node *child;
+
+	if (!socfpga_is_a10())
+		return -ENODEV;
+
+	child =3D of_find_compatible_node(NULL, NULL, "altr,socfpga-sdmmc-ecc");
 	if (!child) {
 		edac_printk(KERN_WARNING, EDAC_DEVICE, "SDMMC node not found\n");
 		return -ENODEV;
--=20
2.14.1
