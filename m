Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeC2Jqu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:46:50 -0400
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:23072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752495AbeC2Jqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:46:48 -0400
From: Manish Narani <MNARANI@xilinx.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
        "naranimanish@gmail.com" <naranimanish@gmail.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] sdhci: arasan: Add runtime PM support
Thread-Topic: [RFC PATCH] sdhci: arasan: Add runtime PM support
Thread-Index: AQHTxyGteOx+EpzZE0SRXgJzBcUwkqPm0GgAgAAmZIA=
Date: Thu, 29 Mar 2018 09:46:41 +0000
Message-ID: <SN1PR0201MB179173E7833404BE8845DFAFC1A20@SN1PR0201MB1791.namprd02.prod.outlook.com>
References: <1522302530-27550-1-git-send-email-naranimanish@gmail.com>
 <83c564e8-6ebf-f21c-676f-05ab75016777@rock-chips.com>
In-Reply-To: <83c564e8-6ebf-f21c-676f-05ab75016777@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR0201MB1887;7:SgTy+xw7tplaAF4YXgs0+hxVYaN0aoXpUeyB9MJfb765ZvwfQ16lxsnal5xljp1/SvHlsFF76zsjDbz2oETxi7KKgRTHMBzu0eggq8vjTQk6T79cwKCAXz6eaZdGk47kqHEWqy+qGPzlJESnHtO0CcbUiTfGex3T9t1l19M6FhQGWvTBIM4lwFaUNviNA4QVHynaEN9Gx1g4rSM0I/tTc7DGY+GFJukFUK8G2mjNAYiFeev1toPUeY9QHPOTlv2y
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57dbd9fe-d8d0-4808-c851-08d59559f987
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR0201MB1887;
x-ms-traffictypediagnostic: SN1PR0201MB1887:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN1PR0201MB1887E73781624EE6800BF584C1A20@SN1PR0201MB1887.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR0201MB1887;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1887;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(39380400002)(396003)(13464003)(199004)(189003)(43544003)(55236004)(6506007)(8936002)(3846002)(6246003)(476003)(4326008)(2501003)(7696005)(81166006)(86362001)(316002)(99286004)(3280700002)(102836004)(14454004)(11346002)(53546011)(8676002)(66066001)(25786009)(74316002)(106356001)(110136005)(486005)(486005)(446003)(81156014)(5250100002)(6116002)(68736007)(39060400002)(76176011)(54906003)(59450400001)(478600001)(53936002)(2906002)(6436002)(97736004)(33656002)(72206003)(229853002)(9686003)(105586002)(3660700001)(55016002)(7736002)(305945005)(5660300001)(2900100001)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1887;H:SN1PR0201MB1791.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: P/H+0qXVD58iGxfQjmgY9EE+R04CQvsFlkqbF0mfCZROjuv8ewQVQoGNb49B+LkPIzHhAnysyPnyHYelooxYK9GKWBUf7NNN6Y9psAeCQsOn1ZpmXFthz45bNikenDzb58XfM6ghri0kwtqK/zAmf10jDQsqMqjBmUg1TlOzj96R1JOZ6MHcG0+8fUQ4Ioe0qq4qudJCNx9VYnhh+jvJiHvof7sf1R3Mql2t3PZ72dUcEfedigtzY0PSJLHwybtf7lVfNDErvRvoDBXhb0DgWN7L52pL2mFJTpWfupgYoq0b9/Az8VakfReMar4PRqDIKwDlAKP7KpEzTfK6tLKa1A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dbd9fe-d8d0-4808-c851-08d59559f987
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 09:46:41.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1887
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2T9ktrL030435

Hi Shawn,

> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> Sent: Thursday, March 29, 2018 12:57 PM
> To: naranimanish@gmail.com
> Cc: adrian.hunter@intel.com; michal.simek@xilinx.com;
> ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; shawn.lin@rock-
> chips.com; Manish Narani <MNARANI@xilinx.com>
> Subject: Re: [RFC PATCH] sdhci: arasan: Add runtime PM support
> 
> On 2018/3/29 13:48, naranimanish@gmail.com wrote:
> > From: Manish Narani <mnarani@xilinx.com>
> >
> > This patch adds runtime PM support in Arasan SD driver.
> >
> > Signed-off-by: Manish Narani <mnarani@xilinx.com>
> > ---
> >   drivers/mmc/host/sdhci-of-arasan.c | 83
> +++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 81 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> > b/drivers/mmc/host/sdhci-of-arasan.c
> > index c33a5f7..47196b5 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -23,6 +23,7 @@
> >   #include <linux/mfd/syscon.h>
> >   #include <linux/module.h>
> >   #include <linux/of_device.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/phy/phy.h>
> >   #include <linux/regmap.h>
> >   #include <linux/of.h>
> > @@ -349,6 +350,75 @@ static const struct sdhci_pltfm_data
> sdhci_arasan_cqe_pdata = {
> >   			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> >   };
> >
> > +#ifdef CONFIG_PM
> > +/**
> > + * sdhci_arasan_runtime_suspend - Suspend method for the driver
> > + * @dev:	Address of the device structure
> > + * Returns 0 on success and error value on error
> > + *
> > + * Put the device in a low power state.
> > + */
> > +static int sdhci_arasan_runtime_suspend(struct device *dev) {
> 
> Would you help take care of cqhci_suspend?
Yes, sure. Will take care of this in next version of patch.

> 
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct sdhci_host *host = platform_get_drvdata(pdev);
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct sdhci_arasan_data *sdhci_arasan =
> sdhci_pltfm_priv(pltfm_host);
> > +	int ret;
> > +
> > +	ret = sdhci_runtime_suspend_host(host);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> > +		mmc_retune_needed(host->mmc);
> > +
> > +	clk_disable(pltfm_host->clk);
> > +	clk_disable(sdhci_arasan->clk_ahb);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * sdhci_arasan_runtime_resume - Resume method for the driver
> > + * @dev:	Address of the device structure
> > + * Returns 0 on success and error value on error
> > + *
> > + * Resume operation after suspend
> > + */
> > +static int sdhci_arasan_runtime_resume(struct device *dev) {
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct sdhci_host *host = platform_get_drvdata(pdev);
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct sdhci_arasan_data *sdhci_arasan =
> sdhci_pltfm_priv(pltfm_host);
> > +	int ret;
> > +
> 
> Ditto, for cqhci_resume.
Yes, okay.

Thanks,
Manish

> 
> > +	ret = clk_enable(sdhci_arasan->clk_ahb);
> > +	if (ret) {
> > +		dev_err(dev, "Cannot enable AHB clock.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = clk_enable(pltfm_host->clk);
> > +	if (ret) {
> > +		dev_err(dev, "Cannot enable SD clock.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = sdhci_runtime_resume_host(host);
> > +	if (ret)
> > +		goto out;
> > +
> > +	return 0;
> > +out:
> > +	clk_disable(pltfm_host->clk);
> > +	clk_disable(sdhci_arasan->clk_ahb);
> > +
> > +	return ret;
> > +}
> > +#endif /* ! CONFIG_PM */
> > +
> >   #ifdef CONFIG_PM_SLEEP
> >   /**
> >    * sdhci_arasan_suspend - Suspend method for the driver @@ -443,8
> > +513,11 @@ static int sdhci_arasan_resume(struct device *dev)
> >   }
> >   #endif /* ! CONFIG_PM_SLEEP */
> >
> > -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops,
> sdhci_arasan_suspend,
> > -			 sdhci_arasan_resume);
> > +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend,
> sdhci_arasan_resume)
> > +	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> > +			   sdhci_arasan_runtime_resume, NULL) };
> >
> >   static const struct of_device_id sdhci_arasan_of_match[] = {
> >   	/* SoC-specific compatible strings w/ soc_ctl_map */ @@ -806,6
> > +879,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
> >   	if (ret)
> >   		goto err_add_host;
> >
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> > +	pm_runtime_mark_last_busy(&pdev->dev);
> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +
> >   	return 0;
> >
> >   err_add_host:
> >
