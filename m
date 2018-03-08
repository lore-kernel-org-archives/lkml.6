Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488393-2-6627344222012903462
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
    t=1520488392; b=LPwF5ROQYAiCOzBLJzLijqzCVIDEKcqDOyQnxILfExTBpid
    2F3hK7Okbp/PFdZ4+hQ7DuhJZGQ9IejvEzi2wdxOcmImNpt0au1xfpNUxOwGpqe/
    bBn9ItGNfR9EbxJQSNGeMu59X/YShMUbpm123kY4MFV32pxx22hIvLnCtn2Vewuk
    gdKq6Y7xlpqqSRsVvLvwpdF0qLLfG3l2VvehQFqEnCtc1ana7znxnflM6WiwkorD
    s4nZpNEpfHVZbq1QZRMj0dgkeMiimHtoNgC4KdqlkNnUy3oSJ8pqDKc2oyUotSmu
    MTQU9NVFiXhWlN75d1LgAK4BMSXI1wmEZ2QlnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488392; bh=yFZF4o
    aso+QzxEv7KI4I4EWRM/9PYIVqJBZ4ReIymY4=; b=sdJcXSHdNohhqlvlEUE6Jh
    d86I2SiISfd3JG89M3VmpGgnpsFZqEcmcvKTAVuxFuRTMmsdf1Olj/zkOA24J7e+
    uFBEOAnaMURZmtk/UZNQpFggvNrD1gwZahkYMCHyd7llSdWLdQjYpYYsIug7Wo+A
    AEucnEWStpPdPWaegD066uBfMHywGHwg8knRxRuDkBL/ngUbKU8rqyBkOnqtvs7d
    hq3RbDeDbE1K4n5qjUgU3ycvMq7EgybLAC2lb4yW6pq2gyriM/ffjM24sMSujNMQ
    4ciN9Bb4g1DHxtZOcqsnGZCSChfQlE90W5wfe3tUfH6c7qbjLflViecy0wZNEJMQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QLUT1B5/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QLUT1B5/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965792AbeCHFxJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:53:09 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:60007
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966085AbeCHFEF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shawn Nematbakhsh <shawnn@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 166/190] platform/chrome: Use proper protocol
 transfer function
Thread-Topic: [PATCH AUTOSEL for 4.9 166/190] platform/chrome: Use proper
 protocol transfer function
Thread-Index: AQHTtppT++mSvSIXK0mGQ4GwFhLvGA==
Date: Thu, 8 Mar 2018 05:00:06 +0000
Message-ID: <20180308045810.8041-166-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;20:5ODwsiHFu1T5gxIBYwDlDh+2nxs1jT32AMZjSePJUFjdHqjMZvk+OvGlF3k3utAEksGsREr5zLs8ErpR6PVam+RoLItOJd53tmGzfZMIluFk9FY0+SQewfcXi6H9svl061qHH2E/ggO38g7889k4MHLKSzxAYlM34O852llEXT0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24affd0d-9581-41c5-c3fa-08d584b20183
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08724473496FF63C11DD2D47FBDF0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(5660300001)(186003)(5250100002)(26005)(316002)(1076002)(4326008)(2501003)(2906002)(25786009)(76176011)(99286004)(6436002)(6486002)(6116002)(36756003)(3846002)(575784001)(22452003)(3280700002)(2950100002)(86362001)(97736004)(8676002)(10090500001)(305945005)(2900100001)(66066001)(102836004)(68736007)(3660700001)(14454004)(7736002)(53936002)(6512007)(86612001)(110136005)(54906003)(6506007)(106356001)(478600001)(107886003)(105586002)(81156014)(81166006)(72206003)(8936002)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: UOrK3aa+n5DZs3WzaN534HTtfQrZlqpTdAkwJ+dfNkj5mIl3PjZ+5m4W+XsqLpDCp6bX0qW/2yglZapPp9CiWHe6YE1S7dwjDh+bPvm8NGBWgs5e9By5xnk1rtda3mmud6SxluHHGm5ZPJtdirpmvpusZPbjzsAJEzFcD9Jwgi1ckk/KyOrS1qs9TCgu23F0PIRYNl+2LkHWGXwD9d9JnJsFsVePD+k92u7ZM34d3B71BM9HEfy0K/baVlhVNP23plSAseZ0fhWFnsUUlvxx7DKqyrbWI/zi1UP9sF1vh6wLIF0d+CK+ZShbEooD7AKr1L4huH/1EfVMctT+FsEniA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24affd0d-9581-41c5-c3fa-08d584b20183
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:06.0797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
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
index 04053fe1e980..cfa3e850c49f 100644
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
