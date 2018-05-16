Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeEPItH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:49:07 -0400
Received: from mail-ve1eur01on0067.outbound.protection.outlook.com ([104.47.1.67]:12608
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752575AbeEPItC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:49:02 -0400
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC: "hch@lst.de" <hch@lst.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Thread-Topic: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Thread-Index: AQHT3hJvd38tyRQBaUCUdR33NexPgaQvVeoAgALRLeA=
Date: Wed, 16 May 2018 08:48:57 +0000
Message-ID: <HE1PR0401MB24253CF729DDCF3F883AC256E6920@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-6-git-send-email-nipun.gupta@nxp.com>
 <5AF9916E.8000504@nxp.com>
In-Reply-To: <5AF9916E.8000504@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2315;7:YHoK4+P//9CmI0Rrb8CpR1LDaA5r4qv2Qp+Gca8S1MWEmnA/tEwboBzOewKU/aLoWdyPI3MUb/u7TE4d+ILHNrsR5tyDBlmqCEqyBNsnE36wthgBMYFYwPqgK5OVXpNPYWcLaRHtxzNzfSgB5e3aijzYNo+GsUuUBIIbQe9/9zli36v5imKfT7o6Uvx5tIdBJ9MPCoJ6OBSADCB/37vE3rz2PoZ+fjAN873nkdH/ryWoJOZufdM0r74yOtLTsLmN
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2315;
x-ms-traffictypediagnostic: HE1PR0401MB2315:
x-microsoft-antispam-prvs: <HE1PR0401MB231575B70BF4075297DFB6C9E6920@HE1PR0401MB2315.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0401MB2315;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2315;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(346002)(376002)(396003)(39860400002)(54094003)(199004)(189003)(54534003)(13464003)(6506007)(53546011)(6436002)(446003)(102836004)(305945005)(74316002)(6246003)(2501003)(5250100002)(11346002)(229853002)(25786009)(33656002)(6116002)(3846002)(97736004)(76176011)(7696005)(99286004)(478600001)(105586002)(2900100001)(9686003)(53936002)(106356001)(316002)(26005)(55016002)(8936002)(44832011)(486006)(8676002)(86362001)(2906002)(7416002)(5660300001)(110136005)(3660700001)(68736007)(3280700002)(66066001)(14454004)(476003)(4326008)(2201001)(54906003)(39060400002)(7736002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2315;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nuh3ndufV6N2YVEL25ZbdaPne38g1nRXDQfz+smUM6ZLtCOP84XlCSQLQwlWzveMDxgg8zET1ozs+FlZ6lrSInbxTrniwmjqWypVQfkmsNVoQtH1anXNCvt7UcRPiwZ0Es1CavJy7NbIYLB4ZnXD9mTwWT+2Gbr31reJF/YsO5bHBgyiNbKI/EoO35ZLub4B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 74650504-199c-447c-a812-08d5bb09dcda
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74650504-199c-447c-a812-08d5bb09dcda
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 08:48:57.5022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G8nEom021426



> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Monday, May 14, 2018 7:10 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>; robin.murphy@arm.com;
> will.deacon@arm.com; mark.rutland@arm.com; catalin.marinas@arm.com
> Cc: hch@lst.de; gregkh@linuxfoundation.org; joro@8bytes.org;
> robh+dt@kernel.org; m.szyprowski@samsung.com; shawnguo@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linux-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices
> on fsl-mc bus
> 
> Hi Nipun,
> 
> On 04/27/2018 01:27 PM, Nipun Gupta wrote:
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >   drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-
> bus.c
> > index 5d8266c..624828b 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev,
> struct kobj_uevent_env *env)
> >   	return 0;
> >   }
> >
> > +static int fsl_mc_dma_configure(struct device *dev)
> > +{
> > +	struct device *dma_dev = dev;
> > +
> > +	while (dev_is_fsl_mc(dma_dev))
> > +		dma_dev = dma_dev->parent;
> > +
> > +	return of_dma_configure(dev, dma_dev->of_node, 0);
> > +}
> > +
> >   static ssize_t modalias_show(struct device *dev, struct device_attribute
> *attr,
> >   			     char *buf)
> >   {
> > @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
> >   	.name = "fsl-mc",
> >   	.match = fsl_mc_bus_match,
> >   	.uevent = fsl_mc_bus_uevent,
> > +	.dma_configure  = fsl_mc_dma_configure,
> >   	.dev_groups = fsl_mc_dev_groups,
> >   };
> >   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> > @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc
> *obj_desc,
> >   		mc_dev->icid = parent_mc_dev->icid;
> >   		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
> >   		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> > +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
> 
> This change seems a bit unrelated to the patch subject. I wonder if it
> makes sense to split it it in a distinct patch.

Okay. I will spin a v5 after splitting this patch and adding changelog (Greg's comment), fixing typo (Bjorn's comment).

Regards,
Nipun

> 
> ---
> Best Regards, Laurentiu
