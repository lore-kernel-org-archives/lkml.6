Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE41C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE5A2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a+wyU0ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE5A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeIBRql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:46:41 -0400
Received: from mail-eopbgr680126.outbound.protection.outlook.com ([40.107.68.126]:15261
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727449AbeIBRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLwNVllIhR5B/Iy9ZD7VlfzAoMWLCJ3zCTFYBusk53Q=;
 b=a+wyU0ulFKOP/OTWTCKVLdv7Y36PUfJuimZ0HbKGX5tP9o7vn2L+MfY0Z04WipJlF3QvEve+EpXrFcIukZPWBlKdINygRVVhSH1lnJ/Mmu3iztiBfNj8H41eej4tmqdO+4lp7NTtoRnY7LKUvEE0jbdMoOPhDex/FuB2O++2Qzc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 092/131] net: dcb: For wild-card lookups, use
 priority -1, not 0
Thread-Topic: [PATCH AUTOSEL 4.18 092/131] net: dcb: For wild-card lookups,
 use priority -1, not 0
Thread-Index: AQHUQr2OmMgcH5bPx0+gp2TBD1T75g==
Date:   Sun, 2 Sep 2018 13:05:00 +0000
Message-ID: <20180902064601.183036-92-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:jDgL+DPhWbnQBWYg6yHnBjCOWykv1a0Rdw4ylVVmY3LfveG+nJ3M+bQgScZzv5jUIaH69KBAA5VDxq1srZeTUG68G16j2XcKdSeFvfJqUA8Ec/bFiaS7gb9xOHOwd6GeYi4Y9VKTCWrtt8VX9fSDcQm/cD1DwxgjD44TvfulKJL6CF8B8FvnZnGxUvfYoAoCdioe4gzcCvy4eOiMlLcfUaC89hRxQRFIHnkMkswXWPCqJ+ADJTfiYI72eHwdyrF5ljr/tIZd1uXfJ8JeoMIWMhcFesNsW3blsT9HX5MMoTsMf2IWm4e13MT9sXYcPs0NMXoz3E8GxYc7t+oMMfdaEQzJ9GzQBxcalZ9zgWcItxk2u8/4g75lwSrgWcdeooyK+VLKwEd6suHEN2oAu9jhNsVLxY238/XUmER7iet9MK/s4+4PR5zb4MySrl2feMCbks4U6a7NpGRo79p454gDrA==;5:ky0jHtpDV5oSpjFO0CFhnVLq6CDL1i3aj5PUThS6dxwy51jejc8/G53WUBdB3jtoQGEYTkZJSOixHsFGfYXDV7HxNKFzsnavANuu8wg1AmBA8TlaAyAm01NhLvlwQXuG+JwsxyPnBjIvT1ho1ygtS3CVcROhEJIYonz8ire2aEc=;7:ToN+x3hT5rS/JyVV9TShWCTcGtM/dDLF32AlXyyVx93ZquO54uJ4BWTyA0yuTrEf4AEvuzq50Dw0zfzDm3QQCraf+wynRPir6x8YDLFjeTjfTXQK8W50+FIvb9NWphFCObw/uL0XmhuJFLYhje99Bk9cGu1FaxykwzAm1h+h0+7lVZC7z0mFPG7MC6QoR1xKkLtUII8G+ofSp8gngJzqSe1Y4xeSVvpCuyhPAm4COv7aZpHBzbyfvUDzoBwcr0SC
x-ms-office365-filtering-correlation-id: a8a2b5cf-db0a-4034-9e6e-08d610d4c366
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741D57AFB0E40D78A1FD785FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wuXBs80d1KSYyNXZCOFXZLdve4kZ+aree/2kTlVXqQQHXF7D+zzeuTOXug54Qomsg0NVTiVINwbzofdTLT3bpgOiImPYEddOLngcs63sYeIQapCiIV9V7lGMyNWQQFRP203aalu7ZnFEfZZcCrR6RWDqEW8SCl9gk1ux1OwXJbOb7lCk3lFVHtzrEUHw+TX442/30x4f+BGbpWdF6wXnHMAJTmEh9BfG06wW8SLFClhjzZc6HFeMsBq8+nPeUPs+zCXNv1SAs5QZ1GoCfTBiQ/wZctuX8biSctuyvArcjwtJGjNw1qDaC+/RrZ/NW/A8/3wMtprPCqHr2SBI05iUH8T5hcEV6eAN0Lo7bjzAwq0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a2b5cf-db0a-4034-9e6e-08d610d4c366
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:00.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 08193d1a893c802c4b807e4d522865061f4e9f4f ]

The function dcb_app_lookup walks the list of specified DCB APP entries,
looking for one that matches a given criteria: ifindex, selector,
protocol ID and optionally also priority. The "don't care" value for
priority is set to 0, because that priority has not been allowed under
CEE regime, which predates the IEEE standardization.

Under IEEE, 0 is a valid priority number. But because dcb_app_lookup
considers zero a wild card, attempts to add an APP entry with priority 0
fail when other entries exist for a given ifindex / selector / PID
triplet.

Fix by changing the wild-card value to -1.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/dcb/dcbnl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 2589a6b78aa1..013fdb6fa07a 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1786,7 +1786,7 @@ static struct dcb_app_type *dcb_app_lookup(const stru=
ct dcb_app *app,
 		if (itr->app.selector =3D=3D app->selector &&
 		    itr->app.protocol =3D=3D app->protocol &&
 		    itr->ifindex =3D=3D ifindex &&
-		    (!prio || itr->app.priority =3D=3D prio))
+		    ((prio =3D=3D -1) || itr->app.priority =3D=3D prio))
 			return itr;
 	}
=20
@@ -1821,7 +1821,8 @@ u8 dcb_getapp(struct net_device *dev, struct dcb_app =
*app)
 	u8 prio =3D 0;
=20
 	spin_lock_bh(&dcb_lock);
-	if ((itr =3D dcb_app_lookup(app, dev->ifindex, 0)))
+	itr =3D dcb_app_lookup(app, dev->ifindex, -1);
+	if (itr)
 		prio =3D itr->app.priority;
 	spin_unlock_bh(&dcb_lock);
=20
@@ -1849,7 +1850,8 @@ int dcb_setapp(struct net_device *dev, struct dcb_app=
 *new)
=20
 	spin_lock_bh(&dcb_lock);
 	/* Search for existing match and replace */
-	if ((itr =3D dcb_app_lookup(new, dev->ifindex, 0))) {
+	itr =3D dcb_app_lookup(new, dev->ifindex, -1);
+	if (itr) {
 		if (new->priority)
 			itr->app.priority =3D new->priority;
 		else {
@@ -1882,7 +1884,8 @@ u8 dcb_ieee_getapp_mask(struct net_device *dev, struc=
t dcb_app *app)
 	u8 prio =3D 0;
=20
 	spin_lock_bh(&dcb_lock);
-	if ((itr =3D dcb_app_lookup(app, dev->ifindex, 0)))
+	itr =3D dcb_app_lookup(app, dev->ifindex, -1);
+	if (itr)
 		prio |=3D 1 << itr->app.priority;
 	spin_unlock_bh(&dcb_lock);
=20
--=20
2.17.1
