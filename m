Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479565-2-4198269907013841054
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
    t=1521479565; b=pFSOxSa5XXy5+7xPzY0kOTGVjgbtwih15I3LaP51nPQJg/Y
    IbeBc3jtDTxteC8WY3YZlsd5XmIDbnX1tswN9gA+V9JKKWefIjtEWrjqofEGR6o3
    PVPqgybf6aO+9837XImlhH8HIZgrJKmOduydqTJXv2YYvmXc2i5sumRA9sxB99Em
    KdCWczGfXie5faS+qwvK/sPOEiPAiCYKszGqM4y5z9EHeDPqDWL/8PMcWFy59b+r
    LPBHxIptEcGXjof6zl1oej0+SllrMhP7OEtKUXrB++kEXl02QD5kKbKRWQH1stji
    lsGf3b2AXjATWXPO9iknuN8cxjf14VAcGb/ePpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479565; bh=jjYKrd
    uvgm1I+kEMxFAd1I3ROjx172A9yBaABBRQB0k=; b=KJgADQMFkV91Fh1fZ/MDd3
    PyrdnlNGhdm7hQG3vU+cuBMO9GcGKMmba8hNUfwRKgZZ7AhTBRWsUJ1vLZHrew3Z
    Kcfk+2D+Ve1XfoVRvj/04twFoOMSU4hyp5UdI6ShDfbbF3NisqLtULrJwx0VC/Rp
    IvspuPngih+D+9WjO8cc72GViY6ISsmcb+Z0gu2PXeS7hFyMki0NOWgEZHPe3JbD
    hgJ5IhIcjmeGtOKNMBqTPHMwJkbT5pM7ZuhVm2J9hmswUNEz45InYa3lXvPeWlVv
    PWqYo05y5ENadHhhF9zFC4ziyPLGmbxsIzjA/I4+2gXqdVoUsve219Z57s1etTKQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M/etLcZB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeigeeknecuvehluhhsthgvrhfuihiivgepiedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M/etLcZB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeigeeknecuvehluhhsthgvrhfuihiivgepiedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965935AbeCSQKe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:34 -0400
Received: from mail-by2nam03on0106.outbound.protection.outlook.com ([104.47.42.106]:22396
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966565AbeCSQKH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 111/167] clk: scpi: fix return type of
 __scpi_dvfs_round_rate
Thread-Topic: [PATCH AUTOSEL for 4.4 111/167] clk: scpi: fix return type of
 __scpi_dvfs_round_rate
Thread-Index: AQHTv5xol0X3xA81fE+pnP6PZStv5Q==
Date: Mon, 19 Mar 2018 16:07:41 +0000
Message-ID: <20180319160513.16384-111-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:Xkn1g46ScLPiGLCw2bc1IrjwlgznroBjbvmDEDwJo+j+/7yXcMCigJG4vKrDwmeb9ZsEl5AYN8r72C3XZcgGB1GLq6MSfSxmYKjRMAV3ne92lNOrq0YG6R5nEx5ocVX0TD3y88mjFuPOjtlIus4IV0G1Q3/hfu53m19G6ajXm+MRlxunDocwOH34PH5KtzvE119ZLpsOCcgOeb6Fvtr0P0SxAHagCVrRcSgNpye/hNu3ywrP90AyCPI0rjMVfabk;20:OeQE4N3exn7hj51/biGodfPag6sWTDGjB7zXN+mE3LEPH3qupfigVchUoXbyR9Y+uIe1+yqvrSqu1ZEULDUwIkYjkrYFQipYAUjz3uRXlmYU18WNHjnHAfzOKaxNpJflvoYxy/cnX1w5DXoON3AmZDnLYW8+Fb2Lq5VEJKcI/bM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5084075a-4bcc-4a45-4ea7-08d58db3dd1c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09193AF33E014539F42E7F03FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xoxGdWSalLDPzpmMIIyDf4hq6QQXdn2kZm/pBdtbmtyudI8qqd1mRZS+DRJIKBBuvBlf6lk78l/A9650CR4mt2iNcEbfgjYi8eNpC2oallZ/VEsBCyBLaWrSesXAncM4NNY2Fc4alm5bVDVTB6kQ2ENCE05GSoqRrj+fpf3LZwmeTPgrLIIU0SCDK7wjS4jgFyoOISBIY/FlwqTdi+1TSQ7065Khwn0BAOzvjdTDYJ0dOiFbkemGc5tPuxgUka3isrjntxHK1rOhjXN5jLPkdXdfTiVC9fGAdAfg4UxIXtpGeCA8po1s2MobTXguS8f558gislM0vWhG0HHhkTh9gw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5084075a-4bcc-4a45-4ea7-08d58db3dd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:41.2238
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
index cd0f2726f5e0..c40445488d3a 100644
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
