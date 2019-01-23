Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369D8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4AE217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="wPJvALSF";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="NmtVZz+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfAWFhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 00:37:01 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:45054 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfAWFhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 00:37:00 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0N5Z4Od014266;
        Tue, 22 Jan 2019 21:36:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=bgGzGouNVxIepReWtKjU2BFeOWUIXx9SuAgiWayvmXE=;
 b=wPJvALSF91UeuKKjBk4t0tn/lffJc96FEe20FAXGI8gvRgceQSfqs5v2ksjReBKYuv7I
 kE8bfbtYRpdCfHYw0NsfzyiPQFHqpp/ONDXvlTWQDhji5fSoy7Gs9UJCvkj/ZojuIY4e
 eSKAEZkmDRrs+jnPSMC1NniVpL02Nk7hFPQqMPHWKu3mZjqSOfcW1t+9iuwMtS0mTyEt
 quGh6agWVpXj4ODwtltZSl4SMCIqqsqs6265v4/OSCvmiaUssBzTQeUyQzgl6flHo1e8
 afFybtfw8eY8zvzcwSVCNVcoKF3mVEvYOqNCOn5oxrAZpO5+WMl2RNIjTFGqoTt+Fzzz hw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2q6cht9xq2-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 21:36:56 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 22 Jan
 2019 21:36:53 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 22 Jan 2019 21:36:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgGzGouNVxIepReWtKjU2BFeOWUIXx9SuAgiWayvmXE=;
 b=NmtVZz+Bwd7zQBHtYdpAw9bBxqJ0oT+TlT52onJKCJWWDQKNkHX1FoiV6U9PeSfbmYM8j4JnePe0RJcW4pNFCftcAQ/DPyk/30hB7wGw2a2SatqC9vDrjRijRHETGye/O3lagcj8cU0ptnIagRi2EzNsl1TwuH8OUg/z7NW7zYI=
Received: from BYAPR18MB2485.namprd18.prod.outlook.com (20.179.92.143) by
 BYAPR18MB2983.namprd18.prod.outlook.com (20.179.60.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 23 Jan 2019 05:36:50 +0000
Received: from BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::e845:9a54:f1be:a474]) by BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::e845:9a54:f1be:a474%2]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 05:36:50 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "QLogic-Storage-Upstream@cavium.com" 
        <QLogic-Storage-Upstream@cavium.com>
Subject: RE: [PATCH 6/7] scsi: qlogic: no need to check return value of
 debugfs_create functions
Thread-Topic: [PATCH 6/7] scsi: qlogic: no need to check return value of
 debugfs_create functions
Thread-Index: AQHUsmSKY1XdW2QBlUaP+OnoY78pxKW8VjDw
Date:   Wed, 23 Jan 2019 05:36:50 +0000
Message-ID: <BYAPR18MB2485661ACC93D549309BB720D8990@BYAPR18MB2485.namprd18.prod.outlook.com>
References: <20190122150906.12470-1-gregkh@linuxfoundation.org>
 <20190122150906.12470-7-gregkh@linuxfoundation.org>
