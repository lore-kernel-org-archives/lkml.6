Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbeDCHmd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:42:33 -0400
Received: from mail-co1nam03on0054.outbound.protection.outlook.com ([104.47.40.54]:30064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754222AbeDCHma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:42:30 -0400
From: "Kalderon, Michal" <Michal.Kalderon@cavium.com>
To: Sinan Kaya <okaya@codeaurora.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>
Subject: RE: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
Thread-Topic: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
Thread-Index: AQHTwfqdtrypC3mzl0CHfKiVN7XDyaPuY1aAgABUiCA=
Date: Tue, 3 Apr 2018 07:42:28 +0000
Message-ID: <CY1PR0701MB201215C9F38E8760732B595088A50@CY1PR0701MB2012.namprd07.prod.outlook.com>
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
 <1521736009-23387-4-git-send-email-okaya@codeaurora.org>
 <ac46b4e4-7e6c-c15f-06eb-01b1e4893d50@codeaurora.org>
In-Reply-To: <ac46b4e4-7e6c-c15f-06eb-01b1e4893d50@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Kalderon@cavium.com;
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB1630;7:M01jdL6WsNIFvmuoyQXNjwc9L06H39bVDICK7TNYXuFpb8a0qlgN6z+kHWE2oBBFS2THCWqpDUuWkg9BODbwShsYrzOlVcseBWwV0Mu+QuHQfmWepHIBXrMdyCEvkouQVejboS0t6534kNN++8V2bv09tvmNmqIDb2txneAZDo+ytHjCUsnIAUdiHEhSik0tqQpOIWrybShdMEN0BZDB0lxZgitvTw1T9YmD8J+bsRzGtTRv8tGEIbxAantQ/2RA
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(8676002)(81166006)(81156014)(5660300001)(476003)(72206003)(9686003)(53936002)(105586002)(8936002)(478600001)(6246003)(14454004)(107886003)(229853002)(55016002)(6436002)(66066001)(2900100001)(5250100002)(486005)(2201001)(486005)(86362001)(2501003)(97736004)(106356001)(3846002)(6116002)(68736007)(99286004)(7696005)(33656002)(2906002)(26005)(54906003)(110136005)(74316002)(102836004)(316002)(53546011)(6506007)(59450400001)(11346002)(446003)(76176011)(3280700002)(25786009)(4326008)(3660700001)(305945005)(186003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1630;H:CY1PR0701MB2012.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ddd4c7ab-fd31-4a01-beda-08d59936732c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB1630;
x-ms-traffictypediagnostic: CY1PR0701MB1630:
x-microsoft-antispam-prvs: <CY1PR0701MB16306C356E0CCED1FEFF2B8488A50@CY1PR0701MB1630.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR0701MB1630;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1630;
x-forefront-prvs: 0631F0BC3D
x-microsoft-antispam-message-info: jUPmQd0RyyF1bzsF0DTDQ0HE8gsgAZ0v4dmmpGNTGsnazd8XmyVkCwSxda23P9QjUZIk0+BkgxAJK9v52HPcTiKXecz89V9Zmhr5rAutjq7rgYtfPeRFmzowlGTFnDJnj1AANxowfTeEfpES8H3C6Dj1te9m2Z9uj3DRXKmnESMqHSRRf6xW31qX4B3IC05ssJvR9mB+o0GChYSpK1gccETXO9kTBKBanK1yPmhX7Msbxk3W38XxuE+G7uwfyBTezx4JRnzOd0lxrlk9G6fw7ZLtIgPPDeP7pRWeAVofX6mA/50bf3MuR03gGu+CVeqV+ed5tPR8a6WOo1YRSVfopG8t3BFwWt3X8z4UtJdey/7+/wDqicn+9num/NXGffUzvFLetsQvUtMUgeK4Qkx9lKJlu7VCTAIM1eV7UJ+R11A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd4c7ab-fd31-4a01-beda-08d59936732c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 07:42:28.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1630
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w337gc0i007927

> From: Sinan Kaya [mailto:okaya@codeaurora.org]
> Sent: Tuesday, April 03, 2018 5:30 AM
> To: linux-rdma@vger.kernel.org; timur@codeaurora.org;
> sulrich@codeaurora.org
> Cc: linux-arm-msm@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Kalderon, Michal <Michal.Kalderon@cavium.com>; Elior, Ariel
> <Ariel.Elior@cavium.com>; Doug Ledford <dledford@redhat.com>; Jason
> Gunthorpe <jgg@ziepe.ca>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
> weakly-ordered archs #2
> 
> On 3/22/2018 12:26 PM, Sinan Kaya wrote:
> > @@ -860,7 +860,7 @@ static void doorbell_cq(struct qedr_cq *cq, u32
> cons, u8 flags)
> >  	wmb();
> >  	cq->db.data.agg_flags = flags;
> >  	cq->db.data.value = cpu_to_le32(cons);
> > -	writeq(cq->db.raw, cq->db_addr);
> > +	writeq_relaxed(cq->db.raw, cq->db_addr);
> 
> Given the direction to get rid of wmb() in front of writeX() functions, I have
> been reviewing this code. Under normal circumstances, I can get rid of all
> wmb() as follows.
> 
> However, I started having my doubts now. Are these wmb() used as a SMP
> barrier too?
> I can't find any smp_Xmb() in drivers/infiniband/hw/qedr directory.

Your doubts are in place. You initial patch series modified writel to writel_relaxed
Simply removing the wmb is dangerous. The wmb before writel are used to make sure the
HW observes the changes in memory before we trigger the doorbell. Smp barriers here
wouldn't suffice, as on a single processor. we still need to make sure memory is updated
and not remained in cache when HW accesses it.
Reviewing the qedr barriers, I can find places where this may have not been necessary, 
But definitely you can't simply remove this wmb barriers. 

> 
> static void doorbell_cq(struct qedr_cq *cq, u32 cons, u8 flags)  {
> -       /* Flush data before signalling doorbell */
> -       wmb();
>         cq->db.data.agg_flags = flags;
>         cq->db.data.value = cpu_to_le32(cons);
>         writeq(cq->db.raw, cq->db_addr); @@ -1870,8 +1868,7 @@ static int
> qedr_update_qp_state(struct qedr_dev *dev,
>                          */
> 
>                         if (rdma_protocol_roce(&dev->ibdev, 1)) {
> -                               wmb();
> -                               writel_relaxed(qp->rq.db_data.raw, qp->rq.db);
> +                               writel(qp->rq.db_data.raw, qp->rq.db);
>                                 /* Make sure write takes effect */
>                                 mmiowb();
>                         }
> @@ -3275,8 +3272,7 @@ int qedr_post_send(struct ib_qp *ibqp, struct
> ib_send_wr *wr,
>          * unchanged). For performance reasons we avoid checking for this
>          * redundant doorbell.
>          */
> -       wmb();
> -       writel_relaxed(qp->sq.db_data.raw, qp->sq.db);
> +       writel(qp->sq.db_data.raw, qp->sq.db);
> 
>         /* Make sure write sticks */
>         mmiowb();
> @@ -3362,9 +3358,6 @@ int qedr_post_recv(struct ib_qp *ibqp, struct
> ib_recv_wr *wr,
> 
>                 qedr_inc_sw_prod(&qp->rq);
> 
> -               /* Flush all the writes before signalling doorbell */
> -               wmb();
> 
> 
> 
> 
> 
> --
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
> Foundation Collaborative Project.
