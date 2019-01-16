Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B4BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A7120840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bvp33zBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390510AbfAPIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:51:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46020 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbfAPIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:51:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so5884794wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 00:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aXQ0K5EeXE1/NVz3VWlVrghUCjY2HyvRcO/snvuf/fQ=;
        b=Bvp33zBiSTtnXm0Hr3tZmBzM30w9OoFnOV5Ba46W7pK73xH3haMsJxGfmNxHGwidgX
         uM+zJaLRRHTgA7ZQlSnRbc2I4L30QEImxWfPXGQFAxlNMhU5SeZ3+GGpdiMAiP5Ny8Jn
         DxOnfrVM+6vBYN28fdPC9sJorMGiACypf1GLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aXQ0K5EeXE1/NVz3VWlVrghUCjY2HyvRcO/snvuf/fQ=;
        b=iwy42brpHlfwdpHIxYxoBXeXshFzaxGq4qkBv4PvVA1zmC2OPM0ZjPg+GIA+Bjj/OH
         C00p26ppFUgQRdiV2yJCJ1/mgfpodop80NdYxrd+EOV09bv48LYdMWIPeLALjmkXY26T
         YLB/D6FQQHdjqdt/Qkx6SteGcEIObfEpBhbGjVdUgRdsl8kzFbi4ISeQeAOebJH99xDi
         XXIn6G5E/+rlPvtvomqerT4KmFitpoGPGZLc7NKRS44a62v841j2hk2L0HHylL7GxCIz
         fZUlxVwfS/SugeooOcwknmA9u7EBTGtmEa3oeVVVSD9YGUc3QiCs+FALXSrOdaxrm/m7
         sVfg==
X-Gm-Message-State: AJcUukdKQ1WabU37oFD+Vvfa13Jz0Q9JvYypsHmVHFOCLzkSwcnjX4J3
        ZAbWIadIZ7C+5MWyvx3ByeDrKg==
X-Google-Smtp-Source: ALg8bN48n1MJdc2AXn2aF5J3I17GsIrHiaSULo22q/p4Cax9q2Y0fJ345etvMsYgFQA/AY9Ge3w2/g==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr6728416wrn.187.1547628687179;
        Wed, 16 Jan 2019 00:51:27 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id y1sm40093167wme.1.2019.01.16.00.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 00:51:26 -0800 (PST)
Date:   Wed, 16 Jan 2019 08:51:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org
Subject: Re: [PATCH v5 0/7] mfd / platform: cros_ec: move cros_ec sysfs
 attributes to its own drivers.
Message-ID: <20190116085124.GC23399@dell>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212173402.27086-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:

> Hi,
> 
> This is another patchset to try to cleanup a bit more the crossed
> references for cros-ec driver between the MFD and the platform/chrome
> subsystems.
> 
> The purpose of these patches is get rid of the different cros-ec attributes
> from mfd/cros_ec_dev to its own sub-driver in platform/chrome. cros_ec_dev
> continues instantiating the sub-devices but the sysfs attributes are owned
> by the platform driver.E.g. The lightbar driver should own his sysfs
> attributes and be instantiated only if the Embedded Controller has a
> lightbar.
> 
> The patchset also adds the documentation of the sysfs attributes.
> 
> Most of the patches touches mfd subsystem and platform/chrome so I'd
> suggest go all using and inmutable branch.
> 
> Best regards,
>  Enric

[...]

> Enric Balletbo i Serra (7):
>   mfd / platform: cros_ec: use devm_mfd_add_devices
>   mfd / platform: cros_ec: move lightbar attributes to its own driver
>   mfd / platform: cros_ec: move vbc attributes to its own driver
>   mfd / platform: cros_ec: move debugfs attributes to its own driver
>   mfd / platform: cros_ec: move device sysfs attributes to its own
>     driver
>   mfd / platform: cros_ec_vbc: instantiate only if the EC has a VBC
>     NVRAM
>   platform/chrome: cros_ec_lightbar: instantiate only if the EC has a
>     lightbar

These patches have been applied to my local MFD tree.  It will be
pushed when 5.0-rc3 has been released.  The MFD tree needs rebasing
onto it since it contains all of the MFD patches due for v5.0.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
