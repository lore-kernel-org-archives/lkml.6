Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F38FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E898C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="O13hdb4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbeFTNmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:42:45 -0400
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:56277
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753541AbeFTNmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JorJVG1G9azWZ04LP4JgcXAHhrmyLeGF2u/q1EpXI3o=;
 b=O13hdb4XvzMfbyzxUyTdRbhtg02QmN7oBDayaWVNwWm6Kvkt6AOVfi+3irDFuhH4SkVnGPZ0wNNObWx2qAzKOZLCIM2VfXYT6Fd8/iZv3tUiApRqKx2zxOZvhToITkw/xlcZXvBMJdFpFvH3rUHmdEIMwwFbmSng4yaGGHTEjAY=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB4060.namprd02.prod.outlook.com (20.176.75.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Wed, 20 Jun 2018 13:42:40 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 13:42:39 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Andrea Merello <andrea.merello@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] dt-bindings: xilinx_dma: add required
 xlnx,lengthregwidth property
Thread-Topic: [PATCH 3/6] dt-bindings: xilinx_dma: add required
 xlnx,lengthregwidth property
Thread-Index: AQHUCHIrvuKZvaHuh0+cb/F15/qdLKRpF5lA
Date:   Wed, 20 Jun 2018 13:42:39 +0000
Message-ID: <DM6PR02MB43610E55E255E9DA5B9E4630C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-3-andrea.merello@gmail.com>
In-Reply-To: <20180620083653.17010-3-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4060;7:T92faMPLYS13H8nd6zYOwGvb9hbnDi8wVw+Oki8piX4gYZNMvq8aEmvoFFP9O7O5O9Wnet9i0FG5trDh0QBrBEHmTxRf57O+RAjOHOcVMskyIqw1UmvjcFSHOkzDNCARKB6PT97NXJDr1eJOsCWETfzNIQTY/sKVmbzSnPLEf9Y/7OjAn4bpVCA6wRv7J2VzMEAzsKHi5Wc17Gcl58IrRVV6bKh3piW1zsM7K3CEJgcvbXJYS2cY9fscF679EOGi
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39380400002)(39860400002)(346002)(189003)(199004)(13464003)(229853002)(39060400002)(25786009)(486006)(4326008)(76176011)(66066001)(7696005)(33656002)(106356001)(68736007)(55236004)(53936002)(2906002)(105586002)(6246003)(102836004)(11346002)(53546011)(6506007)(476003)(5660300001)(446003)(99286004)(2501003)(9686003)(110136005)(54906003)(316002)(7736002)(305945005)(74316002)(5250100002)(966005)(8936002)(478600001)(8676002)(6306002)(14454004)(2900100001)(97736004)(55016002)(6436002)(81156014)(81166006)(86362001)(2201001)(3846002)(3280700002)(186003)(26005)(6116002)(3660700001)(142933001)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4060;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ffbbba6f-8f47-421b-4a57-08d5d6b3b0dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4060;
x-ms-traffictypediagnostic: DM6PR02MB4060:
x-microsoft-antispam-prvs: <DM6PR02MB40603E53C9FEB36DC058463BC7770@DM6PR02MB4060.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4060;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4060;
x-forefront-prvs: 070912876F
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: orBfTI4cTv8YHX/9ZX5HtA6Yrzy1OvnhMvyLR3WBlgY3GZa6xJ9F7cdefim7Heehn11PtL2O0Opm04EPy/CMqPqXyexaV/WxypdQ3rkFy9NHi9IFcT3qbyWt6BcIudc+R5TwvBx2rr/A6VXS6i7wTHGxj7lg89qUUt3AVw8cu7GpFtRIhefkqP4k6p1y0xDdMMmWt+tjDy91NDkALtfB3SokB7VMlOjuVAnUX0VA4oLRbBUfRw3SvE+Qb9aPIFu/9ZJqY8s3eS/HV0rOUQfAy4PYQsgXRnbn7aWPFpOOQjTt0U6PmbaZ6v7fhzNjOVQ8gUC8Nfj3/IeFgrbtBXAaFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbbba6f-8f47-421b-4a57-08d5d6b3b0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 13:42:39.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: dmaengine-owner@vger.kernel.org [mailto:dmaengine-
> owner@vger.kernel.org] On Behalf Of Andrea Merello
> Sent: Wednesday, June 20, 2018 2:07 PM
> To: vkoul@kernel.org; dan.j.williams@intel.com; Michal Simek
> <michals@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Andrea Merello <andrea.merello@gmail.com>
> Subject: [PATCH 3/6] dt-bindings: xilinx_dma: add required
> xlnx,lengthregwidth property

dt-bindings: dmaengine: xilinx_dma

Please also include DT folks.
>=20
> The width of the "length register" cannot be autodetected, and it is now
> specified with a DT property. Add DOC for it.
>=20
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index a2b8bfaec43c..acecdc5d8d47 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -36,6 +36,8 @@ Required properties:
>=20
>  Required properties for VDMA:
>  - xlnx,num-fstores: Should be the number of framebuffers as configured i=
n
> h/w.
> +Required properties for AXI DMA:
> +- xlnx,lengthregwidth: Should be the width of the length register as
> configured in h/w.

One suggestion to be inline with IP property naming we can rename=20
this prop to "xlnx,sg-length-width"? Please take a look at Xilinx tree
we have this feature added in the master branch. It would be good
to consolidate both implementations and upstream. Let me know=20
if there are any followup queries.=20
=20
>=20
>  Optional properties:
>  - xlnx,include-sg: Tells configured for Scatter-mode in
> --
> 2.17.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

