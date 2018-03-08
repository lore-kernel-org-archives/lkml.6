Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485164-2-228307890200494716
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
    t=1520485163; b=TqEHJyS6tgJFFg/b3B6XbSpH91nD6Px3XLIMZ8o4gatLHg6
    XvSPX/iMjo4Sg/lWez8nYRsSEbDfpkSNhtM1XQpKACEhM84YQitNzSFjEwH4mbCQ
    dJ4c2KFbkujzU7hxO+l+SEV4I9GhbSmMxFvFJHLYbbhMyCP9WGLSrKwdaPIHigMq
    Ke1qHYscTlkBQfNBNIx0AucyShiFWEUV8YvuR0v4wXXyJPWdKF/5ZDEK/Upt4m9g
    USg5ERgaGG+2QljOo9hrsZs/s9YTla1/gAUWMyNSreiRVamO4vKCTQvsLrdkxyEC
    ApvwD8crP4q4Wifq90MU8MYiKTNOMlNSgYWMxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485163; bh=ZTQrLj
    MeSZ0TMQT8Q1sL693JK7GIcyVjnxomnFMssW0=; b=DvDFbAdqOdniVTrvBTfKbT
    3RddwBtXFDVhWeMi3xdSfTRi4lN4SWENBe9C/AuKtfb8Wr8Lx1nlh98vIp6hMyfl
    AG5rnz3rpqnZshxGL1tDACVV+3EzC0P5Vp+ojbm0w3JLFqSTSX8z+JWqOP72DT1i
    36tx8s+jUaYEE8z0XmoEvp+vwHQx5mfCByl+5oWIBq59KdjHLlI/lKCorfjOeY1W
    AcCYk4ashQbATbtIprHZRBr6Nhx37JkUE4voQTnrlRowCJ/8m9gf3qFuYsFquglH
    W7TxNopF7L8T8oPJcKaVGPjZOmwxL0k8qyL72D7Qb6gE3k3V34eAyEOdhxwC69PQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cVHwGSPX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cVHwGSPX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965381AbeCHE7T (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:19 -0500
Received: from mail-co1nam03on0126.outbound.protection.outlook.com ([104.47.40.126]:14720
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964807AbeCHE7R (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anton Vasilyev <vasilyev@ispras.ru>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 59/67] RDMA/ocrdma: Fix permissions for
 OCRDMA_RESET_STATS
Thread-Topic: [PATCH AUTOSEL for 4.14 59/67] RDMA/ocrdma: Fix permissions for
 OCRDMA_RESET_STATS
Thread-Index: AQHTtpoGzKQ1OuAIdkWTEds3uxXaKw==
Date: Thu, 8 Mar 2018 04:57:58 +0000
Message-ID: <20180308045641.7814-59-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;20:qhnJAwYcbFQE9DNA+liHQtp6pPjUcgJkiySNzMST0dzsdmFlIW6P/Cwtljvo+VVgGIXG4lk3W86eVfUkjQ/mm+439QhDoj7+FwDMRY9FRhLSDFGztuKmqM32OiML6ADEJitQ7h8sTbtS2cv+3qG3+bhoklvOpMtbAWSpJPhSO38=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e3a966c-01d5-4a09-b433-08d584b155ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09990B29100E29D29998E1DFFBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(4477795004)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3rPMicUns3rO+Fx+G/tLejVDtxGM+sKnn9JDlliJFtEj8J8MXC0RrXNY76jYxXFenBQgCequxp1G+7zsDVbOAv3YctJgw8WuMtmqvOZ43vokL7oTR2V2m34qlVpRu3FzCy2C/fZVpVyGWnyTPGPPHEr1VRENvwFo69dvJdr8f4QdZxhGXvQ92GAnv5ulsofIKVQRKf0ci9fzabphW3sd4DBbXLG1/d76/QpIY0NQY8BWNHFwOSe6FamI8+Z5TANnWH1Hq+HCpsu4343gf9TL+hfojPHygnjYNlQSrKE3Vb0aSEJd5F3dQbm7lCNoZIPT7RvXwGB7L0qSVGHJuHoCYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3a966c-01d5-4a09-b433-08d584b155ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:58.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
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
index 66056f9a9700..48a49f8a5014 100644
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
