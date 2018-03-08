Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486718-2-8355166215119869851
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
    t=1520486717; b=OQa41gZ10BzZZRB7hS3C/U/IxIyJsoMV/eCn08Bamy0M9OZ
    IkwcoW8cfB8CalqTUx7otPehqihE7OrVd5y0kaYBf4r1lkbkBBTA5F76eFuL1EN2
    RsV5e3ziWFWJOVnqHfGozbBlRpnakFLYKv3f/e+Ff0rdjQWoJhqUHO+0Gt35V5Uf
    eZeBIuuAD7G/bEwdvSJKxCoWgoQyixwerHwcKZVkJJVoyeFeND+zcVonEANExIRM
    iFjvcUf+/Ru7YEnd90V9NtbyN86j1Tq+O3G6d9LZXhNw6cWZiE+TxnaaI22Xdkh2
    ZdOqYYqk2XMtf+rvb/IoD/P9SZFPenHa4fjJiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486717; bh=T/v/5e
    V2STnq1ep7blXif5LA0waK+2S2Mdylyl3yI3M=; b=MReWWd0xue87aBCCos6qJd
    eeKlIcN5xVcB+L8gbcAoxBivSWRjfFlmwUf+A7651w3FXGGHvxCwFXAxp7khqjd3
    JRaCDQrTHqzLwARF3hsJeJrgQHouq1ApKJoH7euHtxHWH6aK1l1ANLuWAeoalzLx
    IQC0uHpCEy1kE6hUZSlZl6AB5oRg/vWxTouOiSetTyY5St+F9yWJqYYlAlD3LLkU
    Eghj4Tp14v+3/u5+lAW8Anv0InhgeGzZAat88TGCcc77E38sEf4eKhCYEj1BW/Hk
    06yNBa8LBE3Lp3JBjS+Ji4mhlwllvW7TcWUB42atdzpL0AN+LHwAAtDvAIfFsAdg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IBxj9Vdv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IBxj9Vdv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966692AbeCHFZH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:25:07 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966593AbeCHFHV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shawn Nematbakhsh <shawnn@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 086/101] platform/chrome: Use proper protocol
 transfer function
Thread-Topic: [PATCH AUTOSEL for 4.4 086/101] platform/chrome: Use proper
 protocol transfer function
Thread-Index: AQHTtpqdH0QYJOzONU+on7PoEnR2bQ==
Date: Thu, 8 Mar 2018 05:02:10 +0000
Message-ID: <20180308050023.8548-86-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;20:x7+HHqbJARtHiLvl9VQij+1uknLa7xM+pLYkcicGY2cbJsLti06fXMLeu2fMy2TbgSkjrHBJmwQ1Yuknw0Ja1101p/YQzFIXoFUl0DAlNdGywbhCe44smYcEmycpwjR+lX8Wwpqj9h1u8A6nFg+KM03uZVgU2Ci3SViAS1KWABk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3061adc8-0319-496e-20f8-08d584b2760f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10779DD3DC61846AEA80A772FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: O1cLH66z9yIxzPQV5LA/oMsC9Jev6ry+JG21KS+F29YBfXQ5PsB0hU9i4RU48eSPMtnRVb9YkwjPtaE0h3MBauyd1yYJGzhxAAdGaUnbsC/DSqsr7bNwgdjvOaxH/7eyzeNrTTwgYM12Dt2Nw5BraFHd6egT6wSy7nE/sH/Fr/1+trLwrzpMn3Zvedg7fHVcxk3IVzD+1QNuEHoy9LxMomjIPPE4EawPGKwhcgXPHKvIlEPiyncmSmCTgS7UfWTPqW2NjCpW+tFBss9ETU0exw5msxKjzjYxErc8iX0mLBubH/3456BhGxaKeo1ZHqV2SZs2VUEIT1ixU3nV8t/MGw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3061adc8-0319-496e-20f8-08d584b2760f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:10.9290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
index 92430f781eb7..a0b8c8a8c323 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -59,12 +59,14 @@ static int send_command(struct cros_ec_device *ec_dev,
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
@@ -87,7 +89,7 @@ static int send_command(struct cros_ec_device *ec_dev,
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
