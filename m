Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C26FECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7E9208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQtEfwKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7E9208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeIPCpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:45:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42821 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeIPCpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:45:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so5685537plq.9;
        Sat, 15 Sep 2018 14:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kFl9Cjy2i/loPmuSdollfntfpeDCnzDp1uMCB3FmhWA=;
        b=WQtEfwKvhU8xZbVQWhQY/Gpyb07BbGtQYL9k2OyVzniL4hvCTWXYhxb9D4vVahgstr
         eqDJooPtHILD0ZEcpJQiwXwW163NimOQXbbMZkbO+lVVPP+TLGCvl7OK5s0Q758XCJG7
         AzgooEQ2MosOVfNRBXRmAk1cK8veDnZyQafsITZW6Y8NarKideFopDnJg3T4Ga/TdY+g
         jqMcSLAQ1cQDDc+BYu59kOq+AwgrKW8fDUOX1MC3+hrhCHZu1WZpbudQx5mO19TyI+wl
         cb3xrhe77FDi14z/CACpim6Z6S5/P+5XP0HjUi2EGax5J+i7O8Ep7egZL3ybsp2pgpCx
         dQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kFl9Cjy2i/loPmuSdollfntfpeDCnzDp1uMCB3FmhWA=;
        b=BQEjTxH7ppF6tGGIvq9GfnftWQFUGkv2WOb5BmGXdxCaL64RBnBArVYnaKucwGjGs2
         vQ2U6WT65ICT4zE8w1o6RXCZXJtJPkbZ9QcwOy9BfbYAqKubMhrGFOM3/3cfY8t5s1bg
         aGUpK+oqooM9vUZIk9okfSQ3kx+f15XvdYJ1uEDWcHQ7eDcmVDB9Qi4A4+GeND0NKXN8
         +MYKs8AkEaubJvzVmNVIz/o3i8QZ0VdUFhAoiQbFdPyJRgOoIXXY70M57kWWcQFsttAj
         MI6NbsmX5/iJpKaDU8aZmFbtJQKiXEgPohdWlYi2hCtGowVf94bxVqqcMavdy2QPE/LV
         c44g==
X-Gm-Message-State: APzg51CQ7ex952gnTWGsNtdy0EbcMj3cjERS1zFA348P1LkFUZc/TLdj
        I68T0GFVpEFCwuoH0j5Pz+c=
X-Google-Smtp-Source: ANB0Vdbz420PWUsoMp5WHJQA8X6uW9RIZKEn36i1lHhXPF43NvuMxRR2seUOadj5+28h4XHeLaWK5A==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7-v6mr18206004plv.37.1537046709385;
        Sat, 15 Sep 2018 14:25:09 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id t15-v6sm17857052pfa.158.2018.09.15.14.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:25:07 -0700 (PDT)
Subject: Re: [PATCH net-next v3 11/11] net: mscc: ocelot: make use of SerDes
 PHYs for handling their configuration
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <00989856964175eafbe1435a70862c2ac66cffc0.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0f762d63-a392-d2fe-a121-a013a13a8584@gmail.com>
Date:   Sat, 15 Sep 2018 14:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00989856964175eafbe1435a70862c2ac66cffc0.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:16, Quentin Schulz wrote:
> Previously, the SerDes muxing was hardcoded to a given mode in the MAC
> controller driver. Now, the SerDes muxing is configured within the
> Device Tree and is enforced in the MAC controller driver so we can have
> a lot of different SerDes configurations.
> 
> Make use of the SerDes PHYs in the MAC controller to set up the SerDes
> according to the SerDes<->switch port mapping and the communication mode
> with the Ethernet PHY.

This looks good, just a few comments below:

[snip]

> +		err = of_get_phy_mode(portnp);
> +		if (err < 0)
> +			ocelot->ports[port]->phy_mode = PHY_INTERFACE_MODE_NA;
> +		else
> +			ocelot->ports[port]->phy_mode = err;
> +
> +		switch (ocelot->ports[port]->phy_mode) {
> +		case PHY_INTERFACE_MODE_NA:
> +			continue;

Would not you want to issue a message indicating that the Device Tree
must be updated here? AFAICT with your patch series, this should no
longer be a condition that you will hit unless you kept the old DTB
around, right?

> +		case PHY_INTERFACE_MODE_SGMII:
> +			phy_mode = PHY_MODE_SGMII;
> +			break;
> +		case PHY_INTERFACE_MODE_QSGMII:
> +			phy_mode = PHY_MODE_QSGMII;
> +			break;
> +		default:
> +			dev_err(ocelot->dev,
> +				"invalid phy mode for port%d, (Q)SGMII only\n",
> +				port);
> +			return -EINVAL;
> +		}
> +
> +		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
> +		if (IS_ERR(serdes)) {
> +			err = PTR_ERR(serdes);
> +			if (err == -EPROBE_DEFER) {

This can be simplified into:

			if (err == -EPROBE_DEFER)
				dev_dbg();
			else
				dev_err();
			goto err_probe_ports;

> +				dev_dbg(ocelot->dev, "deferring probe\n");
> +				goto err_probe_ports;
> +			}
> +
> +			dev_err(ocelot->dev, "missing SerDes phys for port%d\n",
> +				port);
>  			goto err_probe_ports;
>  		}
> +
> +		ocelot->ports[port]->serdes = serdes;
>  	}
>  
>  	register_netdevice_notifier(&ocelot_netdevice_nb);
> 

-- 
Florian
