Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7724120989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="axbjdIMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfA3P0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:26:53 -0500
Received: from mailout.micron.com ([137.201.242.129]:10173 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfA3P0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:26:52 -0500
X-Greylist: delayed 2007 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 10:26:51 EST
Received: from mail.micron.com (bowex17b.micron.com [137.201.21.210])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x0UErJqw009123;
        Wed, 30 Jan 2019 07:53:19 -0700
Received: from BOWEX36H.micron.com (137.201.84.179) by bowex17b.micron.com
 (137.201.21.210) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Wed, 30 Jan
 2019 07:53:18 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (137.201.84.23)
 by BOWEX36H.micron.com (137.201.84.179) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Wed, 30 Jan 2019 07:53:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRtO8/GwL9CYqVKa3hsI/C9Uuh+N8dbJUAN7916iXm0=;
 b=axbjdIMhDZ/tNXO26JrJD74at0eEsJqkaGl0EBpnOQrPDy9p+ZsejOVRCsIw/0ZFWXJ5+IHn64s2BE3DbFcmpxrFSvdbrtRJNfyTDWJi1vmtBVA1dAxFX+EyjTP1p1+a42uIQ9BoYMADZ5YHsE2Xw4qHTiECa2GrrWx5jEv8XEQ=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB5829.namprd08.prod.outlook.com (20.179.63.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 14:53:15 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 14:53:14 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>
CC:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: RE:  [PATCH v4 1/3] scsi: ufs-bsg: Change the calling convention for
 write descriptor
Thread-Topic: [PATCH v4 1/3] scsi: ufs-bsg: Change the calling convention for
 write descriptor
Thread-Index: AdS4q4LLvvMlcyQpRoyZYCqeKWc2YA==
Date:   Wed, 30 Jan 2019 14:53:14 +0000
Message-ID: <BYAPR08MB453398C5D7BD52EB90A36096DB900@BYAPR08MB4533.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB5829;6:wptsd/j2X+CzqBfwN77m7OeiWbloSGfgp4P2GxFOVY49hvEMV48euMbB+6+r6popJptt/Sku/CTlAkW+vs79Il/wDnZPGlr84wnVzvu3Ce9oxYWYOTSZayvZOSyh0MXicsABUdwCR9qmg95507eiKJBHsn7K70i0EUiufImXtEkqdqoYYvmEce/RhDlLlfFLQz5T5qQ3gZpOPphuFtzUw0483vjUIM8HhCWO22NVK5DxVQiYq+av4PhftPemjsMbGWaEEZLybpFG+YnW4liHcddCJS+A98fg6kPN+oRUqqE8a4QeZbesPIUkK/2y/8mou7ml61BhrH/3r0xGD0U7coSjfQsoftDLSWAWK77Gu7vs0mVM17s8yDTroY/wHLMs41r5GsuPqGK01DKgBjAcfyTGjVUUct0CEnYNJgRb2rPJ0e6Gc0bj5kF9pjR6awHNFAuZSPnJYb0FLf/gxhxAUw==;5:HoX8MUNjye+hcRSm5/dQqZpHa/24dL076c2LI2gvS71ENnzlHPJnhTHTkJTVeqQG3uQ0WNFXiBdCg/3y7ID6T9tXwFiws/H1Cgq054aDHHkKQbRBhxW0VOBwm+v+/fECTlMrh4u+LPCt/eQXYozGnaNwKsnVVnbQFExPVZDB4BshAR7Rz8vVCVe+Ml+vkn6RG8f0nsLapvfv5zxl/0kpSQ==;7:S337K8axdEb3YekxF7sGGPdaE9m0kz+fscEgEGNcIQJJRYcNwxdbnURfPIisdyfWXPyMrb6Lsb+lv3BgjmP1xHInIuWalMB55u2sadBQnUpRvOLgzV6L7GQnwMHdToVQZ+KmjWr/0Zv3WBDnEvG30A==
x-ms-office365-filtering-correlation-id: 73329e84-bb22-4666-1c33-08d686c2a9b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB5829;
x-ms-traffictypediagnostic: BYAPR08MB5829:|BYAPR08MB5829:
x-microsoft-antispam-prvs: <BYAPR08MB58293E2405C99A5E87FAF5C5DB900@BYAPR08MB5829.namprd08.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(9686003)(81156014)(8936002)(105586002)(14454004)(106356001)(478600001)(966005)(8676002)(81166006)(33656002)(3846002)(6116002)(66066001)(2906002)(229853002)(486006)(476003)(97736004)(71200400001)(316002)(6306002)(2501003)(68736007)(6506007)(99286004)(102836004)(86362001)(6436002)(55016002)(71190400001)(256004)(7696005)(4326008)(2201001)(186003)(26005)(6246003)(305945005)(7736002)(54906003)(53936002)(74316002)(110136005)(25786009)(55236004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB5829;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bugKPtrdUZt3xOEso+YxbgzCKEoEQZynvU7GemJb/V3tvQbEpVIkGxEUEFda8+M6w4pLVZdz6UgDJqzJW7IyH5C7jwtqzhvW4L5phB9ZdR0+36RkjV5EdnD7r8EOUv1GdtvXyNszGtyDL1oWHHqEpIZ7APPo1oQv16DLwlWHfFKgqInDusAiY7bwbZpcn4n4kTd+KcH8Mltbqugx7uM5YKSp4CU4cAmP4nQpwwFzUlOz8CNGzXs6o8c/7AK/88wME9SsFRneY4nsK24mgYZ9KRYsJE/8UBe8lKoTikYWqCAYndPIOTGlHn+UdKNhxJ2hAL7PYVCUg3Db29WGTECW8IaywmpPAnizaqYGaOBED6sCphN+ghzBse5MoneEPbfAz01pkgISYLLm5kB2ZlRqdJS6CpItF6aSBmNb6dIlmAs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73329e84-bb22-4666-1c33-08d686c2a9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 14:53:14.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5829
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24396.005
X-TM-AS-Result: No--20.268900-0.000000-31
X-TM-AS-MatchedID: 150567-157008-139010-703788-700398-700293-707163-708060-7
        08690-702126-121105-701236-704425-704636-704980-701475-850702-704410-700016
        -188019-702099-702643-851458-702358-139704-780058-700818-702609-700040-7002
        72-706290-700264-700373-702042-105700-851106-899170-148004-148007-148020-14
        8050-20020-20043-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Avri

>
>When we had a write descriptor query upiu, we appended the descriptor righ=
t
>after the bsg request.  This was fine as the bsg driver allows to allocate=
 whatever
>buffer we needed in its job request.
>
>Still, the proper way to deliver payload, however small (we only write con=
fig
>descriptors of 144 bytes), is by using the job request payload data buffer=
.
>
>So change this ABI now, while ufs-bsg is still new, and nobody is actually=
 using it.
>
>Signed-off-by: Avri Altman <avri.altman@wdc.com>
>Reviewed-by: Evan Green <evgreen@chromium.org>
>---
> Documentation/scsi/ufs.txt |  6 ++++++
> drivers/scsi/ufs/ufs_bsg.c | 47 +++++++++++++++++++++++++----------------=
-----
> 2 files changed, 32 insertions(+), 21 deletions(-)
>
>diff --git a/Documentation/scsi/ufs.txt b/Documentation/scsi/ufs.txt index
>520b5b0..78fe7cb 100644
>--- a/Documentation/scsi/ufs.txt
>+++ b/Documentation/scsi/ufs.txt
>@@ -147,6 +147,12 @@ send SG_IO with the applicable sg_io_v4:
> 	io_hdr_v4.max_response_len =3D reply_len;
> 	io_hdr_v4.request_len =3D request_len;
> 	io_hdr_v4.request =3D (__u64)request_upiu;
>+	if (dir =3D=3D SG_DXFER_TO_DEV) {
>+		io_hdr_v4.dout_xfer_len =3D (uint32_t)byte_cnt;
>+		io_hdr_v4.dout_xferp =3D (uintptr_t)(__u64)buff;
>+	}
>+
>+If you wish to write a descriptor, use the dout_xferp sg_io_v4.
>
> UFS Specifications can be found at,
> UFS - http://www.jedec.org/sites/default/files/docs/JESD220.pdf
>diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c index
>775bb4e..2fd0769 100644
>--- a/drivers/scsi/ufs/ufs_bsg.c
>+++ b/drivers/scsi/ufs/ufs_bsg.c
>@@ -27,15 +27,11 @@ static int ufs_bsg_get_query_desc_size(struct ufs_hba
>*hba, int *desc_len,
>
> static int ufs_bsg_verify_query_size(struct ufs_hba *hba,
> 				     unsigned int request_len,
>-				     unsigned int reply_len,
>-				     int desc_len, enum query_opcode desc_op)
>+				     unsigned int reply_len)
> {
> 	int min_req_len =3D sizeof(struct ufs_bsg_request);
> 	int min_rsp_len =3D sizeof(struct ufs_bsg_reply);
>
>-	if (desc_op =3D=3D UPIU_QUERY_OPCODE_WRITE_DESC)
>-		min_req_len +=3D desc_len;
>-
> 	if (min_req_len > request_len || min_rsp_len > reply_len) {
> 		dev_err(hba->dev, "not enough space assigned\n");
> 		return -EINVAL;
>@@ -44,14 +40,13 @@ static int ufs_bsg_verify_query_size(struct ufs_hba *h=
ba,
> 	return 0;
> }
>
>-static int ufs_bsg_verify_query_params(struct ufs_hba *hba,
>-				       struct ufs_bsg_request *bsg_request,
>-				       unsigned int request_len,
>-				       unsigned int reply_len,
>-				       uint8_t *desc_buff, int *desc_len,
>-				       enum query_opcode desc_op)
>+static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job =
*job,
>+				     uint8_t **desc_buff, int *desc_len,

Maybe here also we should use 'u8'.

Reviewed-by: Bean Huo <beanhuo@beanhuo@micron.com>

//Beanhuo

