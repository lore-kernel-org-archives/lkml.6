Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485382-2-14473389009636637
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
    t=1520485381; b=se2OWSxbHkjfDj8Rcruc7fM6JifCVBhQA0wkttjz8vKPOsK
    bKcDdUcTE4WUX+ppzKu7tKtfVqC9JhGrfTKOKG47HlgmzyNO7/tcK6rOvZZpIs6c
    0HxXnF+SqAHZ+k/sgvskuSkLq3aZ1MBXhCsxx3jruFdvyNUwB9PpDwJC9aBye9IT
    OtNL2tTPMfhTNcBBiKG72JHwUBnGQ2Ys8jQp+IHVHkAKnvhwdUK6zLg/G0cbYdpl
    rb9cBuRok6YHH44yYrza3cjOZ8Zz7JEQLGLyFQ7bRnG1iMG62NFBN5KiHwlLYTJk
    mq/O11xMhRIteQuePjqR03Q608Lt1j0/mpnEbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485381; bh=AG1UWw
    AOeWxRzGet/P3/UG6GEC9e4oYj2RaOm8nunHk=; b=Fug3Z9vMCN8yd2t8yhmhpi
    smkgQouBZhUaxJ/f4a+KhM72Dno6KYg3D/vhatd+9A9z9n+X3kuIueyt3V1SQXlN
    x3cl7mKJLvDgPJCY5rA1vFii5xZLF8J0dSVKiFeyMmpv6OEvqVj+kzOlfHLAcv5m
    rse1sJIi01cKee9VJKkKKzFJBIB6z2kiKcmh8iiTmvF+4sZzbJ/CV1N+1ukFaZn+
    XJ9UFjsTBx69jMtFctZUdxhiaL4eMTNsvjsconymqLfZlLTB+ux37avQnx7qAWWn
    +bB5PBIt7tYVvYOPOeEbm1fbM92CASBz8VIo+rYH8GTDJL9ECTBbtrcqmLVnFN8A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ew5he3ew x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ew5he3ew x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965793AbeCHFC5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:57 -0500
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:5120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754688AbeCHFCy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Valentin Longchamp <valentin.longchamp@keymile.com>,
        Scott Wood <oss@buserror.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 122/190] soc/fsl/qe: round brg_freq to 1kHz
 granularity
Thread-Topic: [PATCH AUTOSEL for 4.9 122/190] soc/fsl/qe: round brg_freq to
 1kHz granularity
Thread-Index: AQHTtppG8fZts03CsUK27V4HPoWIiQ==
Date: Thu, 8 Mar 2018 04:59:45 +0000
Message-ID: <20180308045810.8041-122-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;20:9YkUj9ZNay7DEkwySKKkqH/+o06s34Ixj+oMeVPRDjzsoNC55oU/ZwOnIwJWdkwRxCWm54MNjHew7JWBD4XUmfExiqG+qnDpWcuGTvLOC8q0YJFZ5xrg8vj44Gw8U+9eAUp2VCY3eQLfg74wPLZca/6YkW83W9N5sMzbx1auNes=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a89360e1-39f7-471b-6e28-08d584b1d80e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013BFB777A103719DBD9E57FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: gWlw6z7ws5bk76hwLrEXlKgdLdixJg/qLc31XhDYl6MyLupDQznw90jBSJ/9eXInr7VXamx8IDGzh8DWKMh+jTTidTqJ5SRTAk2UcO+J3cghaPewbnyc5WdAh+hgQn0l25LPdbQO4Y35pX8aTIMRnjr+sdE+AjehQytXtUOwmysmZHCNPIiqXyC827qAEfef7W1FRgOaNpAc/L3Pxzi6s7WoFDZxrGIZ3yb+P5GZjgPi9kTecDeGK4+yB/8Gwg+hQw0vPG0YlSRkLqBXzYWpYsT/0hsWIT5RRGL5CLhwupiwe3b3tWRXGgrRJbzcqlxPeRDJGkOUOBD/fnML8ySzkA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89360e1-39f7-471b-6e28-08d584b1d80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:45.4831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Valentin Longchamp <valentin.longchamp@keymile.com>

[ Upstream commit 2ccf80b7566cc035d903dd0ac5d7ebd25c2c1060 ]

Because of integer computation rounding in u-boot (that sets the QE
brg-frequency DTS prop), the clk value is 99999999 Hz even though it is
100 MHz.

When setting brg clks that are exact divisors of 100 MHz, this small
differnce plays a role and can result in lower clks to be output (for
instance 20 MHz - divide by 5 - results in 16.666 MHz - divide by 6).

This patch fixes that by "forcing" the brg_clk to the nearest kHz when
the difference is below 2 integer rounding errors (i.e. 4).

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/soc/fsl/qe/qe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2707a827261b..5482302d3d9e 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -163,11 +163,15 @@ EXPORT_SYMBOL(qe_issue_cmd);
  */
 static unsigned int brg_clk =3D 0;
=20
+#define CLK_GRAN	(1000)
+#define CLK_GRAN_LIMIT	(5)
+
 unsigned int qe_get_brg_clk(void)
 {
 	struct device_node *qe;
 	int size;
 	const u32 *prop;
+	unsigned int mod;
=20
 	if (brg_clk)
 		return brg_clk;
@@ -185,6 +189,15 @@ unsigned int qe_get_brg_clk(void)
=20
 	of_node_put(qe);
=20
+	/* round this if near to a multiple of CLK_GRAN */
+	mod =3D brg_clk % CLK_GRAN;
+	if (mod) {
+		if (mod < CLK_GRAN_LIMIT)
+			brg_clk -=3D mod;
+		else if (mod > (CLK_GRAN - CLK_GRAN_LIMIT))
+			brg_clk +=3D CLK_GRAN - mod;
+	}
+
 	return brg_clk;
 }
 EXPORT_SYMBOL(qe_get_brg_clk);
--=20
2.14.1
