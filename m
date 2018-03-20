Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeCTHi5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:38:57 -0400
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:59709
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751105AbeCTHiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:38:52 -0400
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 6/6] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
Thread-Topic: [PATCH v4 6/6] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
Thread-Index: AQHTv/XgDF5N2M61Z0a+5WLZn1a4n6PYvOhw
Date: Tue, 20 Mar 2018 07:38:48 +0000
Message-ID: <CY1PR0701MB20128974717898F2D399431688AB0@CY1PR0701MB2012.namprd07.prod.outlook.com>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-7-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1521514068-8856-7-git-send-email-okaya@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Kalderon@cavium.com;
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB1209;7:DXUf+D8QGzFqf0gKvc4oNH+TdM3lkpVnHUOX0nCxWwB1ujtgY1yk/jV28yLJ6+hZG5oVntcuDHZPEJnjWkGi2JcEIVCo8zcEjk48lsr+LGm2eCdvvCYHYsKPCdpYUsP7JudWFyvQvAOHq/+wAiiAnSnP+UleVw2whb9cGmowjFsJGmZnBJG/G+WVwdm6ixIOJOPVSrz61/US9OuB15CLiHB7jQawKcHrqfioYZIip9EnP/B7KjiE9jEKkXnWi10+
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39380400002)(396003)(39860400002)(189003)(199004)(2900100001)(7736002)(4326008)(106356001)(26005)(6436002)(316002)(77096007)(6116002)(53936002)(3846002)(2201001)(186003)(2906002)(68736007)(3280700002)(55016002)(9686003)(5660300001)(86362001)(2950100002)(66066001)(97736004)(105586002)(99286004)(72206003)(6506007)(7696005)(14454004)(33656002)(102836004)(54906003)(110136005)(229853002)(8676002)(81156014)(74316002)(6246003)(305945005)(25786009)(81166006)(3660700001)(8936002)(76176011)(2501003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1209;H:CY1PR0701MB2012.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-correlation-id: 60d49b38-eb41-4df7-d777-08d58e359e77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB1209;
x-ms-traffictypediagnostic: CY1PR0701MB1209:
x-microsoft-antispam-prvs: <CY1PR0701MB12093E54ACA250EFC3C17ECA88AB0@CY1PR0701MB1209.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR0701MB1209;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1209;
x-forefront-prvs: 061725F016
x-microsoft-antispam-message-info: BtVFo+HVoA7bIeCdqfKxQpCydH5T7rRJPWdjSD8Z1rRGo086yyQ8NG8sfceU5tmUYrFem2nnEzVroD9ZU08849w6Z4bV9jbkxSIEdyz1BJQTdjSCagziB3zncD5nd40M9LBZmwLQGfJ/1ubNRhV7fNGcCRSXiQ8bPEsuLm9hVy0ZlOo7UpfHZaFS//fj/GatMyAYGb0EREXm+wS8z5dwIFaRjGsye6gGbMjRBTTETba+8LQ99hfltnxYZs3A/3lEFebAgf80+b0MW2TdodowQWUuaudYaeqTAukZ0Hxup11rTmEHEOqI7sPIQBZRCA4GC2CFItPUK0PBKaHUUFiv/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d49b38-eb41-4df7-d777-08d58e359e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 07:38:48.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1209
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2K7d2ph021552

> From: Sinan Kaya [mailto:okaya@codeaurora.org]
> Sent: Tuesday, March 20, 2018 4:48 AM
> 
> Code includes wmb() followed by writel() in multiple places. writel() already
> has a barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index ccd55f4..db60360 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -860,7 +860,7 @@ static void doorbell_cq(struct qedr_cq *cq, u32 cons,
> u8 flags)
>  	wmb();
>  	cq->db.data.agg_flags = flags;
>  	cq->db.data.value = cpu_to_le32(cons);
> -	writeq(cq->db.raw, cq->db_addr);
> +	writeq_relaxed(cq->db.raw, cq->db_addr);
> 
>  	/* Make sure write would stick */
>  	mmiowb();
> @@ -3338,7 +3338,7 @@ int qedr_post_recv(struct ib_qp *ibqp, struct
> ib_recv_wr *wr,
> 
>  		qp->rq.db_data.data.value++;
> 
> -		writel(qp->rq.db_data.raw, qp->rq.db);
> +		writel_relaxed(qp->rq.db_data.raw, qp->rq.db);
> 
>  		/* Make sure write sticks */
>  		mmiowb();
> --
> 2.7.4
Acked-by: Michal Kalderon <Michal.Kalderon@cavium.com>
