Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491628-3-14585293886978824211
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
    t=1520491628; b=VswTjFrzpbEhxXdKOcByPVrTMDSUzZogTaaRp1AemeXrCfR
    2dztke7VOHPvdrChOmf/dVUdsQnsG/JHVmwp8nc59x7P/eV07IQlEurczPMZ3pbz
    yGOFcIiFJi5dLO2EOxE1FgMISC6Bz4VfL6PPJbuFzLbbTKhpyQ2M1TQdSdCgFrKE
    cpC66AsinLJnBMdPcq40LsR3K/Se+NFAh3/2zACdM+mapgNqbTs/sksvTSuxot7e
    E6x0srKx+RLbsTRseKu+xfZ3/vSR7MmeSHugJJh6jKDE/BLlPKYnvLTabtTSrbdq
    IljlSGoJGWcMLgMleKiyLSkfc6gIY6HgDqxZwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491628; bh=2KxfKl
    ZebUKZlqETGMyqlEjLWxucAFjWLTsPobu9dl8=; b=WOCedS52b2fNJUg/y3Pnyt
    y+gQb1dM786Lk3Avw23+pS1XjsTa4U9NOkiLOuDPk0mvnOQz5l2XsQfH7TtdfoTI
    DCjjFY1oxGJ94HnSE8BnTQmyNMB93OiND+qm0WLM0AKqVGVkEv8DJ42z6KwNkdO8
    Q/twy/8/1/0boj0avlIDdmrmLu8jixt0O9H3OE0x4yfDkKKmERZCnduYB7S1NdQF
    VqgP/JZihjYPDqfcRePE8rck1wr8JlEckCjvPoeKF3o9vi4dgQO/HQ6mYLyk2JeV
    j+O4fcq+lvvbYMAp+FMQXZpJXyUnobJqg8EEsLCvEPZyFciFRVinaK1YVWBXyEDg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eUsW2qaz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eUsW2qaz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965188AbeCHGqg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:46:36 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:17968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965118AbeCHE6X (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shawn Nematbakhsh <shawnn@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 25/67] platform/chrome: Use proper protocol
 transfer function
Thread-Topic: [PATCH AUTOSEL for 4.14 25/67] platform/chrome: Use proper
 protocol transfer function
Thread-Index: AQHTtpn9439yy/X5bECspoKYD4+EAw==
Date: Thu, 8 Mar 2018 04:57:42 +0000
Message-ID: <20180308045641.7814-25-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;20:qamQXtzwnBgMaJeGf8nv+2G1QxYsydHbu78GqoiC7OQgZAoDNzI7MhjpzY77gdmCVqxsV/yZp6jZ+roIkIkqd+p/4z+vsMtkGSbEKz0PPtqa+nvgEBiA8RNZ0LDw2+C1qR9NhC4bctssVbuwpMawOADuJBzzIjEwmVST752q6HE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a50a3402-1ceb-4ce5-ff96-08d584b1340e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808A4C1CA6133BECC016E16FBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(575784001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: WyBFqcaFqZ5aenEHOuCx5FxT76IeLzhXj0KG/+7xSKmcmb5+7PRDhA3Rcr5kVuchNK++UHyRhz/YcQ7VutngHlVcQp/EwpdkATOco2Ief9t+TSazVtojVx3tqZBi7K8sKez8x9IybQH1jSBNXqDyu2PlTal27WvtZKQmH0boy1vg4oudlGngwbpt9OoEEzrHlMF4I4Vh5gd16jkeVo9vFjT1ElsBuFJFfDRSEAyIg58wdajIdIICfe3IaU4NA2bEIq8fjADXNIFp7PWarN7yUwEfz8XgM9bJaTr2R4zmfwssLNnwxfj2rxyQC/qw9u4mzLq1XyoRV+fdFY7lJz6SLw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50a3402-1ceb-4ce5-ff96-08d584b1340e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:42.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shawn Nematbakhsh <shawnn@chromium.org>

[ Upstream commit d48b8c58c57f6edbe2965f0a5f62c5cf9593ca96 ]

pkt_xfer should be used for protocol v3, and cmd_xfer otherwise. We had
one instance of these functions correct, but not the second, fall-back
case. We use the fall-back only when the first command returns an
IN_PROGRESS status, which is only used on some EC firmwares where we
don't want to constantly poll the bus, but instead back off and
sleep/retry for a little while.

Fixes: 2c7589af3c4d ("mfd: cros_ec: add proto v3 skeleton")
Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/chrome/cros_ec_proto.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chr=
ome/cros_ec_proto.c
index 8dfa7fcb1248..e7bbdf947bbc 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -60,12 +60,14 @@ static int send_command(struct cros_ec_device *ec_dev,
 			struct cros_ec_command *msg)
 {
 	int ret;
+	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
=20
 	if (ec_dev->proto_version > 2)
-		ret =3D ec_dev->pkt_xfer(ec_dev, msg);
+		xfer_fxn =3D ec_dev->pkt_xfer;
 	else
-		ret =3D ec_dev->cmd_xfer(ec_dev, msg);
+		xfer_fxn =3D ec_dev->cmd_xfer;
=20
+	ret =3D (*xfer_fxn)(ec_dev, msg);
 	if (msg->result =3D=3D EC_RES_IN_PROGRESS) {
 		int i;
 		struct cros_ec_command *status_msg;
@@ -88,7 +90,7 @@ static int send_command(struct cros_ec_device *ec_dev,
 		for (i =3D 0; i < EC_COMMAND_RETRIES; i++) {
 			usleep_range(10000, 11000);
=20
-			ret =3D ec_dev->cmd_xfer(ec_dev, status_msg);
+			ret =3D (*xfer_fxn)(ec_dev, status_msg);
 			if (ret < 0)
 				break;
=20
--=20
2.14.1
