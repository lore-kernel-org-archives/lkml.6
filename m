Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523246916-2-13812182047909761380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246916; b=Yjyg3GMSjYNFr/ZTtfQFtsgDZ7n+aVZB9XgqSMpF910pfcTWgn
    429fPmdPzYmm1ZITGWzhW+/bnVGdzYQm94D2dfsO9BSoSsudzZ9LOo47p8OQshFn
    7CmVVk2BGtfOmNeXlcl+PuvXjpWdYsxJc5Nbk6e7Lv6r+GckyUoMRoLfEaq6xFsE
    arqBs5U9W7h0M1IQayFEdJETR5KcU9GK9IKuh5AycLxsGDu/dyiulR0T6ScDWCN8
    27+O7gKkCcOBeOmc0ZorRWCdmgf/xbALiw6qkCBsEwZ0K3zjkH/eKgIax3k/ajTL
    Swjb/jAviHTzDqlp1zim5od6Z67T3uCE4cUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246916; bh=QFwYlAcCvN
    ZhOII3JuyjJfA3QHkXzKAqjc8vy+hxbAo=; b=Ix82SXWeC182Rn0ssSZFfpId3W
    29jDYpQIquauont8Eh3e/svlkJ8oEAa/APR/zijgIm9/QahMFlHx4uH6uauuRaVk
    k32c41v0xjGwTHFH3AbqV1cZpqYwMKBqWNc21olh+gqln3H8ZvIKIykOjyIyXKDP
    nP555I1AF4SRCZyFxoeP1JaxayklGhN4d8LFOetdIBIILNnRYYWvftzy11Hu9XgZ
    66HAUfTSQFuz4AvkIcGJfeo7Ip7+Gqu4F3gz+yJ6v7QFxrMARaxhnPyPKe+TaIvI
    622P5u2T6YbzApHfK0hCPna+3yzLZYzBDQbg0Ai/Jyg11YPmHJ+yLZEMxRsQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ksNwsQz+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ksNwsQz+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI+83UKwJo+rD9f2NURYSDSFX82/btlHHxy4x+tojq2abpElbnIVmdjopjfcAwDTQax7O9SeeACEcWEP+sAa4UoxlOKD/na4H7UjX6CKKU9qq5uBzJ6k
    I3GvU51FqcbbnrDJ/r2w3QbsOOoKcyz/YSoauYI0ve4JxRiqTQDQvSV2QiH2NVChvoX4bhF/zUJKUHF29VNaLVVTA9FsbcfwZDI1BX9UcJDX3BEePhEv6WFI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=pKcfld-E6XSi18XhnWYA:9 a=LnBsnZiJdQwN98_3:21 a=Rk2bQJb-A4SKcpwh:21
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeDIEIb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:08:31 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753069AbeDIARJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 025/189] i40iw: Free IEQ resources
Thread-Topic: [PATCH AUTOSEL for 4.15 025/189] i40iw: Free IEQ resources
Thread-Index: AQHTz5gXFOdVg0mN1EahX79uW71gRA==
Date: Mon, 9 Apr 2018 00:17:05 +0000
Message-ID: <20180409001637.162453-25-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:79vm8vSqyVrQE1+4nQR6uJmJX9zqfQxx2VBc8DeDwDwCtJ4MLfolSi90Bb6XH3YxC7ttiBuD3W46PnkOi6qhs8Hw+PIpI//2tE2DEwQImSVvGX7BdT2vw3LlG3e6UlDjV3aISnSP5HekoiW/xnGJJmMvbkLqWR3leIrsXbd9IcJe1goOZCb9gXLI2qitky4Lid8BA/Aaipbo0OiIMJZXA1MNBCoWmRAyPQ7/nuA1bTFv95otdigafvU/v3lUs6cH;20:f/W66ahxb3Aoy5NC0qKllUZCrdQU37PAQRUlePLELRHumE3ypbM28V2cORsZkeq4ICaBMCbmkJucfeFKsexOAwYHIInjBya1846wvM9z0z5N++TD10PlRDTYYMJnLiZ15BKXj+OyCv+UU0ufKjcctjwGJ5wvlvfjbNKanWo3HKA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66f0e546-d328-4e5a-1b1a-08d59daf39cc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11273AFABEE762B12828EF17FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2sIfDdEPiO/ziWMzQC8xOuu4XZQz63VO6/CZs+6vZEl2fVTCVOh5LKY+z1L+1DhL8ClgTUAxOTt2d4iny9Y9fznIrxeaYCxsWupjifnAPv/M/yGh8O6KllbtuJRImO7TcyVK1dRt6Ckq8riL3H+vdiu7wYQKQGSeWWzjg6F4ffyMndVPnwa7r91c4XOxPe/wx5GHAmO46QWum8Zz96sKFfueu71pH8kYRbZrQSINa1ACNg320ZTR0pHbPWLCTCq7CqyTt2Cv2dNxVzj9tNzp4kF4GVWEAPZlYckSkJB1kaXPp2ku/e5CE5dGEasN9NDwLMm9Dt7f+bUokD6zJWBqWvn5xoYG5q7Uw3giEy14lR4ueQbCh09hQzIxSfCHcMNk7OFu/Q5iqOQVyPX8kH9cyijI1SVpDnXvLqD62saaeyc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f0e546-d328-4e5a-1b1a-08d59daf39cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:05.6214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mustafa Ismail <mustafa.ismail@intel.com>

