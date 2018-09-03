Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648602077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="IEesq7Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648602077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeICNmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:42:09 -0400
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:45184
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbeICNmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPBxzITa1YeUZXCh9JkgHE8ESVFq9EG0VHVUP4/hx0c=;
 b=IEesq7MrODWoUJiYLQ/kwWeMSeN8+mWkdCrxCBOXnY7YdEpuAzGTd9f4cSgrI6q3KM7nTohRzRwS8/NoDaTBRfzkZyhxlCOzQ0Rj0XuJ61lckiB1NW5BOE35IQjyGMeb3sz5KdNMMp3ufKut0dSzssiXiMoAZlzR8inAUdI5Odg=
Received: from CO2PR07MB2709.namprd07.prod.outlook.com (10.166.214.10) by
 CO2PR07MB2616.namprd07.prod.outlook.com (10.166.213.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Mon, 3 Sep 2018 09:22:50 +0000
Received: from CO2PR07MB2709.namprd07.prod.outlook.com
 ([fe80::f519:dbaf:9f46:a66e]) by CO2PR07MB2709.namprd07.prod.outlook.com
 ([fe80::f519:dbaf:9f46:a66e%3]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 09:22:49 +0000
From:   "Verma, Rahul" <Rahul.Verma@cavium.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "Kalderon, Michal" <Michal.Kalderon@cavium.com>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/qedr: remove set but not used variable
 'ctx'
Thread-Topic: [PATCH rdma-next] RDMA/qedr: remove set but not used variable
 'ctx'
Thread-Index: AQHUQaXvCrXb3IYjN0WouFIzA/yjA6Tc2XaggAFmI+A=
Date:   Mon, 3 Sep 2018 09:22:49 +0000
Message-ID: <CO2PR07MB2709148C026CE62A04804E92910C0@CO2PR07MB2709.namprd07.prod.outlook.com>
References: <1535774026-160694-1-git-send-email-yuehaibing@huawei.com>
 <SN6PR07MB50241FB1FF44E657987475A4900D0@SN6PR07MB5024.namprd07.prod.outlook.com>
In-Reply-To: <SN6PR07MB50241FB1FF44E657987475A4900D0@SN6PR07MB5024.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rahul.Verma@cavium.com; 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2616;6:imV0oP/uSzl0bZT6ol+GnMboVqyjvkkBWvfYkbInDBpoD+qiIQUR6Nc74wUBYTwLjQT1nOrM11Jg2aL4ahiFGukfl7ZsaopnOXKxRaDqkrMHGWvMFHi4AuL9Kox98lbnSNjodBph3QGV6FztAOPUW7cdJqo4KexzcS3SFTVXlNpEqnS+y1lsLo5qXxLnBkV/hr9zmWfd2aMpNhvsth63cgEdBOO216/RN2bEsH9IOgdgCmY/iQWa2aNW44MgqZ1m2Kuj0qO8woUGao9KzkXoe8VMhwti3V1ltA4UZZBlUogGS3yin8r9834gpI3xw/RdI+vUwihq5Tf8wxl3sSpnmqxdAwNTzyVLkKUNSwHOSx2Pfxk4CpxOjSnG+ER97IV8vNHyQ9ioYA9xdiUDXZWkk9O5DRwdWviqD6LxY1WV3xFXdVOwsLHWRcYB1TVi58mELnSu1mihhM40taP2jNfXSQ==;5:wpj6ebkzU8+3vgeOxOEkoGGeCWKnATjhP9KyTzUuN9yLNWpVM4wAvElWkC+CeR44qeFIDKk49Fh2ruaxe2Z6+WGmb493TuF7hzi0Imr0ZV7U2/Vsz6WmOLlnuEU9W5SJz/ttCMIZUDr3XiMcAWwxbQD3QR4WES35aCM3gQ+/jmc=;7:1VRlhxlAWabJPxN70sq3grSHcJilvdu485hXbWGFr0EJ3PWBU9QfoiSoQ/Y0aVRYk/OZddzLXcj8LJoZCA/4RxEw2FHRYQLB64zd2Bn7XqPIxVkbw6wBLjdNULOeUNdJcOrz8/gbm1AXG8DRc804f7kuB2Duwye2sK/noyFsXsZavCzHEr9yKjRGjNX1JY1Hi0NFvJewT/zb6J471z98ijGXGUyZsQb/KI9BS4c/8tHkG+WDFEqWka3IyyT7yDVi
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(13464003)(199004)(189003)(476003)(7696005)(446003)(11346002)(5250100002)(26005)(4326008)(72206003)(2906002)(81156014)(478600001)(81166006)(6116002)(3846002)(54906003)(110136005)(8676002)(6506007)(316002)(14454004)(99286004)(6246003)(14444005)(256004)(105586002)(76176011)(486006)(86362001)(102836004)(53546011)(25786009)(186003)(7736002)(74316002)(305945005)(66066001)(2900100001)(97736004)(8936002)(5660300001)(53936002)(55016002)(33656002)(106356001)(229853002)(9686003)(6436002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2616;H:CO2PR07MB2709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 30f8e8c0-bc3b-463b-3513-08d6117ed14f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2616;
x-ms-traffictypediagnostic: CO2PR07MB2616:
x-microsoft-antispam-prvs: <CO2PR07MB2616CCDA4FAB6EB00B7E02BC910C0@CO2PR07MB2616.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR07MB2616;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2616;
x-forefront-prvs: 0784C803FD
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PRtW415wRnq0E4jsuWFY12eMq90C20aobUn7cFJCf+nKoFXv7HGBycKlFMI/PejOcIQKOsV+AEnTWbr7gjJ6muTowLa9JfhylDI0ATIUyeCAFQTmzgzzTTBJf8D/5gF/MYScayMMUsdfb3lBQl8V/dDXa5SFBhMFtDyjqfpF2liUKMN8XCPz3BkCXJZKefXKPjuJK0RpGwaFnYeo6618c8wDiKzg8AaLpl2ToM7s0oc7BlUS1arBB8MvKAB8I7S9Pi0y2d33ZFIoOmnq6XBKOAOGuN9hrV7kG9Fpa6/hYUVwOz/Z2NWgrxNHClfHdSNp5yYO4QBzqDkLQStA1e2JRBz7OWh+7pEPIdb5DyGzjUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f8e8c0-bc3b-463b-3513-08d6117ed14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 09:22:49.3863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Saturday, September 1, 2018 6:54 AM
> To: Kalderon, Michal <Michal.Kalderon@cavium.com>; Elior, Ariel
> <Ariel.Elior@cavium.com>; Doug Ledford <dledford@redhat.com>; Jason
> Gunthorpe <jgg@ziepe.ca>
> Cc: YueHaibing <yuehaibing@huawei.com>; linux-rdma@vger.kernel.org;
> linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH rdma-next] RDMA/qedr: remove set but not used variable
> 'ctx'
>
> External Email
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/infiniband/hw/qedr/verbs.c: In function 'qedr_create_srq':
> drivers/infiniband/hw/qedr/verbs.c:1450:24: warning:
>  variable 'ctx' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 8cc3df2..9d4d165 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1447,7 +1447,6 @@ struct ib_srq *qedr_create_srq(struct ib_pd
> *ibpd,
>         u64 pbl_base_addr, phy_prod_pair_addr;
>         struct ib_ucontext *ib_ctx =3D NULL;
>         struct qedr_srq_hwq_info *hw_srq;
> -       struct qedr_ucontext *ctx =3D NULL;
>         u32 page_cnt, page_size;
>         struct qedr_srq *srq;
>         int rc =3D 0;
> @@ -1473,7 +1472,6 @@ struct ib_srq *qedr_create_srq(struct ib_pd
> *ibpd,
>
>         if (udata && ibpd->uobject && ibpd->uobject->context) {
>                 ib_ctx =3D ibpd->uobject->context;
> -               ctx =3D get_qedr_ucontext(ib_ctx);
>
>                 if (ib_copy_from_udata(&ureq, udata, sizeof(ureq))) {
>                         DP_ERR(dev,

Thank Yue.
Acked-by: Rahul Verma <rahul.verma@cavium.com>=20
