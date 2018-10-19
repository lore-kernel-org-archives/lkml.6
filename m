Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82190ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9D521486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kWv8Ribu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9D521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJSSmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:42:46 -0400
Received: from mail-bl2nam02on0078.outbound.protection.outlook.com ([104.47.38.78]:16608
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeJSSmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtDG62bfEbkCeE7xQbyl/ARqqeuJHYLP1Lp69lrHG5Y=;
 b=kWv8RibugfeYV73/iirMxHUgVw3kdZ4KKwuem3Z6tYSKYLV+s3RUhWqCj09Vw7waRgtN1E5bl3v+YTYQnsk3pOKehUyAHHE52UW98vEPeKIptmVLs8FCgHijcerttXIfGKrFcBkzX5oiG9eHFWo8P7qDzZ6VYBo5OqrqbfbimiE=
Received: from DM5PR02MB2187.namprd02.prod.outlook.com (10.168.173.137) by
 DM5PR02MB2571.namprd02.prod.outlook.com (10.168.195.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Fri, 19 Oct 2018 10:37:11 +0000
Received: from DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::3df2:4226:79e9:b964]) by DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::3df2:4226:79e9:b964%4]) with mapi id 15.20.1250.028; Fri, 19 Oct 2018
 10:37:11 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] dmaengine: xilinx_dma: Introduce helper macro for
 preparing dma address
Thread-Topic: [PATCH v2 3/4] dmaengine: xilinx_dma: Introduce helper macro for
 preparing dma address
Thread-Index: AQHUWBhsEsrIlZ0TXUyIc+bUsfjni6Umfblg
Date:   Fri, 19 Oct 2018 10:37:11 +0000
Message-ID: <DM5PR02MB21878ECD3C2B2E4535F2244FDCF90@DM5PR02MB2187.namprd02.prod.outlook.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1538241480-13844-4-git-send-email-radhey.shyam.pandey@xilinx.com>
In-Reply-To: <1538241480-13844-4-git-send-email-radhey.shyam.pandey@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR02MB2571;6:a1PdMN407WJ7usaUaIm2L7gEo585W1VjyJmr1gmuborKMVeUdvkQfkOzqcf3hPH72To1yZg2oMlrdMZgYHA0lZbhvZlEP01yTlirVExGVBjB24LbMEu74PZQjUQRy0SrRv/t0PBKaDZelLMktnCIgGH0ybP+P2gj7cPG5FcErNGzBNsCaeKuNgyDToGcjZSFgJHUgDPbKPHdzEe9DphCX+EsoMuq5ARnBXsE0KLbxUOf6SmcvJmArbsNlsiPUVx2EdoUG+0bcOqJqlKcE5hJ0dUsF5oGdF9K/K0xYUPak6kkTg7zNjynxkHd1wmzzt+4oVnqidl/BiEvNpOabol5Ft88WZdEOwqRAGKuVVbwdm+PPUVzrSEGGWYUSpQkIGGg6uo3VQB+V27Uk2YYp5CqQnyu9/dVx1+U5AnaCrntiKdaBWjmCvBtXo1SMQhhZjqDhumRSudn3NdMkPQYmz/qaA==;5:b3nxjVvB6JK53ivHKDJxIyfKSI/khq2HS0g0lDUMBM/3MeLGc+gjQ2TAvf+bIYyEPrAxWhFVO9edh/+Enh9+YPWSTvx0a/pQxiuDbGL/itJE08zUBqOjYA8riTuihmwf5M1wG/TjC9K1PA/Kff10an+RW4q86+vKhsa9/M6S388=;7:w/PhDX2vRhbfpCJze7j6oqGPRQUPq+d9uN1Vpu+2EG+gbeCqvGUR5yQvDp4nFhP9k2bh568KXONvtF4N9LRZLasL4gtjx+2EoDQk6x2fohe/Lj6O0kjm5TInHoUZvlhuCt8tpRg6cEoo9B2gbYh94vslkOvuVFt0Noc7eBMDCjMRQGKcQewuVdGBr7QU+AbHWyK6UPU/AhnKx17XEdW7zHuDT1hWXNQY9JAYHoroRqpQj0p3y8qMDPDsmga6FmQH
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 71ad4937-f388-4679-70e4-08d635aed40e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB2571;
x-ms-traffictypediagnostic: DM5PR02MB2571:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB2571CC3CD654A094BC933A06DCF90@DM5PR02MB2571.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR02MB2571;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2571;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39850400004)(396003)(376002)(346002)(51914003)(189003)(199004)(66066001)(6436002)(6246003)(256004)(55016002)(9686003)(53936002)(486006)(86362001)(2201001)(446003)(11346002)(476003)(105586002)(97736004)(106356001)(2501003)(5250100002)(7696005)(6506007)(102836004)(76176011)(99286004)(229853002)(5660300001)(6636002)(478600001)(305945005)(74316002)(7736002)(14454004)(68736007)(4326008)(8936002)(316002)(3846002)(6116002)(2906002)(54906003)(110136005)(186003)(33656002)(71200400001)(71190400001)(26005)(2900100001)(81166006)(81156014)(8676002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2571;H:DM5PR02MB2187.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YGRFjrycjOPVAsdDkoVJWUkS6P55YdkMw7ADSTLvjtPB3jeXGU158KnWD4DhG1kTcGQJoJMB2SlwDMlVvazSSNXC5kDFPm0eidfdgRYeTE7iSqXRQBxW9OwxKUGszVDFbIJw0GSWClWomu5PdQxIcUyfsTntrYa3NzCvF3C2+bSLeHsYNCgujzrizQMk26JZSZYJXLqsnlK5iPl7AHzDyaFveDX3jV65yfXQCaQST3QHTEFhLcNtN3+YNSSQMxCvMTHjQ34bkYufh/PnEt9en69LOpeuIFRmUNOto/aVlr0Y1IRBSCLjLs1VaZ7XBV7toBwLHPhOTtU1jBCM+Kn/6FtXf05RXEU6zryx1yryhAA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ad4937-f388-4679-70e4-08d635aed40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 10:37:11.7332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Thanks for the patch...

>=20
> This patch introduces the xilinx_prep_dma_addr_t macro which prepares
> dma_addr_t from hardware buffer descriptor LSB and MSB fields. It will be
> used in simple dma 64-bit programming sequence.
>=20
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Reviewed-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>

Regards,
Kedar.

> ---
> Changes for v2:
> New patch- Preparatory change for 4/4 fix.
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index a37871e..c27ab64 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -190,6 +190,8 @@
>  /* AXI CDMA Specific Masks */
>  #define XILINX_CDMA_CR_SGMODE          BIT(3)
>=20
> +#define xilinx_prep_dma_addr_t(addr)	\
> +	((dma_addr_t)((u64)addr##_##msb << 32 | (addr)))
>  /**
>   * struct xilinx_vdma_desc_hw - Hardware Descriptor
>   * @next_desc: Next Descriptor Pointer @0x00
> --
> 1.7.1

