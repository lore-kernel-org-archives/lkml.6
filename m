Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495683-2-9706193374735454315
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
    t=1521495682; b=AGP99aWIpqDqeu6MHovak6tXDmrXfqJUzsVxqXgc0ZU4ILi
    U3Ptlf84Qp6ljzPbFNaLvMpDbwkVp/mneUkmstMndcDw4qyA84eym8elrCWTdo6B
    OoAfV3NuVKUOj6UrSWRg6T2rnSXjPgK4s+09+2Pb9ToApLhmBrMJwYf9zXm8VmIS
    Uulyl+AU9nRtjRtT4b1yJ2QOrPczzmOCJBDuYa5nUGetHB9ahyJrT2VaC1V9byS+
    Jot3x6U+C5dQyeT627a17PLDhg0eqcfGHBAXzT2GTuwuJpIrhjKRMF3P6H6rM04K
    iKIg38Dzfqo9R5ZhdJcSuvzcd+U+GWmSh0oZLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495682; bh=fVKowD
    vAMNDeM8sicGW1vy7Mu0Vu5E2ZaGnWc7t2Djw=; b=j82d9kVpM+6iX7no0+wAbI
    wt1pP5xFIdrDJGejj0Z30kY0UUgERQhlp38K6/t70hTFArl3g8t245bzrEshNEMB
    oGc8XjEUHR4iwnS+oIhtC3L4jdWJu2a+x4fVbrPVsGxp42GhqZAcwOF8Pjs89eo6
    x2kkNmJyJTfBW0NOyti7rBEOCHlSNnMHLFOvrRZuA2FUYh4+Lc2Xg2up0yHHZPrP
    FO/3pidZdg8KWL0PQFhIS0n3vYPT114vZXB0EqlS1W4pewiUezAnWP/ny9GmP6Yh
    +us9gGjr28GDdWOlXDJuBHvrBppX+1HNrvSL4CQVPD6kWO2m3pVSWFjG+gCEGnWg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FrVjL1sF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedvheenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FrVjL1sF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedvheenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971944AbeCSVlQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:41:16 -0400
Received: from mail-dm3nam03on0100.outbound.protection.outlook.com ([104.47.41.100]:46912
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934355AbeCSP7A (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 031/281] netxen_nic: set rcode to the return
 status from the call to netxen_issue_cmd
Thread-Topic: [PATCH AUTOSEL for 4.9 031/281] netxen_nic: set rcode to the
 return status from the call to netxen_issue_cmd
Thread-Index: AQHTv5sez+rbxyRS+E+xYyAGzG9JeQ==
Date: Mon, 19 Mar 2018 15:58:27 +0000
Message-ID: <20180319155742.13731-31-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:UUzrd+N2qMsV2cpsj36vLDza+JTKArhCJizJTnBwBLF9YEDxfNrSimW+kzp40QeiJrjhr/dQrW/xpSrKqb4HMFlrVXpg2Zz4RL++Pj+6TUhGrzgeIxH+DYNy7AohvWwOZ1QVPxKHpaZwJlM0j/z6GBPh0yjOVlgNGDWJfiPL9PtJR5rnQ4S8HCmfQrKjqBtElhOh8oHjsARJP+SSotTnUy215K/bNK9gGpaGS3mXBHJ9DHjx8bG2BrBf7QRzNi0C;20:nyjhDSI4JQ3y6bbjHnvHpT/9/Ka2nE7ISVHXT+rfIWhu34OHCLDdndQ4f8AdqN7RwgHYH0NvAZWHcUD6oZ+WNkuJbZKOcdpeek6NajZKD8jCdeZNBbzCgAdLK5Tt82ah+RU5cgvsPXxmNkp22CO9zL1SsQHqLGIvnifJ1kZaIMM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a850f3b1-8590-4254-a9f0-08d58db25301
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015221392CE4E0632AE2A5BFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: IA89lvoZ0f0MgthZd4sayHbCpXxNEi+jHzWJsH8O5mTbjCTzAjRwQe0g0q2sLTy8r1mORXlGpDy/73ADlRgTa40JkYyjoWH4Q/p5ukYsUbeTidd5lWFWqOt9QpTuM/agXMH0sdeBeXiOrNGWtFyurLP9HjYX8DpKtgwAY8WG3Qnd4ExF0jR0kK3ugV8vhWsPi5e6nmKR95kwvJhkRFm8APrjE6oGstw/StW7/5fiEZq7Lxpqk1rYCU35jgwHEv0LVAbQUzGv6eI2aRY4d9h8B5vvJsjRfNnIfYpYrDRqCC2M8GyD2PL/OAnYiXt5LajZpWJBNSYibaf1wmkfVd+nTw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a850f3b1-8590-4254-a9f0-08d58db25301
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:27.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 0fe20fafd1791f993806d417048213ec57b81045 ]

Currently rcode is being initialized to NX_RCODE_SUCCESS and later it
is checked to see if it is not NX_RCODE_SUCCESS which is never true. It
appears that there is an unintentional missing assignment of rcode from
the return of the call to netxen_issue_cmd() that was dropped in
an earlier fix, so add it in.

Detected by CoverityScan, CID#401900 ("Logically dead code")

Fixes: 2dcd5d95ad6b2 ("netxen_nic: fix cdrp race condition")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c b/drivers/=
net/ethernet/qlogic/netxen/netxen_nic_ctx.c
index b8d5270359cd..e30676515529 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
@@ -247,7 +247,7 @@ nx_fw_cmd_set_mtu(struct netxen_adapter *adapter, int m=
tu)
 	cmd.req.arg3 =3D 0;
=20
 	if (recv_ctx->state =3D=3D NX_HOST_CTX_STATE_ACTIVE)
-		netxen_issue_cmd(adapter, &cmd);
+		rcode =3D netxen_issue_cmd(adapter, &cmd);
=20
 	if (rcode !=3D NX_RCODE_SUCCESS)
 		return -EIO;
--=20
2.14.1
