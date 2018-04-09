Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246604-2-3843680190485899680
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
    1523246603; b=DfU2fRVdFRVM3YjsCvlvLm5qK4UWTyuL+Deb1TBHTPATg0+Hy2
    wT8oI2S61kAsWWeGGZ3cew1ZATSt6aY3WmUpkZ5qJ6P75K0WtaPzKMayIEgpctJd
    NAzcIuV8NuizL/++U3oiO6pb7FCZhCPToti7AO3FgkGdvMwOC2ttfgbU68HXd01Y
    lSymzxhdln7I6AN0G8c2RDfv8rteM0d/UInDmvWRHAOuPS288XrvG4UnioTJ5r/f
    lpWSd1x7w85FzD6fi96lmpvhnWWobrCh7QjZscUPoQ5W0oVZ5Mj7VVaX6UIByiMq
    /5iWMvuFJLLKDlZNYThvc74FcWC+6QDqB1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246603; bh=PereLzsXEd
    Ujym93YLzmOTMTpS3AP4xqRZM6UXrmLzg=; b=EhJEoniL+cqXwq5arzKGwqDU3k
    zaWhIdzhvAJgXgxJEUtDLI/a8k2t2oLf9gfb6kpEyov8uVGQjbwxh5wTVaExNjMz
    slJAPtA/0+6Ed7qEkxfCJxNsVVd539leyKBwHr9CqgX4GdMgU+qH8vDuUiDAdZCg
    MXX7sit0bR/fAXYHtUNk1FIefj1cJehbxU/Uw5ulcKQdqOIXnC+hi6W5Huj8Jnbk
    inWg66DDE/Cp1HNyZE69yC/i+jEpCduAi/cxMvaBUdLDoNtdMaJqKBvdDaREDKeo
    9VDs/K5++G4O9JWnw9MSugrqkHwUHtVofKaWOHoyH+j7IMqyT1V8GPNvPAaA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q2dSo/YD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q2dSo/YD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPiB/VXr+BREWwYBgiYugPlxJQ6ryIGZRLijJhWQepmLIBpBEc8ik8dPibzIHVC60Yjnl9XbCecjSHGZyqoEfUMUzEFR+VzcBMd1Urxc98odeIacF481
    BNQw7o3R6L4q/6/j3Mr+MvHSkXSjIsvvu1vFUr2S02Sfv5RlK6SCJqrt2perGHWmD0u9MolnC0wrWb3XD0Cryq025p8t5pMJCaokb+kfg5DuT0KDBjLZC0qR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JF9118EUAAAA:8 a=dqWlGzSaAAAA:8 a=CbDCq_QkAAAA:8
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=EMdR6aQotsSsGIq5rdsA:9
    a=4s6Jqu4vFyd_y-XY:21 a=Odg4Y3_TQzeNocgm:21 a=wPNLvfGTeEIA:10
    a=xVlTc564ipvMDusKsbsT:22 a=zQxbTC3D8LPejNAg5Fck:22 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeDIAR6 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:58 -0400
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:5451
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753289AbeDIARz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 045/189] IB/cq: Don't force IB_POLL_DIRECT
 poll context for ib_process_cq_direct
Thread-Topic: [PATCH AUTOSEL for 4.15 045/189] IB/cq: Don't force
 IB_POLL_DIRECT poll context for ib_process_cq_direct
Thread-Index: AQHTz5ggeRLup7dywkGCbGMSiDnHhw==
Date: Mon, 9 Apr 2018 00:17:21 +0000
Message-ID: <20180409001637.162453-45-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:rUai3MeZsVwebQi5HSLaWMXbjitEpnbV2ZtAZ2bqwRE3XHPy5PHScm0skhAnn5Mwvy/rEzqKL4Jbr7z6q4kDtQV0mEoE+0VVFWKQ59j3k3doq4fpGdTCXt6PR+GlHJizZ78fDH3RsOA/E4hoKQtK+Q0k2yprf7g3T3ApYuLoBI7sCRoCyDHf28vHccGafu38h83fvlBA7lIRRqJLDy3ls/wpLO1h/X5cb407fa72MH3ZF/4v5lriC+4gy5RR38HL;20:e1P9pYZGmRz+4Fs5IDDh8FWUwSW4gI9W533wxSqCoyXRMkCqKu4VFgTJCCM1eC/7fm2+0MjduGFkOn+B2YnEILDCRhi6a+icNN5bHCLyLwz/qYqIExCEFThkutJwNLJmhohZFLoYv3nBezGkeyw3FomsXPTh2zDJGlKvgzWD3YI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26b48037-43a0-41df-d384-08d59daf5341
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10480BCFE5AD8A1EB3FF8CECFBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ELRwVXzljYTvfIDUe8z3v2tZs4Ms0IdrwwhrXP2lWzWMRxX0NYk3+AI/iqrzCRljaXqHlmmOvFAGZ3dXiJn/AHY+s66wFyJf0R4nK6MSwFX/9aYXaEUOnp52BdLFAS7Jc06ovQm9Xx8MtjnRxdgeBJIqpf9y8j7Q9KwJoGpcX7NpcxgoahLw9Qs/MQoduHaWcYLJPkvoqeBUJ4TpxSch28FuAsyA8Pia0FDT4cnmpbS02klns8A+2cRme1O08pT7j8Ae4aKIpkOjr49WOphtRB+LYBR7o9jxCyefJ4iypCnK1rkuxrok7TplRQXn9VXbEcIHQ0N1wmLxZd60HzzSUQMqmQZXq4rV8lcLhisT01WUTQaN9sg8jrMltwFl329oUPtPSA7nq0HLvYLnUgSF77KxxyNXaE/hSc2IKQeC/+o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b48037-43a0-41df-d384-08d59daf5341
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:21.4478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
