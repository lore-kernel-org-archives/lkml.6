Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481549-2-9024631718525380328
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
    t=1521481548; b=lcQpAxB19gFJVnFJmwssj82useR2WxbjL1C//+MWu6fKF1l
    K3nSCeVlxcvmYC9P0EyZznUr6cuGIw6T7ikSVwbyXPft0NvSu9AjwYWmZXbBkAKx
    A4llriZ24uaXhZtDzyoDQpmK1xWJUSiuLJaCilZsW51RJr6yFidbqHNEtxi7w8fS
    4+U6cyX/JzJAwyHZvBt/KI9Gf5cg/yBFleaY+VM3M4beibPeC+k9u/wnZs38fFnD
    83EGYbyJL/i2mHwukOACg7O47kXQtseIYFvjvAFhrATH3T05vkwjgLsEb23vWVcU
    qFBfpd32Xa0xSbxA3HCOzZSacfR0Ow13qDOSraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481548; bh=I9K7ef
    o/EWIavcgKmlixcNeKjyRxSGuLkd11hh4t6Cg=; b=sA26IW6wKSBlg7l2XxVU9I
    6nswnx3SNFkxb2ke/ITjWd0qFRJP5VGqohlsEfwJDNtGLQriTHm0eLxpb1xyVnrz
    eE8ux83YBp1+IBp0Umb46yaRKkmzSyTbvZyDttNBzEX/74e5ZIxMABOv4ygrkw14
    fyeJkzWqQpxSXtOq8F6wdd2E4GBbgx/IPNdH1q+mQvv7nILWMRh5/1o3IpwpOzIO
    dJT//1pOqkla8Kp4yLfusuCr0DqWUis9/+Iv59FTavtIsWVeNsuyT1KHbjCtqrYK
    RB4D9asUYZ4Af4FFpoJ5owmoGFmqGrkPPQDCjawnN2BpwUQS+mix9eEtjMrADgQQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F0IYSXRz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekiedtjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F0IYSXRz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekiedtjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968176AbeCSRo5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:44:57 -0400
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com ([104.47.38.128]:47286
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934999AbeCSQFh (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 246/281] net: ena: fix rare uncompleted admin
 command false alarm
Thread-Topic: [PATCH AUTOSEL for 4.9 246/281] net: ena: fix rare uncompleted
 admin command false alarm
Thread-Index: AQHTv5u4ZNnlaBNsD0i0yPRxcvUmvQ==
Date: Mon, 19 Mar 2018 16:02:45 +0000
Message-ID: <20180319155742.13731-246-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:GsWvwc+GduvCB8o7RaIhUvH3JCvFN+15VgSwyKMGXAKlWO49agdsiwpBhzYQ2whRxJ6uzBjqGrtVkV1JawyDKbiid6F8Il22eiXCFjgr3mljrhHwq2ifrWPmVCuke0bX2fyCru3Rm48s7xv8WryQ6+RnFinvcK1INpaH9Um4MdwtAHE+vlirSJ8I788OEW7jYe9R00yWpVCcJg4UP/p0POKchSLgw77OjOwIk+fTxK10saX2Az2U/U4TMy6BvD1K;20:pDHROYUJ7GjBMyKRy37bIASXVeW6QE6L8wYTKQCRY1SvM0pmfz6cD4+Tby8Sv2mD8VpoZ3P/WrwolWIxNUHFIseZvDAxFX+NWOG+yabBEJd6IsOut6wo6qTq9yy814wtw3wb+P0zSHKc1z9tMhjCVcDIOMkN5PkLH+itRzjkkS0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1766982-28a3-4a5d-af3a-08d58db33c60
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727EB681C3683053C60E559FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yZ29uFWeZrYaLNc737hF5IR2OT8EgA6c8b7L3KvoR+Ry444sTswUEI3fvOiuM0we4jRpCqpyKHa2bVkwkc79yxvWNIi6StaOJun46uaoN9aM3Gps9eyu0yTx8FIJToQhvKkyZk3fEAERrIDqbzSzvQ5wSJRECf+Zm5lFz++2I0Tofx+x/vlYaXEq9VtQp3dbgdQ1YnjMNo7eJvtXC46m2gVITdopABpf/QW0+OlvEPZ4kUqJHbINLrjJg5lUjtyZvPsuS6KIRiZRzl5wbP1/9W8PdR4sn1YRpUcwSoXWXi5ZL69uJtVFCBjmWrhA9znavUDapC7EJw+rWOs+WuzOpA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1766982-28a3-4a5d-af3a-08d58db33c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:45.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit a77c1aafcc906f657d1a0890c1d898be9ee1d5c9 ]

The current flow to detect admin completion is:
while (command_not_completed) {
	if (timeout)
		error

	check_for_completion()
		sleep()
   }
So in case the sleep took more than the timeout
(in case the thread/workqueue was not scheduled due to higher priority
task or prolonged VMexit), the driver can detect a stall even if
the completion is present.

The fix changes the order of this function to first check for
completion and only after that check if the timeout expired.

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethern=
et/amazon/ena/ena_com.c
index e2512ab41168..564b556baba9 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -508,15 +508,20 @@ static int ena_com_comp_status_to_errno(u8 comp_statu=
s)
 static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *=
comp_ctx,
 						     struct ena_com_admin_queue *admin_queue)
 {
-	unsigned long flags;
-	u32 start_time;
+	unsigned long flags, timeout;
 	int ret;
=20
-	start_time =3D ((u32)jiffies_to_usecs(jiffies));
+	timeout =3D jiffies + ADMIN_CMD_TIMEOUT_US;
+
+	while (1) {
+		spin_lock_irqsave(&admin_queue->q_lock, flags);
+		ena_com_handle_admin_completion(admin_queue);
+		spin_unlock_irqrestore(&admin_queue->q_lock, flags);
=20
-	while (comp_ctx->status =3D=3D ENA_CMD_SUBMITTED) {
-		if ((((u32)jiffies_to_usecs(jiffies)) - start_time) >
-		    ADMIN_CMD_TIMEOUT_US) {
+		if (comp_ctx->status !=3D ENA_CMD_SUBMITTED)
+			break;
+
+		if (time_is_before_jiffies(timeout)) {
 			pr_err("Wait for completion (polling) timeout\n");
 			/* ENA didn't have any completion */
 			spin_lock_irqsave(&admin_queue->q_lock, flags);
@@ -528,10 +533,6 @@ static int ena_com_wait_and_process_admin_cq_polling(s=
truct ena_comp_ctx *comp_c
 			goto err;
 		}
=20
-		spin_lock_irqsave(&admin_queue->q_lock, flags);
-		ena_com_handle_admin_completion(admin_queue);
-		spin_unlock_irqrestore(&admin_queue->q_lock, flags);
-
 		msleep(100);
 	}
=20
--=20
2.14.1
