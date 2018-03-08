Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485454-2-17991449277902560841
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
    t=1520485453; b=oC5j+CV2vPaoZdFq7gFYBGe2IDWqb9bmhtCr+ifqcOEv5Cz
    /xHcncNypX416G9RfPeLZPKZauLFtERuBZzYayLD3lEfVzw8RW4rtKPzl3p9Uh+Q
    RdtPomCNvGBXeL3Z32nqQty35VA/P/IlYw8xncQdDHD+CfyBE9duO5b75hEuL/Ud
    w0Jq7xptsdfsfrz+48dFRb28PvFi9x9Bhbc82phX0lkFuxsH9aUHN8BZA/jUOVMo
    fRpxkMbNf7l/m2poZhG4ERR7umjeTYnD31snnyBd1KE/zFqfPOeYxHmb/1L7YnCZ
    G+3PyMK5F/L+rXwvZQdhAye8BAlxHX3XhBE5hbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485453; bh=x/N5Jp
    9ieCbjlk/Ap8oDxP5QCpd4j/o3AEqVKInmPME=; b=ZRrjJhN2cfZrck1w7OJ4Qd
    Cevj0g3Ufgh+Qvs5xjYcccNNMrcsOVmguLVxpd8sQV5ZvOILeAan8EDTv9wuqM38
    ZZOeITbs8t5/LvOeBUQoA7KEUu/etZVtYuKNmZSxQBCDiqipxxMyolg/E/HEdlAq
    cGurgYk7176OPcnFJz0VShpGoz9Zqrv2ZQLh/K4reISzftqGkH1vUIYRIIPwVmMu
    SgaOYYQ+eNVnZ82XzkCwSAVQSFSIxaUmOT8tQxVQc54tSmNEllLyYTucqXaEgpJX
    FqPQ5Ik/PNwBYbPAIZO62rtwxRLukQ0ZxzXpHkQilgxXGCDohIbh0SdNnnmRMj7A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2/2Nmlh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2/2Nmlh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935450AbeCHFEK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:10 -0500
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:13700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966110AbeCHFEE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ron Economos <w6rz@comcast.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 161/190] media: [RESEND] media: dvb-frontends:
 Add delay to Si2168 restart
Thread-Topic: [PATCH AUTOSEL for 4.9 161/190] media: [RESEND] media:
 dvb-frontends: Add delay to Si2168 restart
Thread-Index: AQHTtppRsFkvUTsKuUCbfNh0qvV+jA==
Date: Thu, 8 Mar 2018 05:00:03 +0000
Message-ID: <20180308045810.8041-161-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:6ti5lG+8sURuNJbEe2nYwxF7/VbaibZAgPQGFaAd7undpfDfcfMvavebhMcMdWr4MshwTh+RVGzjvrCjaQyNqwG4qXQ1/ycUMx52gWfhuo2PO7kA51gy/UMCTxJ3/l1Q3kr98PtsBZ2HrIjsg9dtOdwIj35vuTxE/8w4ji0zID4gZYKsg8TKFs0n3Tk6JTYpME/9qomsiClhOOKzgqlWtzlf1yR7mfXWM90O1wCWCOYLkImqiHOAWQ63dYThCto/;20:6GUOBzvqSGrF0iBo/sONfXdC3EsztnlGlRjm1YdU6xCEZhk2nBPrjCBxmRPk3EtMyf0NAAH7rVf5TzUKT/ryHetNlOTGHnTZoONIwdaY8GKzF4n6WYXx7IsQe8auartz/3KG+Dbxdo73PjY/inU3E+/5q/nGFPZYDNsCg40VY0c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d07c91f4-df02-4ac3-1293-08d584b2003c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919E0FBA6FC5F10990B4469FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(68173958961439)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(966005)(2900100001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8666007)(6306002)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +Ybi/NqSPtqkTs0ALLjwasCUrIz3FZ4U903BLEv0GLnB0Y94vNyTLbi87HK3XixvsHsXTsg2WPHxtorDQt6cgE2V4nJrVVySpEze6jn36d1ab/wQ26X6f8Qhv+BZOc9gkzxzNLcGI7IN0cm50hiqBPdC40lRplPfbnJkuZ+bFxg72Wb5HAmwZ9f4caAtvu2XzQtj5Ty9SCCJfhsvwxvOfjCakKm++BKmYVMRZ0zPuvDSKdlUiGPkzEHFiyRkz9urIiWqEF+T7OEho3HGwGH63PsgEIqVwl4Tk2yOFjtq0yVUoxSZHDYa0ENZsyk/BVwhwvNYHF9UYZFJikQG4ThoEA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07c91f4-df02-4ac3-1293-08d584b2003c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:03.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ron Economos <w6rz@comcast.net>

[ Upstream commit 380a6c86457573aa42d27ae11e025eb25941a0b7 ]

On faster CPUs a delay is required after the resume command and the restart=
 command. Without the delay, the restart command often returns -EREMOTEIO a=
nd the Si2168 does not restart.

Note that this patch fixes the same issue as https://patchwork.linuxtv.org/=
patch/44304/, but I believe my udelay() fix addresses the actual problem.

Signed-off-by: Ron Economos <w6rz@comcast.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-frontends/si2168.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-front=
ends/si2168.c
index 20b4a659e2e4..0fe69f79a24d 100644
--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -14,6 +14,8 @@
  *    GNU General Public License for more details.
  */
=20
+#include <linux/delay.h>
+
 #include "si2168_priv.h"
=20
 static const struct dvb_frontend_ops si2168_ops;
@@ -378,6 +380,7 @@ static int si2168_init(struct dvb_frontend *fe)
 		if (ret)
 			goto err;
=20
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen =3D 1;
 		cmd.rlen =3D 1;
--=20
2.14.1
