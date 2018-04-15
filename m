Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523803444-2-6390450810679713443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523803443; b=AOaU2Rc/uP21tDTr9g4EZ379Sfq/5mA0mLOoB2iNJCwPh/YKpp
    5X88RPa2HX7W9mAn+OWCjKa1qnh0Zg3Ir0D0tWGaBGLkUSTJpfJ9oRJ5ENKhtv5u
    jtapuBm9tbkwRRsc2G82QChNRbHboPZtVKFekfFzLN5L1a3bjLCDvWO5XA8iQFnx
    7AvkPwjiF9xbvgmbQa4opmf+5YKLhZxxOTzXioVLExOY7Xg35NPgmUPSAwgQzSBP
    bNJZftisIeDQu+H7JYT3hZr2fy+KfM02DhoQP6h4y5OVjoKlB4cLCKegwliElZ0K
    rPrHUkpGtPYQpw/u4Zvxk2pP122S2IcsrUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523803443; bh=U6jS7wgwtpr5WkZ+TCUXzrp1V5sTXxW5/b0RTvBMF9Q=; b=
    s+yBzyL7odo2eyfLp8aPoaiIny7a0tYY8FIloYskIUVntxLr7CgLmhedj1vvE+yl
    NxJZ1a7ig4iQbfw3GUSNSb7zJUZQ61ExPn9aMybTxiXJ6W4lBUD8Zo5w2urEyvbF
    MdDrUE8ZTA9v/iYR14qjT6XlejvAGgVxZWcQPax7qpQKWMje8Ce+CPztcBigzW10
    tufXL8nkX0JhTND1ZfpoQbrtWZD2T83m8Gx+IyYikQyju6Lj2KGjlep4be3DCOww
    D/WjV9Eb3G7mJ86t64A8D7p6zf2TVF2+osQI7eTOVV76A91xs1p3kALe/MVZnbTm
    Le+dbizMspyzouMMIj+PoQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TWm1yCRF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TWm1yCRF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3DCPvA2w12poc6GeTEi2sAeUMYYjVbhcmPC+LVJozk7i2kX8QsNZL4lv9Rjv8+JHtTeCNR4woi2c8lSJIRmz3ZTlfFiP+GBFYMzWVC4rPC9VUX0KN3
    T7LxKPd2FjIWRF2sN9xAlC0fQtypMtcFCpZls2lxqOzl+tYcOP78IDulFX0VdjMg3VMUnTEXxObTAmsZyQI5tMWCN9bJ02flcSQt0g2yKUzkwNoA8ikiX0Cd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=JF9118EUAAAA:8 a=dqWlGzSaAAAA:8
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=j-pzbIBsU81jl75a5CcA:9
    a=S19pQo5MFTncxcs_:21 a=qnehwoakZGziWJ2w:21 a=CjuIK1q_8ugA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=xVlTc564ipvMDusKsbsT:22 a=zQxbTC3D8LPejNAg5Fck:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeDOOoC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 10:44:02 -0400
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:5868
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752457AbeDOOoB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 10:44:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Max Gurtovoy <maxg@mellanox.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH AUTOSEL for 4.14 039/161] IB/cq: Don't force
 IB_POLL_DIRECT poll context for ib_process_cq_direct
Thread-Topic: [PATCH AUTOSEL for 4.14 039/161] IB/cq: Don't force
 IB_POLL_DIRECT poll context for ib_process_cq_direct
Thread-Index: AQHTz5iIg1M3hBrmkEqs12Sly5FN3aP4nm+AgAlSvYA=
Date: Sun, 15 Apr 2018 14:43:58 +0000
Message-ID: <20180415144357.GQ2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-39-alexander.levin@microsoft.com>
 <49117250-bfbf-53c2-8178-5359a08ef3de@mellanox.com>
