Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233356-2-13740604134652052796
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233356; b=txfx8e3V6MdR8SNkd4koEFtDkd4DcgNfHY4KhEk5I0vfKHDD2R
    v2IfgVnLs4Nrg4GoNDE3VWPaCUrJK0D8l8EndvzOnR41XttIGpZ2USyeJ7kHVH2Q
    5tJf/PgTE6f8+YGwFjgyfK8BM5KEdx+dHxLJuaoK/KXwCrdeDkUCbVlaNYrsyMHZ
    wbev8OoTrhHQnrqx8VXYwahRp9Bsx9pToUmiRcw9CkPDEMIHgLoN2ids9L4/vlAL
    V7ukBRdnfZPlY+yMGwD0cc+8IM8s9y6eheMv3pnV8IWRg2iynLpcBbLRSyU5cxaf
    Tf+AELTGTi/3Q689QuEg9ayWyC8X8QryAiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233356; bh=DBgz58YiBp
    m94d6sjbuup15R1ZuMvhomyz8bdvpP+wo=; b=LXvPCSgbucCIR/Ne1D4dyah3Xl
    Kw4Zv1Ru1jqHHMotpBn9EOidfqXer/toIPu89GER0XP9sSuUFo/BIYL39Heov7NO
    CHKLWDH+5rCKNUcOdBHYBAgAFrD6c+olBTt7u19I2TDpitBJWaAz7WSGbEf1BJ6u
    lg6hRc02wJtofFxh1KhxSkn6CHdJBJC2VJM31omlRKFIRJ0GuBdEP8zd8WXGfAog
    NB5ccbGWItvyPKsTQ4D8JlUTml7HyHsbFzaDRB+EFl1wPOF8qDJeUFwFiJ+gtYUk
    +WYLrySFXaPNQmsX46DRLWgZmNY6321Zo4pzUc95wBrO/AIG5+IuBrQZ+31A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lTRJ6wg4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lTRJ6wg4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/XYlt4hhjKLDsBZzndMCiGUM19f7Hl+eZuW7z61kMuC0picbNj47374k32ysiAJqoWv4+bOLIOzVLxkXVYUQBv+ijrTiARIdkwx1tyf0dtaMN+F3Dt
    T8mUYTxiTyzmVi6BPqeG7R9bZ9nK74YPzXNczJq5WycvqaajVJni4LVsx40DJORRODWFm50hIHQuw9zq8/hfKnwl/SHE/nUQe/Q+LQUGXhpKxvv3xUZPRYMm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=pKcfld-E6XSi18XhnWYA:9 a=LnBsnZiJdQwN98_3:21 a=Rk2bQJb-A4SKcpwh:21
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbeDIAWM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:12 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:31261
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754656AbeDIAWL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 021/161] i40iw: Free IEQ resources
Thread-Topic: [PATCH AUTOSEL for 4.14 021/161] i40iw: Free IEQ resources
Thread-Index: AQHTz5h+HvcEtPQ3pkqPkluDE3p5zQ==
Date: Mon, 9 Apr 2018 00:19:58 +0000
Message-ID: <20180409001936.162706-21-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:TitWfRybo3tqfFZ/EEYkx3p+f2MHH0dCyqGAb9S1Dslzsy9vXBMt72kpOBL61IKrewKPCHkCM9PwPgj/Nm0p5WrtJL19D1ETMGDHmoznfxBKf7T2+QqrfQEdzMEdMJdozWQTLf7FBN8+FdpDTV0Gaqq7lAevm+VaDSUsHFJh6q35edB1PyxEItDBQcblZzE7OWYGwsIKiQ6eJgCHwEg3rekWS68Kxq6HljaU+qfC5rgFNUtwZQE5KLQkBIwd9EM5;20:5pKOVmScr1s/l04agDkor3krHoT2GiEk+BvW6+v+uRYQWWGJZukuoLxTa6uwmYOkSBr514xD/Z7jGyMq4imFva3fEjkNGMKn1DKfz8gFdmPgXv/v3ktgEZQ386d4yAOvMUajnHIhh6KrotesO7kbyidzoSGGedQcOORoOHokrB8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99c18996-5bcf-49a3-6559-08d59dafedf2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966EF59AD8E3862E8210926FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: G9MXybc/vP1kTsAM1doChu5HJQwpf3+7Y5VZ5q4Rsf1LrQq4fVEw71TjbK6hPMm1go+cY5DpAh8thhlQ1ZDRdLG4sPcZTwS8yeuXwZ7a/A7+JOuq0E0aBeodd4+m6VgG9/fEx0EL0BVuIBbFJdxN/kY0zZyUcglu31nPyZ3oC12ox7ulPZUsxPhSmMqY1ylWMxZnxz1jPUXC7SL4zOZp8Y7HW7ZTQnnv0PKAjGsjePJUyr786DkkLrn8DTcHqLAm9zeXyjNvplhnfDnDklPi2Dk4ZVJxmLuEf0z2Kdoh48bbQpoXacAu9A5LPgvyUpwu5sjVSyRyOti05rB+gjwOqae6qioRtRRyPxoop9uq2wP7IPBw++uXzIsrySSabY0LGYL9+R3OG4o20uiBm1w10xTHK4BFxS2yathLCE/YHyo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c18996-5bcf-49a3-6559-08d59dafedf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:58.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index 59f70676f0e0..74c7f6879084 100644
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
@@ -1480,7 +1479,7 @@ static void i40iw_ieq_tx_compl(struct i40iw_sc_vsi *v=
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
index dba05ce7d392..ebe37f157d90 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.h
@@ -186,4 +186,5 @@ enum i40iw_status_code i40iw_cqp_qp_create_cmd(struct i=
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
index 62be0a41ad0b..9e7ae7161d2f 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -428,6 +428,7 @@ void i40iw_free_qp_resources(struct i40iw_device *iwdev=
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
