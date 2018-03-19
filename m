Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482813-2-37541120580123011
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
    t=1521482813; b=Grpy2tNy6GepjXhtLvpPJn4h1KjE9r8InInCfxIU+HCntRs
    VjOwq9gItTdiWDFGeZCLExzVmH+7ijDRArfFlYEfbuw/UOsA5tGpUdfb4H8/2QUD
    ep68CaNXL/pOiWZJ1ckZoxOyJbih44v+Ejs3GcUw07wumnKDvoRbDqIpzhq+kwOC
    M1zSrhzHBqlh7CSOqE0wOp8u3NImS+U+L/bgEuffxuwACORQYvYTynOyeg2dNQrX
    gmSPhX3JmVP/jKucRGJlqT36flAH+cuLVkDRvy4R9Gi7EcZ5bQK7I6wU3NXTQIbP
    br4n4N/eYdba4+15XpXHLWGJd/qW+OqGKYvc/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482813; bh=tqG+1i
    kWfVXW+fjivo3v4djosD1DOP4+x+1E0+fArb0=; b=Afrd3UnrpLZXFea7TQZCKG
    BIwbjL2I04xCTqTDjQsfSRSQqVABWoHHrxEgSKKP7L8W9Gc+BuG01o4vbdefVdcg
    BH/hYkMrDPTh9N7Yu9lEpYGsaElJIy96uj9rPNv6BX1CQN/glhKEzhjZgkMP5bPP
    AqnDmcRw3dK5HC4QGK7LVSUJye7JKRhMB3Z1TOCvjNHmFTvftkdlVuCQnT+RLdys
    d1aSbsS8ypv+OjAIUFy5k9HSycAURIoz3oEOA7iAov11lWq5H2M6N+hT5kGgL95v
    5/S/E+s4F6Lb+XxbvUXq6jyKiHtSXPGNqOZOkQiO5h9uCFdWpJh/QSM6euwm/mMA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NLVC+mub x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieegkeenucevlhhushhtvghrufhiiigvpedvfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NLVC+mub x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieegkeenucevlhhushhtvghrufhiiigvpedvfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934981AbeCSQDc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:32 -0400
Received: from mail-by2nam03on0139.outbound.protection.outlook.com ([104.47.42.139]:32544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965474AbeCSQDS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 177/281] clk: scpi: fix return type of
 __scpi_dvfs_round_rate
Thread-Topic: [PATCH AUTOSEL for 4.9 177/281] clk: scpi: fix return type of
 __scpi_dvfs_round_rate
Thread-Index: AQHTv5uGtHpaVywcdEyu1UMV/zRmWQ==
Date: Mon, 19 Mar 2018 16:01:22 +0000
Message-ID: <20180319155742.13731-177-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:99aAa6WYrQPqK9Ak/xeb50+w0mw468xtKna4rH0d2NtGMPTaxZXwcKQDt66ClloEHwSYyT2by5unyaGbIVBkU0isOdP8tm6HwZVvlaiq1j6Nu39pUxvxqpCKbP0/kmYT9a+S3ViKAH2JpYhundRha9FU3PK50a7Diae28hjs5rRqSsImGGeT1RsRDeh4oJZv0e08mm/fxFF6aFQwkKUpWkIuvl1Z2AVvJxXdupOH9GK3nv6nf/oADuJQLbwbp55i;20:ROL8P3QITvAKGq07wgM0ztGSBDMcYaVvHiRy4jf5h7J2EvSCIb8lu5B+lUdu7arkKb7xbYXAv2yvvgDz/MwI4zSRAsnBCjMyI/4HSnacbIdUPTDClNHP1ugoCRaEY4olsZi9S5jclPiVqW6oNIZWWi16hCFE2YnkHyofDwbQzY0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce3d10fe-908f-46ae-116c-08d58db2ec1c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09197F4DEA64E08881EE01A5FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9aroGOtT6OEwbspE0nKvC7tZFWg8nT10hz9b0V3StafM7kesnHCbwgquJTHnKlYk9jznerW0fH2adVWhzCbKHvAsUZnsevK+bZr9hDulY5Hfnq2+z0NVxHcKzNQnsZ0I36sjBcRt2RyCMP1KMa+VdaTL+3bQhniWmbmynoQ7JJFJ7xfTma2TtZFG4PDpMk9unzHxPtj2fxoWTEdq98zMzUS5QD7JU6QkNNdp2Q27F79S+UZz2mx8DKZMzN0lhcSIloGvqTXB0KNoOBSegFK6rh1qq3xQzqz8TyjlZBjOey5QmHAEQcPzpY+UaeMjvsz1bKckzDvwLtDdZJ+vgGIR7Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3d10fe-908f-46ae-116c-08d58db2ec1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:22.7480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 7374aec95636ca39409545eba4ef5ff3125c2346 ]

The frequencies above the maximum value of signed integer(i.e. 2^31 -1)
will overflow with the current code.

This patch fixes the return type of __scpi_dvfs_round_rate from 'int'
to 'unsigned long'.

Fixes: cd52c2a4b5c4 ("clk: add support for clocks provided by SCP(System Co=
ntrol Processor)")
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-scpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 96d37175d0ad..8ad458b5ad6e 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -71,15 +71,15 @@ static const struct clk_ops scpi_clk_ops =3D {
 };
=20
 /* find closest match to given frequency in OPP table */
-static int __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rate=
)
+static long __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rat=
e)
 {
 	int idx;
-	u32 fmin =3D 0, fmax =3D ~0, ftmp;
+	unsigned long fmin =3D 0, fmax =3D ~0, ftmp;
 	const struct scpi_opp *opp =3D clk->info->opps;
=20
 	for (idx =3D 0; idx < clk->info->count; idx++, opp++) {
 		ftmp =3D opp->freq;
-		if (ftmp >=3D (u32)rate) {
+		if (ftmp >=3D rate) {
 			if (ftmp <=3D fmax)
 				fmax =3D ftmp;
 			break;
--=20
2.14.1
