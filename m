Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122156-2-5925697136937838532
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
    t=1520122155; b=TCFwgLNd1tf609fFKto9oZl/mdbMzLU7aj2m4fS2jGOWSjf
    +EQ0IbLtO4qmQgyux/FUT7HvhJ0KW4dlb59p9mejlHa/b9fdJaGN+L8nZs1z+DWy
    EoKkd+hmHaueWeWlpPpZl9Gk2OazX0vPUGL/3MXYFg+XJcmwQ3ZfIh/DJ6r8LWP7
    H5vGTszHSQAf886juOeXE3rf2M/wNkPZvv7I75A/hijr++GkpuUMWIUPXhCyAZW0
    iZ7bfGWL4DINCh5uxS2VwP3gHktbGhsHaL2O/jIedsYYk0bsGCuWs0dWRVDmhFEB
    J7LJwWHW9Gz66AKov1DqlNhQjR67pM9UtgzDhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122155; bh=RhuNuo
    yjpdCXyUEeYOhOqntGEPtSHtwHVj0Jo7AQy+c=; b=UoxHrm9SR+cRRimSBdXTbp
    2hjxy+D/wPK4K05zjmlfCup63SwpRnGtaVKVqLc92vi3Zuamv8nnfi1tNyxd7QzD
    fxbalaE7ApGlpn51M+jaa3lNFAeZsmDLCgXASWCj2dRcRL6GOulerCdyHLo96LJS
    9OesIiScWyGfRcwjqpMFCHKmOoTCGcX61wZSnZmhzsd56QRgsWn+9tebMkymfKHA
    lx5Wb11KIRkFjP2X46J96LDZ+MvmKXM/QydDouveUX5i/MLf/JF9AQe/sHOHa4BX
    DL7d4Nwll/ii9qdXhupaLc01QDRq3JraTjo0qVNAUqqXS1b2K37wR3YK1eBWSx+A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ya/Ge6Hv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ya/Ge6Hv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933562AbeCCWbC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:02 -0500
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:51749
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933545AbeCCWa7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sinan Kaya <okaya@codeaurora.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 84/84] dmaengine: qcom_hidma: check pending
 interrupts
Thread-Topic: [PATCH AUTOSEL for 4.14 84/84] dmaengine: qcom_hidma: check
 pending interrupts
Thread-Index: AQHTsz64QNA+Bhiu50avjR3T1Vs1Jw==
Date: Sat, 3 Mar 2018 22:26:49 +0000
Message-ID: <20180303222518.26271-84-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:LKmJPp6dWPPVFlEhUc1mJaU5NnHKTrfbsxLdPfV64XX3J2xr4yIfuI6/F1njUKgTZorRZwDnha0xK9D7PcyuwwL0nhfq4aHNrkrZ8EpmK+TQeydxMVQvUk1t56Kgg+tZwZAbETSmUwKKoDIeKaitENLivqEm7QzpPzXflLeM1vpY5kjfSUgltQcOGmxl1RIRpItDeWj2avmo1GHi078Ip547JWH+XC7T1CyUOl3IsiyDp6FW3oCcFHDg5RE8QSsr
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cf1215e-249c-4176-74ac-08d581566d77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970336CB1A733BD23EE5FB8FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201703061421075)(201703161042150)(6072148)(6042181)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(498600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zWAHs9a2ckan1bNZR9jMjyPUQG9Oh+Z8B6y/oZdkzoM1Oga9XAHlk6XwuXCtEEnaB2RhF95EV3uW+J3ni72+GBj6EO6Q6JL7smcnKb/5VB/EfXFIH/7VTXsxzZq393uEEzI36bzZO74avkbqfafwM+2KSKfF6Y575JCQirqrIsM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf1215e-249c-4176-74ac-08d581566d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:49.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
