Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeBSTFW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:05:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753644AbeBSTFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:05:20 -0500
From: Josef Bacik <jbacik@fb.com>
To: Mykola Golub <to.my.trociny@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, Jason Dillaman <jdillama@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: nbd: on-the-fly resize does not work any more
Thread-Topic: nbd: on-the-fly resize does not work any more
Thread-Index: AQHTqON2e0/OBmVwdkaJU8kjmKoZNqOsF0iD
Date: Mon, 19 Feb 2018 19:04:55 +0000
Message-ID: <AE8A8EC3-1A09-4257-AA6F-9C35B16C9A29@fb.com>
References: <20180218180744.GC28602@gmail.com>
In-Reply-To: <20180218180744.GC28602@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2600:387:2:813::70]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1481;7:U29AzXouWzVaiySy4U77pMrntafNWgPmMZKQGCJrCOjMIGMCTILjbewQJ2VnBAIdpfKpEoSewZKXN8VDlYN+OTr4YKQoAfAnMjiFg6+1cDB5wLprjXO2qt0DomNbUymjJEb/GLl7zpNZ4g/qdwIOH0YLms0uPdRoCfKAsX+7nSvGOgZD+LyhfuhXYTiAARRgV06YCm4CkmCGXOOffwHJLhjvfqM+EtOIvNTgYsFwOHiqSNRAfoZe0sBrV/bKBnTm;20:E3uKC6H7ciQaSTjuQtKUBGAu5bDp5ZCQkN/IERwdryMqx0LTKSOZmrmKPoQB6rVhhFXTQSibmJRmgJy5MLboC1hNltA02bRrmJTkLijkQ15LcHMsxOIgH2ZIpqH+CbXSad+GhQq9kLIBykJ+SH4x56870H8XWdCknmlMtxxdx9s=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: eda59c8f-388f-4c96-8e44-08d577cbaa3f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1481;
x-ms-traffictypediagnostic: DM5PR15MB1481:|DM5PR15MB1481:
x-microsoft-antispam-prvs: <DM5PR15MB1481A5A343767B94B128AD5DB9C80@DM5PR15MB1481.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(11241501184)(944501161)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR15MB1481;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1481;
x-forefront-prvs: 0588B2BD96
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(396003)(39380400002)(366004)(39860400002)(376002)(189003)(199004)(81156014)(25786009)(7736002)(229853002)(8936002)(33656002)(5250100002)(9886003)(82746002)(8676002)(81166006)(305945005)(39060400002)(4326008)(6916009)(5660300001)(2950100002)(3660700001)(3280700002)(105586002)(5003630100001)(6116002)(106356001)(2906002)(6486002)(2900100001)(53936002)(6246003)(6436002)(6306002)(6512007)(68736007)(99286004)(14454004)(186003)(76176011)(86362001)(83716003)(478600001)(53546011)(6506007)(36756003)(102836004)(97736004)(966005)(316002)(54906003)(31884003)(239114005);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR15MB1481;H:DM5PR15MB1434.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iekqIySJiHXPPtlCVCYikIOFNBFDjIufccACXosEnr7tnm1aC3Fy+lHffTGA1ph2qmoZV9IVgjBGwmV9ulLMGktTJleLnZ5iX6YG1MI0LnXPsxdvsUiJZkscXQyHfhoVypJKyJ7b5CgvhcIkJqZPk6MljMhEUohF7ZFymGmtff0=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eda59c8f-388f-4c96-8e44-08d577cbaa3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2018 19:04:55.7870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1481
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1JJ5R9I024658

Yeah I fucked that up, I’ll fix it when I’m back from holiday tomorrow.  Thanks,

Josef

Sent from my iPhone

> On Feb 18, 2018, at 1:08 PM, Mykola Golub <to.my.trociny@gmail.com> wrote:
> 
> Hi,
> 
> It looks like after the recent changes to nbd driver, on-the-fly
> resize has stopped working for rbd-nbd. Particularly this change [1]
> breaks how NBD_SET_SIZE is used for rbd-nbd on-the-fly resize [2].
> 
> Could this be fixed?
> 
> [1] https://github.com/torvalds/linux/commit/639812a1ed9bf49ae2c026086fbf975339cd1eef
> [2] https://github.com/ceph/ceph/blob/483f14c/src/tools/rbd_nbd/rbd-nbd.cc#L488
> 
> -- 
> Mykola Golub
