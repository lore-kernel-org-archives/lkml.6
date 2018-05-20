Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeETOV7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 10:21:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29360 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeETOV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 10:21:56 -0400
X-IronPort-AV: E=Sophos;i="5.49,423,1520870400";
   d="scan'208";a="181691056"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "shaik.ameer@samsung.com" <shaik.ameer@samsung.com>
Subject: Re: [PATCH V3] scsi: ufs: Add specific callback for setting DMA mask
Thread-Topic: [PATCH V3] scsi: ufs: Add specific callback for setting DMA mask
Thread-Index: AQHT7+Nquj1CD2u830CMAE6/PI3mJKQ4rAIA
Date: Sun, 20 May 2018 14:21:51 +0000
Message-ID: <c9b0e89069769a093e07ac911f3a9019d1da32c1.camel@wdc.com>
References: <CGME20180520023633epcas2p333689dfc3c9f94c15018e33f69c751cb@epcas2p3.samsung.com>
         <1526783057-16620-1-git-send-email-alim.akhtar@samsung.com>
In-Reply-To: <1526783057-16620-1-git-send-email-alim.akhtar@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [67.180.189.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0721;7:zS74MjbAagy9DBHovpnp6PQyYzdkwdz1QNGjA+Ppia3YJZKUPyalhqdGJUEamp5yRHmWi4okoDjollkNuu7fByjUS3HVYdZSsJr2yUy47d3A65LSvpavtmL3GvnNwJNRKzrlohu0vxqWOuxLJ5ivBC2sYFFJgdxAEUK1TU5T0KBPsjVfcZEjO4eSt94tKcEaGOgFPQm1wwHHi7UZf7+DY/qvH6e24qRjj/vM9aBLJMZoQzBl1PGrDJVrRloindQE;20:Nd7KzDLIZ6GFkjbK579wezG2zG3u6EoSiYe7i1UotXxDu+0veL4ophQHTZVEmESjxKzdxRtdp1gl7yifT/zXsYRMMLR4sKhsTav635Eh176BqTEni4e8gGa5yDkIxax7sqX7xy+25Bw91XJzQg8/KESoW3Y+tKgCXulQAs3RdcQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0721;
x-ms-traffictypediagnostic: MWHPR04MB0721:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07214E331EF07C63FB4F29C898960@MWHPR04MB0721.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0721;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0721;
x-forefront-prvs: 06780E24F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(39860400002)(396003)(189003)(199004)(377424004)(66066001)(25786009)(99286004)(54906003)(6116002)(110136005)(316002)(105586002)(3846002)(14454004)(2906002)(118296001)(7736002)(186003)(5660300001)(76176011)(478600001)(72206003)(305945005)(81166006)(36756003)(26005)(8676002)(6506007)(102836004)(68736007)(2201001)(8936002)(81156014)(53936002)(3280700002)(486006)(446003)(39060400002)(6246003)(86362001)(6486002)(6436002)(97736004)(229853002)(6512007)(3660700001)(2900100001)(4326008)(106356001)(5250100002)(2501003)(2616005)(11346002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0721;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RiBAC4Nmj8G6nYALDFK3gXiGxzjBgVoszCR07ZSb96L4fR8P6tfUyYPpdzLvM6yKUTAbfrz16IaS0y0xBZbaUAchFw76BRA/KnD+RK9wVFCeUGJE5QECGHasxkZOjIEsEN9zvFSLbPOsayMJhb8YsNnQhCWKoM7VU0zhRVKtSzdTaMnxDV96kUTqvnupZSAH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE05F6E1EBFCF64B980C28E8C3CCB81E@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e89b1fc7-e792-42ec-49ad-08d5be5d081e
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89b1fc7-e792-42ec-49ad-08d5be5d081e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2018 14:21:51.8200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4KEM7Fj020588

On Sun, 2018-05-20 at 07:54 +0530, Alim Akhtar wrote:
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index a355d98..9a1374e 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -7781,6 +7781,9 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
>   */
>  static int ufshcd_set_dma_mask(struct ufs_hba *hba)
>  {
> +	if (hba->vops && hba->vops->set_dma_mask)
> +		return hba->vops->set_dma_mask(hba);
> +
>  	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
>  		if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
>  			return 0;
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 1332e54..89c6dae 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
>   * @resume: called during host controller PM callback
>   * @dbg_register_dump: used to dump controller debug information
>   * @phy_initialization: used to initialize phys
> + * @set_dma_mask: used to set variant specific DMA mask
>   */
>  struct ufs_hba_variant_ops {
>  	const char *name;
> @@ -325,6 +326,7 @@ struct ufs_hba_variant_ops {
>  	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
>  	void	(*dbg_register_dump)(struct ufs_hba *hba);
>  	int	(*phy_initialization)(struct ufs_hba *);
> +	int	(*set_dma_mask)(struct ufs_hba *hba);
>  };

I want to see the code that sets the .set_dma_mask callback function. Where
is it? If it is outside the upstream kernel, please consider to send it
upstream before making changes like this. Adding support for out-of-tree
kernel code is frowned upon big time in the kernel community.

Bart.
