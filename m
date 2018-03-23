Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeCWJv4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:51:56 -0400
Received: from mail-he1eur01on0073.outbound.protection.outlook.com ([104.47.0.73]:36731
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752413AbeCWJvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:51:54 -0400
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: David Miller <davem@davemloft.net>
CC: "geert.uytterhoeven@gmail.com" <geert.uytterhoeven@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fsl/fman: remove unnecessary set_dma_ops() call and
 HAS_DMA dependency
Thread-Topic: [PATCH] fsl/fman: remove unnecessary set_dma_ops() call and
 HAS_DMA dependency
Thread-Index: AQHTwPNM6OcA5dkOCUiRR7/SybW65qPcljmAgAD/rLA=
Date: Fri, 23 Mar 2018 09:51:51 +0000
Message-ID: <AM5PR04MB3267DB8FE8E5AE98F59D7C45ECA80@AM5PR04MB3267.eurprd04.prod.outlook.com>
References: <20180321085819.23249-1-madalin.bucur@nxp.com>
 <20180322.143159.2085752623277697593.davem@davemloft.net>
In-Reply-To: <20180322.143159.2085752623277697593.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR04MB2962;7:am4QEzyquAd6BQQGSgBjvh2bvaURWY9Dy2H4lw7jr9usP5MQDq3CZmQtmc99P1fIfgJUa+n8klv3aS3AdtK5RQEcSaLZ0JlSkEtfDyli4sudgze3DymeJqABjtPMY94wpPFWbh0RaRNYPuNwtKnAswdH+yNi0o4MpzWQ6Sc0qCkXy1bX5p7THkVO/6X4p2PQ6kDZ/S6v8QC3pRE5v0VfqgXhBZ/NMpM6npV+I6dERWpB4pMv2vxrhz+ovDQAvDwi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2c2da43-cc2a-4650-471e-08d590a3b3d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB2962;
x-ms-traffictypediagnostic: AM5PR04MB2962:
x-microsoft-antispam-prvs: <AM5PR04MB2962F7A0B563F3AE081178BAECA80@AM5PR04MB2962.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR04MB2962;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB2962;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(39380400002)(376002)(13464003)(189003)(199004)(6116002)(2906002)(68736007)(105586002)(53936002)(229853002)(4326008)(3846002)(9686003)(25786009)(6916009)(2900100001)(14454004)(6246003)(97736004)(11346002)(55016002)(5250100002)(106356001)(8936002)(81166006)(81156014)(5660300001)(66066001)(3660700001)(305945005)(8676002)(39060400002)(3280700002)(7736002)(33656002)(74316002)(7696005)(26005)(6436002)(99286004)(76176011)(86362001)(186003)(6506007)(102836004)(316002)(54906003)(53546011)(478600001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB2962;H:AM5PR04MB3267.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 05tGHmtTOZgDsEpmVBdnE3P4HHx+HTU/Ozkr3gAaclpRJCY7OVLAU4ib/MyCJl+HiWJYiX99nBZr+nxgkthgmKA5gGkYu7a3M5TYq1GSzXiM7b8q85hw9Bm8Q7/vaOp/h0eDsMKMco69H+G92OhaL6x0aepUkXz9vqNesFrd5jPsfA6ReCMqrIhnV8rHi+73cm9gQ34ZaRYAroKmB6q7043JgB5qR2PQuPM4c4kzN+mABDgx96+uFYAKg0BBe6i2u7EnJCkII/LRBmUrFvAfJw9rb1XPCi4m4Xj6jti4mYvG65oLnEQ4QR05HHHZUxqBtdAoLNQ89hPUD46sbBnqIg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c2da43-cc2a-4650-471e-08d590a3b3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 09:51:51.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2962
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2N9pxXJ010915

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Thursday, March 22, 2018 8:32 PM
> To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> Cc: geert.uytterhoeven@gmail.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] fsl/fman: remove unnecessary set_dma_ops() call and
> HAS_DMA dependency
> 
> From: Madalin Bucur <madalin.bucur@nxp.com>
> Date: Wed, 21 Mar 2018 03:58:19 -0500
> 
> > The platform device is no longer used for DMA mapping so the
> > (questionable) setting of the DMA ops done here is no longer
> > needed. Removing it together with the HAS_DMA dependency that
> > it required.
> >
> > Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> 
> This doesn't apply to any of my trees.

Sorry, it's caused by a patch in my tree that adds ARM 32b support, resulting in differences
in the context:

-       depends on FSL_SOC || ARCH_LAYERSCAPE || COMPILE_TEST
+       depends on ARM || ARCH_LAYERSCAPE || FSL_SOC || COMPILE_TEST

I'll send a v2 based on a clean tree.

Madalin
