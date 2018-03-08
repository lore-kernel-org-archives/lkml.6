Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488642-2-15107827190330069001
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
    t=1520488641; b=bS4kQLwcNTlB6tUSIORgCLM/Dc0NpWZShhBsPmLrjTjKvLd
    Mowx4vLdb4kv956vglPr8cV1rkhIn5e2ZB0YDQSmzKqaNo9KMTZP4Z/KoIVgaSUI
    J6qN1aKwnzbBh/GLpZQRMXsexG+UIRTESwGKIVgIKtRpKvkJKWi/Nrf3+zouJu3s
    8o1TlXCKmrzVyKLQpvailqEZCsbDURGHrIlUOLEbcExV+budQCrTnWykZfknxNR5
    wOa1UA703KDombPEvfMV1HPQQaO5oW9nYb2RT8x3r/yVUlSV/ABrgD3WS8XtZGBD
    fTLJe8doalOuu2JUooYTrhi0YaFooqGDiDqAg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488641; bh=zMWkZZ
    BwlxY/mJ8+Ul8650HAu9scUVN2qP+GSZhEf4g=; b=r+3CDCeuFd/KNhOtCuufKx
    Vs2vi0ct5Mej1QtCr++U58YcjvreKEWkgOVAI3ZDKMo2bxGyzydZdEpQjETBAKg5
    ZsWJRizWZiGO1IPZMV5xoHhIgY0KWup+Fk18h9ZPegmzCuVc548usiq5ibOW4QCw
    VhV3u/StXzmM5o4m1XLx8hPAPaT3Fj1v/FMVFwD2lVaPCOHuISCFlhtfmdOcbjoc
    zHIoK89vYFJcKcFChUMA8D5ePg5MVWBk3veOaIYBBAygRnSa+TO2dWY6AUNVpjQm
    HYGJOd1T4YIYQgsHVOD+6IQIAyBC6/TmnuY4CSZPHETQ2EnWiY8Tfh+XaJIoNekw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TI0+2YYV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TI0+2YYV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966028AbeCHF4s (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:56:48 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:38578
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965889AbeCHFDb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:31 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Mera <dev@michaelmera.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 149/190] ath10k: fix out of bounds access to
 local buffer
Thread-Topic: [PATCH AUTOSEL for 4.9 149/190] ath10k: fix out of bounds access
 to local buffer
Thread-Index: AQHTtppOFBCiIAk4NkGnXcwxWY9LYg==
Date: Thu, 8 Mar 2018 04:59:57 +0000
Message-ID: <20180308045810.8041-149-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;20:idxO81hyu992JTv0W1XfrdcJ6IxOD7z3Fls+BNu5dmE3whuOK6p4i6ed8RoPrQRsyVQ8Q/j3i3ezgNNv/6jEFKa+Gfkcmazhi2INV7CG2cYa9n7yX7wQ3/KEpHItqn8/r+53Zk0kLNnjHagHDnDqc85LQtRqM2zjmHU2c2DAY9w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcc5f517-f438-46f8-673a-08d584b1eae5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902CED9B79E3A594B90B5BBFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: S05HvdiiY67v5SZlEWY2TVKhTFRJ1RbwPXKdQbXq+cYV6sem9bX9wybE9tyO7GNuipmMJ9eFgqcx+wEOFId5xyLTA0tGw1midn3iLPUl3V2UlYE4ARvfNqoUAGoP/Vo/4NLcIRvdROSW/HY1m+3lIu1/+54BGIviHxAVf6epkTQQNwNms4Ge71YI01rpyyUNcprRWv4oPke2APGpe7LtTu8szpq18lEPSwvUf2Vzvf6y8JjdC7/M7kpQ7QgcXLMz1tGNR3Jxu/B9rg+slMVybuhJ0uq+hHf+YnrPxLFtz4g2pzsYwVUEGzzfCLeJKFfjlZbBYREfijaGmFy6+BWpFQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc5f517-f438-46f8-673a-08d584b1eae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:57.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Mera <dev@michaelmera.com>

[ Upstream commit a16703aaeaedec7a8bee5be5522c7c3e75478951 ]

During write to debugfs file simulate_fw_crash, fixed-size local buffer
'buf' is accessed and modified at index 'count-1', where 'count' is the
size of the write (so potentially out of bounds).
This patch fixes this problem.

Signed-off-by: Michael Mera <dev@michaelmera.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/debug.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless=
/ath/ath10k/debug.c
index 82a4c67f3672..4b3e70df223e 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -624,17 +624,21 @@ static ssize_t ath10k_write_simulate_fw_crash(struct =
file *file,
 					      size_t count, loff_t *ppos)
 {
 	struct ath10k *ar =3D file->private_data;
-	char buf[32];
+	char buf[32] =3D {0};
+	ssize_t rc;
 	int ret;
=20
-	simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	/* filter partial writes and invalid commands */
+	if (*ppos !=3D 0 || count >=3D sizeof(buf) || count =3D=3D 0)
+		return -EINVAL;
=20
-	/* make sure that buf is null terminated */
-	buf[sizeof(buf) - 1] =3D 0;
+	rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count=
);
+	if (rc < 0)
+		return rc;
=20
 	/* drop the possible '\n' from the end */
-	if (buf[count - 1] =3D=3D '\n')
-		buf[count - 1] =3D 0;
+	if (buf[*ppos - 1] =3D=3D '\n')
+		buf[*ppos - 1] =3D '\0';
=20
 	mutex_lock(&ar->conf_mutex);
=20
--=20
2.14.1
