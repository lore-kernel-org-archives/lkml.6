Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E7F20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E7F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392873AbeKVSxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:53:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:24352 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733142AbeKVSxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:53:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 00:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,264,1539673200"; 
   d="scan'208";a="102252515"
Received: from nanchanf-mobl2.ccr.corp.intel.com ([10.255.31.248])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2018 00:15:01 -0800
Message-ID: <1542874498.2187.25.camel@intel.com>
Subject: Re: [PATCH v3] thermal: qoriq: add multiple sensors support
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Tang <andy.tang@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 22 Nov 2018 16:14:58 +0800
In-Reply-To: <16bf9114-8403-a11a-0a29-f78bc139b480@linaro.org>
References: <20181030010008.27237-1-andy.tang@nxp.com>
         <VI1PR04MB4333200BCB4E2DABE1DC5B55F3C30@VI1PR04MB4333.eurprd04.prod.outlook.com>
         <VI1PR04MB433384F335FBE426117B2188F3DA0@VI1PR04MB4333.eurprd04.prod.outlook.com>
         <16bf9114-8403-a11a-0a29-f78bc139b480@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2018-11-21 at 09:43 +0100, Daniel Lezcano wrote:
> On 21/11/2018 02:34, Andy Tang wrote:
> > 
> > Hi all,
> > 
> > Do you have any comments on this patch?
> > 
> > I found for our thermal driver(qoriq_thermal.c) there are different
> > between the following two git trees:
> > git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git 
> > branch: next  
> > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> > thermal.git.
> > branch: next
> > 
> > Could you please clarify which git tree/branch should I use?
> SoC changes are submitted against linux-soc-thermal.git.
> 
> Generic thermal framework are sent against Zhang Rui's tree but it
> happens sometimes Eduardo pick them also when the changes are related
> to
> SoC behavior.
> 
> However, I agree that can be confusing :)
> 

In the beginning, for soc thermal driver changes, I used to take them
with Acked-by/Reviewed-by from Eduardo or the driver maintainers.
Later, we have Eduardo to take the soc-thermal patches and send me pull
request so that I can merge them altogether before merge window.
Recently, we started to send separate pull requests to see how it goes.

So to make it easier, I agree we'd better stick with one tree.

thanks,
rui

