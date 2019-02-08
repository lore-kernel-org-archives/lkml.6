Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3111C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDB020823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leb6vN76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBHK2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:28:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45739 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBHK2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:28:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so1382569pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p09V2S7OIkLdfFhBGIwLYYlq78eyifsffg80M3hgwMI=;
        b=leb6vN76XpLeqXQ3yRHsrF71nkJSOivPC6ccTD/CMMhJpcV7hIY7XzAw/xrv9d8ugY
         Yy/ajOyHBSytwE/Awnu7RG5xq+UsB1id0ReKXAZx5CfygdWl6P9ZJDtW3jWQv1VB8elC
         d7MS6ZyIuYrrTbzREAjrHn3EDPTpmAY9lP8p7HywYB7J7gNAAaGgAu98eIlP5m88XUMg
         beuZ6jFtD2guvll/Froal3A8o57VXxZzVm9WAyNFvpUlk59PF6+4uCuTbtFMEoRHjrWb
         0ZJwfXSu8AemThRBSB+FT6vXM0FatFtM0qmOPdXUANx+JIXspgNeXq1zg+7P62RwAH75
         PXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p09V2S7OIkLdfFhBGIwLYYlq78eyifsffg80M3hgwMI=;
        b=oF//npPPwxG3Z0t5lVoqtkTcjSVAua/NzxT1eb6CzwTO7kmH+V1vh0XW0yQN0YggNZ
         /tr7GuoYzn9yOAFPyI21aw6GZ92fCUfSyAzeXvZfaxqWqzu+JspYgBfAiQis/1Dks7RY
         rYwPKlwCWTcHskXxmd6AdkXvG1sk/U+ka9ajqZUqBK5/V/urgcs8CKM2sxFAbOitIlz+
         Qq2witP2asiZ2bfOBQRY8kvzssWKhfmVkFc1ZdA/I8wm5YC/2r8i8Q8pJrh1Bv6q4YI1
         I8kqsWwB+K2cxnJXuheNh1JrePX69x8oLcoklcUf3RlotuTJsR6qJhzuMMdJMNv49S5l
         c9+A==
X-Gm-Message-State: AHQUAua41W5YZY8jJ9vHuVG01RL4PicTf+U3SuOuk/v1DAEw+VeqeYJu
        l2hQpS2czx+n5klfi4WJYC214w==
X-Google-Smtp-Source: AHgI3IZBX4Iue3yHpBGQULhdmb7oOz21N8xRqHOVrYCJcBEzE3udh2nzqVrOOcwkZ0kGkHfJ7tng+Q==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr9565633pgt.243.1549621718574;
        Fri, 08 Feb 2019 02:28:38 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id l87sm956010pfj.35.2019.02.08.02.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 02:28:37 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:58:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190208102835.fjxyeyp3kkdwar5d@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com>
 <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
 <CAJZ5v0jB7CDd9+gX+R3e+yrEsJty1E2MwuJGnuaJS0QeHeJ5rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jB7CDd9+gX+R3e+yrEsJty1E2MwuJGnuaJS0QeHeJ5rg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 11:18, Rafael J. Wysocki wrote:
> Obviously, all I2C transfers need to take place either before
> suspending the I2C controller or after resuming it.

Right. But all I am saying is that it is the responsibility of the
cpufreq core/driver to make sure we call ->init() only when the
resources are available to be used. For example during driver load, we
defer probe if resources aren't available and that makes sure ->init()
gets called when we can actually change the frequency.

Shouldn't the same be true during resume? That is make sure all
resources are in place before ->init() gets called ?

-- 
viresh
