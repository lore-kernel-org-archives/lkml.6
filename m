Return-Path: <bharat.bhushan@nxp.com>
X-Google-Smtp-Source: AG47ELv8AVJi7I2i8iwKWBlnL48HYoVrNWqjLEGHaAr41zwFRGhFBAEbJgMrvcy1kh+aw+GVcmPU
ARC-Seal: i=1; a=rsa-sha256; t=1521616759; cv=none;
        d=google.com; s=arc-20160816;
        b=lUZV9y//XkW4z3/TBMcZI2xdefZCrErCyQIm+YUdFd4FNNR0IyRh/6km/prz/GUllj
         KZFNWyBwA4sukzEWeVQaHAIn+q0MN4pE2ZU6ha4MkzSoObkOzoOleEuNXRh9oxxOwdas
         AblUfoKUiRfNK8unCuWcViQHdWQp9rILLRFOOxWYPngHi4k25BlTtWqf1Fsr/g0208Rx
         PjDV5/qPQETj05d9D1JLdpLyJ9NMpYW4wPvH+pJ9zP0qLfPe4PhoPD1B/8H9Z5jwbe8g
         pRqMW6qUReUld+IwVRHMkgOxQ17cwOE649WvqqXkGcsZbAYJBbPgDfREAewc/4JOWJDC
         Dp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=RVkqLjhWsVTlQYdro6Kc9Z6iHJlGkC/yBrr3zMldftg=;
        b=j2r+ufT9x+sGATldFhxRwfp9ltqB6i9/mhRoHq/90wbArxv2XBAdJCuMTHxvShPXtK
         Bk+XDOhVxR7fOXpY4m+zzqAfwQArW9f9/oVyvvRVFowurDx1eobk6/PjJo/0vDIoqBGy
         nfM/eLCLss94x4ePKnQhEiseiOLgZCcKDVtplOE8PgCMZmNVsVBwPGheQJ++MiA5ENzm
         8DHvaHgqVDx2CAjd2S5zMA2Z0KXYx38l+b5plCh27qHdsm1JYUrvOtr/s5yimtO6WJdq
         5pulIFFQcUoKQiYOFdiwWn0FO8j7sIQyXTUCosicN5//BagV3NMugroAl1KE752PZqLN
         snoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=u8icd2Z7;
       spf=pass (google.com: domain of bharat.bhushan@nxp.com designates 104.47.1.57 as permitted sender) smtp.mailfrom=bharat.bhushan@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=u8icd2Z7;
       spf=pass (google.com: domain of bharat.bhushan@nxp.com designates 104.47.1.57 as permitted sender) smtp.mailfrom=bharat.bhushan@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Nipun Gupta <nipun.gupta@nxp.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "zajec5@gmail.com"
	<zajec5@gmail.com>, "andy.gross@linaro.org" <andy.gross@linaro.org>,
	"david.brown@linaro.org" <david.brown@linaro.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "vinod.koul@intel.com" <vinod.koul@intel.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "johan@kernel.org"
	<johan@kernel.org>, "msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Leo Li
	<leoyang.li@nxp.com>