[ Upstream commit f20d429511affab6a2a9129f46042f43e6ffe396 ]

The iWARP Exception Queue (IEQ) resources are not freed when a QP is
destroyed. Fix this by freeing IEQ resources when freeing QP resources.

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_puda.c  | 3 +--
 drivers/infiniband/hw/i40iw/i40iw_puda.h  | 1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.c b/drivers/infiniband/=
hw/i40iw/i40iw_puda.c
index 796a815b53fd..266c5952ba92 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -48,7 +48,6 @@ static void i40iw_ieq_tx_compl(struct i40iw_sc_vsi *vsi, =
void *sqwrid);
 static void i40iw_ilq_putback_rcvbuf(struct i40iw_sc_qp *qp, u32 wqe_idx);
 static enum i40iw_status_code i40iw_puda_replenish_rq(struct i40iw_puda_rs=
rc
 						      *rsrc, bool initial);
-static void i40iw_ieq_cleanup_qp(struct i40iw_puda_rsrc *ieq, struct i40iw=
_sc_qp *qp);
 /**
  * i40iw_puda_get_listbuf - get buffer from puda list
  * @list: list to use for buffers (ILQ or IEQ)
@@ -1483,7 +1482,7 @@ static void i40iw_ieq_tx_compl(struct i40iw_sc_vsi *v=
si, void *sqwrid)
  * @ieq: ieq resource
  * @qp: all pending fpdu buffers
  */
-static void i40iw_ieq_cleanup_qp(struct i40iw_puda_rsrc *ieq, struct i40iw=
_sc_qp *qp)
+void i40iw_ieq_cleanup_qp(struct i40iw_puda_rsrc *ieq, struct i40iw_sc_qp =
*qp)
 {
 	struct i40iw_puda_buf *buf;
 	struct i40iw_pfpdu *pfpdu =3D &qp->pfpdu;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.h b/drivers/infiniband/=
hw/i40iw/i40iw_puda.h
index 660aa3edae56..53a7d58c84b5 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.h
@@ -184,4 +184,5 @@ enum i40iw_status_code i40iw_cqp_qp_create_cmd(struct i=
40iw_sc_dev *dev, struct
 enum i40iw_status_code i40iw_cqp_cq_create_cmd(struct i40iw_sc_dev *dev, s=
truct i40iw_sc_cq *cq);
 void i40iw_cqp_qp_destroy_cmd(struct i40iw_sc_dev *dev, struct i40iw_sc_qp=
 *qp);
 void i40iw_cqp_cq_destroy_cmd(struct i40iw_sc_dev *dev, struct i40iw_sc_cq=
 *cq);
+void i40iw_ieq_cleanup_qp(struct i40iw_puda_rsrc *ieq, struct i40iw_sc_qp =
*qp);
 #endif
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index 3c6f3ce88f89..6aa613835405 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -412,6 +412,7 @@ void i40iw_free_qp_resources(struct i40iw_device *iwdev=
,
 {
 	struct i40iw_pbl *iwpbl =3D &iwqp->iwpbl;
=20
+	i40iw_ieq_cleanup_qp(iwdev->vsi.ieq, &iwqp->sc_qp);
 	i40iw_dealloc_push_page(iwdev, &iwqp->sc_qp);
 	if (qp_num)
 		i40iw_free_resource(iwdev, iwdev->allocated_qps, qp_num);
--=20
2.15.1
