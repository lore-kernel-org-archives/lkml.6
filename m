Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478913-2-17616171706272551408
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
    t=1521478913; b=lqnWCBdLb5zMr7WEdK3KaxWe4tu5vGutf8xNEjP0SBbw1ib
    EFZkcG+lTLlBMjF3knVJoU/T3JfO1qzRvE3ROJs0/MF+dJqwMJsg+l4ymVSXo91K
    z6uynkuKnmy1WgfCVuUXjqJNjKKCqlLqwhopa8ZO+CR2XktljXiCXe8u3G3dTxD4
    uS7F7sJkbY1lBMW0PaY2InZNVbXItdsWXY7nyv06ZjsSWN5Z9vZevIb9d4NwWzkh
    uBx5+PzaubkVN1F6LHgDEu1CK/s8OMGjlPaNUZuoNXNBeARl3JF3kOeA7vVyuaS2
    ADr+68rfxSS6Kamm3Mybq9F5DbhnEDYuMDO+Iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478913; bh=ci6zuS
    wrh8wb8yTUiL8Wcr0Eiz6OTMXi2zzohqooWn4=; b=NbM0+RvQRaeDMieCiuU7GA
    O+u441NzdlfihqpEz0/SX4kQOMzhEATMtdWv4bMRCu+IHoxTaO63N6E/YLAmlRUt
    +TjMJ4ZJ5nHh89Ga4Y+WSsBG/5ZNvQa1kTtwIepYkCmcGrqOd2QLX0BPJF2h7OIl
    f9kWEQskyDnpK7f3p5ZaD8TmXZ5SY1mXhO2mvHJ3wgaKl2JxMEpbVNYHyg2FZ4r0
    lCghEdUmNnF5LpWsIAvrqHDqyTNnNSYvuETfMBkHKlJ059A8Ci7Xl0sXfWvThNoV
    28L9KUTVFRHsPG8Y4ieIT/zEa7WJAuc31pMJ7NqAzZb1ho4FgpcELeHSIYlpwgIA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MIlRfr0R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdehjeenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MIlRfr0R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdehjeenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933974AbeCSRBQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:01:16 -0400
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:57012
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965995AbeCSQLG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 149/167] ACPICA: Events: Add runtime stub
 support for event APIs
Thread-Topic: [PATCH AUTOSEL for 4.4 149/167] ACPICA: Events: Add runtime stub
 support for event APIs
Thread-Index: AQHTv5yFTg4DfoY4ykyC36Up2/YYEw==
Date: Mon, 19 Mar 2018 16:08:29 +0000
Message-ID: <20180319160513.16384-149-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:+9iYMUblp6D3ZMygSDWLRL+p1snoGjVPShbfnYNNNoGoDLHfPqKhOkeZ+eZVb9oc2vDoFxyTEJd7lpyzoXYwBuurAwcANnEwKqTZ6vyxB8KZMuFeVarhV7+16TTHrf7HOU5uKtmUkv7F6Kj9/YlkT6d5THm+0AuWGSRLtNsXNwoS/XYH1ai03kB2BUteofdE87/HCHUJDCMQMIzSDV3xGh3Uc3niWTDHq7sH6J3b1u8agSLebisoTpVF2vJyLB7m;20:mSdq0WKJhMwcl/NQIJMyDVBkDgItSeKM4ZfHTkB6Mk6Ac9rNIhW9khEiyEjPz27QpPCZ2fuqzX8KKTtXMsHVTLgZNXagbhkP/0g3/rOCguPZTfF3BCP1QxIGPV0qojB9Oit9HWJIdbJav1i+XnRuY2cOj2Hu93U4ZFGBoFJnIGU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b15d2f7-7a2a-44b5-6637-08d58db3fb43
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095FE6148E25499686D467AFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(966005)(59450400001)(97736004)(54906003)(6512007)(6306002)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: wrliFtB0wRp3X4lrskyP5ZVmQyfcGY3ZN31jrl5inkq++Vc8/MO+tMNIfrmDcb3iKeKG0IVAEFSFHecudmnXhCTWFd41ApyHCXQce3aIbwmGUTqmSfPsPDf7x7pxw/i5YBYnHZ4n3w83uW5hwJYhhnB11O3R/A+ySKettqAnUCCj1T9oTV7l3G3buiVx9WcauPe05oGEQ251QsCbgZaO3bfTF8hEpUe1IQzqlMpzBb6AtARMAfrqPDQPPYVX8QoZEyRNX0nqpJyrCYGhhoxEl3fruZTyBgI0ltf5pgZlvG3cBAEwlXN3Dbl9n1ab7fonF64Ma4//FV2SLMaXJaTFFQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b15d2f7-7a2a-44b5-6637-08d58db3fb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:29.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit 861ba6351c520328e94a78c923b415faa9116287 ]

ACPICA commit 99bc3beca92c6574ea1d69de42e54f872e6373ce

It is reported that on Linux, RTC driver complains wrong errors on
hardware reduced platform:
  [    4.085420] ACPI Warning: Could not enable fixed event - real_time_clo=
ck (4) (20160422/evxface-654)

This patch fixes this by correctly adding runtime reduced hardware check.
Reported by Chandan Tagore, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/99bc3bec
Tested-by: Chandan Tagore <tagore.chandan@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpica/evxfevnt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.=
c
index 10ce48e16ebf..d830705f8a18 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -180,6 +180,12 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
=20
 	ACPI_FUNCTION_TRACE(acpi_enable_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
@@ -237,6 +243,12 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
=20
 	ACPI_FUNCTION_TRACE(acpi_disable_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
@@ -290,6 +302,12 @@ acpi_status acpi_clear_event(u32 event)
=20
 	ACPI_FUNCTION_TRACE(acpi_clear_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
--=20
2.14.1