> Eduardo, Rui,
> 
> how about to add a section in the maintainer handbook for the thermal
> to
> clarify the expectations and the flow?
> 
> > 
> > > 
> > > -----Original Message-----
> > > From: Andy Tang
> > > Sent: 2018年11月14日 15:29
> > > To: rui.zhang@intel.com; daniel.lezcano@linaro.org
> > > Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH v3] thermal: qoriq: add multiple sensors
> > > support
> > > 
> > > PING.
> > > 
> > > BR,
> > > Andy
> > > 
> > > > 
> > > > -----Original Message-----
> > > > From: andy.tang@nxp.com <andy.tang@nxp.com>
> > > > Sent: 2018年10月30日 9:00
> > > > To: rui.zhang@intel.com; daniel.lezcano@linaro.org
> > > > Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Andy Tang <andy.tang@nxp.com>
> > > > Subject: [PATCH v3] thermal: qoriq: add multiple sensors
> > > > support
> > > > 
> > > > From: Yuantian Tang <andy.tang@nxp.com>
> > > > 
> > > > The QorIQ Layerscape SoC has several thermal sensors but the
> > > > current
> > > > driver only supports one.
> > > > 
> > > > Massage the code to be sensor oriented and allow the support
> > > > for
> > > > multiple sensors.
> > > > 
> > > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > > Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > ---
> > > > v3:
> > > >   - add Reviewed-by
> > > > v2:
> > > >   - update the commit message
> > > >   - refine the qoriq_tmu_register_tmu_zone()
> > > > 
> > > >  drivers/thermal/qoriq_thermal.c |  100
> > > > ++++++++++++++++++---------------------
> > > >  1 files changed, 46 insertions(+), 54 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/qoriq_thermal.c
> > > > b/drivers/thermal/qoriq_thermal.c index 450ed66..8beb344 100644
> > > > --- a/drivers/thermal/qoriq_thermal.c
> > > > +++ b/drivers/thermal/qoriq_thermal.c
> > > > @@ -59,14 +59,21 @@ struct qoriq_tmu_regs {
> > > >  	u32 ttr3cr;		/* Temperature Range 3
> > > > Control Register */
> > > >  };
> > > > 
> > > > +struct qoriq_tmu_data;
> > > > +
> > > >  /*
> > > >   * Thermal zone data
> > > >   */
> > > > +struct qoriq_sensor {
> > > > +	struct thermal_zone_device	*tzd;
> > > > +	struct qoriq_tmu_data		*qdata;
> > > > +	int				id;
> > > > +};
> > > > +
> > > >  struct qoriq_tmu_data {
> > > > -	struct thermal_zone_device *tz;
> > > >  	struct qoriq_tmu_regs __iomem *regs;
> > > > -	int sensor_id;
> > > >  	bool little_endian;
> > > > +	struct qoriq_sensor	*sensor[SITES_MAX];
> > > >  };
> > > > 
> > > >  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void
> > > > __iomem
> > > > *addr) @@ -87,48 +94,51 @@ static u32 tmu_read(struct
> > > qoriq_tmu_data
> > > > 
> > > > *p, void __iomem *addr)
> > > > 
> > > >  static int tmu_get_temp(void *p, int *temp)  {
> > > > +	struct qoriq_sensor *qsensor = p;
> > > > +	struct qoriq_tmu_data *qdata = qsensor->qdata;
> > > >  	u32 val;
> > > > -	struct qoriq_tmu_data *data = p;
> > > > 
> > > > -	val = tmu_read(data, &data->regs->site[data-
> > > > >sensor_id].tritsr);
> > > > +	val = tmu_read(qdata, &qdata->regs->site[qsensor-
> > > > >id].tritsr);
> > > >  	*temp = (val & 0xff) * 1000;
> > > > 
> > > >  	return 0;
> > > >  }
> > > > 
> > > > -static int qoriq_tmu_get_sensor_id(void)
> > > > +static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> > > > +	.get_temp = tmu_get_temp,
> > > > +};
> > > > +
> > > > +static int qoriq_tmu_register_tmu_zone(struct platform_device
> > > > *pdev)
> > > >  {
> > > > -	int ret, id;
> > > > -	struct of_phandle_args sensor_specs;
> > > > -	struct device_node *np, *sensor_np;
> > > > +	struct qoriq_tmu_data *qdata =
> > > > platform_get_drvdata(pdev);
> > > > +	int id, sites = 0;
> > > > 
> > > > -	np = of_find_node_by_name(NULL, "thermal-zones");
> > > > -	if (!np)
> > > > -		return -ENODEV;
> > > > +	for (id = 0; id < SITES_MAX; id++) {
> > > > +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> > > > +				sizeof(struct qoriq_sensor),
> > > > GFP_KERNEL);
> > > > +		if (!qdata->sensor[id])
> > > > +			return -ENOMEM;
> > > > 
> > > > -	sensor_np = of_get_next_child(np, NULL);
> > > > -	ret = of_parse_phandle_with_args(sensor_np, "thermal-
> > > > sensors",
> > > > -			"#thermal-sensor-cells",
> > > > -			0, &sensor_specs);
> > > > -	if (ret) {
> > > > -		of_node_put(np);
> > > > -		of_node_put(sensor_np);
> > > > -		return ret;
> > > > -	}
> > > > +		qdata->sensor[id]->id = id;
> > > > +		qdata->sensor[id]->qdata = qdata;
> > > > 
> > > > -	if (sensor_specs.args_count >= 1) {
> > > > -		id = sensor_specs.args[0];
> > > > -		WARN(sensor_specs.args_count > 1,
> > > > -				"%s: too many cells in sensor
> > > > specifier %d\n",
> > > > -				sensor_specs.np->name,
> > > > sensor_specs.args_count);
> > > > -	} else {
> > > > -		id = 0;
> > > > -	}
> > > > +		qdata->sensor[id]->tzd =
> > > > devm_thermal_zone_of_sensor_register(
> > > > +				&pdev->dev, id, qdata-
> > > > >sensor[id], &tmu_tz_ops);
> > > > +		if (IS_ERR(qdata->sensor[id]->tzd)) {
> > > > +			if (PTR_ERR(qdata->sensor[id]->tzd) ==
> > > > -ENODEV)
> > > > +				continue;
> > > > +			else
> > > > +				return PTR_ERR(qdata-
> > > > >sensor[id]->tzd);
> > > > 
> > > > -	of_node_put(np);
> > > > -	of_node_put(sensor_np);
> > > > +		}
> > > > +
> > > > +		sites |= 0x1 << (15 - id);
> > > > +	}
> > > > +	/* Enable monitoring */
> > > > +	if (sites != 0)
> > > > +		tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
> > > > &qdata->regs->tmr);
> > > > 
> > > > -	return id;
> > > > +	return 0;
> > > >  }
> > > > 
> > > >  static int qoriq_tmu_calibration(struct platform_device *pdev)
> > > > @@
> > > > -178,16 +188,11 @@ static void qoriq_tmu_init_device(struct
> > > > qoriq_tmu_data *data)
> > > >  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);  }
> > > > 
> > > > -static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> > > > -	.get_temp = tmu_get_temp,
> > > > -};
> > > > -
> > > >  static int qoriq_tmu_probe(struct platform_device *pdev)  {
> > > >  	int ret;
> > > >  	struct qoriq_tmu_data *data;
> > > >  	struct device_node *np = pdev->dev.of_node;
> > > > -	u32 site;
> > > > 
> > > >  	if (!np) {
> > > >  		dev_err(&pdev->dev, "Device OF-Node is NULL");
> > > > @@ -203,13
> > > > +208,6 @@ static int qoriq_tmu_probe(struct platform_device
> > > > *pdev)
> > > > 
> > > >  	data->little_endian = of_property_read_bool(np,
> > > > "little-endian");
> > > > 
> > > > -	data->sensor_id = qoriq_tmu_get_sensor_id();
> > > > -	if (data->sensor_id < 0) {
> > > > -		dev_err(&pdev->dev, "Failed to get sensor
> > > > id\n");
> > > > -		ret = -ENODEV;
> > > > -		goto err_iomap;
> > > > -	}
> > > > -
> > > >  	data->regs = of_iomap(np, 0);
> > > >  	if (!data->regs) {
> > > >  		dev_err(&pdev->dev, "Failed to get memory
> > > > region\n"); @@
> > > > -223,19 +221,13 @@ static int qoriq_tmu_probe(struct
> > > > platform_device
> > > > *pdev)
> > > >  	if (ret < 0)
> > > >  		goto err_tmu;
> > > > 
> > > > -	data->tz = devm_thermal_zone_of_sensor_register(&pdev-
> > > > >dev,
> > > > -							data-
> > > > >sensor_id,
> > > > -							data,
> > > > &tmu_tz_ops);
> > > > -	if (IS_ERR(data->tz)) {
> > > > -		ret = PTR_ERR(data->tz);
> > > > -		dev_err(&pdev->dev,
> > > > -			"Failed to register thermal zone
> > > > device %d\n", ret);
> > > > -		goto err_tmu;
> > > > +	ret = qoriq_tmu_register_tmu_zone(pdev);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&pdev->dev, "Failed to register
> > > > sensors\n");
> > > > +		ret = -ENODEV;
> > > > +		goto err_iomap;
> > > >  	}
> > > > 
> > > > -	/* Enable monitoring */
> > > > -	site = 0x1 << (15 - data->sensor_id);
> > > > -	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs-
> > > > >tmr);
> > > > 
> > > >  	return 0;
> > > > 
> > > > --
> > > > 1.7.1
> 
