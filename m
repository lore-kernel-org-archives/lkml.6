Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489512-2-9568463066398194620
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
    t=1520489512; b=Nhq4dXCg+0zZ9BdbTEWa5XkQ5YT1yISqWNvxUkcB98SpqdS
    IyxKLAJH8dOASAPQ+Sf9zK7IRWlrF3HxfcMXVHSXOjRKqS/BmlzDlvwd4AnHIoax
    bJfHozVT8lzK7oYZp6mwF+5hk9X2EOLRWZQ/B44aY1O96Qu2h89X9u+B0TRs61pv
    sKvKOqPvSX+YanjVB0WFxXhjWnxsky65YS5MQlnT5tdFzpY90fLDvQNNnxdS0CZo
    GMXRDqQK8i7kERI2/jZPIwBB7bT1rw4Pcq9iZitIUmnIICgrsipX5HsgU6KxW4nt
    4kYW59mnN5t99nZXxahE8SAlO+9LPxlzbCUWAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489512; bh=MZ2C9b
    ueT+7ztQmHtAJFfdhAE3Qnmtr9oSi0kf/EKko=; b=wF29i9RntL41//RSOx5Apu
    0mb1EaYUY2Wz7ZrrOLsXkeYl80BAi1+XuSw7Ao4rLJhdVLVIG1dax3TMEr8DDU95
    g+yd+LGXDhNfwRC+t4MixkPKa6kuAGTA47+9igkyAIqhvHwoFs+RQwWZIDvRBsi8
    rqNKj9ST6zdgdAQiOUMSYD1QZBwcRii0nfLwbWQKM1brbX6+YVLH5iihTZ/C8lEC
    8DgTqwbEFSnHFxA3C9W8uSIySeYMey7F6lehVyCQlu/4GeLLYW+QMpTdr9+G2q20
    cwZMkYkh2RwPLNnetUR1/+1qEerTUEiU9hAHy8Oj01fhdLVTaMQepRoIf993cpGA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VZP8weo2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VZP8weo2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbeCHGLD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:11:03 -0500
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:20160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965740AbeCHFBi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:38 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 080/190] wan: pc300too: abort path on failure
Thread-Topic: [PATCH AUTOSEL for 4.9 080/190] wan: pc300too: abort path on
 failure
Thread-Index: AQHTtpo7mc+DalXETU2MvmS0fqAX1Q==
Date: Thu, 8 Mar 2018 04:59:27 +0000
Message-ID: <20180308045810.8041-80-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:JMplqrs0k9rgTqwyZsCMc4xrPZM5gszgSuvLNqny4rqqNc1/ZV37mhu7tyPN3hpT2PvRJc50y4IV/ty3MmgvaGmh4Gjk2nOl+wvJ88Zreg3SVOln1hcTgDDvk01zyNadx+V8Qb2tDLOtTMmYQyyPE4AV4r6sZjjHow1paZzlrMoX+2q/tgeW7VnvN9MSxQIfEqfdnObF3zc4OiNQFNRm5IMn7vOzEFuImip6ZmMtPj5cROilT7Ca7lDzTI3EyRTP;20:RQPrciMYkNAOqkf3YkhFQKf0+7CaDWg5uIMzken22qqc8Ii935jo6eTxETfkNyQej5eP1Jb1PY4vwrfacGiIMubICNVhLN+zOsysJ58jPYvjVC/o/qz278kLVcAzOxwFXj/G4sQMdagbkXosR3EGSwOckSUDba27fumVJ3om0lg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dc541e2-a418-4fd9-9637-08d584b1a6b5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09018923436B0CBFBDEDE883FBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(575784001)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: THIdAHfItz15UEcRwY9uHCGcU09rBjhnzHwX0s9xlJbRrJ7PgSN/ObhIXeon9gQgxaR2FdQX9ppCfok90dSqefcfQhcxDbgh/41DtguiaKQzuZD5P2cYOXDuZDLRppZDBr60+IdubwYdtiE+UiiraM6gShZsUSA62X0dpuZ7PrfgvEOQK/hbyyZB1PtvdeXWqeSASM0kg9FEF80t4/GlpLQOZWj+y7JmNlx8SNWTnj1s8m+E+u2b0X6IQlkCbRx1r4mBWn1UZbwBwk49urNY55/Ph4+aq41IuX4MxTsB7mrKE5XcpCx5XKOFidrzuqwrG8d8PmrP1OqYQre5KQ2pTQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc541e2-a418-4fd9-9637-08d584b1a6b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:27.1301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 2a39e7aa8a98f777f0732ca7125b6c9668791760 ]

In function pc300_pci_init_one(), on the ioremap error path, function
pc300_pci_remove_one() is called to free the allocated memory. However,
the path is not terminated, and the freed memory will be used later,
resulting in use-after-free bugs. This path fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wan/pc300too.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/pc300too.c b/drivers/net/wan/pc300too.c
index db363856e0b5..2b064998915f 100644
--- a/drivers/net/wan/pc300too.c
+++ b/drivers/net/wan/pc300too.c
@@ -347,6 +347,7 @@ static int pc300_pci_init_one(struct pci_dev *pdev,
 	    card->rambase =3D=3D NULL) {
 		pr_err("ioremap() failed\n");
 		pc300_pci_remove_one(pdev);
+		return -ENOMEM;
 	}
=20
 	/* PLX PCI 9050 workaround for local configuration register read bug */
--=20
2.14.1
