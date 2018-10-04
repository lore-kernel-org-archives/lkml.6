Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AF3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D45206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="ks1fY0fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D45206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJDXkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:40:39 -0400
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:31269
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeJDXkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHPaL6PtVzXI324S+eDAn+3ytzw6yJx5chkdntCE0Hk=;
 b=ks1fY0filDRoICQhLe/yr4v+GB7JMNu7K1tsK+KVFYaCz2WeJFw9/O0Ah5k96Bh4htu9ipYdqUNsdOqWIiKmLX6f9B+tMClTNviTe/c0dVMHrXfqjg44WmCoiSaPNHYDbgc5f32JAs7j3kPPspdqhkFKYKC1QHcmBA2tG/P3uDo=
Received: from CY1PR07MB2554.namprd07.prod.outlook.com (10.167.16.21) by
 CY1PR07MB2347.namprd07.prod.outlook.com (10.166.194.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Thu, 4 Oct 2018 16:46:31 +0000
Received: from CY1PR07MB2554.namprd07.prod.outlook.com
 ([fe80::d38:17f1:bc0c:5643]) by CY1PR07MB2554.namprd07.prod.outlook.com
 ([fe80::d38:17f1:bc0c:5643%4]) with mapi id 15.20.1185.026; Thu, 4 Oct 2018
 16:46:31 +0000
From:   "Tayar, Tomer" <Tomer.Tayar@cavium.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
Subject: RE: [PATCH v2] qed: Avoid implicit enum conversion in
 qed_ooo_submit_tx_buffers
Thread-Topic: [PATCH v2] qed: Avoid implicit enum conversion in
 qed_ooo_submit_tx_buffers
Thread-Index: AQHUXAEKHUHyNNXBEE2AFGWeeEnGFKUPSzJg
Date:   Thu, 4 Oct 2018 16:46:31 +0000
Message-ID: <CY1PR07MB2554A3689F2690F70366CA7180EA0@CY1PR07MB2554.namprd07.prod.outlook.com>
References: <20181004000912.22242-1-natechancellor@gmail.com>
 <20181004163919.13972-1-natechancellor@gmail.com>
In-Reply-To: <20181004163919.13972-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tomer.Tayar@cavium.com; 
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR07MB2347;6:eGLlt4+NbE7oZoo6U/TxiHoUBeE1JzXolpQSrNNuKLnswn3JSbH+PTMzSOHTRl9lK9wYMTj8WouA3dszAy0K8Xu05ti8U1aARVS0+PXU5AM3cY2UNE86mno6fAciNKg4SLxMe/MYqCJj3IGrNuhoxgWNNnIFaLosJy/8K4hF4edoyLIuqid/YgEwGzktCvyn+v2aA6ef7ZZ23n/Xmi4AU6G8C0BE+W8qnR2MJI1VNV5byF1Z8mDxe0TDzhWfV6b1DDpNz2qLfi6mzT3B78H39FFKvk9VgEaqnrZgY01gWtLhTPHBEcVAQ1pCleo2XcsZ4WwVy7LjdJhYfbG1Gzj/a5K8aYIwnbYV/GF2rFQ+GW96aOMNV0oH8OGxWvd88iMDok66L8yQWh3m/N1XrpzkV01d9Aoww69wza89+7eZhjYGJyZPp4kJ91yyZw87GHNkAIMkS3Jp9OcIhSJWVL4O0g==;5:poYKYvnKzA80oRf4EYxin7poeSS5h6f2b9pRjGF1WLq8whUKvHjiVAAYsaYkISqsLihxfny2xwJCoX/xDoAANiJB/FGblXIXJK9k7vbx+KaXGjwIC/REL5jOf5cIean1Vj3XtBD/HqJlGlnn9xqk7PKCoKJ68NS8jWmrqfOShAY=;7:MI2Zi1i//m7FrjTsTM723hJ2KyvLaEetfxKpTctbk5LCH8eSyL/HihnQrFrd576Ysya7RmkGcehU306bTnHn715da2r04/YEtTrUoe51TbIl6CdwMhMGSRWxPMaXjSFDf7cZ3VcbtznV0ET3jX319jJ2KXNcjSCDx72XMP9WOc6vTrcowueqriSQUm4q7XOmv2aiT1kYoJKG7mW7GIV9/8ubbpzMZTkzRZcU7mhmrkUm8LUqRHzEVBWaSBzcbM9L
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 9292ca05-da4e-41c3-1bc9-08d62a18f02c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR07MB2347;
x-ms-traffictypediagnostic: CY1PR07MB2347:
x-microsoft-antispam-prvs: <CY1PR07MB23479A969AE14E37B9835B5480EA0@CY1PR07MB2347.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302088)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:CY1PR07MB2347;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2347;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(68736007)(486006)(14454004)(6116002)(8936002)(2906002)(3846002)(33656002)(71190400001)(6506007)(26005)(229853002)(66066001)(7696005)(256004)(102836004)(5660300001)(110136005)(6246003)(71200400001)(76176011)(54906003)(14444005)(316002)(53936002)(305945005)(7736002)(55016002)(4326008)(39060400002)(107886003)(478600001)(966005)(476003)(9686003)(72206003)(446003)(86362001)(25786009)(6436002)(11346002)(99286004)(2900100001)(74316002)(106356001)(81166006)(8676002)(97736004)(186003)(6306002)(81156014)(105586002)(5250100002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2347;H:CY1PR07MB2554.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +QR4XecLm9t8qmM0PADrkkgFAansRLdB+qAnnNbHd+7a61osuqmqAUkSS0oI28r3G+bKbarNOYU4iOPb9cp/5QEOK5Pm15GpxV19Hs3U+PW7Dc3e5LzdjpGJmqXztKfeY6ZuOqtQ8uMou4wnKvD0zxSLBuD4lkhGnb2RDOxiee4cCcCb5oOM5maTGl90+l2KUAZsgpVduav7sV+10p3TIrWL+XBzXXm2Y3R96yokdGiCBJj+0/WAsMiSND3OsLF4GtbV1bJGR4gqcNQP42Ot9bg2BP86gTQ4rl3sgDCLUzXE8OBxapdl2Ud/r0AQ3YSwODQO+kUkzzORWsOepIirkP6ed3dmNwYogzXDmlRmvss=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9292ca05-da4e-41c3-1bc9-08d62a18f02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:46:31.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2347
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Sent: Thursday, October 04, 2018 7:39 PM

> Clang warns when one enumerated type is implicitly converted to another.
>=20
> drivers/net/ethernet/qlogic/qed/qed_ll2.c:799:32: warning: implicit
> conversion from enumeration type 'enum core_tx_dest' to different
> enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
>                 tx_pkt.tx_dest =3D p_ll2_conn->tx_dest;
>                                ~ ~~~~~~~~~~~~^~~~~~~
> 1 warning generated.
>=20
> Fix this by using a switch statement to convert between the enumerated
> values since they are not 1 to 1, which matches how the rest of the
> driver handles this conversion.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/125
> Suggested-by: Tomer Tayar <Tomer.Tayar@cavium.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>=20
> v1 -> v2:
>=20
> * Use an explicit switch statement to convert between the enumerated
>   types like the rest of the driver, as suggested by Tomer.

Thanks
Acked-by: Tomer Tayar <Tomer.Tayar@cavium.com>
