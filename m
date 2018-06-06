Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pt7V8MoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FF076070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeFFKXm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:23:42 -0400
Received: from mail-he1eur01on0052.outbound.protection.outlook.com ([104.47.0.52]:36053
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750972AbeFFKXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:23:40 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [upstream-release] [PATCH] irqchip/ls-scfg-msi: map MSIs in the
        iommu
Thread-Topic: [upstream-release] [PATCH] irqchip/ls-scfg-msi: map MSIs in the
        iommu
Thread-Index: AQHT/Mih0MoTX0EdZEikhL0A/sqXxaRTBiIQ
Date: Wed, 6 Jun 2018 10:23:37 +0000
Message-ID: <HE1PR0401MB2556E56AA3E9887262D400019A650@HE1PR0401MB2556.eurprd04.prod.outlook.com>
References: <20180605122727.12831-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20180605122727.12831-1-laurentiu.tudor@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2042;7:T0274fLQUbjhdQM7lH/fuyNjSZuLQOgfzs+T2Bx48j2pZkajGr5Dq4qjVxrltl9DkYNNPqoW2WPvMo2TUDz1NDUMR/7/BdbBGlfiBXaVku7cnWnGQ4R/XS+VuDfVa54n8jVKy4MX7ude/kggZuTv0xKjLXjVjCGWkua/aN7+I9sepwEsPVQKnWdU5HKKlb2bRmtmxcHjcGp2HOp2YFZDZ1Z/BLWmNfJERktjbc2b2KJRDr/t6HcOrGNFpefu9zZ1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2042;
x-ms-traffictypediagnostic: HE1PR0401MB2042:
x-microsoft-antispam-prvs: <HE1PR0401MB20425B536AB6BB9E63A9F7589A650@HE1PR0401MB2042.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2042;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2042;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39860400002)(396003)(366004)(13464003)(189003)(199004)(2201001)(6246003)(55016002)(102836004)(2906002)(6506007)(478600001)(26005)(8936002)(305945005)(66066001)(33656002)(7736002)(76176011)(476003)(53546011)(316002)(446003)(74316002)(105586002)(68736007)(3660700001)(14454004)(11346002)(54906003)(3280700002)(110136005)(106356001)(966005)(99286004)(81156014)(2501003)(81166006)(5660300001)(44832011)(486006)(6436002)(229853002)(2900100001)(45080400002)(3846002)(6116002)(97736004)(25786009)(9686003)(7696005)(4326008)(86362001)(575784001)(6306002)(53936002)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2042;H:HE1PR0401MB2556.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6AuD/A2fa6wqitIc30kRVAZmGYcNvvqkY+A7QBSNPKIlXlHqeoyg1hUkm1ItzaI+/ZTt+16eehRDJ9LQaO0zLpP6BVcKA0n2nQO1mRarrWrrx+LMBbyJIlw0nFdrtdO8KrMbAPmJ2M1mTUCnHc27cHB6qCOtKVUVuFcIzCFgp48CXO8hKeCtSl58ulzQfHpR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 282f1fbf-3dbe-4838-6608-08d5cb9790dc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282f1fbf-3dbe-4838-6608-08d5cb9790dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 10:23:37.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2042
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: upstream-release-bounces@linux.freescale.net [mailto:upstream-
> release-bounces@linux.freescale.net] On Behalf Of Laurentiu Tudor
> Sent: Tuesday, June 5, 2018 5:57 PM
> To: tglx@linutronix.de; jason@lakedaemon.net; marc.zyngier@arm.com; linux=
-
> kernel@vger.kernel.org
> Cc: M.h. Lian <minghuan.lian@nxp.com>; Z.q. Hou <zhiqiang.hou@nxp.com>;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: [upstream-release] [PATCH] irqchip/ls-scfg-msi: map MSIs in the =
iommu
>=20
> Add the required iommu_dma_map_msi_msg() when composing the MSI
> message, otherwise the interrupts will not work.
>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Reviewed-by: Bharat Bhushan <bharat.bhushan@nxp.com>

Thanks
-Bharat
> ---
>  drivers/irqchip/irq-ls-scfg-msi.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-s=
cfg-msi.c
> index 57e3d900f19e..1ec3bfe56693 100644
> --- a/drivers/irqchip/irq-ls-scfg-msi.c
> +++ b/drivers/irqchip/irq-ls-scfg-msi.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/spinlock.h>
> +#include <linux/dma-iommu.h>
>=20
>  #define MSI_IRQS_PER_MSIR	32
>  #define MSI_MSIR_OFFSET		4
> @@ -94,6 +95,8 @@ static void ls_scfg_msi_compose_msg(struct irq_data
> *data, struct msi_msg *msg)
>=20
>  	if (msi_affinity_flag)
>  		msg->data |=3D cpumask_first(data->common->affinity);
> +
> +	iommu_dma_map_msi_msg(data->irq, msg);
>  }
>=20
>  static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
> --
> 2.17.0
>=20
> _______________________________________________
> upstream-release mailing list
> upstream-release@linux.freescale.net
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flinux=
.fr
> eescale.net%2Fmailman%2Flistinfo%2Fupstream-
> release&data=3D02%7C01%7Cbharat.bhushan%40nxp.com%7Cba9303002bf142d9
> b63308d5cadfc179%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 6637984747938689&sdata=3D3Hg2OVpp%2Bhfdj0qbCFLWLwBn0RFoNhlPPdmxGf
> AspyA%3D&reserved=3D0
