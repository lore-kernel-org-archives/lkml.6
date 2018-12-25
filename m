Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19232177E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="wS+kpXcl";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="hTN/1+rf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbeLYNNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 08:13:49 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:46964 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbeLYNNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 08:13:48 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBPD5nkN032482;
        Tue, 25 Dec 2018 05:13:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NwIDR0IOmUUokwyIk2q2cXd893XM9ArmTV1KNjyf6JA=;
 b=wS+kpXclMWgCHKaV8uj1GP2ZWDeGZ7eLqQCGES9DwjMtNcEcSRQSLi8DQBZP4m1XMjzU
 lbeZxnJB7mPCbl16TYEf9an/yvvlZ8QfP+GZl63Fq7v1A+JUlZ8aoODwAxFjRXR839tD
 +0QIIMPnQP+iY5nQgQ5HA2UuMbIJMYiGiCfzCrDVn41WjB0rQwxL1BHPYNi2yUy5QK4W
 XweUXPr6/wWopCoFPXlv8Ot/r3qRlZvSh0Z/bR91qZtpIr7zgkgc3/2DtEWYso+QWNJE
 P5q+zuYBGviiIPyoUhWjgHuxTmDY8auek8R1UPk+070U7CNfCleYhEP/M7HaCI70mLPS 5g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2pkmmer34x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Dec 2018 05:13:38 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 25 Dec
 2018 05:13:37 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.51) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 25 Dec 2018 05:13:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwIDR0IOmUUokwyIk2q2cXd893XM9ArmTV1KNjyf6JA=;
 b=hTN/1+rfusE8OffbfzlclYSVAMFgA/74Oll1+tzQdfiQFGWqNiyiezi35hBVW899ybnb588R6orO2y/qGUgis/N6/24yIr4JrgJTG/xUQe7S6jNcX1pI30WOL1H9CsFeb7ycHuHny5UkEPTOXoeZMk5LLsetuv71k5w4na1kcNo=
Received: from BLUPR18MB0130.namprd18.prod.outlook.com (10.160.188.26) by
 BLUPR18MB0451.namprd18.prod.outlook.com (10.164.19.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Tue, 25 Dec 2018 13:13:36 +0000
Received: from BLUPR18MB0130.namprd18.prod.outlook.com
 ([fe80::8865:c99a:b707:1478]) by BLUPR18MB0130.namprd18.prod.outlook.com
 ([fe80::8865:c99a:b707:1478%11]) with mapi id 15.20.1446.026; Tue, 25 Dec
 2018 13:13:35 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Aditya Pakki <pakki001@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] infiniband/qedr: Potential null ptr dereference of
 qp
Thread-Topic: [EXT] [PATCH] infiniband/qedr: Potential null ptr dereference of
 qp
Thread-Index: AQHUm7X+AUGjhoUstkeHgtDUcAY6hqWPb6Pw
Date:   Tue, 25 Dec 2018 13:13:35 +0000
Message-ID: <BLUPR18MB013099199B96DDC73099D0E5A1B40@BLUPR18MB0130.namprd18.prod.outlook.com>
References: <20181224182445.21256-1-pakki001@umn.edu>
In-Reply-To: <20181224182445.21256-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR18MB0451;20:nwGzEevODCP960gKjCvTFoVZDgk83s2cfrf2X7fYOU+j9LVyoNY+7UEYlkVtXeHc/ejNR88QyJm1ePl7UKb7YpWcXVg5ZdqLx8cCDIPPCh+WPS+BevedIAJwf0UCmdbP7lz1eESzhj+2d+6XR9+/YDyqaJSXO/OpJMArbJtq0hg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d416b6ba-4b67-4ab3-9f32-08d66a6ac6fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR18MB0451;
x-ms-traffictypediagnostic: BLUPR18MB0451:
x-microsoft-antispam-prvs: <BLUPR18MB0451427173B88CFAA247C471A1B40@BLUPR18MB0451.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR18MB0451;BCL:0;PCL:0;RULEID:;SRVR:BLUPR18MB0451;
x-forefront-prvs: 08978A8F5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(366004)(346002)(136003)(376002)(199004)(189003)(5660300001)(9686003)(55016002)(256004)(6436002)(7736002)(229853002)(305945005)(74316002)(97736004)(86362001)(106356001)(105586002)(71190400001)(71200400001)(66066001)(7696005)(6506007)(2171002)(8936002)(3846002)(81166006)(81156014)(8676002)(6116002)(186003)(99286004)(33656002)(53936002)(6246003)(478600001)(4326008)(2906002)(6916009)(25786009)(316002)(11346002)(68736007)(14454004)(76176011)(54906003)(26005)(102836004)(446003)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR18MB0451;H:BLUPR18MB0130.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hji9+0iRRJoRaaXknRkkFS4K+Ekl3C4hqOVHY2gT7S1zTYzrTetvmhZELsmRHdeh81F1yuOF/TkIA63tZGPXvccuX+HC6moYTzbd8TF4DNbRpFKwGJ+sYwhn8Lym69+eh5E0cqLBhh/QSZjjosEaqFuEjMpGVbuyPEg6C9ePxvYoSFFtU4FpVNImlct6oJf/Aa5QPDCgFC0i6iLDuZ7pVtuux2GXhCuLmWvnnB5mt7Thxt7X9Qtj2Q7GTqV11CLDXAk7xClReC+db7V5a9t1ZzA3B9x3qeVDj1lSvxjxU9NwhUDziqsoGe78Kro96ni3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d416b6ba-4b67-4ab3-9f32-08d66a6ac6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2018 13:13:35.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR18MB0451
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-25_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=783 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812250119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Aditya Pakki <pakki001@umn.edu>
> Sent: Monday, December 24, 2018 8:25 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> External Email
>=20
> idr_find() may fail and return a NULL pointer. The fix checks the return =
value
> of the function and returns an error in case of NULL.
>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> index 505fa3648762..93b16237b767 100644
> --- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> @@ -492,6 +492,8 @@ int qedr_iw_connect(struct iw_cm_id *cm_id, struct
> iw_cm_conn_param *conn_param)
>         int i;
>=20
>         qp =3D idr_find(&dev->qpidr.idr, conn_param->qpn);
> +       if (unlikely(!qp))
> +               return -EINVAL;
>=20
>         laddr =3D (struct sockaddr_in *)&cm_id->m_local_addr;
>         raddr =3D (struct sockaddr_in *)&cm_id->m_remote_addr;
> --
> 2.17.1

Thanks,

Acked-by: Michal Kalderon <michal.kalderon@marvell.com>


