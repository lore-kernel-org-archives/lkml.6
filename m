Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240997-2-16429761334395854345
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
    1523240997; b=Jd374eNSorv1kF2MCCfr6DfueKnXohb5XCrnMLxaGFBfJnAr4F
    IONaL7xsdkqeY1Imp+cdvZ5yTaP5Z4+HtaCzC0t9evJw0cBOfalFVSQqXR3jl0YR
    W1pkQXkV+i8/KakGGpAtRbwKyX1QtEZrErnLd+9GGAV97tEs6dy65zOYcbSodDG+
    p+bd8aHpm2/SVUGUyYnzvMycIXMbkHK6vKkKEGqsJ2XRNSxYNVEUJxDiDP7VbSVs
    1R6G6EB5rmypwyKFWjA41Imd3MYYyxDTQimpeacKvgDCQE3kFy61DxSyYhoRl60H
    5tLuJ0IoB/oPQuMvXqLRbxRP1rkzkGYNC9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240997; bh=uVfZjqFd8X
    wtPCM9hz7ZCM0CvuJSF7Bqwcv0Rb/x5Yk=; b=qPRqQv/Za2vHsHa9lGufuJIR1v
    4vZyCR/PtlD6JBhl8g+/G8LEVURjuY/leKur6OcYlVBp5f6XrTQ87WJCs7k/gasp
    RUINwnfz7yT2i7WtJitcYKSjsWu/O0h++ggvnG5Po++/fzJHfQTuPVoWeH79qLBa
    lJcpeM/wvbAu9+Eaqv9Q+VACPVziVDiMLqu1wOqD4lfxdiwPs2mC7+6HlmIGoBFh
    59etc1MtBLSnB0zGgYMf0aKh9BlHQJgMklfqsHR1XNSqjER4Zh6ggng6M8deK9eh
    xM/OTs+q5oX28/oZRLOWbMZOfbIyZyLZP+FJl+LC6YCHh7+I/Gg2oVeiXs9g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dX7eQNmx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dX7eQNmx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN4rbWcM8LspMCXFQoaSjAZlzCqThchXhjDXx9lFiiQ2oaqhU/8ULgd+93MG+1IiEU+M6/VId9mFxl2ffwZ9SjEkxzrELQaLKqS0iawDKcpcPUrTot/q
    2E31bv9cXUED9/WBzjZZjtv2DI3N2x5++ClZhp0Z4BqFx/2clgkyMo28m1D1Sfp481l1JkIA5CUEXBiKaUCcDPz2eMaVABAwZAV4HuW44/5jpyOn3ZQ93zee
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=t7UcQ3b8EIM5L76Z2osA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757924AbeDIC3d (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:29:33 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755862AbeDIA2g (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 077/293] firmware: dmi_scan: Look for SMBIOS 3
 entry point first
Thread-Topic: [PATCH AUTOSEL for 4.9 077/293] firmware: dmi_scan: Look for
 SMBIOS 3 entry point first
Thread-Index: AQHTz5kKWdI6Q2i5GUOJsPM905/1IA==
Date: Mon, 9 Apr 2018 00:23:54 +0000
Message-ID: <20180409002239.163177-77-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:aver8n/GiLpLwPoEMQtM2m0AvqZESEre81tB7ZLCVutJUCOFSTwQvJ8Z4A7hVJ838eNBCl4UDJ1HP8Ds7TB5F0cpPF1al0MplaSu0GR6fOb7/pjTSfnmVIcCUZIcfB8g0MYDSL5P5Sajd6G4hMLqPJl1STT75YyPpnD0lcyoamFAX4b6CoKBIeP3dAPP7l/L7fQnaUxumk6ceWWXWEsghygIXDqAGSa0Mh6sQ2I6iQAWJUNk89MhD/RtKaJ7vpSs;20:Ia3i3bSSG7p+nl2lrKKxhHg3Yu7TFdEwG/HMIlbm1Qr6uxeY6ORsZc9yEjrwtYHW96ficaAute85qFtdTS1NGQzHOUBUwpMXKUcxHk5qzNXPag2ZkRclboQx0aLZMn7eUvYq72ejIRHP0BwryRdb60RNBlkE7n7gPEDrtUPsHA4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89190751-6f8d-4790-b4d9-08d59db0d148
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080712712D6413BEE6ACEB2AFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: r5AjRJSJjbx86f0Y4ibS7UN4cwyTv9Q5liS/Lm7mWw/C8G4SkFhqnTukRFc10EJVHcDaUWShJWHbMLodHR2TK5Ocvkqoc+3dkEFnzkpawy0w8ad0raiNqF2jSK2QEOOSiixGj72gHO8aGPWb22WFBuXwck4HE/i3Jbt+Yryu20maHA4NTnKvE28CbMT7LnQ69EQe7pOzHZ1npsufNwd3M4HozYI84iBfA9IYMmHBcFFPkD5FdpD9GIN7XB6GgijvxGk21t2exlCBAyN/3xH9zxQk34Dft+CaUIh60fwbhhqBkh3YaXWm21N3u1VVkfBoXEnjnRR6x4I9LwIqVahLWbKorgz1c+TMYtKt2k2rskMss9JoH6VY5xjZHrxEGe/6xTh29wATBSBoSvtZRlxqL2Hd1QOLCxUSW4NmUpc/aOw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89190751-6f8d-4790-b4d9-08d59db0d148
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:54.4093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit c9aba14362a6eec583819ec8f4b872c1816f5cbe ]

Since version 3.0.0 of the SMBIOS specification, there can be
multiple entry points in memory, pointing to one or two DMI tables.
If both a 32-bit ("_SM_") entry point and a 64-bit ("_SM3_") entry
point are present, the specification requires that the latter points
to a table which is a super-set of the table pointed to by the
former. Therefore we should give preference to the 64-bit ("_SM3_")
entry point.

However, currently the code is picking the first valid entry point
it finds. Per specification, we should look for a 64-bit ("_SM3_")
entry point first, and if we can't find any, look for a 32-bit
("_SM_" or "_DMI_") entry point. Modify the code to do that.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/dmi_scan.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 88bebe1968b7..8590f94de9dc 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -648,6 +648,21 @@ void __init dmi_scan_machine(void)
 		if (p =3D=3D NULL)
 			goto error;
=20
+		/*
+		 * Same logic as above, look for a 64-bit entry point
+		 * first, and if not found, fall back to 32-bit entry point.
+		 */
+		memcpy_fromio(buf, p, 16);
+		for (q =3D p + 16; q < p + 0x10000; q +=3D 16) {
+			memcpy_fromio(buf + 16, q, 16);
+			if (!dmi_smbios3_present(buf)) {
+				dmi_available =3D 1;
+				dmi_early_unmap(p, 0x10000);
+				goto out;
+			}
+			memcpy(buf, buf + 16, 16);
+		}
+
 		/*
 		 * Iterate over all possible DMI header addresses q.
 		 * Maintain the 32 bytes around q in buf.  On the
@@ -658,7 +673,7 @@ void __init dmi_scan_machine(void)
 		memset(buf, 0, 16);
 		for (q =3D p; q < p + 0x10000; q +=3D 16) {
 			memcpy_fromio(buf + 16, q, 16);
-			if (!dmi_smbios3_present(buf) || !dmi_present(buf)) {
+			if (!dmi_present(buf)) {
 				dmi_available =3D 1;
 				dmi_early_unmap(p, 0x10000);
 				goto out;
--=20
2.15.1
