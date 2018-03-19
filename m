Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481502-2-13290399033324310325
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
    t=1521481501; b=EcY69Jh8cxfXaLsHtSdUvgM74ptCICoA61XjpRt12A2Mcev
    35wuCpS7kOqt2oyMYJC7iWkkPlGI0kZU64snMJeu2DNncHgLTEa+NHtAwIucLPXs
    zh/HwAGwn7/9AsixmO34cC7ac55dOx6M16bdOp/TV1fHlEsPihINH8oxt1L+3KAL
    PTeIhwQietXbPigXkEHrxO3p+v7aKQtQq8Kw0K4wXyi74fFBDYbOq8wmNRos7iGV
    tuuGrTYcqUSoqTF3qK2YbGio1NtX4jt6q0v32Yi7+vfV8WZBFc1Q+lxC2zuyDPYG
    VW79vuJXZ/U8CiV77i8CRPKbkr1sgRa5Gw3qzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481501; bh=HNARpU
    wWWNRP2cX9flQf+IYLOdVP+D32i8+gN5xcY2s=; b=mZ3lycsB6U027gKaBdl7Bf
    cBSkbrwENPIAP6iyCxAXgp3BQ2gEqBXJSB6qwiIzuqqZgYSwKGsQaYmFUjYcG8Wh
    LYd7o6CFzs9WY8tvxyXnanoFoblY9eCQZfNewBzKU8Nb3Tz+oQOJTSd7V+hVZzTA
    l/WjrPECZq44jxyA0xXMVp3p6lajXKQvMC0kagTGl/twDg9//TsTQ2vcXMsAKkzz
    Tof1f1ArBp1fw40S0TnSAnHQka846Nyn7Uvgk55DQJJQ2wfDvvWEXl4XRVCaP2xE
    oaNjfD876W9tV1BsblB0E+QfzRx6xygE38oSuPaycHQRIT9LNmiXC7K47Q474t/w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aiKf9B6C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvheeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aiKf9B6C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvheeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968180AbeCSRo7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:44:59 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:50048
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935052AbeCSQFg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 255/281] ACPICA: Events: Add runtime stub
 support for event APIs
Thread-Topic: [PATCH AUTOSEL for 4.9 255/281] ACPICA: Events: Add runtime stub
 support for event APIs
Thread-Index: AQHTv5u+1BVQiBENmU2c7WLeYIPozw==
Date: Mon, 19 Mar 2018 16:02:56 +0000
Message-ID: <20180319155742.13731-255-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:Pf/scM8KA6W7MDxwYD4va30rkvul+6jHhvqKHuguu5YnwWKEtA2VFfrj8QfWAeqTeMzk5tBEDjA37hkj6a/T+LxJoZossNzIP8a1x056ncKQlRX31QBxPq6wJFRaMptjCxBxhOXPTosOiwAQlYJBXFuV2eZJXk5R4eZTF/W4f0VfYzefrvEJzci1SFjCjWn7m2oCNs/th9ZPRf/TbWYlSPb5Yz25FGxjLoT5/coGykSrK7yenqEw89EIU1vgoCaw;20:X92E5oITneHXDDpKjv6jDsT5uHSbPIhvoch7MdxJP6irhD6QQtuwSIMZ6uLmOLbnZUDSPCRvIQD8Xd5griPHsNYVW3jz9sbPZbmXPrBVFfBKrhsc7ZzOBDRb88SVFEEHNJ1irD7tEoVC/B46WLSLuk4ksrV2PadohhFc8tdoAdE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d82afe8-0adf-4c6d-c79a-08d58db33fa3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07285CBA107ED91D4E2C3329FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(478600001)(53936002)(107886003)(966005)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(6306002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: r8pHLkbRfSQxIdnCuQaCgGOsYKUsNYXt50C1Ao3mZjrxv+DDrfhrUjtjZBb2kW7TUNI09ZgM/JayD/dQZlPmIaaV+w4xpmzm77mqUV5noJeBvjbgX9R7Meg31pQXLRpbYFpS29SWVkLP0cUY5mks0MhRZoF5I1SaO9XJBpv791zxyxzhpvTB+VjMujwpNm/I6av32EYp1zyzJxzbO9lFVU63xa2yNCQhRgSQ4VCybPeVFpBXp3/+tR6KNvewIhCW1CZZ0xVwhOmbUXAnKrFO8+dcU/Mno6k4OMo6buYiaydIOq09uqVhrtGwwFiDkfQSIJ+oJ556bZXIZfrpJj87jw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d82afe8-0adf-4c6d-c79a-08d58db33fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:56.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index 9179e9abe3db..35a2d9ea0654 100644
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