Subject: RE: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Thread-Topic: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Thread-Index: AQHTwOGuZLbMdRjDpEaQmrs3J6wdnaPaR4hg
Date: Wed, 21 Mar 2018 07:19:15 +0000
Message-ID: <AM5PR0401MB254503027680DE6A23355D909AAA0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2626;7:ya6M+a7DWIMgqT/xUc1rCcHmW+Mkv9GBMvog6hI09Q2wtRze7MxdD1ShsGtN7fYLsuRcWmY38V0E/I0INiFBOQlGgCJmwE6RNTSXXZT1rhy1jEf0oFI/lfKGPMZHxi2mwdzHrcKkqTOAcYNLbFr6mzIwc69SoiG1GP+EhQE4EODbVe+vdc5w245qoGo4zYMUJ9NzDsbOit+r6hooA58tDkk4bGYejfw1O0OAlm4RyUv3XLcINBMLGQ6icAwV25Wq
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca2fbd80-9b70-48b4-9507-08d58efc0e0d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2626;
x-ms-traffictypediagnostic: AM5PR0401MB2626:
x-microsoft-antispam-prvs: <AM5PR0401MB2626BC35091DBF6D6CB349489AAA0@AM5PR0401MB2626.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(211936372134217)(217544274631240)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501320)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0401MB2626;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2626;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(13464003)(189003)(199004)(6116002)(3846002)(25786009)(3660700001)(39060400002)(3280700002)(2501003)(76176011)(59450400001)(97736004)(33656002)(7736002)(74316002)(5660300001)(2906002)(2201001)(305945005)(4326008)(5890100001)(7416002)(5250100002)(53546011)(6506007)(229853002)(68736007)(102836004)(8936002)(966005)(316002)(26005)(99286004)(81156014)(81166006)(2900100001)(2950100002)(86362001)(14454004)(478600001)(66066001)(7696005)(55016002)(54906003)(8676002)(9686003)(6436002)(110136005)(106356001)(53936002)(6306002)(6246003)(105586002)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2626;H:AM5PR0401MB2545.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Rr4YP+T9AGw6vB6vlUDQdzULqS9zzb+lT82BLKsLP/W5Ppsp0y0Qs0U14SYkYVmhUy96iqVjx80OaUhzAFwW9RNh4c1JBCuXtWjlNYfsK+14yWiD/KdAPR+cU1oxA8gzdTLPBAecvji30vDa8/dPM94nph30EEvDtW93/g2L8Oe5d5uLayniUmoc8egDl5RoHvHbVwML8Lak21dRsB15VABMc1JD6cljiETE5UzJj5ndXC/1RgYDdQzpTG7mIgecVpg+NfvnV/RN0ItW9wVgkYloKqo7bABWdebsu/QxT0LerAq45X2jCqrEmx9azNsNVw1ANc829xNURNEC3w5dgA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2fbd80-9b70-48b4-9507-08d58efc0e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 07:19:16.0516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2626
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1595530814998464422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Nipun Gupta
> Sent: Wednesday, March 21, 2018 12:25 PM
> To: robin.murphy@arm.com; hch@lst.de; linux@armlinux.org.uk;
> gregkh@linuxfoundation.org; m.szyprowski@samsung.com
> Cc: bhelgaas@google.com; zajec5@gmail.com; andy.gross@linaro.org;
> david.brown@linaro.org; dan.j.williams@intel.com; vinod.koul@intel.com;
> thierry.reding@gmail.com; robh+dt@kernel.org; frowand.list@gmail.com;
> jarkko.sakkinen@linux.intel.com; rafael.j.wysocki@intel.com;
> dmitry.torokhov@gmail.com; johan@kernel.org; msuchanek@suse.de; linux-
> kernel@vger.kernel.org; iommu@lists.linux-foundation.org; linux-
> wireless@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
> soc@vger.kernel.org; dmaengine@vger.kernel.org; dri-
> devel@lists.freedesktop.org; linux-tegra@vger.kernel.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org; Bharat Bhushan
> <bharat.bhushan@nxp.com>; Leo Li <leoyang.li@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>
> Subject: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
> infrastructure
>=20
> It's bus specific aspect to map a given device on the bus and relevant fi=
rmware
> description of its DMA configuration.
> So, this change introduces '/dma_configure/' as bus callback giving flexi=
bility to
> busses for implementing its own dma configuration function.
>=20
> The change eases the addition of new busses w.r.t. adding the dma
> configuration functionality.
>=20
> This patch also updates the PCI, Platform, ACPI and host1x bus to use new
> introduced callbacks.
>=20
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  - The patches are based on the comments on:
>    https://patchwork.kernel.org/patch/10259087/
>=20
> Changes in v2:
>   - Do not have dma_deconfigure callback
>   - Have '/dma_common_configure/' API to provide a common DMA
>     configuration which can be used by busses if it suits them.
>   - Platform and ACPI bus to use '/dma_common_configure/' in
>     '/dma_configure/' callback.
>   - Updated commit message
>   - Updated pci_dma_configure API with changes suggested by Robin
>=20
>  drivers/amba/bus.c          |  7 +++++++
>  drivers/base/dma-mapping.c  | 35 +++++++++++++++--------------------
>  drivers/base/platform.c     |  6 ++++++
>  drivers/gpu/host1x/bus.c    |  9 +++++++++
>  drivers/pci/pci-driver.c    | 32 ++++++++++++++++++++++++++++++++
>  include/linux/device.h      |  4 ++++
>  include/linux/dma-mapping.h |  1 +
>  7 files changed, 74 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c index 594c228..2fa1e=
8b
> 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -20,6 +20,7 @@
>  #include <linux/sizes.h>
>  #include <linux/limits.h>
>  #include <linux/clk/clk-conf.h>
> +#include <linux/dma-mapping.h>
>=20
>  #include <asm/irq.h>
>=20
> @@ -171,6 +172,11 @@ static int amba_pm_runtime_resume(struct device
> *dev)  }  #endif /* CONFIG_PM */
>=20
> +static int amba_dma_configure(struct device *dev) {
> +	return dma_common_configure(dev);
> +}
> +
>  static const struct dev_pm_ops amba_pm =3D {
>  	.suspend	=3D pm_generic_suspend,
>  	.resume		=3D pm_generic_resume,
> @@ -194,6 +200,7 @@ struct bus_type amba_bustype =3D {
>  	.dev_groups	=3D amba_dev_groups,
>  	.match		=3D amba_match,
>  	.uevent		=3D amba_uevent,
> +	.dma_configure	=3D amba_dma_configure,
>  	.pm		=3D &amba_pm,
>  	.force_dma	=3D true,
>  };
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c inde=
x
> 3b11835..48f9af0 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -331,38 +331,33 @@ void dma_common_free_remap(void *cpu_addr,
> size_t size, unsigned long vm_flags)  #endif
>=20
>  /*
> - * Common configuration to enable DMA API use for a device
> + * Common configuration to enable DMA API use for a device.
> + * A bus can use this function in its 'dma_configure' callback, if
> + * suitable for the bus.
>   */
> -#include <linux/pci.h>
> -
> -int dma_configure(struct device *dev)
> +int dma_common_configure(struct device *dev)
>  {
> -	struct device *bridge =3D NULL, *dma_dev =3D dev;
>  	enum dev_dma_attr attr;
>  	int ret =3D 0;
>=20
> -	if (dev_is_pci(dev)) {
> -		bridge =3D pci_get_host_bridge_device(to_pci_dev(dev));
> -		dma_dev =3D bridge;
> -		if (IS_ENABLED(CONFIG_OF) && dma_dev->parent &&
> -		    dma_dev->parent->of_node)
> -			dma_dev =3D dma_dev->parent;
> -	}
> -
> -	if (dma_dev->of_node) {
> -		ret =3D of_dma_configure(dev, dma_dev->of_node);
> -	} else if (has_acpi_companion(dma_dev)) {
> -		attr =3D acpi_get_dma_attr(to_acpi_device_node(dma_dev-
> >fwnode));
> +	if (dev->of_node) {
> +		ret =3D of_dma_configure(dev, dev->of_node);
> +	} else if (has_acpi_companion(dev)) {
> +		attr =3D acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
>  		if (attr !=3D DEV_DMA_NOT_SUPPORTED)
>  			ret =3D acpi_dma_configure(dev, attr);
>  	}
>=20
> -	if (bridge)
> -		pci_put_host_bridge_device(bridge);
> -
>  	return ret;
>  }
>=20
> +int dma_configure(struct device *dev)
> +{
> +	if (dev->bus->dma_configure)
> +		return dev->bus->dma_configure(dev);

What if dma_common_configure() is called in case "bus->dma_configure" is no=
t defined?

Thanks
-Bharat

> +
> +	return 0;
> +}
>  void dma_deconfigure(struct device *dev)  {
>  	of_dma_deconfigure(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c index
> f1bf7b3..d2d5891 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1130,6 +1130,11 @@ int platform_pm_restore(struct device *dev)
>=20
>  #endif /* CONFIG_HIBERNATE_CALLBACKS */
>=20
> +static int platform_dma_configure(struct device *dev) {
> +	return dma_common_configure(dev);
> +}
> +
>  static const struct dev_pm_ops platform_dev_pm_ops =3D {
>  	.runtime_suspend =3D pm_generic_runtime_suspend,
>  	.runtime_resume =3D pm_generic_runtime_resume, @@ -1141,6 +1146,7
> @@ struct bus_type platform_bus_type =3D {
>  	.dev_groups	=3D platform_dev_groups,
>  	.match		=3D platform_match,
>  	.uevent		=3D platform_uevent,
> +	.dma_configure	=3D platform_dma_configure,
>  	.pm		=3D &platform_dev_pm_ops,
>  	.force_dma	=3D true,
>  };
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c index
> 88a3558..fa9896d 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -314,6 +314,14 @@ static int host1x_device_match(struct device *dev,
> struct device_driver *drv)
>  	return strcmp(dev_name(dev), drv->name) =3D=3D 0;  }
>=20
> +static int host1x_dma_configure(struct device *dev) {
> +	if (dev->of_node)
> +		return of_dma_configure(dev, dev->of_node);
> +
> +	return 0;
> +}
> +
>  static const struct dev_pm_ops host1x_device_pm_ops =3D {
>  	.suspend =3D pm_generic_suspend,
>  	.resume =3D pm_generic_resume,
> @@ -326,6 +334,7 @@ static int host1x_device_match(struct device *dev,
> struct device_driver *drv)  struct bus_type host1x_bus_type =3D {
>  	.name =3D "host1x",
>  	.match =3D host1x_device_match,
> +	.dma_configure	=3D host1x_dma_configure,
>  	.pm =3D &host1x_device_pm_ops,
>  	.force_dma =3D true,
>  };
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c index
> 3bed6be..b473a4c 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -18,6 +18,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/suspend.h>
>  #include <linux/kexec.h>
> +#include <linux/of_device.h>
> +#include <linux/acpi.h>
>  #include "pci.h"
>=20
>  struct pci_dynid {
> @@ -1522,6 +1524,35 @@ static int pci_bus_num_vf(struct device *dev)
>  	return pci_num_vf(to_pci_dev(dev));
>  }
>=20
> +/**
> + * pci_dma_configure - Setup DMA configuration
> + * @dev: ptr to dev structure
> + *
> + * Function to update PCI devices's DMA configuration using the same
> + * info from the OF node or ACPI node of host bridge's parent (if any).
> + */
> +static int pci_dma_configure(struct device *dev) {
> +	struct device *bridge;
> +	enum dev_dma_attr attr;
> +	int ret =3D 0;
> +
> +	bridge =3D pci_get_host_bridge_device(to_pci_dev(dev));
> +
> +	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
> +	    bridge->parent->of_node) {
> +		ret =3D of_dma_configure(dev, bridge->parent->of_node);
> +	} else if (has_acpi_companion(bridge)) {
> +		attr =3D acpi_get_dma_attr(to_acpi_device_node(bridge-
> >fwnode));
> +		if (attr !=3D DEV_DMA_NOT_SUPPORTED)
> +			ret =3D acpi_dma_configure(dev, attr);
> +	}
> +
> +	pci_put_host_bridge_device(bridge);
> +
> +	return ret;
> +}
> +
>  struct bus_type pci_bus_type =3D {
>  	.name		=3D "pci",
>  	.match		=3D pci_bus_match,
> @@ -1534,6 +1565,7 @@ struct bus_type pci_bus_type =3D {
>  	.drv_groups	=3D pci_drv_groups,
>  	.pm		=3D PCI_PM_OPS_PTR,
>  	.num_vf		=3D pci_bus_num_vf,
> +	.dma_configure	=3D pci_dma_configure,
>  	.force_dma	=3D true,
>  };
>  EXPORT_SYMBOL(pci_bus_type);
> diff --git a/include/linux/device.h b/include/linux/device.h index
> b093405..1832d90 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -88,6 +88,8 @@ extern int __must_check bus_create_file(struct bus_type
> *,
>   * @resume:	Called to bring a device on this bus out of sleep mode.
>   * @num_vf:	Called to find out how many virtual functions a device on th=
is
>   *		bus supports.
> + * @dma_configure:	Called to setup DMA configuration on a device on
> +			this bus.
>   * @pm:		Power management operations of this bus, callback the
> specific
>   *		device driver's pm-ops.
>   * @iommu_ops:  IOMMU specific operations for this bus, used to attach
> IOMMU @@ -130,6 +132,8 @@ struct bus_type {
>=20
>  	int (*num_vf)(struct device *dev);
>=20
> +	int (*dma_configure)(struct device *dev);
> +
>  	const struct dev_pm_ops *pm;
>=20
>  	const struct iommu_ops *iommu_ops;
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h in=
dex
> eb9eab4..c15986b 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -761,6 +761,7 @@ void *dma_mark_declared_memory_occupied(struct
> device *dev,  }  #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
>=20
> +int dma_common_configure(struct device *dev);
>  #ifdef CONFIG_HAS_DMA
>  int dma_configure(struct device *dev);
>  void dma_deconfigure(struct device *dev);
> --
> 1.9.1
