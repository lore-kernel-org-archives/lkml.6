Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244213-2-6338639726431971397
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
    1523244212; b=IGdheyVcxiOZmcXq8JpTOLhD0mIeBEm9cqTgkeKeCmsiiCgyP8
    +DZifnvZDOHluHj4mKPlKPWnzvcPNFKWIGHe0lZf3B7Cmd6d/7NNrkiAelOr8Rs6
    DTLJ2+W5KK2bs/7/9nXvQWmN99yU+BU6SWLi/hQQuPexGYw4slk50iWgf2b64FxL
    Szbqfm+LW/ivcEDjyeoaXZ/khFsqJjEOGSiYN3JmqO7xyhLjURkhdS+hmG+NduPU
    VbZUEb68rUj7OVhKrnE8ft/6oBa7mdTUHNP/FdPPDfye7P6o9611yeZcs5arFV38
    fwexWKLBYfLoa+cWHUrq0cLGSCPUvUOL7K9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244212; bh=PereLzsXEd
    Ujym93YLzmOTMTpS3AP4xqRZM6UXrmLzg=; b=F7vRjTsrohRlxYLsubjKJQejct
    DixnQLsphNxkV+KQK2hO8hJsxWiS7htmhjQTWHWcAluBtD6xie91G+NPblxAOxJP
    BhvH2gEOSQzQNvMiqU///40X0YNmMCurJEH+fXu0sg72jFAndkmuTDXFfNzJKbOD
    TLP3TuVurC1T/SSRsTXLVECJ3Ru2gILLdzNL1LMzQeA2BlYJCWrxZ/o4sJqVC/sF
    SYFlLivz4pIsQbl+TlG6C7WAHoIJ+pXBMnM0ozpAsD3GOQIJ85YVXbxofavKaMnm
    sqm5rk+IY/2AsL9yOuh4yIU67fY0Z/swMRARnFEUnuHKgucCHYzD6Ij1RIiA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eiC5cK1B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eiC5cK1B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP8+X9Fu0Ne/vuYrO8S8PY2Qr5oa8WSEDrMWzcBLs3ZeLSIIIEA480QVPyOeTxDcWtn/1lFhm7yRFjnWEL0ANA7vpuOmXd7qVld6ZLeJn+Xtr42GqHVQ
    kgPuuis0MY+xwOjW9rpazub06QQiCaDmhWrP29m7BDeMvLz2NVz/8S9MJRHW0Ubp67t2LbrFF7B5ttlPUD9Hd2PtoU9pIMnP3Nfzof9sgRFGqDj01Nqf64BQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JF9118EUAAAA:8 a=dqWlGzSaAAAA:8 a=CbDCq_QkAAAA:8
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=EMdR6aQotsSsGIq5rdsA:9
    a=4s6Jqu4vFyd_y-XY:21 a=Odg4Y3_TQzeNocgm:21 a=wPNLvfGTeEIA:10
    a=xVlTc564ipvMDusKsbsT:22 a=zQxbTC3D8LPejNAg5Fck:22 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeDIDX2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:23:28 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754737AbeDIAWw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 039/161] IB/cq: Don't force IB_POLL_DIRECT
 poll context for ib_process_cq_direct
Thread-Topic: [PATCH AUTOSEL for 4.14 039/161] IB/cq: Don't force
 IB_POLL_DIRECT poll context for ib_process_cq_direct
Thread-Index: AQHTz5iIg1M3hBrmkEqs12Sly5FN3Q==
Date: Mon, 9 Apr 2018 00:20:16 +0000
Message-ID: <20180409001936.162706-39-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:A3hRpzmN5Cg3OgcvWgSD12QosXCK28q7pQVmKX5VB394yLMUhCqtDo1ST/e8kfEObUHYLarOffonFXJPl2GTfmi1EtVbkPwrQgvnV8Iw+qv87UaGeRJQRQ7j0Xxcha5VC9Flj0oeUw3qD3sPKX49v1vI728WJqJqVki9Kbz/UZq4EOM5TbN01Ik/OJQPqQ3/wbJR6mnGlO5x49vOLvIuuAkmppvMa09CYQ8YJHjX0HibIy55EHf+NLf9GVeJUtgm;20:cW7y0R2z2cancWGb2V4AVWm+eFDIwAhD7Hd3jMsQ95vtk3kbB/PtzASqvEo0tAIagMVdhqvN53cTF8y6B3r3xxeqcNlSActTrMX7QJods+AyWP58BdgsLpqtS4zUGOMCCYZatZWekoLVmEDPKNhKuRCHRUCXR/Z0gSnmBbrYOQE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a65f995d-31ef-43ab-cc80-08d59db0068f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10146E2FFD9EEE5BC7B6A42EFBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: q+t3/K6FrbM47f5iT+iFGpGACVC+hFUTVIrSSiTQ9XFvZmGBp4e33ZTMxhR34muveHdBBJCiuy18X/t+6Hee0ii93lYf7hfAyJ+b9pODPesGPPGtcXKRclYgIA/SZ+kiLEwap4kjFsFK2LioTusKiX0wg2SNvepgN9DoC1kxrsGm6Hu6bFLKhJ0+tTlpoMcS1nMT9Deb1S+5uGPY3N5nq66HOLR2YwJysB+Y3wxHeJZ2APA4InvRZnVHqhqVg49P1uBZG8Wgee0KfzT7nURrC1cpEi6fGpKqSPILG/InUlG3CdIZlYd+z6Xei1vKJwuBX+qyKCaScXCSPe8iDg1Coq8O1Is0J5cz9tNN9xOp4yjM/yuE2D94aai1x5Fe/lmiWf/c8Hs8k8W/xgR1dZ8x9ctge0zVREhEfOK5RwhUTM8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65f995d-31ef-43ab-cc80-08d59db0068f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:16.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 246d8b184c100e8eb6b4e8c88f232c2ed2a4e672 ]