In-Reply-To: <20190122150906.12470-7-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR18MB2983;20:izr+ix7E58jBP8Y9lpYIqqK54iEyEa+Sp1dJZRtH1b0tjWHNVZAjWLIwMOGR6kuYs/dxOq+xvsC80+6xDQJjBtLXBVH1qmTZaWTinqWmlbAf8qazJ4tjht7eqHeTHFrzkCfN/yOe+qfwnwVRnbdtpvcY2lWxpw1pPIMCcSwF9Q8=
x-ms-office365-filtering-correlation-id: ca2b8605-9f0f-48c0-ca1a-08d680f4c66b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2983;
x-ms-traffictypediagnostic: BYAPR18MB2983:
x-microsoft-antispam-prvs: <BYAPR18MB298381DCA5207211AFDFB709D8990@BYAPR18MB2983.namprd18.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(13464003)(199004)(189003)(6116002)(86362001)(186003)(7696005)(76176011)(102836004)(53546011)(6506007)(26005)(2906002)(3846002)(8936002)(66066001)(97736004)(74316002)(106356001)(105586002)(33656002)(229853002)(55016002)(486006)(4326008)(53936002)(6436002)(6246003)(25786009)(9686003)(71190400001)(99286004)(71200400001)(7736002)(54906003)(110136005)(81156014)(14454004)(8676002)(81166006)(476003)(478600001)(446003)(11346002)(305945005)(316002)(14444005)(68736007)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2983;H:BYAPR18MB2485.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: huhWzYeNUHRxGtluTn8V1JkGodYdefQKXVwSwNPgT2y+tqnWnqZ33jqzY3whMFq7Nsd7jcKGX1r4jhEIut7jS3IrwtCEs0trXTW8/knygopiAxR4fbigiAnEO5FWKUpbVZ7MaQzQ8MyffUjNPtW6jDxhLV5/WNpqHCSOHmFnKdG4LwyNV06T9NVAIfTmgUBYKeceXRTnuVEfGAuIkjMjGCzM/4xDVTqSjvA49R3aSBbGNw6QaUvy/tNfCPlNtcDFZK691GMt/J9IrVF90Nqlz6uIrDIvAq96PMpsvZuhIHyWplJ+IBCcyG+qB+SjYS0DWLEJeGgcpi4CRQbvWe97T0uohAQySnbidlbiFGDjq2H0v0omr4zBhEebZFVixoHxYKCQ97BsUsswdAxRbx/oGHhL14KHkS+9rRCO/jeNN74=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2b8605-9f0f-48c0-ca1a-08d680f4c66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 05:36:50.7582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2983
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 22, 2019 8:39 PM
> To: James Bottomley <jejb@linux.ibm.com>; Martin Petersen
> <martin.petersen@oracle.com>
> Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>; QLogic-Storage-
> Upstream@cavium.com
> Subject: [PATCH 6/7] scsi: qlogic: no need to check return value of
> debugfs_create functions
>=20
> External Email
>=20
> When calling debugfs functions, there is no need to ever check the return
> value.  The function can work or not, but the code logic should never do
> something different based on this.
>=20
> Cc: QLogic-Storage-Upstream@cavium.com
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/scsi/qedf/qedf_debugfs.c | 18 ++----------------
> drivers/scsi/qedi/qedi_debugfs.c | 17 ++---------------
>  2 files changed, 4 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/scsi/qedf/qedf_debugfs.c
> b/drivers/scsi/qedf/qedf_debugfs.c
> index c29c162a494f..a32d8ee4666e 100644
> --- a/drivers/scsi/qedf/qedf_debugfs.c
> +++ b/drivers/scsi/qedf/qedf_debugfs.c
> @@ -27,30 +27,19 @@ qedf_dbg_host_init(struct qedf_dbg_ctx *qedf,
>                     const struct file_operations *fops)  {
>         char host_dirname[32];
> -       struct dentry *file_dentry =3D NULL;
>=20
>         QEDF_INFO(qedf, QEDF_LOG_DEBUGFS, "Creating debugfs host
> node\n");
>         /* create pf dir */
>         sprintf(host_dirname, "host%u", qedf->host_no);
>         qedf->bdf_dentry =3D debugfs_create_dir(host_dirname,
> qedf_dbg_root);
> -       if (!qedf->bdf_dentry)
> -               return;
>=20
>         /* create debugfs files */
>         while (dops) {
>                 if (!(dops->name))
>                         break;
>=20
> -               file_dentry =3D debugfs_create_file(dops->name, 0600,
> -                                                 qedf->bdf_dentry, qedf,
> -                                                 fops);
> -               if (!file_dentry) {
> -                       QEDF_INFO(qedf, QEDF_LOG_DEBUGFS,
> -                                  "Debugfs entry %s creation failed\n",
> -                                  dops->name);
> -                       debugfs_remove_recursive(qedf->bdf_dentry);
> -                       return;
> -               }
> +               debugfs_create_file(dops->name, 0600, qedf->bdf_dentry, q=
edf,
> +                                   fops);
>                 dops++;
>                 fops++;
>         }
> @@ -80,9 +69,6 @@ qedf_dbg_init(char *drv_name)
>=20
>         /* create qed dir in root of debugfs. NULL means debugfs root */
>         qedf_dbg_root =3D debugfs_create_dir(drv_name, NULL);
> -       if (!qedf_dbg_root)
> -               QEDF_INFO(NULL, QEDF_LOG_DEBUGFS, "Init of debugfs "
> -                          "failed\n");
>  }
>=20
>  /**
> diff --git a/drivers/scsi/qedi/qedi_debugfs.c
> b/drivers/scsi/qedi/qedi_debugfs.c
> index fd914ca4149a..5667e4752e2e 100644
> --- a/drivers/scsi/qedi/qedi_debugfs.c
> +++ b/drivers/scsi/qedi/qedi_debugfs.c
> @@ -23,27 +23,16 @@ qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
>                    const struct file_operations *fops)  {
>         char host_dirname[32];
> -       struct dentry *file_dentry =3D NULL;
>=20
>         sprintf(host_dirname, "host%u", qedi->host_no);
>         qedi->bdf_dentry =3D debugfs_create_dir(host_dirname, qedi_dbg_ro=
ot);
> -       if (!qedi->bdf_dentry)
> -               return;
>=20
>         while (dops) {
>                 if (!(dops->name))
>                         break;
>=20
> -               file_dentry =3D debugfs_create_file(dops->name, 0600,
> -                                                 qedi->bdf_dentry, qedi,
> -                                                 fops);
> -               if (!file_dentry) {
> -                       QEDI_INFO(qedi, QEDI_LOG_DEBUGFS,
> -                                 "Debugfs entry %s creation failed\n",
> -                                 dops->name);
> -                       debugfs_remove_recursive(qedi->bdf_dentry);
> -                       return;
> -               }
> +               debugfs_create_file(dops->name, 0600, qedi->bdf_dentry, q=
edi,
> +                                   fops);
>                 dops++;
>                 fops++;
>         }
> @@ -60,8 +49,6 @@ void
>  qedi_dbg_init(char *drv_name)
>  {
>         qedi_dbg_root =3D debugfs_create_dir(drv_name, NULL);
> -       if (!qedi_dbg_root)
> -               QEDI_INFO(NULL, QEDI_LOG_DEBUGFS, "Init of debugfs failed=
\n");
>  }
>=20
>  void
> --
> 2.20.1

Thanks
Acked-by: Manish Rangankar <mrangankar@marvell.com>
