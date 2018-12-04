Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E4CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF6B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF6B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeLDVwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:52:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44409 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeLDVwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:52:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id m6so15686144oig.11;
        Tue, 04 Dec 2018 13:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fsZ5Zua72BmMYMgU+O5fVAy9sXXoKh0UJjkbWZ+mPnI=;
        b=rq8hv4qqkGQi/gJZXL8o+17lSKNUutEXtBiQNUNwgfqgDFuugFhNyvedc0MeldTwjc
         /5OMmBO9DvP38QIg2gcl+amVAp2FgdJ3CC3Nb1sg/EXTKJHs/86X4LkL/ciw/r8OHcdC
         2xYiCzDQRxgGXN+dGFRlAhLaut07Y0dVMvMhBBLv8/20cPbDy6ouU8YHgTKSdn6Ws5qf
         yOAAfNUhsSKIBSq8xnip2nM7q/OEXoGAcm3pp3nKYCkqPcoVmjzN7pylvwj8Y5faBCDp
         8Scfyx3nUWcjvrwKE8k2Knm6FU4CTBGiOSdhphUq+a9YwIHRpmOoH3w4WA8Aq5LG27q6
         jJMA==
X-Gm-Message-State: AA+aEWbR0WmOQ/h9/UumEdVk35BiG6kFGZQ5KX0KueJ6yYeRHtY9B8sF
        gw+IR/L4CYYJhDWjkMoIhA==
X-Google-Smtp-Source: AFSGD/UyxWBbzRCEkUmfMJJxobr3sIy5XOW6jgkx99FzZHxROk2HQpFCnxUxICZULC96rD5/a25MrA==
X-Received: by 2002:aca:da84:: with SMTP id r126mr14251648oig.219.1543960340485;
        Tue, 04 Dec 2018 13:52:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z191sm7660636oig.3.2018.12.04.13.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:52:19 -0800 (PST)
Date:   Tue, 4 Dec 2018 15:52:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 5/6] power: supply: charger-manager: Remove deprecated
 extcon APIs
Message-ID: <20181204215219.GA14502@bogus>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
 <a41e3aad0147b25c4c22189dd7af0d68c5587b92.1542362262.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41e3aad0147b25c4c22189dd7af0d68c5587b92.1542362262.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 07:01:12PM +0800, Baolin Wang wrote:
> The struct extcon_specific_cable_nb and related APIs are deprecated now,
> so we should use new method to get one extcon device and register extcon
> notifier.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../bindings/power/supply/charger-manager.txt      |    6 +--

Bindings should be a separate patch.

>  drivers/power/supply/charger-manager.c             |   51 ++++++++------------
>  include/linux/power/charger-manager.h              |    2 +-
>  3 files changed, 23 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/charger-manager.txt b/Documentation/devicetree/bindings/power/supply/charger-manager.txt
> index ec4fe9d..315b0cb 100644
> --- a/Documentation/devicetree/bindings/power/supply/charger-manager.txt
> +++ b/Documentation/devicetree/bindings/power/supply/charger-manager.txt
> @@ -11,7 +11,7 @@ Required properties :
>  	- cm-regulator-name : name of charger regulator
>  	- subnode <cable> :
>  		- cm-cable-name : name of charger cable
> -		- cm-cable-extcon : name of extcon dev
> +		- extcon : phandles to external connector devices

Somewhat less terrible, but not really. I consider extcon binding itself 
deprecated. I suspect 'charger-manager' as a whole probably needs to be 
reworked. This also is not a backwards compatible change.

