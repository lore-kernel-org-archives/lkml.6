Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239381-2-4713872065388763586
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239381; b=YV/5b4qPYkprPnV7dWxdzVfQaHLYwTNEPkMXzYGYJwCFQkcAPJ
    ogmtY8shcuovh4R+wrA/oHr8sbYvE2mJFv4fXqtdhiGxSXn2hrhNginw9b4XJQjf
    3Nvz8HrFjsrYH5xfvFWMQxKr8p9x39J0VB1HqQ7TpN+gsWwUTmIG9C+QbzwAjjNc
    biP+Fu/yVx4ZEOOfe2Z8rYSRn01TAMMSLpVqbV++pvUvw+jHWDhCFGPxjcDdq8rF
    EumriXr9O6R+hwjIkKEwVFbIPhSFwVpia5v+cK5rW2qSz/fQEHRWkxnrQD0XHehE
    vN8HaKveXHLzxBpyWFTKdfEgalH9WEtmB+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239381; bh=2FLSf+V37W
    lOVLvSHr2ISBcV5YDtvv5Fyljmg3ZO77I=; b=I6Fau/+xCscDEH3nQhpGMDj0Ty
    JHmMjnAXT+wBq/dJSmlg60zHwuhrLdJuR9s9im+DMJPVsL6stiSjkNIFq77woN6u
    MOBGcgFmBf3B0kydhBpRiGDfZiq1dMCr9pd1KMDk466QyDEMAB46B/sCf9KILpww
    8c7wAQZAC0wPplsyF1DCDm0Lw4m6ZD9ArH5FOAee40Hf+rMNd1U8mFqUpC0wSiM3
    BuuVupP1N7+XIh9VUPMiepT8mLoSbLoh5lLe1sDJAKIVJqAhcHIOpzAtMT0E2Rbz
    Q/d7homLIBM8i0R2ahOWERU8S4foIJ9WQ0ieiSHVkh6btTXk2uDq1lFVcKhg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VsWUGN8X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VsWUGN8X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAbeOnMFQqIWeIEt5YCgkd51IV9R9pCOynCH2/1cOsIajr2mzT8FDuaQlrxSFwAoKKTfVgfwZY8umyK3zmIr2BoRewZCZcx4Wk5yrt2GyAHTfKCVyWRF
    im586M+tdaXzg6CZ0wvcJkQH8T6gWUz5N2KGmg1i3qbgcmxgAuZxdQOHFY90LjZOjwfbFQq+GqgZhqMACtORLOwPGAXnuZtn7IFxvhZyYTnVoZ1M/jdhssi2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=LpQP-O61AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=s3xS02uc_K3_kLHZ-PMA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=wPNLvfGTeEIA:10
    a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932284AbeDICCx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:02:53 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756418AbeDIAcI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sinan Kaya <okaya@codeaurora.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 196/293] dmaengine: qcom_hidma: correct API
 violation for submit
Thread-Topic: [PATCH AUTOSEL for 4.9 196/293] dmaengine: qcom_hidma: correct
 API violation for submit
Thread-Index: AQHTz5lCLrROEPgki0OtEAEhkDT9mw==
Date: Mon, 9 Apr 2018 00:25:27 +0000
Message-ID: <20180409002239.163177-196-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:zgulnKALxB0RjZ1dxZzSGbIYjN+5kVvIM1gOso8dSCVoAgMqYcyhSwejgRN8BmzQXp6UytNMT84sjCMEP28797d55ZZNjHP/QGxzqqtyFthfkhYSQWMF2Ub6EOfE2MAS+3+aYvkXlT7CLOHI/vxjDM+N2m38i26EJRYAjFXIHQfrPmYOWYJ/B3mQ7zh+wAb4+MwRJ1R/bWiUHkU10pHxM+BIue4dxKDz5SgodAjra1mJ8oWKXJGRjsMoHxPlWy/j;20:3SfR5Jsugjk5tF9ISdw4rPhRcs8NqgiQPDaFlNA1S3doA7rro8swIUXi3/KMj7EgVN/8uTpqlK798M43LpmPoU7CfWfeznnMcfi/hEI7uwkPvO10kST6HNWaQv3u1YBvHZoHYn+r5/YOR/V4fCDlB7cOHkFatqRAzKafi+YGY14=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 581e725b-5165-4b58-7804-08d59db151fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870418566F0657B64390A3EFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(575784001)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EJKwfbHqbI4l3ieknahsHbcGEE3gXh5ZCxEM8I4Cm2h535YzpfD8N6r5eoITvg39Crmrgf1BFzLwF8ko2H3yK4XZuvosrTA3fMropTUIi/0/oXkArK0eberTayDTRRZcONqEZltYnS6VFnh/mjoFNVtpP9jPPgHHwtAXCy/f1VXqRfEfzrVHlJfOypqZz+mRp1IbWXycbv4XyZ5KGQn/9OugpAniLRt+rshrqqqYgQJz/uiIFj386NcDfxJJGHGsZFvjvReZ+IzMcFdJvHQsJPmCd4LD/rkirYe20dSakG9F2uUFUKrAC7NkGaEJ0sitetvQ39SR7Q5GN+p5lH9KOzZTmser9iAD7YjJ9Q/7860+qlHR3wFLAZENFhnIZlFQ8WbZTSj+0Idr/tBtcjwvr+P4arN5fs0SILUrRZTqhYM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581e725b-5165-4b58-7804-08d59db151fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:27.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sinan Kaya <okaya@codeaurora.org>

