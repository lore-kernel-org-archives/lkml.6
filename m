Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497268-2-2879018059835490616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497267; b=HQsCjSgqAVyZBF/Tc8LylpBWbYbzhyI6NoIMXXn06uzhWBC
    IFpZNQjXWeAhCjavYHkxEllc9iyUxH5wzR4iEpueULBauZlCnd4nJMh+kE6fuqm9
    16DR/crcxRJwF8AOo42dpdg3n0tInUOJNUwQTkYgcHRxZtkuE3xh+g4tUMnC0LpR
    OtOJqrns2W0sTvkTzCiKBS1oKHbtzEOyascK3T52qWHjXZmbHba70noxQivr9OcD
    OBbR3d3UC9mfR+mhw+Y3nUA2nr7XYxyzJ+pRFdfBhuIu5HgkdZWzNZ5kXMjJh09l
    XfNq2uVWK7d1Uh2rMcrHp27qH+W7dSFFqKcornQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497267; bh=Qji2zz
    Vur24tRvq8c8XQon5UjtzAXsO7LOI7FSjSf6M=; b=vLH2x0b19XbhEfD33bRMMc
    /kf5MaueLC3uOYJIynDEDg136U6Tv3sJMmrXANYHV2k/OLUIh9mdNIeI/NH6d/DF
    a6n6jSx8VPT9AIuQyFjN7l8QqajBX58zBZeGT22Dj4VFd21aHTpMJeX9KUHeMoxQ
    ZdhgIvRe08yjkDv3Wa+4uWiKMXoueoqHeI+K8ggbcZPxwOcoAheccvLgDsbL7jTo
    e+ZDe5/9nwrp9D9iMkuw2CrnSG8YpqdMYEqFRj10GxpaLcANcuclgVkhm6xOrCcP
    QIyjwoH4CKJkPIQH/TYAyRWygNVsIl7aQMFvb0q4Z1i/hekg2p9TbPvNfe8WSKrQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IigZsPEA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdejtdenucevlhhushhtvghrufhiiigvpeejvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IigZsPEA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdejtdenucevlhhushhtvghrufhiiigvpeejvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972220AbeCSWHo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:07:44 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:46720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964786AbeCSPy6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 24/97] RDMA/cma: Mark end of CMA ID messages
Thread-Topic: [PATCH AUTOSEL for 4.14 24/97] RDMA/cma: Mark end of CMA ID
 messages
Thread-Index: AQHTv5qgte36D4lZEEut9Nzuz/MeVw==
Date: Mon, 19 Mar 2018 15:54:56 +0000
Message-ID: <20180319155411.12348-24-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:UXepNcwATczRnR4/8QIYvxAbYTvzSb+y50OU+LzaWd1ul9a8mzwn9dgWcavRYls2ze2VXfdhir4KsUU3ZolorsbGOJ1ey04CUE40yvVrWlKFkDRUowRxQ+LPpaEargpUnHnbad9PPdniqL0dN4hEC3aGt0dEuUf04Ei6s9BgIHri+w+whErHq9vvfPBHYCLuOp9LkFDjKYUv+GVYHg0x96HIt+5VwP1+mqde2ty7vYMJUos/DbM5faRQ33f7iAo/;20:VDLxBCS1rxyNljbxDqxJ5yXS7c38VRC6Ake3Dvx7ewJqemlFS1YWI/gjs1ewICBZrk98iI5fDsiQXPTKGCKOk3F11YyKmiAhhcSpU5Qjd/mnEocQhRNP9zzMkLFJYaCDCLfbJmcDuiKGhHEutDlpSRqlarBEFO1//RwCpSmS37I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64f98010-07e2-400f-a331-08d58db1c329
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806A17ED118577566071086FBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(102836004)(6506007)(53936002)(15650500001)(86362001)(575784001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZbxUfMIZT0+aotUOsKR4N7iyrhKBC4yKh26ZPZtugnCQx6iZ4X4X8VedFc5z4CXv/JxlLoing1gAFLIcDtBYbBih2BlPIrwk1E4oPCwpQVz/xQzKvB08xQio8c4+LmkGEuo4lMrgjcSozi+8YGWBUs2X/LSpGwajVvBKedK6j938PfMNuqGtMCNixZ5IRA0qrrCjibm60a+3+uqKxU0uGKGtQpLFdyhI2ULKCu17ju7rvr5bS9dOBypDnEBtpSCKcEZN7Rv6sZ1zMqs7HDQ0CSy+CeetotbEfHyH1t/4dnHLvDukClUjH4bRQZpnVJOH3THeQ7ZPyTzwlSB/ZSb0KQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f98010-07e2-400f-a331-08d58db1c329
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:56.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit e48e5e198fb6ec77c91047a694022f0fefa45292 ]

The commit 1a1c116f3dcf ("RDMA/netlink: Simplify the put_msg and put_attr")
removes nlmsg_len calculation in ibnl_put_attr causing netlink messages and
caused to miss source and destination addresses.

Fixes: 1a1c116f3dcf ("RDMA/netlink: Simplify the put_msg and put_attr")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index e457dface2d2..750490be8334 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4448,6 +4448,7 @@ static int cma_get_id_stats(struct sk_buff *skb, stru=
ct netlink_callback *cb)
 			id_stats->qp_type	=3D id->qp_type;
=20
 			i_id++;
+			nlmsg_end(skb, nlh);
 		}
=20
 		cb->args[1] =3D 0;
--=20
2.14.1
