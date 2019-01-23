Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8512CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5186121726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKTFJpu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfAWLQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:16:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37837 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfAWLQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:16:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1026107plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 03:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PK3+Mb2dwsAXIF2yB3Qf5s3LT4TcmZEvNwgdLMgy6Bs=;
        b=IKTFJpu3aI974ikZSJm6SgcIbGXi4EKKjoT30RMVvTFi1x3iHYHH5ID5otscUI5EFW
         zfemOnAg/XzFXACuJo1AzfvaEGBgwwssFbGZzksiygop7qvQcPhvXvL677hr9UTP+qva
         COZcKjTNfs5j9YmtPA6XE/Zjr0PbElnt8Fc2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PK3+Mb2dwsAXIF2yB3Qf5s3LT4TcmZEvNwgdLMgy6Bs=;
        b=d51xhlXxdrt2XUqPCsCHkJwr5gkNvvGf1LACJOhDBNQ+L4tLpws9i9UZxB6GeEagDz
         4zq8QjCFyrwHPDiFrBUR6+fZYIaoHa4Dg90owe3k76Fem4nPHy8/x+orjju7C6LcYo2Q
         PfTBf6gjQlvuAZSa03H7/ZHjYYeMVKccmEtQK/FNHSNn+1AAfSyYrqwPn4jSFi9R5xw8
         9LbJzQjn7fYjXU9hvzE18frjlzxO/epb7zccMTUXDyASz99y6sFfie9JDCG4w1R7s7lj
         +Dqs47z0Ho/jFxLE8dOAcTQ2u/NBnbc1ET9soV8gZ4P9v49J1SEIhma8Y8YI2aqN6AUQ
         ajUw==
X-Gm-Message-State: AJcUukd8hmND4ePNts54/6iEVkamxd/iYig/I7YddAX84ZE1O5kavy/7
        FjK7JL4xRGP0oJaLbzn3tM261Q==
X-Google-Smtp-Source: ALg8bN5D6C9kWx9/8Z3Ge0b7g4xrKkQIPFyYKWNOeKb8q6zCrwrpINP01xEovO13zdKKb/U9L1D/Ww==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr1826238pld.181.1548242193278;
        Wed, 23 Jan 2019 03:16:33 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id o4sm44147961pgs.12.2019.01.23.03.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 03:16:32 -0800 (PST)
Date:   Wed, 23 Jan 2019 16:46:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
Message-ID: <20190123111630.s33rzxn7o3mr6kks@vireshk-i7>
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
 <df735d42-d208-62c7-ddbc-87ea314c36d1@codeaurora.org>
 <25f46403-e78e-271b-c4d0-13b4623846b3@roeck-us.net>
 <864348fb-3d06-7b4b-cc82-17c96b7ce219@codeaurora.org>
 <20190122100854.nuepsz5ddbt4jda4@vireshk-i7>
 <57f73ea8-3be4-470c-1ef8-d870af605347@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f73ea8-3be4-470c-1ef8-d870af605347@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-19, 16:05, Rajendra Nayak wrote:
> Seeing this now during remove
> 
> [   34.008216] ------------[ cut here ]------------
> [   34.012894] Device 'mss' does not have a release() function, it is broken and must be fixed. See Docum.
> [   34.024143] WARNING: CPU: 6 PID: 1600 at drivers/base/core.c:922 device_release+0x84/0x98
> [   34.032379] Modules linked in:
> [   34.035477] CPU: 6 PID: 1600 Comm: sh Not tainted 5.0.0-rc1-00012-g0513915837c5-dirty #34
> [   34.043724] Hardware name: Qualcomm Technologies, Inc. SDM845 MTP (DT)
> [   34.050305] pstate: 60400005 (nZCv daif +PAN -UAO)
> [   34.055141] pc : device_release+0x84/0x98
> [   34.059186] lr : device_release+0x84/0x98
> [   34.063229] sp : ffff0000183c3b40
> [   34.066574] x29: ffff0000183c3b40 x28: ffff800174b55100
> [   34.071930] x27: 0000000000000000 x26: 0000000000000000
> [   34.077285] x25: 0000000056000000 x24: 0000000000000015
> [   34.082640] x23: dead000000000100 x22: dead000000000200
> [   34.087997] x21: 0000000000000000 x20: ffff0000112f9780
> [   34.093352] x19: ffff0000112f9770 x18: ffff0000111dd6c8
> [   34.098719] x17: 0000000000000000 x16: 0000000000000000
> [   34.104072] x15: ffff0000983c3867 x14: 6966206562207473
> [   34.109438] x13: 756d20646e61206e x12: 656b6f7262207369
> [   34.114791] x11: 207469202c6e6f69 x10: 74636e7566202928
> [   34.120147] x9 : 657361656c657220 x8 : 742e7463656a626f
> [   34.125514] x7 : 6b2f6e6f69746174 x6 : 0000000000000149
> [   34.130867] x5 : 0000000000000020 x4 : 000000000001c200
> [   34.136223] x3 : 00000000ffffffff x2 : ffff0000111f5828
> [   34.141579] x1 : bc1d8ed5415ab200 x0 : 0000000000000000
> [   34.146936] Call trace:
> [   34.149413]  device_release+0x84/0x98
> [   34.153116]  kobject_put+0x98/0xe8
> [   34.156551]  put_device+0x14/0x28
> [   34.159899]  genpd_remove+0x108/0x190
> [   34.163598]  of_genpd_remove_last+0xbc/0xf0
> [   34.167828]  rpmhpd_remove+0x2c/0x48
> [   34.171436]  platform_drv_remove+0x24/0x68
> [   34.175574]  device_release_driver_internal+0x184/0x218
> [   34.180845]  device_release_driver+0x14/0x20
> [   34.185152]  unbind_store+0xec/0x138
> [   34.188760]  drv_attr_store+0x20/0x30
> [   34.192465]  sysfs_kf_write+0x48/0x58
> [   34.196163]  kernfs_fop_write+0xcc/0x1c8
> [   34.200129]  __vfs_write+0x34/0x170
> [   34.203654]  vfs_write+0xa8/0x1b8
> [   34.206998]  ksys_write+0x5c/0xc8
> [   34.210345]  __arm64_sys_write+0x14/0x20
> [   34.214318]  el0_svc_common+0xb4/0x118
> [   34.218107]  el0_svc_handler+0x2c/0x80
> [   34.221899]  el0_svc+0x8/0xc
> [   34.224804] ---[ end trace 9cee1458d0b6c175 ]---
> [   34.229490] ------------[ cut here ]------------

This shall fix it:

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 500de1dee967..8a44b1f356d0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1711,6 +1711,15 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
        }
 }
 
+static void genpd_device_release(struct device *dev)
+{
+}
+
+struct device_type genpd_device_type = {
+       .name =         "genpd_device",
+       .release =      genpd_device_release,
+};
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1770,6 +1779,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
                pr_warn("%s : no governor for states\n", genpd->name);
        }
 
+       genpd->dev.type = &genpd_device_type;
        device_initialize(&genpd->dev);
        dev_set_name(&genpd->dev, "%s", genpd->name);
 

@Ulf: You fine with this ?

-- 
viresh
