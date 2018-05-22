Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeEVHDv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:03:51 -0400
Received: from mail-ve1eur01on0080.outbound.protection.outlook.com ([104.47.1.80]:6176
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751069AbeEVHDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:03:48 -0400
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Nipun Gupta <nipun.gupta@nxp.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC: "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH 6/7 v5] bus: fsl-mc: set coherent dma mask for devices on
 fsl-mc bus
Thread-Topic: [PATCH 6/7 v5] bus: fsl-mc: set coherent dma mask for devices on
 fsl-mc bus
Thread-Index: AQHT8EGRtaC6I2rjGkqOFzqgjiwk9KQ7VYgA
Date: Tue, 22 May 2018 07:03:44 +0000
Message-ID: <5B03C0D0.1090609@nxp.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-7-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1526824191-7000-7-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3809;7:ZfcYfyhlGGjYoPrEOQ0j4rqy4UuElG4Ztjz59agLRCE+REAMgLfZwJheb3Z5GHaNOEBDobWeHhXPShbTngIhYAVhEilneCe3MX+8MCY64X2b6u7G+Orbtj3qfDtRS9Pla4xRRMXn/DzxHcvSAgyMZMovy+QcstkkCYGnF1ikWXCTybax6xEvHHhvighpyxfvxP6qh0sPBKCtZ0jUEUIQB0zs4SC/zV+Kcoa4APqLjre1LmZpRroPep46NdAjSVVY
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3809;
x-ms-traffictypediagnostic: AM0PR0402MB3809:
x-microsoft-antispam-prvs: <AM0PR0402MB3809F90759D51F2F66824C1AEC940@AM0PR0402MB3809.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0402MB3809;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3809;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39380400002)(396003)(39860400002)(199004)(189003)(6506007)(26005)(2201001)(3660700001)(3280700002)(102836004)(486006)(2906002)(6512007)(229853002)(6436002)(53936002)(476003)(53546011)(2616005)(446003)(3846002)(6116002)(11346002)(86362001)(5660300001)(8936002)(81166006)(81156014)(8676002)(2501003)(99286004)(76176011)(87266011)(65816011)(5250100002)(316002)(44832011)(7416002)(7736002)(305945005)(54906003)(110136005)(68736007)(66066001)(106356001)(105586002)(478600001)(97736004)(14454004)(25786009)(33656002)(4326008)(6246003)(39060400002)(6486002)(80316001)(59896002)(2900100001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3809;H:AM0PR0402MB3860.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pbJ50Fw/8LbhSp34nHedVT7QtDxr1XfQCSFi+xN2MbBWEdplFMHEKN8gvfY4VKduEMB5TyE245TVso1TjzQRqm8/fDZOmbSxaUXzurvcNWXYOhV5u2Pu/NMo3HQvNFI0TKtvWo+L28vT7bHMk86ukThvK+Vb7a+GroJr43i/3atmwVS43jotCnVt/PN48F80
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FB70176499E51542B41B9AB282AF31C3@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a8f63d85-09fc-45e2-b3b6-08d5bfb228bf
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f63d85-09fc-45e2-b3b6-08d5bfb228bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 07:03:45.0435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3809
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4M73uJa012583



On 05/20/2018 04:49 PM, Nipun Gupta wrote:
> of_dma_configure() API expects coherent_dma_mask to be correctly
> set in the devices. This patch does the needful.
>
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>

Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index fa43c7d..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -627,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>   		mc_dev->icid = parent_mc_dev->icid;
>   		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
>   		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
>   		dev_set_msi_domain(&mc_dev->dev,
>   				   dev_get_msi_domain(&parent_mc_dev->dev));
>   	}
>
