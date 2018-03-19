Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478221-2-1814167129829180221
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
    t=1521478220; b=Va+yljkSTOi1Tl7teu+CF4vptMVSVmK2HlSACF70JscK667
    TYZnbnleYYq+5RmeMd2p4CNfsXTetzX3sbHfu6rvh9aLo9mcr0COCjBwgBtPtEpE
    7G07um/U12veTVHvITFNcZ9KNNKWXmzbVy/pqp8DjdMBtOEPMdEQO1KTWXn/JOvX
    GktEUhwNJFBq5ieRosZ4DxG9aD6Yh2ftXmYptuEKIvJ49CguMVt4m0K5ORq/Kiue
    ClMn8ggnaBCbhAqL3MNvFXUB2mqv3PFSy+EyomrzxzUSfBReBCtqFd3UQ6IB9cXE
    wj26rjee2yBO9WIEkIKsVHavOj5nZ3AxeXDSwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478220; bh=fVKowD
    vAMNDeM8sicGW1vy7Mu0Vu5E2ZaGnWc7t2Djw=; b=VP85zro6J8WAnfSRCrjE/h
    6bRrkMzxC85nGttQqCyUP6CHuAdyoizrh7/VJSwXlK/4sakIAZ7gyoOPLhAcv3oF
    o1zm4Wx9ioqtEX+UfKJctqbvvQO4VoP3ij2HxmI7/Y9ki0v8QxkGb3U1TU5saz2c
    l+RRbA3LRaDog+f/iNrZIktsq4Szop0DrJ1MMdr05dkqyoFrVECAfGkVHGs0ulcS
    01O1NyFEeAv2/5rwTn1E8l0Pe7lH15J0rZoTGdgvwstMcl00djgb8o+yBnNHake5
    ZTIzdkWWpioiVE22cRhA7r9WL81L54WAhzOQzNEVbJb6bk2Sw5Y8aRbzaEVmaDeQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X+86LMzn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehudejnecuvehluhhsthgvrhfuihiivgepgeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X+86LMzn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehudejnecuvehluhhsthgvrhfuihiivgepgeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967431AbeCSQtT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:49:19 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:23560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966404AbeCSQLw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 014/102] netxen_nic: set rcode to the return
 status from the call to netxen_issue_cmd
Thread-Topic: [PATCH AUTOSEL for 3.18 014/102] netxen_nic: set rcode to the
 return status from the call to netxen_issue_cmd
Thread-Index: AQHTv5z4UkQB1OV6W02tfIQsGGZ6dw==
Date: Mon, 19 Mar 2018 16:11:42 +0000
Message-ID: <20180319161117.17833-14-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:dUAwoY4sVNiLvixeIZTLdkO+mhVaMvyF2nCkWj/oDQ1a1EPlTQ+XrNGeA4tUUhzv0E0ZpB+XsJil+HuudhOLBfgFcbnTSJ70zTkupydVPGxEYmWaqayMt/K+9bpSb872wR56VgdXMf1887AewIp7CqbNs7Lc5Z/AlXt4gitIOFDapv67yyjlKZ8nhST/h8dFOnQZ50dniFSPAmSuJWNNRr/DS+Uqq8MBSipc1C5nFWULzg31g+DfovjSQV3kx+L1;20:I7FT93HEe6iG9W1juWswazzd4ZehLSaOnC1JOLMru0GI9ljIHz/Vi5g3TqgSWihzI8gFU9LvGwVJjhPFm58FmtMnjCaJCvnBc16AgL1kptUzaiQFVF/Iv6hX4MbxZ3v/YgVxrm2ELG1W4Q3A4y0w27yQBZBzKncH/0/wGDv1Mg0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bc15e1e-fba7-4d3f-aefa-08d58db41ac0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984723D5B437E9FC87B913FFBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(59450400001)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qrK9pbsC4OR96dIYHOYslFYjpeeOs6WKrdY9L59t5KW2DKg9JEhJb0m+lms5wYP42MGNNynh8g/Usd6RrYuSwJ+OFwfGrWcDq66TPXXZ7iyZEk7cMTYHNkQhAyZk9v2bBOiIQLKudOBwJnzLzWKsaqkpD4vHg/eFfxFBTErtqMFNHGTmlA+xQTuHXQ89+DUb1cCO3iL28CffNRATKcHF1zncdbm/RF/tVlrBURk8DUI7KKAGfd5y2B4rzXdWRpSJTve04kju85K/YWF+6UvC57MBNm7YGgfsTc8ECTRV3HidSuBPYCG7e1dAu3Ij6xt3CDjmwyvcLUSPfUGsihB2Hg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc15e1e-fba7-4d3f-aefa-08d58db41ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:42.3707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
