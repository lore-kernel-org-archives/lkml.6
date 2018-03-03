Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123425-2-4503487823808688832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123424; b=bTilQJ7LuBJMhnJL5Vg4dh/7t7DO0eWZx2UdRIzt7npOunJ
    NN3TV82yorI6LqRRtbjZfxpAJlr7H9Jie+y4wgRLMocMRfjAMiRctRyjYGQ76lp4
    G1YPl9SpDELZmnZW9WzqGSMBPwoTS+0DEAPOKaC7P0fvnRL2MTXcWN68QsCumV/8
    7MzWAd0/OMucettVatsJjfXs5Mc9TAuPd5xfktgALQE9V582sJe66XVQ4rupCMDo
    4JrPfKpBkgPDuC2ST1DpKaKGMsdzFN8Ad44SYWqtD1zyYA28lirp/lFVQMQaTT8l
    eOMhU1T9HEmN7vT7FLUvrR7TIHuaOGKAeJwYZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123424; bh=RhuNuo
    yjpdCXyUEeYOhOqntGEPtSHtwHVj0Jo7AQy+c=; b=P2PdPOylhvC0JSeCOYFRPb
    ob5x1EJG3Ks7UuZ1lLd5ppOB/CRTnDCnQVw8sHv5IQ1/cIKmIb9DVIy4SxkJofV2
    SBruFhCRtgJsMCrMlciNpnz7i2Q/nUEUOqT0M+ehg3svBZCVJkwTro9RibbRkuT0
    5XFtJbmBt0aThGotRfYlgt47hsGueHhADdYnZBuQZQP2UZ6dJIyk+71emM1zbZUy
    M6XbadS7mR63K0NrRdldz719u4SKPiobUP8J4N05BNYvmYeofBb6XD3DF5t+bYgD
    /vRAQ+T0IDHnpbJdPBjTMrWgCDEfAGMxXBrf/hp6rJf5APdOYxPLNBkILijGD0Wg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aoAadtqq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aoAadtqq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeCDAaF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:30:05 -0500
Received: from mail-by2nam01on0108.outbound.protection.outlook.com ([104.47.34.108]:51456
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932464AbeCCW2E (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sinan Kaya <okaya@codeaurora.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 102/102] dmaengine: qcom_hidma: check pending
 interrupts
Thread-Topic: [PATCH AUTOSEL for 4.15 102/102] dmaengine: qcom_hidma: check
 pending interrupts
Thread-Index: AQHTsz58q1jwDw2GQU6MGyMgKJExqw==
Date: Sat, 3 Mar 2018 22:25:08 +0000
Message-ID: <20180303222318.26006-102-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:O4Cp3XkM/qSvfdXijiM/b/aCr39TrrEM7k8pw7mrIHkvp6pieXNvluXL1Qt/I19SV6EMbC83QZ8dMs+XmZY0w2ml5+fVZpxy02XOOdWXmr6XtwJ3rIEEUkcTPk6gtUdINmOlU7vg4Fz+6C90AASrfrzhRRCmj7b4rssWltSYsvdR/FqnayryHrTNzO9rX2JAWaUYnj/mRjliJQkjyU6MzLVnG043zIo3WsXmXwlKsR040tkk7XYSmk5QNULn1zhZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 765463c8-ecc0-42f2-685e-08d5815602e0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB063905FE446B99A4CB6C46FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +QL2bO02Zmy0uq1zXzkNMcYeQ7p1ZvNGio52wOe+RPYFOZJEQ4E8Gj4OQYZ2st2yZS6fXHhFnTvHtqsxKiX4f/HhThs4J6b568uLE4Z7wMaSync9pzomRVDE75VGeXfuKdxxbdTuI/z2fOIUCZbMG3nmv7VjnPRkMrcqe0L2RfM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765463c8-ecc0-42f2-685e-08d5815602e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:08.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sinan Kaya <okaya@codeaurora.org>

[ Upstream commit 38680bc6b1e3592bc9e18adc1d6e259667df27ce ]

Driver is missing the interrupts if two requests are queued up at the same
time as the interrupt handler is servicing a request that was just
delivered.

The ISR clears the interrupt at the end but it could be clearing the
interrupt for an outstanding event. Therefore, second interrupt never
arrives.

Clear the interrupt first and then check for completions.

Also, make sure that request start and interrupt clear do not overlap in
time by using a spinlock.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/qcom/hidma_ll.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 4999e266b2de..7c6e2ff212a2 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -393,6 +393,8 @@ static int hidma_ll_reset(struct hidma_lldev *lldev)
  */
 static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int c=
ause)
 {
+	unsigned long irqflags;
+
 	if (cause & HIDMA_ERR_INT_MASK) {
 		dev_err(lldev->dev, "error 0x%x, disabling...\n",
 				cause);
@@ -410,6 +412,10 @@ static void hidma_ll_int_handler_internal(struct hidma=
_lldev *lldev, int cause)
 		return;
 	}
=20
+	spin_lock_irqsave(&lldev->lock, irqflags);
+	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+	spin_unlock_irqrestore(&lldev->lock, irqflags);
+
 	/*
 	 * Fine tuned for this HW...
 	 *
@@ -421,9 +427,6 @@ static void hidma_ll_int_handler_internal(struct hidma_=
lldev *lldev, int cause)
 	 * Try to consume as many EVREs as possible.
 	 */
 	hidma_handle_tre_completion(lldev);
-
-	/* We consumed TREs or there are pending TREs or EVREs. */
-	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
 }
=20
 irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
--=20
2.14.1
