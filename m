Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491238-5-17570845026516030832
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
    t=1520491238; b=t5dc+w9ZD4//6qAgwZ2uUtW8r7QUQXgT5w76SLXxjuytWna
    eMWYS7HEjg31x6/IMFheLU/e+cOtzmO857Xt4EWf3csBuovnYmZ1BbJIb7M7aaCp
    QObtG5lJ0TAPPNNDWVNVxiMl1GofqdfG8UxN27bu4UFf7WAUsoNwCeqVt4PP6cVZ
    UInfGEeMWtn3DIeaPtUUPCMF31ic9DxurshDethZ+Dneq3UdLNvpXcmIX7DvQAF+
    u6/h0gH3sW+KAVnR5R+yXNYP5iIWe+gd4MUr5xAM1DG+WlUIu6SVRnv0z41qexKv
    pkkf+t9Ho01f+a6ugMF3fCIkCXTEHwLkrTW/zKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491238; bh=37ejiP
    jRl6rhaJja1p9bNTgB50sSbN39RoXTYEt0bGs=; b=msQ+ENKRozDhPOXbtWw+5C
    wt/WKnnWjEin5aDUIOr7Nra8Mp6Sbj5ufAP5qVlQ447hqyuJcVI7J8vKg/8i77oJ
    o8I6lEKfVisHqUdFGUd1pR6gB1i0Isrvkfup7JQ6Fq6E8k938G2oRwNOKzOTC/I8
    hx2VvW+MYnVSK3lf1ZBSvkeYPpo7feB1ZP40+Ogh92FgQ+Ald/9KKm8xDbMUECzX
    FXBedik41D2QATOisjKEHfXFHTRPVTaRBVvzoaSrCVJmx8bfPCTt9cl0UAXh2Aqx
    WPd+maHBDcoBKMbgdfIdFMbPlV/w8IOamRCkpEcM4+g0JMn9pAcDiAOLE+U+WAHg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XVnA7p2Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XVnA7p2Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbeCHGkH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:40:07 -0500
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:14491
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935347AbeCHE7K (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 49/67] media: davinci: fix a debug printk
Thread-Topic: [PATCH AUTOSEL for 4.14 49/67] media: davinci: fix a debug
 printk
Thread-Index: AQHTtpoDydgXi3p/4EKXVYh7kS7xVQ==
Date: Thu, 8 Mar 2018 04:57:52 +0000
Message-ID: <20180308045641.7814-49-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:lDTDKkqMlzBXoyuuBg0ZvgcPDWaTUF0gsqGFdwKafFrZVb6H+uBjlSj8l69vnnE8/IAF/R4bfyKYxwvB/qBx1pvJePW/PqDAKP+umiHHcMQCBctQhTqjYHb8sQqasBefLqVg0ceQY6HFwv446lVcy40WMH9bf345d3IAZ3rvQF4f7spFV6xAgj5Ejfdp4IVq9TqT4x5olZoIhZWJd5qAgqhfK5TtHLOAcuIQ/DWY9UXQR5ipSlRduRBWaCzlIsdD;20:AKeTutrgDSbK/YUWpXSgjjMNYUYsWjMLplMTL8xX4gRIzfv0982CtrK85UZeoAzZpQw4H2ytcIKKN984KU/VcpcVPMdh+izRnM98T1gYOa7E/hwuesDo+PA8Hv4D3rR292v9kvEsfKBI6jtFLQlvMB78lPhNHX5s6P/ZM46MwQs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64f567f2-ec63-49ef-2f86-08d584b152ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101597A4AD8BB896C03D7CF7FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Wrh6J+wLYa4UQKS2ON8bFCdM/+wJAxUUsdi0Dqru8Dwi3dckbxFiGLdMVuUJ/ae7KuwOKzr4e3cH0dpTI+WTUfqWEmYYFQQpn6PPs3kl/jmLxSXlPJaqhf83OHRUj6KzqD82T8v81v8AGPYURlLE1I0/EJnykmUZZ51/iyfATxcsKMBFUV9Xd46ZY15bjkKLIJ7s629OYGEOmoUdD49bFjqmEZNuyw41sLNSoVFTz4ipOsn6DE9t7FMm/YQoxrQnvctVHMqNlkEK8DQ8ERzPXl6XofzTm/xQjll1LAPPxpq+W/VG9dio8b0VJS3ojGmpXhulXqpKPIo9U4SDXqsgYw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f567f2-ec63-49ef-2f86-08d584b152ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:52.8517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit 4f6c11044f512356cb63d3df0f3b38db79dc6736 ]

Two orthogonal changesets caused a breakage at a printk
inside davinci. Commit a2d17962c9ca
("[media] davinci: Switch from V4L2 OF to V4L2 fwnode")
made davinci to use struct fwnode_handle instead of
struct device_node. Commit 68d9c47b1679
("media: Convert to using %pOF instead of full_name")
changed the printk to not use ->full_name, but, instead,
to rely on %pOF.

With both patches applied, the Kernel will do the wrong
thing, as warned by smatch:
	drivers/media/platform/davinci/vpif_capture.c:1399 vpif_async_bound() erro=
r: '%pOF' expects argument of type 'struct device_node*', argument 5 has ty=
pe 'void*'

So, change the logic to actually print the device name
that was obtained before the print logic.

Fixes: 68d9c47b1679 ("media: Convert to using %pOF instead of full_name")
Fixes: a2d17962c9ca ("[media] davinci: Switch from V4L2 OF to V4L2 fwnode")

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/=
platform/davinci/vpif_capture.c
index 0ef36cec21d1..60b8583a26f2 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1397,9 +1397,9 @@ static int vpif_async_bound(struct v4l2_async_notifie=
r *notifier,
 			vpif_obj.config->chan_config->inputs[i].subdev_name =3D
 				(char *)to_of_node(subdev->fwnode)->full_name;
 			vpif_dbg(2, debug,
-				 "%s: setting input %d subdev_name =3D %pOF\n",
+				 "%s: setting input %d subdev_name =3D %s\n",
 				 __func__, i,
-				 to_of_node(subdev->fwnode));
+				vpif_obj.config->chan_config->inputs[i].subdev_name);
 			return 0;
 		}
 	}
--=20
2.14.1
