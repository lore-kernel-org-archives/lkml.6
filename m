Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487058-2-666343661007007473
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487057; b=fBi7YolSseZvbBy82nXFOCMHX1yS9anJBeruvNWalPyGUTe
    AEsTHz7qYreO49/Y385gqpME11R0QE/pNBZXd+/3sdpGDPmAYZHlgN8m6Y4iUd5y
    gyg8jDl0C5Bvz65ZKy5TIMHd5yyein0giLTo5thorYY6IYCUOP1LDctV+Xhu0daL
    n0nmmUi63rh1phY0stXM2tS4ZTZO9qJmMz3Z4yGeV15MlJyXnvqWkVZ6gRDn9X0B
    9Uruv7odQYZi8UaVYnQBeBxFbw2/4QyI+qV26WRXIb8lsaVySywpiIN+iA7OZPPf
    5oOUWTG0spMg36M7698U74fEHbL9rp8uk5wqj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487057; bh=r+CDo/
    eMKRw7SYQfR30RVsUxytki+wgwv9GNImi+9H0=; b=ljPAlPAzFymzzimPNdy/e/
    Lzb7M6Nl1frDyrfFUz1aQho62K9QbX40hZLL28mrgh1dgGKpXOax9uSHo7j+l/oN
    dx6AE8Dg1HWw//NfGiQfHujsOValJlkN4l8b0gKYMv0Fnb6M4Kp8fZKK9j19mhVv
    JUybSrMULPm15pwvkNjrLdNUnZURU72VTLb40cygB08g4vkkCg9me35AmqX/dMLL
    ezAyzHLgFIbG8+m7mgsEmx5RWRL+EVizr8Wrw3fRd9c1VBqAXWefs4NOw7GKKl5t
    eGCLt67ijTbva+kZ+kz6w0Uhqgddixj7fsu2WcUpEvOuPp7m6iZwKTzGmr1UJriw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LeF+L0ds x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LeF+L0ds x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935526AbeCHFGy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:54 -0500
Received: from mail-cys01nam02hn0204.outbound.protection.outlook.com ([104.47.37.204]:8367
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755278AbeCHFGu (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 061/101] ARM: DRA7: clockdomain: Change the
 CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Thread-Topic: [PATCH AUTOSEL for 4.4 061/101] ARM: DRA7: clockdomain: Change
 the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Thread-Index: AQHTtpqV0fXiVdUpC0Kn3mpIkjy7TQ==
Date: Thu, 8 Mar 2018 05:01:57 +0000
Message-ID: <20180308050023.8548-61-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:e9VefMp2kYCiftEuqhKsCZEutUlXrBaDscNlrsNz3VRVW0FR3ZAKa0yJXzuKrwUSPxq0b82XHRhPkMnm3X8lXOKGLWvFwPW6mPPFA/081x0ceVSQdRY2DJna9NS+XsYF9bbT0kvvoG8f6LTSOMpVOe9ZzBdlKPcMEuzL7eWzQN2117VDVYhYEryQT1p3B38o8ZS1Lo7/9a5ijG4Kug4gAjOnYmQOfA+YsaS4cN1A3eI4LS7qexULWnFpSlGBVNpz;20:tp0YjYoihrGZLnQJx1CyHrO7pduHsQGS/eSGD9gihY3+I+sTXb13acAGCC1/7QuvjBi3flgw3kruFqgqviqzsk1pIbb2l0dA9GTAgmVdW51w0GZMRpntZdIRoSmtKYizwSSAeoOebjjaXCPEN+/2abUaiPXgP4iR80GSLUiynEI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b090c894-7487-42c6-cf0f-08d584b26487
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10167223D2B1ACB08B831BF7FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(6666003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(66066001)(106356001)(10090500001)(22906009)(133343001)(121003001)(217873001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: HpNHb6qlSVVwLLQbQKI8DaXBnJpauQ6UCJQVOuwm3PuWlI+gJxOpTNgS/uYYPUmeKJMjoXjczRkD9ID8asla/tW/t4euddLdimBV9nFfnzRU38rYqm6BMIKaHAMehPzd1GL9ZtkbBxXzEp15Bk7GBopuFmKSRPp60BE/X1PEe0OINaM3w3UqlJSv0dwXdJj8NWsk7h6EROBx2rPGtak3FVO25lua8NJJiHSnYOXNPm0n82gJFKGOs8j3kh6cZkPVeSf3vkSkIsQFlIyMqOpApHSlAZGXAC68pEQ3gZ+nLRZRCqkH+cce3aBqdeDy7YJ8Gl64QEHXFiGFqBQMRHEo/lzZGm/TidF4FblHJ/5ZsCZfeN9OTzTZUo9bhIfMY4+SABhqKaONsqyBepPzSFoKzA==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b090c894-7487-42c6-cf0f-08d584b26487
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:57.2413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 2c949ce38f4e81d7487f165fa3b8f77d74a2a6c4 ]

The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should be
set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO in RC
mode. However in EP mode, the host system is not able to access the
MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-oma=
p2/clockdomains7xx_data.c
index 7581e036bda6..70e3b711e79c 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -524,7 +524,7 @@ static struct clockdomain pcie_7xx_clkdm =3D {
 	.dep_bit	  =3D DRA7XX_PCIE_STATDEP_SHIFT,
 	.wkdep_srcs	  =3D pcie_wkup_sleep_deps,
 	.sleepdep_srcs	  =3D pcie_wkup_sleep_deps,
-	.flags		  =3D CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  =3D CLKDM_CAN_SWSUP,
 };
=20
 static struct clockdomain atl_7xx_clkdm =3D {
--=20
2.14.1
