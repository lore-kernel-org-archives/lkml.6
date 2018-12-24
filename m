Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5110FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138A521773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qn2Jx6af";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="WVwA5LM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbeLXJBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:01:47 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40328 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbeLXJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:01:43 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBO90GXt029866;
        Mon, 24 Dec 2018 01:01:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=zBPYTH5Pwqmj6aX18wjZyIWPpSVYx9V7XZb+lALQYTo=;
 b=Qn2Jx6afV0foLgGhnBs3EWQmbUyIkB2XXUcX5/9KVFZSi4GGFKmgYtodfh/LUemB3Ls4
 nYuXNXSrV4hZOPJhv2vpzmclMAoXboaPvSKsscI27V90vQhgLFyam1MpVIPUlI74laNw
 BUHPNIJIluGMBGO7+MTR4+9mcYbp3D0vrIPaxQ+4yofQWnSpDrdl3yY35S64xA512jHN
 mwj8wYuDgOH4cFqUsMwJ6Reqt7uG7kT/b39cR5QLleLweFN6bKvD3Vff/bSiCOLl4YMQ
 ZXJiNjmjQrv/7cmWFNJ+uRLy6XnctP1v3Bk2+Phdq8ZUqQplP/mijYjhT3zzbOAaEfHR jA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2phnnqfjhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Dec 2018 01:01:30 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Dec
 2018 01:01:29 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Dec 2018 01:01:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBPYTH5Pwqmj6aX18wjZyIWPpSVYx9V7XZb+lALQYTo=;
 b=WVwA5LM67BMP4oJzrCGmC0My/NBoMVjYsaetUxz2S/G0lMRgjKaITCjvfIKp6KBHtYZ9sWdEdsE+ibaXJOsh+JbdHvP/8yYXobgsG4QCKReTW3nUzxzGrxaswVA63dBNNZLA4Q+0bCTeebyKtI60Nf698OicCUDzUnBFRxHyAqs=
Received: from SN1PR18MB2301.namprd18.prod.outlook.com (52.132.199.151) by
 SN1PR18MB2333.namprd18.prod.outlook.com (52.132.199.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:01:26 +0000
Received: from SN1PR18MB2301.namprd18.prod.outlook.com
 ([fe80::111a:125d:f7db:3cf2]) by SN1PR18MB2301.namprd18.prod.outlook.com
 ([fe80::111a:125d:f7db:3cf2%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:01:26 +0000
From:   Nilesh Javali <njavali@marvell.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Dept-Eng QLogic Storage Upstream" 
        <QLogic-Storage-Upstream@cavium.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/41] scsi: qla4xxx: ql4_os: mark expected switch
 fall-through
Thread-Topic: [PATCH 36/41] scsi: qla4xxx: ql4_os: mark expected switch
 fall-through
Thread-Index: AQHUhufpXZzxcjxy50iuv0ezG5qkdqWOHNwA
Date:   Mon, 24 Dec 2018 09:01:26 +0000
Message-ID: <D8469DE5.5427A%njavali@marvell.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <a118ae0eeeb3cdcd4846bc1031ea89ca62af1e00.1543374820.git.gustavo@embeddedor.com>
In-Reply-To: <a118ae0eeeb3cdcd4846bc1031ea89ca62af1e00.1543374820.git.gustavo@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR18MB2333;20:lk/u2LYE9fZVzs4TtfNh+UmGqjv8Sdf+p6FOKVyWgO/FhVV2UqvBHarBnMz20ZK1/Dnn4fbXkcqRnmm49mSrcOP7BARU5tGZ1MM3WDAbwbl2ZXBYNggTLK5K0bUJaMTtSoNzbB5uuXJ2Rm3Z/T02ixf4TqQOwKfm6tJ7QWcIIJ0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f255ea41-a232-475f-b693-08d6697e62e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR18MB2333;
x-ms-traffictypediagnostic: SN1PR18MB2333:
x-microsoft-antispam-prvs: <SN1PR18MB233373B7F41436409A1A5C43AFBB0@SN1PR18MB2333.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR18MB2333;BCL:0;PCL:0;RULEID:;SRVR:SN1PR18MB2333;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39850400004)(136003)(396003)(199004)(189003)(6486002)(6436002)(99286004)(25786009)(229853002)(86362001)(316002)(6116002)(3846002)(305945005)(7736002)(53936002)(110136005)(54906003)(81166006)(8676002)(8936002)(81156014)(105586002)(186003)(26005)(106356001)(486006)(6246003)(256004)(76176011)(36756003)(14454004)(53546011)(68736007)(102836004)(14444005)(6506007)(6512007)(478600001)(2616005)(476003)(446003)(2906002)(71190400001)(71200400001)(11346002)(4326008)(5660300001)(66066001)(97736004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR18MB2333;H:SN1PR18MB2301.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /LCPDDxGKJHn2enGgc/c+6T/qgXaL1m47dp/4+Tcz+HmXd8jRbfKyvWMR6J6+6auS9FedBkYr4E2O0+r2Kk4dEpY2DUbDYI6BZipj9PkefrIW493atPvy3/ilqOpHHsRsOKM6QZL51G25rh553CpUEE/dQLIiSgLl+TQT4uRqK2noA+3n82rmAtY31g+mDoq5VivVmNAXLhGP1PTJFBYxU1ry5SAPEVt6uOzlEjw0nnW5Li7fqatekTuRdzQ+VDZeNYBpqnhkm/n+J61PN7I6w3pVOClsvaVDrSssuk929XZqC4XJuCimDRmXjUpghY5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79F86365B1F85B4BA18E2C91171340EE@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f255ea41-a232-475f-b693-08d6697e62e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:01:26.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2333
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-24_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=953 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812240082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/18, 10:03 AM, "linux-scsi-owner@vger.kernel.org on behalf of
Gustavo A. R. Silva" <linux-scsi-owner@vger.kernel.org on behalf of
gustavo@embeddedor.com> wrote:

>External Email
>
>In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>where we are expecting to fall through.
>
>Notice that, in this particular case, I replaced "allow fall-through"
>with a "fall through" annotation, which is what GCC is expecting to
>find.
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>---
> drivers/scsi/qla4xxx/ql4_os.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
>index 1c702cd22359..7fd3491ea2d9 100644
>--- a/drivers/scsi/qla4xxx/ql4_os.c
>+++ b/drivers/scsi/qla4xxx/ql4_os.c
>@@ -2876,7 +2876,7 @@ static int qla4xxx_session_get_param(struct
>iscsi_cls_session *cls_sess,
>                                                chap_tbl.secret_len);
>                        }
>                }
>-               /* allow fall-through */
>+               /* fall through */
>        default:
>                return iscsi_session_get_param(cls_sess, param, buf);
>        }
>--
>2.17.1

Thanks.
Acked-by: Nilesh Javali <njavali@marvell.com>

