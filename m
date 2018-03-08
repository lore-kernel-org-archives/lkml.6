Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486524-2-12731460648781229803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486523; b=gpNkzSt8JR2kupXlu4zuTHIWYWaw4nAtbKOzozJycV2AYIt
    zwqCEL8vsE37iplbOQ6xXvIQTyGNDtKLY3pRwgrQX3T9heI9/WzQGl7fQPHUAkRL
    Y3Eb9Y2+H5kSJDyPpeawz+sXjlPGlhDTA2SBoTMpGvVtiUZjnEG7xw181Cp8aqBT
    v0Q7nPdv8/3KyAI5kxH5GjqkuTZMGLWZn0eNZIHZ9Ezj3FKTWF4N0KWoR4OMQ9hY
    LH4bchiZhpWg8KiTbIFVzRwPMA4/yXFvdKzhOs2gr9Sc20eHcq8XBVNDRJtO6SbQ
    m6orV/jfZj//FL/VlaWmjMFWOMFI6c9YIJg5hOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486523; bh=aItdMQ
    FhXcN6qbb+be9alSmuWeOENXRACvoeTnFIGPY=; b=R2vweWXfcFuW9EEJ5TR/7K
    DRSj6+6oKP6BjA2IV3EOng6JwND2E2QWJqxdtsk5RnZ6G/v81PzsJQyCR7edqSvk
    4GtUW8Bh3U5I6jYaSiuQIW+n16ZJFJgvef75xqfxxhbyQRzArfsyJLuUtteyTmlU
    Evw8n96Fxst7LWkHgNdb+MonOmqeyHWlOQxumZa2qyrO8mYLocdZgTOJCJ6L199m
    XKl4HO3n1DrzBP+WYnN1KuqQPhxTb/XxTQamxPneDIyV6aDsEfy3jeffmefb/zFB
    Nrlmg/ueCarSE9ddWk9kvyG7G8JzqROXMinobaN3airfK+fpXpldF90d/Yw5wWQg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AWNaEeBg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AWNaEeBg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966692AbeCHFIG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:06 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966674AbeCHFID (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anton Vasilyev <vasilyev@ispras.ru>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 098/101] RDMA/ocrdma: Fix permissions for
 OCRDMA_RESET_STATS
Thread-Topic: [PATCH AUTOSEL for 4.4 098/101] RDMA/ocrdma: Fix permissions for
 OCRDMA_RESET_STATS
Thread-Index: AQHTtpqgF4Kz7mwbXEyF67Ib//9VsA==
Date: Thu, 8 Mar 2018 05:02:16 +0000
Message-ID: <20180308050023.8548-98-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:nprnIkHVfD98kNTMti6+HdZB+chHTkWDqREdSNfrhnxnpaO7biAUb1L3CTG6rfJpm/0oc1nEDtbFDZX3Am/cm7u9wXfrSgpnfVSonj/AstOjEByr4tUCbRZYeHz7VibtwPqIjhOGBs2k9O0fKB6qJT1+5olMTD3WLOP4/jkYRfA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6aae0fa4-213d-4524-c6c4-08d584b28d68
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727E8D6D457360763B16395FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(4477795004)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 3wcskZcnPmVeKiyHpuPLz8IJrhr2RJce/oQRgracVMMYsmmLQNOEXAlWBqTcgcQWil6f8A4m6z40bKYVzNItNTiKPA3rH6WcZzwDwwdE8069ywvsKNM/sv7ydXLKxBe7DhrlS2qFGfaLjylpu42ev4jFy7him+UDkqz82JAY6zwUGG5b3Cu7cKS71icVJt5tRjN14HTxTtlBXojIOMZP3LZ2e8QYT4fGJJTY8paMI+omyrzBpYZtSm5WLoJeM3Ldx/JpMUt2eDWR93vzB6mBea4SH1oTwejjP5nrwSSqzr/wGLOC4cmuzX1jULLoznsVW+2IrzUf9jdX3j9NicGrlg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aae0fa4-213d-4524-c6c4-08d584b28d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:16.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 744820869166c8c78be891240cf5f66e8a333694 ]

Debugfs file reset_stats is created with S_IRUSR permissions,
but ocrdma_dbgfs_ops_read() doesn't support OCRDMA_RESET_STATS,
whereas ocrdma_dbgfs_ops_write() supports only OCRDMA_RESET_STATS.

The patch fixes misstype with permissions.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_stats.c
index 86c303a620c1..748b63b86cbc 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -834,7 +834,7 @@ void ocrdma_add_port_stats(struct ocrdma_dev *dev)
=20
 	dev->reset_stats.type =3D OCRDMA_RESET_STATS;
 	dev->reset_stats.dev =3D dev;
-	if (!debugfs_create_file("reset_stats", S_IRUSR, dev->dir,
+	if (!debugfs_create_file("reset_stats", 0200, dev->dir,
 				&dev->reset_stats, &ocrdma_dbg_ops))
 		goto err;
=20
--=20
2.14.1