>  (optional)	- cm-cable-min : minimum current of cable
>  (optional)	- cm-cable-max : maximum current of cable
>  
> @@ -66,13 +66,13 @@ Example :
>  			cm-regulator-name = "chg-reg";
>  			cable@0 {
>  				cm-cable-name = "USB";
> -				cm-cable-extcon = "extcon-dev.0";
> +				extcon = <&extcon_usb>;
>  				cm-cable-min = <475000>;
>  				cm-cable-max = <500000>;
>  			};
>  			cable@1 {
>  				cm-cable-name = "TA";
> -				cm-cable-extcon = "extcon-dev.0";
> +				extcon = <&extcon_usb>;
>  				cm-cable-min = <650000>;
>  				cm-cable-max = <675000>;
>  			};
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> index dc0c9a6..4f28c03 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1207,12 +1207,11 @@ static int charger_extcon_init(struct charger_manager *cm,
>  	 */
>  	INIT_WORK(&cable->wq, charger_extcon_work);
>  	cable->nb.notifier_call = charger_extcon_notifier;
> -	ret = extcon_register_interest(&cable->extcon_dev,
> -			cable->extcon_name, cable->name, &cable->nb);
> -	if (ret < 0) {
> -		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
> -			cable->extcon_name, cable->name);
> -	}
> +	ret = devm_extcon_register_notifier(cm->dev, cable->extcon_dev,
> +					    EXTCON_USB, &cable->nb);
> +	if (ret < 0)
> +		dev_err(cm->dev, "Cannot register extcon_dev for (cable: %s)\n",
> +			cable->name);
>  
>  	return ret;
>  }
> @@ -1589,15 +1588,25 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
>  				for_each_child_of_node(child, _child) {
>  					of_property_read_string(_child,
>  					"cm-cable-name", &cables->name);
> -					of_property_read_string(_child,
> -					"cm-cable-extcon",
> -					&cables->extcon_name);
>  					of_property_read_u32(_child,
>  					"cm-cable-min",
>  					&cables->min_uA);
>  					of_property_read_u32(_child,
>  					"cm-cable-max",
>  					&cables->max_uA);
> +
> +					if (of_property_read_bool(_child, "extcon")) {
> +						struct device_node *np;
> +
> +						np = of_parse_phandle(_child, "extcon", 0);
> +						if (!np)
> +							return ERR_PTR(-ENODEV);
> +
> +						cables->extcon_dev = extcon_find_edev_by_node(np);
> +						of_node_put(np);
> +						if (IS_ERR(cables->extcon_dev))
> +							return ERR_PTR(PTR_ERR(cables->extcon_dev));
> +					}
>  					cables++;
>  				}
>  			}
> @@ -1625,7 +1634,6 @@ static int charger_manager_probe(struct platform_device *pdev)
>  	struct charger_desc *desc = cm_get_drv_data(pdev);
>  	struct charger_manager *cm;
>  	int ret, i = 0;
> -	int j = 0;
>  	union power_supply_propval val;
>  	struct power_supply *fuel_gauge;
>  	struct power_supply_config psy_cfg = {};
> @@ -1823,19 +1831,8 @@ static int charger_manager_probe(struct platform_device *pdev)
>  				&charger->attr_g);
>  	}
>  err_reg_extcon:
> -	for (i = 0; i < desc->num_charger_regulators; i++) {
> -		struct charger_regulator *charger;
> -
> -		charger = &desc->charger_regulators[i];
> -		for (j = 0; j < charger->num_cables; j++) {
> -			struct charger_cable *cable = &charger->cables[j];
> -			/* Remove notifier block if only edev exists */
> -			if (cable->extcon_dev.edev)
> -				extcon_unregister_interest(&cable->extcon_dev);
> -		}
> -
> +	for (i = 0; i < desc->num_charger_regulators; i++)
>  		regulator_put(desc->charger_regulators[i].consumer);
> -	}
>  
>  	power_supply_unregister(cm->charger_psy);
>  
> @@ -1847,7 +1844,6 @@ static int charger_manager_remove(struct platform_device *pdev)
>  	struct charger_manager *cm = platform_get_drvdata(pdev);
>  	struct charger_desc *desc = cm->desc;
>  	int i = 0;
> -	int j = 0;
>  
>  	/* Remove from the list */
>  	mutex_lock(&cm_list_mtx);
> @@ -1857,15 +1853,6 @@ static int charger_manager_remove(struct platform_device *pdev)
>  	cancel_work_sync(&setup_polling);
>  	cancel_delayed_work_sync(&cm_monitor_work);
>  
> -	for (i = 0 ; i < desc->num_charger_regulators ; i++) {
> -		struct charger_regulator *charger
> -				= &desc->charger_regulators[i];
> -		for (j = 0 ; j < charger->num_cables ; j++) {
> -			struct charger_cable *cable = &charger->cables[j];
> -			extcon_unregister_interest(&cable->extcon_dev);
> -		}
> -	}
> -
>  	for (i = 0 ; i < desc->num_charger_regulators ; i++)
>  		regulator_put(desc->charger_regulators[i].consumer);
>  
> diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
> index c4fa907..e4d0269 100644
> --- a/include/linux/power/charger-manager.h
> +++ b/include/linux/power/charger-manager.h
> @@ -66,7 +66,7 @@ struct charger_cable {
>  	const char *name;
>  
>  	/* The charger-manager use Extcon framework */
> -	struct extcon_specific_cable_nb extcon_dev;
> +	struct extcon_dev *extcon_dev;
>  	struct work_struct wq;
>  	struct notifier_block nb;
>  
> -- 
> 1.7.9.5
> 
