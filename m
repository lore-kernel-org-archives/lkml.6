Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485024-2-11186459926087259663
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
    t=1520485024; b=aoAFQUKwDxR+Qm9kqLnGGwIvH1bqmPWhT6+XxQ/lX1QgIsb
    bGT65kScJn55mZn5HVsthrgxIff4Dgg6uj1pxNefxjWioOX/HbBaX3v9h9mEh4Cd
    K8+qsjrHzytxOdjQMIRKewO6wOcQgqQw/ENz81UOof5JrdeC3fu7B20BbYHgtOiS
    y/EUST+kQAVu6E4i9QE9X0Jx48XB9lweohcDgjR4d78L6r45mBrYn8q+9FJbzp9U
    OXng1vYVCpPFyijlYwPi24nemAyOVfyW/XRSBXpgJ6mCmqUiTdTKrQL1CVHjyH5a
    Flunkec4OwAMP2tGVzQmvXQpm20e1+TrGlBI0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485024; bh=2KxfKl
    ZebUKZlqETGMyqlEjLWxucAFjWLTsPobu9dl8=; b=owFer/IucAmgue6yntEa2r
    eD/PmlMRZAMFATuOGFEgKKh+Vlf+/omFMHqElldRGybZGak5kDT6CLCh71x7KxLx
    A0xB5pRcbBLyuz5bW/Z8Sj33nsQSMrrtwWdoovlvHeM6zk1RIcr0di8M2liX/+O0
    6UJoL3h0wU1my1l3CNvvzSNQ4PY8yno5Apb0t6+vNZLxbMvLyo11BpMtZG5r/g0v
    W1YKu+flG33+wumlFFcZ4u5lTUMTvx4VZT9bLXo/ZYYzcRCBKQq/8CGJKKeLzM9R
    bSuYf2OmSq7+D6mKJGxXZxVN8xx/HB7h6MQJxq0lDlK+AgmBcWodqtSrQUd5v/FQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lDsMNi3w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lDsMNi3w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755187AbeCHE4h (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:56:37 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934577AbeCHE4f (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:35 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shawn Nematbakhsh <shawnn@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 30/78] platform/chrome: Use proper protocol
 transfer function
Thread-Topic: [PATCH AUTOSEL for 4.15 30/78] platform/chrome: Use proper
 protocol transfer function
Thread-Index: AQHTtpnJLNHmXu/QfkW5gzNWsLcskA==
Date: Thu, 8 Mar 2018 04:56:14 +0000
Message-ID: <20180308045525.7662-30-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;20:YROp6hCQkRU86qn9SvJWVq4mXJoR3jJgsk+4P7fUvum3Hfh+UPnUl2KyW5fGUT13BRNwFWY04FgntHIoDtA8/p9nzHl2vuTe1iaWu4WD4eVfrtBvJ0Y7Uu2rKWcfiZ6ZziS2iWMDxcfIGk2ru6xacDbXdCMYxtoIlofz1LPlC4Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45c868a1-cf5e-4729-ef95-08d584b0f59e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111F00D62EBB33F80CD766DFBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: q871Mo/QlISFM/wAEe3dFAEJLapkx5jvF2GbRUqud0QMgLEPztciggLC1UllL1RZ1T4IK+mlDFTWz7S0q4eC/0cZJqK/DCsFALBpQ5lOnUzgomzMYbWQbJXWPs5mL43+Sv1zyk7xvKcOQuiTdVFrogsFLTdnCoqq1+rxIXox/bM6k3fCZM2vB740ZmAmN8EmbPQbRvsCpxRmLPrsHSikVNkvuh/S4SWLv+iV7RFnT3Xf73sdY4hlcBaNb2SvD9vNK+tCiotIrxBlG9rpv1LBKIwr8G5jooxFcWlqZ0zmMd4krQ/jHHeCG0yFRiNlGXDuQZEQS7aUWdrfDqosBTK2MA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c868a1-cf5e-4729-ef95-08d584b0f59e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:14.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
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
