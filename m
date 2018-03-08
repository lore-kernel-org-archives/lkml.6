Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491687-2-5385273504440842205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491687; b=QHR8/kloF67htuxH/tj/ncAwaU+YLe40KVSgwMpslVpG1e8
    JBTQ3jcewZ8QvirkeMgStJgLxYr97JNImy27ZvK3HmJds9C/R7pRtkmAHzzlC3Eb
    NYX2oPyUMhFP37v0ZS5S4J42M7gAbXg4Q6zz9XfMR+9OAknnSmRyCN4Qy1xLhwke
    g7GbDTk6ypSFf1YN2CExbUGK58c/OcmS7htngtGsClpa+gptWqq2lAaNxfc+9wzG
    3LZuF0ObOknlo6sw37+T45zwWrUbdV1kXITfFEvYEs3VIRNozMBTzK22UdyNSTFl
    DYIkZBRlrEa9+0je0yfih7ziR2ua8xa5eQfk3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491687; bh=lD3cGE
    ExF2nBGPyjdg3ED3KPpiIbAqcnWLBgwyqQTao=; b=nPYQPVwsMPb2lgSFuZYNNa
    m97LiqSWbbJ7X+AYpprFosKgbdXw88i2V/CdvNioMztiUFxFIygKX5l4b+F+tlgw
    EGoXBEj16O1AwQCjwObPOVOboWpXO1q91999PsreoMxczwD3DZ7UgpNjZ6iKxo+E
    +oNyDfiPAwj45LwRD2AAt1MY2lEGMuNWPxeE/jnxSsjhiWQzEWbzT0scQSknpkM4
    CrXSJVh63mkuneWdsXiu85HmMLfqeTjM5faoguLrvN206Vq6E279MMhGTIDfOVX+
    X4fb2MJqktI4vZqR0PXNtTlOj6kKkD6hFPp/Gi5CfNBxBG5fpKiwK20VXpRglQpg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jZc6GYCg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jZc6GYCg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755445AbeCHGrt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:47:49 -0500
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:51511
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935242AbeCHE6V (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Kedareswara rao Appana <appanad@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 26/67] dmaengine: zynqmp_dma: Fix race
 condition in the probe
Thread-Topic: [PATCH AUTOSEL for 4.14 26/67] dmaengine: zynqmp_dma: Fix race
 condition in the probe
Thread-Index: AQHTtpn9DxS8TjGmy0KO3JcgtWe1ZQ==
Date: Thu, 8 Mar 2018 04:57:42 +0000
Message-ID: <20180308045641.7814-26-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:CNWLkND5vqSCiugtTzfR6wrCkzEzeMiCNyqlgk29Rc0CVq+cWe2r46OPA77zSOYdxr8NtBtQEFI5emTrJbqrlkvLCTJWeHVTCpRzqdhEfiBb0x5wceico1qaP7UjzQWRwBzhhhu2uMFOD5evrWT/WZTPARGgFuqhyZSjRo65+lJQfFddHYQHSvohtSj3dxCqd3/zns18e4ffvJhSsBf2OMP3ks1V1/ioL2eVhBUdJrVucjZ/LSKFX8VkvDvcrjDk;20:cYlol0pIUQAhX0z9/HHy2iJCFbYFaMfZglg1GQBnItOA8KepzpPOQKcDq/y74jnKNvsuMy7XMtcMuiP7HiE+oYz3wj40U0l4zQCoU4pOHyQqYj+sfUmzOwnsnzjYQCaMBLldR3Nr70y95GpXfNkFThZS8ELM/pYnHr2Tu69juEE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87a7e4de-0ff3-424c-eadf-08d584b13456
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080AA69F5ABAC5A874DB169FBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192813158149592)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(8666007)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(575784001)(36756003)(97736004)(54906003)(110136005)(5660300001)(8656006)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xMpmPakuBlqRYMlmuGqNgi/fLcBay1wHdsiK+eAmzFnrexYGBH9rn/Ncb75tkSbzkCU7u7jYNDGzyRgK4eMWAdvaqqBCbfIZ+Zwvxtobrb8tCLj3FRiD6CTRQMGtr4k6tHVZqyCuJqS7xyaj7byHRJOEobCa9zp8+yyncGraapxR8QYpNNZq6OMYTneYIvEPpverHg95n0XKrEla06umc3+1cWhUrQNYtiwwg7jMGEROdBUFcxTD+ZQMPDPXJkjvw+tyPGoLO8YKnIT2VreinP9nLtN7a/vmAF4jW/LI1vzfUbcv7SAEjMky1ST0Gscyf5wZdA9L2FS0X9mOtpsvmg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a7e4de-0ff3-424c-eadf-08d584b13456
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:42.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>

[ Upstream commit 5ba080aada5e739165e0f38d5cc3b04c82b323c8 ]

Incase of interrupt property is not present,
Driver is trying to free an invalid irq,
This patch fixes it by adding a check before freeing the irq.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dm=
a.c
index 1ee1241ca797..5cc8ed31f26b 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -838,7 +838,8 @@ static void zynqmp_dma_chan_remove(struct zynqmp_dma_ch=
an *chan)
 	if (!chan)
 		return;
=20
-	devm_free_irq(chan->zdev->dev, chan->irq, chan);
+	if (chan->irq)
+		devm_free_irq(chan->zdev->dev, chan->irq, chan);
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 	clk_disable_unprepare(chan->clk_apb);
--=20
2.14.1
