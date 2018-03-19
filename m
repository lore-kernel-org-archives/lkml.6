Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496363-2-18345782775806854304
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
    t=1521496363; b=i0NBpzgw/2NEqhB1zHiQ6s4SdOjZAZu/wNDZcI5AJp2ZjLO
    Em2+dzrOM1Fv9wqWo4RfBN1g8l/Vyseq2POp/ppPAHnAYtCWnJpMCQP97kdQqict
    LVavTmd7oSHmpDFT+xIfPG2HjmbD4VnNejV7JjnmHJrULuU3RY6cALjKDvPJ+pUy
    MzwOWppxNQz7SlAaR3ilSZSa/2sNydr5nyoqIntl0IAWeeMDSM2af+/Um0DEJFxr
    HZmi++3SPd6KujtutbcPH3QxSp611mWTcwJMjeRWjEk+Cz8EpZVAJc/sufYVAXP3
    xoQECNkmIiUY/7iamKLncq2mpB+f5AspQtItbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1521496363; bh=ObNXgYYMwXLz6rM5yEoGhAhW9h
    7uuEJx8dr2x9vkz8Q=; b=GCZNcxDhbc8ZK5uu0Lbj2rLvp037JjsnBYJx3BjySW
    JLpvTVZo+BFnv4WWm5eDC7mukfdPysh1d5wtayYGCusOychkN5ov7ed3FH/ODP5j
    uIB3OpmIuLfFXj3K2AaiyDWmWtoJs2R2g52CEq8VlBvUN59hx7Z9rscrKha326Sv
    L/4vySGsuM92aOFtuchko9mitUA1ccZ2eUsZdTQ1pkrrfkoNfXTtWOcd8arENLWh
    mTjnWfOnvzFMSCUdTRacLlMthSzhxyN0+4fmC9SU32mOBzYEw6WtBWuMxPyY+TDc
    WBjWYSjOk3H+rkOz6dkPOrWez+fwvPdEQkIT+3bAFeUA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Tp+mu3YV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltdekkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Tp+mu3YV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltdekkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031677AbeCSVwY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:52:24 -0400
