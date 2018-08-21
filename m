Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20510C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7272151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLRb2CUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7272151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeHURX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:23:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40395 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:23:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id z25-v6so3811340pgu.7;
        Tue, 21 Aug 2018 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/VnmYoAyJ4SVln8hwnNvr7F94TfsFN6gJjb3CBp1nM=;
        b=WLRb2CUT3EMveUtjRmSoFw/ggtntBupU6BfNNBjpQxvkMnJeJ2AziuOpafSaGGV+t4
         8CRC6pNOvWayE/OGHQqWjWrml3+D0yvinPgGwLoLYdC5u2CEngf8/PizIh1ON4nnodY8
         JdVZ9B75EgcMBBlKvUs/Wxrqqfuaag5r0RP7Ez9IGqT0Xpq4ktHWsN+T3edfWDxL9C/A
         5f+2Z//4D1Abt/c6BkHbiVeXaRY+fUqpWEviB84s0efVwzgo50CZo9FxohciO6EjJjki
         6BWpwLZ4dDtrixfaVaoeqjhc95tD2+KoyLGcYKgGBSdIG9/CfnFIWw7LAHJVlaAbBuTM
         rCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/VnmYoAyJ4SVln8hwnNvr7F94TfsFN6gJjb3CBp1nM=;
        b=DpKiYBA9Xa5H5PYGRYA/30pSh/A+iyZ8pL4nmrtSPhfYlSdFVlW0xVwHRKkpJx+P0X
         MqIaitMwUs3ozlqpHPeupnHtyS4Ey57q51SeJk3PJX2svlWNZrAVTHGJPgykoHXE3Egw
         Sb6vNLZuHpM/5hWCeTbsQo3ImOaLSOl4+xPTqi2oEqAInB7q12dDwAlVp4wOc9tSV+Gc
         KxDE34CCCoiCweK6Ce9SdAAr9ivHtwxc+oy7LSO5qjcqdQ/ecV106yi3HJJJWuPC8ZrM
         sX9Bl+CtZWt6keguz5ORT6NAhJXNAnqQNcWWJE24VWfL1KSTqRASZbSmbmD6I9Ynu7nW
         e+UQ==
X-Gm-Message-State: AOUpUlF8Kz1E507uUaB31ufNc1YiowSjBoD37eFTE5bU3rl8Kn9NrJ7W
        gV3Dtie3WxGlkr8uv1hzMAY=
X-Google-Smtp-Source: AA+uWPzXC/1W8R9FB0V/h+Jal7kLvB4dkRd0XP+qDRZyj+vR4g3amlQek/ffNw15V+nv9D/Bme4Pyg==
X-Received: by 2002:a62:6d02:: with SMTP id i2-v6mr53393038pfc.218.1534860219797;
        Tue, 21 Aug 2018 07:03:39 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y18-v6sm15615916pfl.90.2018.08.21.07.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:03:39 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:03:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH 3/3] usb: typec: fusb302: Populate tcpc fwnode for TCPM
 property handling
Message-ID: <20180821140338.GE17160@roeck-us.net>
References: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
 <5ab35968fea28abb54326423523af38dd887ddcc.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab35968fea28abb54326423523af38dd887ddcc.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 01:28:23PM +0100, Adam Thomson wrote:
> This update populates the tcpc handle's fwnode pointer with the
> child usb-connector node, if it exists, so that TCPM can perform
> generic property handling to define the ports capabilities.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/fusb302/fusb302.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
> index 82bed98..1b464c9 100644
> --- a/drivers/usb/typec/fusb302/fusb302.c
> +++ b/drivers/usb/typec/fusb302/fusb302.c
> @@ -1736,6 +1736,9 @@ static int fusb302_probe(struct i2c_client *client,
>  	chip->tcpc_dev.config = &chip->tcpc_config;
>  	mutex_init(&chip->lock);
>  
> +	chip->tcpc_dev.fwnode =
> +		device_get_named_child_node(dev, "connector");
> +
>  	if (!device_property_read_u32(dev, "fcs,operating-sink-microwatt", &v))
>  		chip->tcpc_config.operating_snk_mw = v / 1000;
>  
> -- 
> 1.9.1
> 