[ Upstream commit 99efdb3e48fb2fa84addb3102946d3eca341192b ]

Current code is violating the DMA Engine API by putting the submitted
requests directly into the HW queue. This causes queued transactions
to be started by another thread as soon as the first one finishes.

The DMA Engine document clearly states this.

"dmaengine_submit() will not start the DMA operation".

Move HW queuing of the requests into the issue_pending() routine
to comply with API requirements also create a new queued state for
temporarily holding the requests.

A descriptor goes through these transitions now.

free->prepared->queued->active->completed->free

as opposed to

free->prepared->active->completed->free

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/qcom/hidma.c | 15 ++++++++++++---
 drivers/dma/qcom/hidma.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index e244e10a94b5..d38a2ceaa0dc 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -208,6 +208,7 @@ static int hidma_chan_init(struct hidma_dev *dmadev, u3=
2 dma_sig)
 	INIT_LIST_HEAD(&mchan->prepared);
 	INIT_LIST_HEAD(&mchan->active);
 	INIT_LIST_HEAD(&mchan->completed);
+	INIT_LIST_HEAD(&mchan->queued);
=20
 	spin_lock_init(&mchan->lock);
 	list_add_tail(&mchan->chan.device_node, &ddev->channels);
@@ -228,9 +229,15 @@ static void hidma_issue_pending(struct dma_chan *dmach=
)
 	struct hidma_chan *mchan =3D to_hidma_chan(dmach);
 	struct hidma_dev *dmadev =3D mchan->dmadev;
 	unsigned long flags;
+	struct hidma_desc *qdesc, *next;
 	int status;
=20
 	spin_lock_irqsave(&mchan->lock, flags);
+	list_for_each_entry_safe(qdesc, next, &mchan->queued, node) {
+		hidma_ll_queue_request(dmadev->lldev, qdesc->tre_ch);
+		list_move_tail(&qdesc->node, &mchan->active);
+	}
+
 	if (!mchan->running) {
 		struct hidma_desc *desc =3D list_first_entry(&mchan->active,
 							   struct hidma_desc,
@@ -313,17 +320,18 @@ static dma_cookie_t hidma_tx_submit(struct dma_async_=
tx_descriptor *txd)
 		pm_runtime_put_autosuspend(dmadev->ddev.dev);
 		return -ENODEV;
 	}
+	pm_runtime_mark_last_busy(dmadev->ddev.dev);
+	pm_runtime_put_autosuspend(dmadev->ddev.dev);
=20
 	mdesc =3D container_of(txd, struct hidma_desc, desc);
 	spin_lock_irqsave(&mchan->lock, irqflags);
=20
-	/* Move descriptor to active */
-	list_move_tail(&mdesc->node, &mchan->active);
+	/* Move descriptor to queued */
+	list_move_tail(&mdesc->node, &mchan->queued);
=20
 	/* Update cookie */
 	cookie =3D dma_cookie_assign(txd);
=20
-	hidma_ll_queue_request(dmadev->lldev, mdesc->tre_ch);
 	spin_unlock_irqrestore(&mchan->lock, irqflags);
=20
 	return cookie;
@@ -429,6 +437,7 @@ static int hidma_terminate_channel(struct dma_chan *cha=
n)
 	list_splice_init(&mchan->active, &list);
 	list_splice_init(&mchan->prepared, &list);
 	list_splice_init(&mchan->completed, &list);
+	list_splice_init(&mchan->queued, &list);
 	spin_unlock_irqrestore(&mchan->lock, irqflags);
=20
 	/* this suspends the existing transfer */
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index e52e20716303..03775ca940e2 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -103,6 +103,7 @@ struct hidma_chan {
 	struct dma_chan			chan;
 	struct list_head		free;
 	struct list_head		prepared;
+	struct list_head		queued;
 	struct list_head		active;
 	struct list_head		completed;
=20
--=20
2.15.1