Received: from mail-by2nam01on0125.outbound.protection.outlook.com ([104.47.34.125]:56880
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934096AbeCSP5v (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "sudarsana.kalluru@cavium.com" <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Yuval Mintz <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 001/281] qed: Fix overriding of supported
 autoneg value.
Thread-Topic: [PATCH AUTOSEL for 4.9 001/281] qed: Fix overriding of supported
 autoneg value.
Thread-Index: AQHTv5sHS4KInRuif0GiYsIRhY9NiQ==
Date: Mon, 19 Mar 2018 15:57:49 +0000
Message-ID: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:MQVNAcDwic5OEud/8Rzwhbs6/iT8OqcXNdXEaSoLlnwdgh1AG0MVTxONepbvK2nwSEFPa5RJhzr5tYILoDGfi/gzWa92jNBOdQiH7Ym0/+ydJL7gud8Z1z6u2adzOZWcOp+AWTmU4TFkQAolXAUB+fPGzJZUXFGPIt7ha3g7tAuso5McSPilRzY6b8oxKvfNgNUm4nL/gBgSYpQVGKdi0JrDsfnV9MafK4ux0n4Oh9sIKIXjvaZizFG8i+9RWfOq;20:8O1VDtwQCR1v7XQ3wjU4DnOpmITwKvJTSj61QXX8h9aTHwP2zPhj01RbqRFccsCzyBIrTtwuJlgubJOhEzJTFNaNcitTjn+O5lhVdhGOm8eHE749Dl735eJ6rXmV7rF/QBKKodZ6CodLexCfPafmKkWa+kNyUiLj5cfIzsMGWdI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b22368ae-f1f4-4e78-23ee-08d58db22a29
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1064BCF5D2089F11849BBB45FBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: aGTXK6V570d+A3fvsbjTeSvA9E/PobLxla8jnOCLM98nhPzeTKd5weud2uaR+JZ/mwhJHW7A7HuHrFWQKWuE0eTifG8DaIIHoSHZy5MKbHMytoMx4rMXluJq+zkaP/Qp9N3Wwv9/flWLjbKoFuuWTq8cU0ONSUfhDrD6eHvmEWrIWx8XqPM5BgMy322GfL2Z5y316gvvAo+dJzlNFi72eu71STA+CjY7okB2ZUa521763oRHJ5XxZXhw9+GmdNDuPNmzIV/oMK440kdMZEuXn8/VuM28ScR7kQbGhD42qgQ3ESwLWtpcagv4agW1PfPtDasQNtmiSghtBlSCkF5kQg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22368ae-f1f4-4e78-23ee-08d58db22a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:57:49.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "sudarsana.kalluru@cavium.com" <sudarsana.kalluru@cavium.com>

[ Upstream commit 34f9199ce7b7e5c641b96e928bd60e086bf7f278 ]

Driver currently uses advertised-autoneg value to populate the
supported-autoneg field. When advertised field is updated, user gets
the same value for supported field. Supported-autoneg value need to be
populated from the link capabilities value returned by the MFW.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c  | 3 +++
 drivers/net/ethernet/qlogic/qed/qed_main.c | 6 +++++-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethern=
et/qlogic/qed/qed_dev.c
index afe5e57d9acb..9a6adbd9ed34 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -1628,6 +1628,9 @@ static int qed_hw_get_nvm_info(struct qed_hwfn *p_hwf=
n, struct qed_ptt *p_ptt)
 		DP_NOTICE(p_hwfn, "Unknown Speed in 0x%08x\n", link_temp);
 	}
=20
+	p_hwfn->mcp_info->link_capabilities.default_speed_autoneg =3D
+		link->speed.autoneg;
+
 	link_temp &=3D NVM_CFG1_PORT_DRV_FLOW_CONTROL_MASK;
 	link_temp >>=3D NVM_CFG1_PORT_DRV_FLOW_CONTROL_OFFSET;
 	link->pause.autoneg =3D !!(link_temp &
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ether=
net/qlogic/qed/qed_main.c
index 333c7442e48a..605351a2a1bc 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1239,7 +1239,7 @@ static void qed_fill_link(struct qed_hwfn *hwfn,
=20
 	/* TODO - at the moment assume supported and advertised speed equal */
 	if_link->supported_caps =3D QED_LM_FIBRE_BIT;
-	if (params.speed.autoneg)
+	if (link_caps.default_speed_autoneg)
 		if_link->supported_caps |=3D QED_LM_Autoneg_BIT;
 	if (params.pause.autoneg ||
 	    (params.pause.forced_rx && params.pause.forced_tx))
@@ -1249,6 +1249,10 @@ static void qed_fill_link(struct qed_hwfn *hwfn,
 		if_link->supported_caps |=3D QED_LM_Pause_BIT;
=20
 	if_link->advertised_caps =3D if_link->supported_caps;
+	if (params.speed.autoneg)
+		if_link->advertised_caps |=3D QED_LM_Autoneg_BIT;
+	else
+		if_link->advertised_caps &=3D ~QED_LM_Autoneg_BIT;
 	if (params.speed.advertised_speeds &
 	    NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_1G)
 		if_link->advertised_caps |=3D QED_LM_1000baseT_Half_BIT |
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.h b/drivers/net/ethern=
et/qlogic/qed/qed_mcp.h
index dff520ed069b..7b7a84d2c839 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -35,6 +35,7 @@ struct qed_mcp_link_params {
=20
 struct qed_mcp_link_capabilities {
 	u32 speed_capabilities;
+	bool default_speed_autoneg;
 };
=20
 struct qed_mcp_link_state {
--=20
2.14.1
