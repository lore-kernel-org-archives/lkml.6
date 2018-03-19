Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474557-2-6423475841186241436
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
    t=1521474556; b=bTqXQ77w2kU2Gv/dtyDwdeZTFqdEnUdmKQ1BBzGD4MyFD+d
    LXTBbbLfoXaA2c6DlWDRDe1+hXBjoOgrW2831Lseh/S65+5oERqet3WDy5Stq7S+
    0WdllAB7DqbC5W7d5inuza3rbmF7MhFRWWBG2tDFzUYAYES1DepLsAfMoojafp6Y
    8oX0wumFk7wq8lBvSqPEuOh19k7oRdaZNqk+FE9xf/VRQ3u2RRSjeLONOApZxPe1
    JwVmHpSPXpvt8BybNJ19Bp2kGTDQTUFokiPt/YGAYhEowYYk0Yo4D9lhKvclxW1y
    k+5FGIc7VxDk83jxB0xyPAnNrOtm9BMtSqXA28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474556; bh=OL7EBP
    Z3SUj0UTbJSNwfCqY82w25mDF4KgbgiscG5lA=; b=b3Xs+mSzh5zw6UI60A1eZF
    CGo4UkfLqLCEuoYtanNPGgWzzrWNyYZa5OUROBGDLdk17qwNa6zPCEGm+xnJvT6Q
    HrzYdl+G/IFBKmdLcqOI0wVKeXUzp1b2M4Cczf/MEfM9EUO0p50mlnAqGsIBZoU5
    SXdv6RI2pn7RtmUrn4IcVLZVtiZBooK75JqVZ56nDMZHK4pDeNA6BHIRdt120FuW
    vnLWJEdq5K7dmbj6I+dkQ4POjdFdIxlYdlPz1PJ4TE2ALFHnHUl+QUliYZJyMbh2
    ERo7P3jC0mIeUsoFs5T3yrSvAcehNUy39gEeeAEkxB3Z9GoMRa50nmw5HSR8sXrA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JHtTRAfs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeggeefnecuvehluhhsthgvrhfuihiivgepieei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JHtTRAfs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeggeefnecuvehluhhsthgvrhfuihiivgepieei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933888AbeCSPtI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:49:08 -0400
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:43108
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933847AbeCSPsz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Israel Rukshin <israelr@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 068/124] nvme: fix subsystem multiple
 controllers support check
Thread-Topic: [PATCH AUTOSEL for 4.15 068/124] nvme: fix subsystem multiple
 controllers support check
Thread-Index: AQHTv5mxV6ejS4bZJ0yeK8x6eOQzBw==
Date: Mon, 19 Mar 2018 15:48:14 +0000
Message-ID: <20180319154645.11350-68-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:DVdr8AZRFG3NLx3PeX0w5f3GRJDurxFOfZjlvCqxtSNQReAMEr09Y5zyGRBMtyZfV87500FARKmczFEAx+BoxTT9va6VqquVrJaHwkprtRa/mDWFtb706srtIZVBLoKAHTFEX51chwK0uLanWhW6ejx9yWS5Pk7XkjQQJ7LQ0P4KFa0ID0+uO+LhwkesU12rI5RwUxHsQZXH5+5uf/35HuT60hlkzsUku6dLMiE5cx/uEv/i4m9+pCD/5QhPny+B;20:FI6gPt1hIzwkk+QVdQLKXiO+7jpMKS4cLaogNnPK10WczxpPZIq6cQCcE9EvyrV38ekouqlK+Qnm+ZKHqn923Q4MgfLEXoUYqPtWQrskwwjzg5/d7bYFZvB3BVccqPB7sV+sVTbsJh0Q2ZXGDIsBWlehFpbW5zoDCiqS6TWPylg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb87f722-efab-47fc-67fe-08d58db0eaa1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09196CDD7748AFABAAFB4FC7FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 10z9VPSVSkwjTYLzuI70/jgW1ZsiExvOenk0quyLfc+TLMZIkAJCY+ER5cDyQYRY9yuABAZxEoNH8Xdwh7+6GoApF+yIUmMtoDXUYkseKvwpdWI0cB1u9TuTTqnPLl2I/97FUaCPjAkBpdkiP9kJEph81IMDkoVwnCNfMgeVq1wLwp1pFdJd6RxM6xzMWI0libhZCTmmuFCYmPlPqGk0P1Rjfujg/ZqrvMczVShiweYYQAvoU2DVe6zTVsvc2B3XQqHQQ9ZvEQTLOchVuFLhL8aBAUObvOIJffjkZCksI9wKvcxNIq+5v/H06nk9Jn+juFpTCLgt6D2Es2bLnIIlfg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb87f722-efab-47fc-67fe-08d58db0eaa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:14.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Israel Rukshin <israelr@mellanox.com>

[ Upstream commit b837b28394fb76993c28bb242db7061ee0417da6 ]

There is a problem when another module (e.g. nvmet) takes a reference on
the nvme block device and the physical nvme drive is removed.  In that
case nvme_free_ctrl() will not be called and the controller state will be
"deleting" or "dead" unless nvmet module releases the block device.
Later on, the same nvme drive probes back and nvme_init_subsystem() will
be called and fail due to duplicate subnqn (if the nvme device doesn't
support subsystem with multiple controllers). This will cause a probe
failure.  This commit changes the check of multiple controllers support
at nvme_init_subsystem() by not counting all the controllers at "dead" or
"deleting" state (this is safe because controllers at this state will
never be active again).

Fixes: ab9e00cc72fa ("nvme: track subsystems")
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3551fbd6fe41..935593032123 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2052,6 +2052,22 @@ static const struct attribute_group *nvme_subsys_att=
rs_groups[] =3D {
 	NULL,
 };
=20
+static int nvme_active_ctrls(struct nvme_subsystem *subsys)
+{
+	int count =3D 0;
+	struct nvme_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->state !=3D NVME_CTRL_DELETING &&
+		    ctrl->state !=3D NVME_CTRL_DEAD)
+			count++;
+	}
+	mutex_unlock(&subsys->lock);
+
+	return count;
+}
+
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl=
 *id)
 {
 	struct nvme_subsystem *subsys, *found;
@@ -2090,7 +2106,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl=
, struct nvme_id_ctrl *id)
 		 * Verify that the subsystem actually supports multiple
 		 * controllers, else bail out.
 		 */
-		if (!(id->cmic & (1 << 1))) {
+		if (nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
 			dev_err(ctrl->device,
 				"ignoring ctrl due to duplicate subnqn (%s).\n",
 				found->subnqn);
--=20
2.14.1