polling the completion queue directly does not interfere
with the existing polling logic, hence drop the requirement.
Be aware that running ib_process_cq_direct with non IB_POLL_DIRECT
CQ may trigger concurrent CQ processing.

This can be used for polling mode ULPs.

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Reported-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
[maxg: added wcs array argument to __ib_process_cq]
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cq.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index f2ae75fa3128..c8c5a5a7f433 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -25,9 +25,10 @@
 #define IB_POLL_FLAGS \
 	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
=20
-static int __ib_process_cq(struct ib_cq *cq, int budget)
+static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *pol=
l_wc)
 {
 	int i, n, completed =3D 0;
+	struct ib_wc *wcs =3D poll_wc ? : cq->wc;
=20
 	/*
 	 * budget might be (-1) if the caller does not
@@ -35,9 +36,9 @@ static int __ib_process_cq(struct ib_cq *cq, int budget)
 	 * minimum here.
 	 */
 	while ((n =3D ib_poll_cq(cq, min_t(u32, IB_POLL_BATCH,
-			budget - completed), cq->wc)) > 0) {
+			budget - completed), wcs)) > 0) {
 		for (i =3D 0; i < n; i++) {
-			struct ib_wc *wc =3D &cq->wc[i];
+			struct ib_wc *wc =3D &wcs[i];
=20
 			if (wc->wr_cqe)
 				wc->wr_cqe->done(cq, wc);
@@ -60,18 +61,20 @@ static int __ib_process_cq(struct ib_cq *cq, int budget=
)
  * @cq:		CQ to process
  * @budget:	number of CQEs to poll for
  *
- * This function is used to process all outstanding CQ entries on a
- * %IB_POLL_DIRECT CQ.  It does not offload CQ processing to a different
- * context and does not ask for completion interrupts from the HCA.
+ * This function is used to process all outstanding CQ entries.
+ * It does not offload CQ processing to a different context and does
+ * not ask for completion interrupts from the HCA.
+ * Using direct processing on CQ with non IB_POLL_DIRECT type may trigger
+ * concurrent processing.
  *
  * Note: do not pass -1 as %budget unless it is guaranteed that the number
  * of completions that will be processed is small.
  */
 int ib_process_cq_direct(struct ib_cq *cq, int budget)
 {
-	WARN_ON_ONCE(cq->poll_ctx !=3D IB_POLL_DIRECT);
+	struct ib_wc wcs[IB_POLL_BATCH];
=20
-	return __ib_process_cq(cq, budget);
+	return __ib_process_cq(cq, budget, wcs);
 }
 EXPORT_SYMBOL(ib_process_cq_direct);
=20
@@ -85,7 +88,7 @@ static int ib_poll_handler(struct irq_poll *iop, int budg=
et)
 	struct ib_cq *cq =3D container_of(iop, struct ib_cq, iop);
 	int completed;
=20
-	completed =3D __ib_process_cq(cq, budget);
+	completed =3D __ib_process_cq(cq, budget, NULL);
 	if (completed < budget) {
 		irq_poll_complete(&cq->iop);
 		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
@@ -105,7 +108,7 @@ static void ib_cq_poll_work(struct work_struct *work)
 	struct ib_cq *cq =3D container_of(work, struct ib_cq, work);
 	int completed;
=20
-	completed =3D __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE);
+	completed =3D __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
 	if (completed >=3D IB_POLL_BUDGET_WORKQUEUE ||
 	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
 		queue_work(ib_comp_wq, &cq->work);
--=20
2.15.1
