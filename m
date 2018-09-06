Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312FFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0A82075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g+8x1rMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0A82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIFODP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:03:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38992 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeIFODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:03:15 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w869S6qX087576;
        Thu, 6 Sep 2018 04:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536226086;
        bh=xkc98GbyouHW+qOU3eD2jleCNC5CCKrGkcSf59kxs60=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=g+8x1rMnBd0atM/giIqWlaEaYOkBB6le1VFlbOtdwbG7gXVXs6h/jmBt95dBg/oc0
         Qm4ZVYaWxkAu17dVIdOdvtkKCKYh7T1125iClhy9zLahfTATwMXqCoQlYyiqcHa7X0
         SgDZZRMDNK02L3mCrUBc2OsSpdDoSIQLLJmPqv8c=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w869S6Ye023226;
        Thu, 6 Sep 2018 04:28:06 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 6 Sep
 2018 04:28:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 6 Sep 2018 04:28:05 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w869S1RC015779;
        Thu, 6 Sep 2018 04:28:02 -0500
Subject: Re: [PATCH 02/10] phy: Add configuration interface
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1ed01c1f-76d5-fa96-572b-9bfd269ad11b@ti.com>
Date:   Thu, 6 Sep 2018 14:57:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 05 September 2018 02:46 PM, Maxime Ripard wrote:
> The phy framework is only allowing to configure the power state of the PHY
> using the init and power_on hooks, and their power_off and exit
> counterparts.
> 
> While it works for most, simple, PHYs supported so far, some more advanced
> PHYs need some configuration depending on runtime parameters. These PHYs
> have been supported by a number of means already, often by using ad-hoc
> drivers in their consumer drivers.
> 
> That doesn't work too well however, when a consumer device needs to deal
> multiple PHYs, or when multiple consumers need to deal with the same PHY (a
> DSI driver and a CSI driver for example).
> 
> So we'll add a new interface, through two funtions, phy_validate and
> phy_configure. The first one will allow to check that a current
> configuration, for a given mode, is applicable. It will also allow the PHY
> driver to tune the settings given as parameters as it sees fit.
> 
> phy_configure will actually apply that configuration in the phy itself.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/phy/phy-core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/phy/phy.h | 42 ++++++++++++++++++++++++++++-
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 35fd38c5a4a1..6eaf655e370f 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -408,6 +408,68 @@ int phy_calibrate(struct phy *phy)
>  EXPORT_SYMBOL_GPL(phy_calibrate);
>  
>  /**
> + * phy_configure() - Changes the phy parameters
> + * @phy: the phy returned by phy_get()
> + * @mode: phy_mode the configuration is applicable to.

mode should be used if the same PHY can be configured in multiple modes. But
with phy_set_mode() and phy_calibrate() we could achieve the same.
> + * @opts: New configuration to apply

Should these configuration come from the consumer driver? Can't the helper
functions be directly invoked by the PHY driver for the configuration.
> + *
> + * Used to change the PHY parameters. phy_init() must have
> + * been called on the phy.
> + *
> + * Returns: 0 if successful, an negative error code otherwise
> + */
> +int phy_configure(struct phy *phy, enum phy_mode mode,
> +		  union phy_configure_opts *opts)
> +{> +	int ret;
> +
> +	if (!phy)
> +		return -EINVAL;
> +
> +	if (!phy->ops->configure)
> +		return 0;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->configure(phy, mode, opts);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * phy_validate() - Checks the phy parameters
> + * @phy: the phy returned by phy_get()
> + * @mode: phy_mode the configuration is applicable to.
> + * @opts: Configuration to check
> + *
> + * Used to check that the current set of parameters can be handled by
> + * the phy. Implementations are free to tune the parameters passed as
> + * arguments if needed by some implementation detail or
> + * constraints. It will not change any actual configuration of the
> + * PHY, so calling it as many times as deemed fit will have no side
> + * effect.
> + *
> + * Returns: 0 if successful, an negative error code otherwise
> + */
> +int phy_validate(struct phy *phy, enum phy_mode mode,
> +		  union phy_configure_opts *opts)

IIUC the consumer driver will pass configuration options (or PHY parameters)
which will be validated by the PHY driver and in some cases the PHY driver can
modify the configuration options? And these modified configuration options will
again be given to phy_configure?

Looks like it's a round about way of doing the same thing.


> +{
> +	int ret;
> +
> +	if (!phy)
> +		return -EINVAL;
> +
> +	if (!phy->ops->validate)
> +		return 0;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->validate(phy, mode, opts);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +
> +/**
>   * _of_phy_get() - lookup and obtain a reference to a phy by phandle
>   * @np: device_node for which to get the phy
>   * @index: the index of the phy
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 9cba7fe16c23..3cc315dcfcd0 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -44,6 +44,12 @@ enum phy_mode {
>  };
>  
>  /**
> + * union phy_configure_opts - Opaque generic phy configuration
> + */
> +union phy_configure_opts {
> +};
> +
> +/**
>   * struct phy_ops - set of function pointers for performing phy operations
>   * @init: operation to be performed for initializing phy
>   * @exit: operation to be performed while exiting
> @@ -60,6 +66,38 @@ struct phy_ops {
>  	int	(*power_on)(struct phy *phy);
>  	int	(*power_off)(struct phy *phy);
>  	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
> +
> +	/**
> +	 * @configure:
> +	 *
> +	 * Optional.
> +	 *
> +	 * Used to change the PHY parameters. phy_init() must have
> +	 * been called on the phy.
> +	 *
> +	 * Returns: 0 if successful, an negative error code otherwise
> +	 */
> +	int	(*configure)(struct phy *phy, enum phy_mode mode,
> +			     union phy_configure_opts *opts);
> +
> +	/**
> +	 * @validate:
> +	 *
> +	 * Optional.
> +	 *
> +	 * Used to check that the current set of parameters can be
> +	 * handled by the phy. Implementations are free to tune the
> +	 * parameters passed as arguments if needed by some
> +	 * implementation detail or constraints. It must not change
> +	 * any actual configuration of the PHY, so calling it as many
> +	 * times as deemed fit by the consumer must have no side
> +	 * effect.
> +	 *
> +	 * Returns: 0 if the configuration can be applied, an negative
> +	 * error code otherwise
> +	 */
> +	int	(*validate)(struct phy *phy, enum phy_mode mode,
> +			    union phy_configure_opts *opts);
>  	int	(*reset)(struct phy *phy);
>  	int	(*calibrate)(struct phy *phy);
>  	struct module *owner;
> @@ -164,6 +202,10 @@ int phy_exit(struct phy *phy);
>  int phy_power_on(struct phy *phy);
>  int phy_power_off(struct phy *phy);
>  int phy_set_mode(struct phy *phy, enum phy_mode mode);
> +int phy_configure(struct phy *phy, enum phy_mode mode,
> +		  union phy_configure_opts *opts);
> +int phy_validate(struct phy *phy, enum phy_mode mode,
> +		 union phy_configure_opts *opts);

Stub function when CONFIG_GENERIC_PHY is not set is also required.

Thanks
Kishon
