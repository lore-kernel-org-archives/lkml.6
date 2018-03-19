Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482903-2-1181873704461967409
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
    t=1521482903; b=I14ryy6nNPGLVR3HcI92tmyRS7mHaZT2/HQlJ1CR1gYi4O9
    iuRfpezlffK+1DNqxEcZBKeAAlGWgxPUl2JuFQY8qmohssalMQiUY/jHvZXb4dJY
    IjLg1TAgHMSF1hc0fuqyHEiLHh2edLfC3PaIiYnM339VFq+xd1XGTh8pje5v6dxH
    o43u9oCxS1Q51DS92ZLLhtO5+E1uIvbgifOpUZ4ozuuU9HaNTLu6GFE7oIqc4SXc
    CbPYKVcLIYxIRxG6F1fTlG9tAQdKDge6H7xE09/6/gVI1F22ym+69rX1Dss/0Sgp
    XkPNGE7E7BS4IFPmGaBjin4Vc6iZ9LvAgZcgmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482903; bh=QoYdUx
    oV2ywwpXdDMj6MqnIEaWTSAabMPpYy5LdAmX4=; b=fDHQ8J0Q5t0BpYjpDNX5KE
    /mW2t3tjzgkhguuwQWgg53PmPiwIu0ZvDBmT9tk9XLbvc3lsLbAtr/afHzXuWFZz
    kHMwOz6yyWWbHrZzE1qo2MMzXFx/JLSlsbBFcVCjqEczH5BzLTTWc7x+aTaRvKBU
    u1quYdD6RuE65GOQqc0qCorOk+iQY8zsb5yvHeRLaox/xxLkmy6SX0JB4yLH7MP4
    PTLsDpAib2HiCN7+uc+nP1kFnW9/SxOeWgjNskTam5CzyS8zPiYYfcigHp86+JQv
    vuhq+Shfr+h8uI/sQcecoktKlrx7j1sBPk9qDvw290xgwjEpQ8T+TZNW8N6VZbqg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M5dapYdt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeduheenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M5dapYdt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeduheenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965551AbeCSQDM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:12 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:53674
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965533AbeCSQDJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 172/281] drm/sun4i: Ignore the generic
 connectors for components
Thread-Topic: [PATCH AUTOSEL for 4.9 172/281] drm/sun4i: Ignore the generic
 connectors for components
Thread-Index: AQHTv5uD9qgG6lP+3keco7sYJnubnA==
Date: Mon, 19 Mar 2018 16:01:17 +0000
Message-ID: <20180319155742.13731-172-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:ok7zNkJzWk7luYdncS2f4etChJ7sdK+N5ycQk8w2aG/hogZNX+Uof5rLV1jhZdSfNYjPZKepDwls0ekjtfhucBS0r+F1FmkrA2LdEt73QD1U7vAfuz8rU8iIqCIdMBdggXjirWo60zU0U5pIaGLAj1cBx33OjW4YzXmzKTOvXRgfQK9T7WtExlrnRTIYAMMDyO6zHjAW7xzEEtMZWrVkbSa1R7eDci1iQfqWoop1uTo7NRPrGlcXUPywsvsOk12w;20:nRB4tGxKsOPKQ3nBkgOGyfmULdrxEwRJLDh7UXLcagLqa0JMKXoASMNOaO8bbqBJGzV1hEh2d6Ra/89dSJl+DFkzK9cqmdAWEl0Vuc4Ab/LwTxAYZfc3EC0LrW9DZVFG3Jbyi0DcLMpUNeIV2qKysVisfNGVvYCS9WmLzarXP/8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec03643b-b226-414e-a78a-08d58db2e273
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725E9EEC9BCB2A59EA636FCFBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: LQ+ZSkklCYe0zaORtgfjzriNX/IW3YTAJdvLx3fVQzKywMfRkRa3WTiCZRja55N/Cfcl9t1eEXSqi4Utl8JQ1h9yN2R3bCMd7CHIqQhTDJFegEW54kVPGKcj3dK8T+KnOJwIH2Hica3ajdUqKK6u9CRNdFxJOK26vSyxBwOVFDhU5ZL8DxtnSW9wptWLOw8hdwq5EBx1n9Vi4ez3Wo19iefuTCxqGjS3aNGa9imDqVlYrjcLBKm2K++Csh5QpAQ+NcLbxvnx2H0GEY/zl7oxmOrR0dNyG0gDSLrPXCLAqgDpMYtfcn7RGa+bJM5ve1zJ28g/ZOS/LNPJ2BGudTTENQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec03643b-b226-414e-a78a-08d58db2e273
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:17.1820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maxime Ripard <maxime.ripard@free-electrons.com>

[ Upstream commit 49baeb074783f5bdf770dc9fac5fbb2837190583 ]

The generic connectors such as hdmi-connector doesn't have any driver in,
so if they are added to the component list, we will be waiting forever for
a non-existing driver to probe.

Add a list of the connectors we want to ignore when building our component
list.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4=
i_drv.c
index 1feec34ca9dd..7a3d8e8eed75 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -206,6 +206,11 @@ static const struct component_master_ops sun4i_drv_mas=
ter_ops =3D {
 	.unbind	=3D sun4i_drv_unbind,
 };
=20
+static bool sun4i_drv_node_is_connector(struct device_node *node)
+{
+	return of_device_is_compatible(node, "hdmi-connector");
+}
+
 static bool sun4i_drv_node_is_frontend(struct device_node *node)
 {
 	return of_device_is_compatible(node, "allwinner,sun5i-a13-display-fronten=
d") ||
@@ -246,6 +251,13 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	    !of_device_is_available(node))
 		return 0;
=20
+	/*
+	 * The connectors will be the last nodes in our pipeline, we
+	 * can just bail out.
+	 */
+	if (sun4i_drv_node_is_connector(node))
+		return 0;
+
 	if (!sun4i_drv_node_is_frontend(node)) {
 		/* Add current component */
 		DRM_DEBUG_DRIVER("Adding component %s\n",
--=20
2.14.1