In-Reply-To: <49117250-bfbf-53c2-8178-5359a08ef3de@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:VTPEVeL8ovcXt5TGuhFspdFKT7sLrLAKVJOrIam8lv4aZ48TmpVm+1eqvoUQ5pILc8ADcCokvRrtIjfmyTCq/7GPM4wK+sWElrjZwcZ2I1Kdw2bQvUGmbXwIhk6PY5J2ZbUk28flMclIpowB+OFD5T2i7RHRGxXNbItsnO/h5pAeauTMnOTPkOttCVOWronfD1aj5N0I8amALRvFUP6lotbE5QIBHqAKdNSo3hNtwF8EQeJCF2c8NrMeWVuJutRE;20:PzGaK3h4Ag7gBK26A7D64gsz57IhhGgty7/pLTDtllEEoHnXBi9YY6etYLuaIfueFD9xblV2ePlcnL9DsMsU3OYNLK76QxlD2Y8bHUirRFXSQM13CUZjtYSZU5nBAkIQ6ocsaK43XvKo2cdZ0GQpnOTBGa/r8ywju28QloiVBzs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983FAEE8002B4768E62254CFBB10@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501347)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(6506007)(5250100002)(7736002)(102836004)(229853002)(6916009)(9686003)(6512007)(99286004)(76176011)(305945005)(33896004)(2906002)(1076002)(86362001)(3660700001)(86612001)(59450400001)(53936002)(2900100001)(106356001)(3280700002)(105586002)(33656002)(6246003)(486006)(22452003)(10090500001)(14454004)(476003)(11346002)(72206003)(446003)(25786009)(26005)(6116002)(3846002)(66066001)(33716001)(6486002)(4326008)(68736007)(186003)(5660300001)(316002)(10290500003)(97736004)(8936002)(8676002)(81166006)(81156014)(6436002)(478600001)(54906003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +xMEz0SKV+DnyADb2ujaP0ZpcgslJs6k457Y/8emZn6+iC7M7hexofC4vIZN5EqrUToU6eDfNiKGFbS9BJZEO9BegvXnrjtyQoPuyEvD9EZXsYIqmdKYSOAs+5U+mFepkIqzLzggHZ/VNihkkc9zoGJ5iCx3Q9W8Rz1+qNJpw5nTAmrw0MqBWgNUPbBGmWRV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <398ADEA95B9CA448AD5D820A4577CF72@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: afbba9f6-ee81-46a4-7989-08d5a2df52aa
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbba9f6-ee81-46a4-7989-08d5a2df52aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:43:58.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Grabbed it for both 4.14 and 4.15, thanks Max!

On Mon, Apr 09, 2018 at 07:21:29PM +0300, Max Gurtovoy wrote:
>Hi Sasha,
>please consider taking a small fix for this one (also useful for 4.15):
>
>commit d3b9e8ad425cfd5b9116732e057f1b48e4d3bcb8
>Author: Max Gurtovoy <maxg@mellanox.com>
>Date:   Mon Mar 5 20:09:48 2018 +0200
>
>    RDMA/core: Reduce poll batch for direct cq polling
>
>    Fix warning limit for kernel stack consumption:
>
>    drivers/infiniband/core/cq.c: In function 'ib_process_cq_direct':
>    drivers/infiniband/core/cq.c:78:1: error: the frame size of 1032 bytes
>    is larger than 1024 bytes [-Werror=3Dframe-larger-than=3D]
>
>    Using smaller ib_wc array on the stack brings us comfortably below tha=
t
>    limit again.
>
>    Fixes: 246d8b184c10 ("IB/cq: Don't force IB_POLL_DIRECT poll=20
>context for ib_process_cq_direct")
>    Reported-by: Arnd Bergmann <arnd@arndb.de>
>    Reviewed-by: Sergey Gorenko <sergeygo@mellanox.com>
>    Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>    Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>    Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
>    Acked-by: Arnd Bergmann <arnd@arndb.de>
>    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>
>
>-Max.
>
>
>On 4/9/2018 3:20 AM, Sasha Levin wrote:
>>From: Sagi Grimberg <sagi@grimberg.me>
>>
>>[ Upstream commit 246d8b184c100e8eb6b4e8c88f232c2ed2a4e672 ]
>>
>>polling the completion queue directly does not interfere
>>with the existing polling logic, hence drop the requirement.
>>Be aware that running ib_process_cq_direct with non IB_POLL_DIRECT
>>CQ may trigger concurrent CQ processing.
>>
>>This can be used for polling mode ULPs.
>>
>>Cc: Bart Van Assche <bart.vanassche@wdc.com>
>>Reported-by: Steve Wise <swise@opengridcomputing.com>
>>Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>[maxg: added wcs array argument to __ib_process_cq]
>>Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>Signed-off-by: Doug Ledford <dledford@redhat.com>
>>Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>---
>>  drivers/infiniband/core/cq.c | 23 +++++++++++++----------
>>  1 file changed, 13 insertions(+), 10 deletions(-)
>>
>>diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>>index f2ae75fa3128..c8c5a5a7f433 100644
>>--- a/drivers/infiniband/core/cq.c
>>+++ b/drivers/infiniband/core/cq.c
>>@@ -25,9 +25,10 @@
>>  #define IB_POLL_FLAGS \
>>  	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
>>-static int __ib_process_cq(struct ib_cq *cq, int budget)
>>+static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *p=
oll_wc)
>>  {
>>  	int i, n, completed =3D 0;
>>+	struct ib_wc *wcs =3D poll_wc ? : cq->wc;
>>  	/*
>>  	 * budget might be (-1) if the caller does not
>>@@ -35,9 +36,9 @@ static int __ib_process_cq(struct ib_cq *cq, int budget=
)
>>  	 * minimum here.
>>  	 */
>>  	while ((n =3D ib_poll_cq(cq, min_t(u32, IB_POLL_BATCH,
>>-			budget - completed), cq->wc)) > 0) {
>>+			budget - completed), wcs)) > 0) {
>>  		for (i =3D 0; i < n; i++) {
>>-			struct ib_wc *wc =3D &cq->wc[i];
>>+			struct ib_wc *wc =3D &wcs[i];
>>  			if (wc->wr_cqe)
>>  				wc->wr_cqe->done(cq, wc);
>>@@ -60,18 +61,20 @@ static int __ib_process_cq(struct ib_cq *cq, int budg=
et)
>>   * @cq:		CQ to process
>>   * @budget:	number of CQEs to poll for
>>   *
>>- * This function is used to process all outstanding CQ entries on a
>>- * %IB_POLL_DIRECT CQ.  It does not offload CQ processing to a different
>>- * context and does not ask for completion interrupts from the HCA.
>>+ * This function is used to process all outstanding CQ entries.
>>+ * It does not offload CQ processing to a different context and does
>>+ * not ask for completion interrupts from the HCA.
>>+ * Using direct processing on CQ with non IB_POLL_DIRECT type may trigge=
r
>>+ * concurrent processing.
>>   *
>>   * Note: do not pass -1 as %budget unless it is guaranteed that the num=
ber
>>   * of completions that will be processed is small.
>>   */
>>  int ib_process_cq_direct(struct ib_cq *cq, int budget)
>>  {
>>-	WARN_ON_ONCE(cq->poll_ctx !=3D IB_POLL_DIRECT);
>>+	struct ib_wc wcs[IB_POLL_BATCH];
>>-	return __ib_process_cq(cq, budget);
>>+	return __ib_process_cq(cq, budget, wcs);
>>  }
>>  EXPORT_SYMBOL(ib_process_cq_direct);
>>@@ -85,7 +88,7 @@ static int ib_poll_handler(struct irq_poll *iop, int bu=
dget)
>>  	struct ib_cq *cq =3D container_of(iop, struct ib_cq, iop);
>>  	int completed;
>>-	completed =3D __ib_process_cq(cq, budget);
>>+	completed =3D __ib_process_cq(cq, budget, NULL);
>>  	if (completed < budget) {
>>  		irq_poll_complete(&cq->iop);
>>  		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
>>@@ -105,7 +108,7 @@ static void ib_cq_poll_work(struct work_struct *work)
>>  	struct ib_cq *cq =3D container_of(work, struct ib_cq, work);
>>  	int completed;
>>-	completed =3D __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE);
>>+	completed =3D __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
>>  	if (completed >=3D IB_POLL_BUDGET_WORKQUEUE ||
>>  	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
>>  		queue_work(ib_comp_wq, &cq->work);
>>=
