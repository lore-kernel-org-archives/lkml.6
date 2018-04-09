Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243709-2-2789807804986179465
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243708; b=NB4Q3az9yqNeSJCQvZpWYWMzVAKejpsxjJrSyAzFNsvDQSHvr1
    iz518Nm8tS8HmxzPNB18dNQvgneT28zQuOo5bDWyaDXxibAUo+r7nYyW5rttTiy8
    M4JpwJai9TlmQvkpbwx1dU1hhyw88bTFzsxlA/edrIhPhMnS3stzzVeu18ZuQY3G
    soqnlTi9cZSFyvFAWyAlMX6HP2OPn4bB5ZzwujMh7atcWDqZ277qpO2o+YCatiJt
    Bh+Rg7tQnZBqPgakdHBEM6FeR9mguIBXBMIUolANfxNzXQ634V1br3ZMj/S0Ljwe
    yx82nvBhyvbjHlZn//JZMSInA3M6uNd0wwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243708; bh=HZQ20IDZwt
    OQINDJAY7ntPtMr3vyQYCmp0OXea68EZk=; b=Jl5N37A1WJoErq5CZ1TuSGd6ib
    tzlJN6F5YxMOggRa75rsT96slHo6ocA4Ybz8ieT/4HJ1fp+1DQYl7ygUnXNDtdxG
    KfW/cPrU/MJEvYmyAt0G6nayZ/YOta5GGPqLB2qTDOuKTObY5p7IdhkaNgjM/rSL
    eCm+XX+CRnOxk7RYzcnCjNjnZgNEDl9VQw+hwxlv8UwoPuentCIu8sSx5QDYiFEy
    JUGr79IVfhzslO1jQAcwtUcuGMF7qCAn3SDeocMOgSyHx764i4YYl4MzKKAisM35
    SiTRXkEy5QIqm+PEVpCkhTRqfBifIkri1MHq8xMpHjvBbZCWBHXl9WQIdgSw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nDRzw2kf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nDRzw2kf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE5YqHNmvYP9bmMV1DbNcAP8BPd8aB1V9hqyb1OLGqbglH4MWhVBcM4y8xzQecaBwRHLG0OgUKcgA8EjyoY14eaIEs5bDiw4nBEsGT0SUv/FlH/FSciy
    QFNV1XRuD00dPeOGyw2lY/LV4/1zyeQVVE3HQQZa6+lOW9v8Q5ol4FBaIqW4M7d3Uqkmzd/bJronxrIYFOlPsCgxXbGLsoIRwCoMVkd0WzEqp1rO3Wu1as6g
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=pxVlmbZgAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=citNvokU5oaPeovvbZAA:9 a=wPNLvfGTeEIA:10
    a=L4_cbsQG0mmWe7eFWZkK:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDIDOx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:14:53 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754926AbeDIAXs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: David Herrmann <dh.herrmann@gmail.com>,
        Matthew Thode <mthode@mthode.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 068/161] platform/x86: thinkpad_acpi:
 suppress warning about palm detection
Thread-Topic: [PATCH AUTOSEL for 4.14 068/161] platform/x86: thinkpad_acpi:
 suppress warning about palm detection
Thread-Index: AQHTz5iXDQjGw0x6xkKInlyV7zjZVw==
Date: Mon, 9 Apr 2018 00:20:41 +0000
Message-ID: <20180409001936.162706-68-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:/iVow9sXxu0xjeC0NLvrn0kOFQS9QH5TxpKuPUh9l7TRZSJydhyx9GN/MhFHICH8lGfLOKy+nPtqwBrXRoK3BfLcl/sdEbgf1v+ZNN18QUy0RIrKqjq9WdylP54EeQHWsCWgN6f6VtKtiEXaZ9pE3eDWB5KPKMlxJGVSPeq7m0IwWR509nwrVs7ZaKRHkip2ei4/FZiJZJKQd4D1r7nlLbaYndGzqJo5Os8FCCgP92N7NDDDhbSYgpWWugM+ImKJ;20:NgOgoIwmf9PtMARyqT2JbegPMHUzt4nRc9durjq7GuY3cbeFLTtpszHBjItN06iYlxWw8KFN2Y7/eG2quao+EyzWOaAlXcuQxItCfjgnpCWApev4xItgG9i//jWXU/1DxlKnBACjzxRVYPPGuQf9qHrpsg9Y1Iuy4l9ZDXhIpks=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d34bf78b-3cfc-4501-fde4-08d59db0278e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080491B0EC11BA1E236ECE4FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(39060400002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wHTwV1k8gvx24tH1DlMEM/WGy94V6Yf5G4kZ4BHBkZKoP90xbi90/jSx9m0nWbz0uuK8mp4DJeJ6Tx7we1MgIpX07POiQdwlJHgYnZ7Lu4CC0bmk/NqDppDF4M85o/8ZiVXpzkvj14j8pyKhDurTAv1zx+9fhyGQj+obsojqG8hJqyTkjfBwWhSY3g6VjlsSqasLBRhEbY0/tcQ3kWQIgAjr8RjL8zMx8GeGzvTzdta6iNBx/6BWPUUddzz8pu6zjck85D5Oq7XVWJLMzi8JqYKRaJNzST5FSlXinaT8j+sz4z0Ei15ESXpwkPb6jPk71yPkiHeyQY0rdJsklMM3U0tjMvpWiJy5lC7S2eUvTpv7Ebmfg0hvOa53e6IYv5wlzbilJEILO3zf9/KYVaB5FWbk+5nBTy9no2Ld7eE3oNc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34bf78b-3cfc-4501-fde4-08d59db0278e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:41.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Herrmann <dh.herrmann@gmail.com>

[ Upstream commit 587d8628fb71c3bfae29fb2bbe84c1478c59bac8 ]

This patch prevents the thinkpad_acpi driver from warning about 2 event
codes returned for keyboard palm-detection. No behavioral changes,
other than suppressing the warning in the kernel log. The events are
still forwarded via acpi-netlink channels.

We could, optionally, decide to forward the event through a
input-switch on the tpacpi input device. However, so far no suitable
input-code exists, and no similar drivers report such events. Hence,
leave it an acpi event for now.

Note that the event-codes are named based on empirical studies. On the
ThinkPad X1 5th Gen the sensor can be found underneath the arrow key.

Cc: Matthew Thode <mthode@mthode.org>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/th=
inkpad_acpi.c
index 2242d6035d9e..c407d52ef7cf 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -214,6 +214,10 @@ enum tpacpi_hkey_event_t {
 	/* AC-related events */
 	TP_HKEY_EV_AC_CHANGED		=3D 0x6040, /* AC status changed */
=20
+	/* Further user-interface events */
+	TP_HKEY_EV_PALM_DETECTED	=3D 0x60b0, /* palm hoveres keyboard */
+	TP_HKEY_EV_PALM_UNDETECTED	=3D 0x60b1, /* palm removed */
+
 	/* Misc */
 	TP_HKEY_EV_RFKILL_CHANGED	=3D 0x7000, /* rfkill switch changed */
 };
@@ -3973,6 +3977,12 @@ static bool hotkey_notify_6xxx(const u32 hkey,
 		*send_acpi_ev =3D false;
 		break;
=20
+	case TP_HKEY_EV_PALM_DETECTED:
+	case TP_HKEY_EV_PALM_UNDETECTED:
+		/* palm detected hovering the keyboard, forward to user-space
+		 * via netlink for consumption */
+		return true;
+
 	default:
 		pr_warn("unknown possible thermal alarm or keyboard event received\n");
 		known =3D false;
--=20
2.15.1
