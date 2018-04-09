Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235764-2-8539888776032580908
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
    1523235763; b=UKtevmJLpp7ubjhIBDWDn3sVYNO6f+ZLXlDH2l2R68kjqQU8Eu
    mvGQ62dWcNlfh+q2NLjQXNEodAxMrz8VB+S4yan/m/bSe4Fr6C7hMVl6GTzwg8ek
    Ze6fypKGthrNInRAx0HT0K9cKXuf1xXn1FFWX9dutjWxQiz4tyzmXL/VyXVtSDoL
    bR+hzd9eC2wF+6G1YTOcKUEi/oFjukh+HuQ1xzJArcaKridnJnYwwloTdiSRv72h
    zV/CblpVPd3oyjOaT3wNzyFtLwnz4NmWjLXAI4dSyG0HjOViXthp1mVae+ODrRMm
    bj/y1Ok8TaE1YOmW7xlV62ClEHZzwdCzSTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235763; bh=hwDMu1il0J
    P3Wo8EzQ8hVCZMy18qQznCCfsSTtQBJmE=; b=SlU1DHCESVCGS+ydY021uWrECV
    5JT67s6wNDO6gMxJyIq7FFN+WvBoUiv4/0iJSUOB7ximkeAcS06FpCsu86vrxt4K
    GRluF9yEypu4NKdWEKzzoGr8ON/XZLzaooTfvUHvdlCH2Dl43rdwGjGQhsVUt+sT
    hLKceHjK+KRgAYsPFW9DFzlCtgwsdX2LrKv7uR8c+u9dA+UWi1nA90os6ITFTCZC
    X7tab6AE9wEc0ZLOg0OL9IfDdPCf2mk9jd3ciQzmmtvpBKKEPq2J6zroeWazvA/f
    BHmic7pEunnwncbPPKHGLDv4+p9jsoH3IpCHyJYn7sx8JZ46IB//L5gmZBiQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=grN09Y9o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=grN09Y9o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLduFphtDk7mLNvVtU63kc/ou35oKLUfuFAvUdg+8h8TaXqoa7ziMwZq+kvt3YV8/28R6cHu1foCbW/VmCs/lIu+twk05tXFgBylNZK0JRYYLBnZnnff
    os9Fx9l1lwpMnVGL3KXMpSTYtgSUC8dcmlLUoS7aNJ5HOWjFumDXLJynjrQIEZN7fzhAuBRYsmHlqeD83OUh3JsB7DHGTsuAu/rgw/jShXEE/hBgcWxowgkD
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
    a=yMhMjlubAAAA:8 a=gYLVPaDO0sj71Jv8NcsA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933177AbeDIBBO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:01:14 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:50200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933176AbeDIAjj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 015/101] ACPICA: Events: Add runtime stub
 support for event APIs
Thread-Topic: [PATCH AUTOSEL for 3.18 015/101] ACPICA: Events: Add runtime
 stub support for event APIs
Thread-Index: AQHTz5qksfaeXhngTk2ZcOpqB50Eeg==
Date: Mon, 9 Apr 2018 00:35:22 +0000
Message-ID: <20180409003505.164715-15-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:3AggIOEwQrhbTlu6d4cixOKKySDiAPvqw758YV6P95SS1Y7765Eq8WkCs9cAVJAfPhUGoYPBbQ+mwoqORJviI48R+kSpXmEwz7WM/xc8jyVOzb15QqoI3H28n0Lk5eL2Bvr71zTs+WM5VB7dp2vV1LtXyhgqFJyHw+l53H/kSsPB2NdCcWsM5ixDnOLENHYg5GKgpT4U3RaVI5aQffDVJnvvmZVk5qPwwjNjirH5Qo9Cs5fRj7TlbQz/KGcEviaU;20:CzutL2orLMiRL4wPuC3WK7j0l90kbG92480We5zBjRynPJAnNBzT8MnHk+ntQOxCMgJaNsDkneV/YfmLZ6X/EkMATgTSycpbGjmDqs6tWjvuQDrFCu+y8iVbH7VeRasLGLf09HzSZq6k/w7ageO/lfaM8El0WrdKhuWtyau/9js=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49f35b70-364d-4a74-4a19-08d59db25e2a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047FEFE66ED2249231F5DC9FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(966005)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6306002)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: QBzugJuc4n/1+mTRoReuZQKxttJS8aqdkeNXmhNHcfEPJyJOuNj8YvUNlZ2pZHAABxfh9/xHaPEVaeHhXHfgfz9qLgds/cxeQ1YHyuFJv0UtFVAOJp/0xLxDGO+eUL7DbD05gyLNhKEOHxLz3IOGG3M0M/zU/ZBPQhwVQIqZzJFBkYfOGeHNg4O6q21KngSTe1QmgnICbYT6M6WQvhMaQOG6lJ8ND0oSyStxwBrFYOVYNM3IE5ByusfE5zyi1TU+BqCkgYWXJWCQKTOopX8iG15A9bzY6H/T7zJHMMoD0JmqLatm3xteSZ0NXfbffEoYUbublkbMBGckOh29Es8qzgFalP4nKqloljhta/G7ieTiDVg/eUF9D8PwryANZ7668CoeRUSqhptJzi3skbiOT1FJXjXLl4wMaqy7xOXVr5E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f35b70-364d-4a74-4a19-08d59db25e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:22.1423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
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
index bb8cbf5961bf..d375968c8072 100644
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
2.15.1
