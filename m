Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35486C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF6421736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyUVgcEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBKIoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:44:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44501 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBKIoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:44:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id y1so4640463pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/iyvwIiLL+/J3ZsFRLfEOyGYB0t9tKZjd1RN306gWBI=;
        b=oyUVgcEBt1dgVUBvv1kEtl4HL97a3+dvdr5a7I83OZI9L6+jaPTMwoECuFCN9ZSxda
         L1Tc3VceaNpjC5xPtpt1lELHg6H9RiPZWNTj/YnGuu744BLc0jox35s0ZxnOy+G65PMD
         V0mxM5DYomfhubXDUb3UP7tFWxJUcL6YrKzWrBtv1khGLcamzrEPKVzwAlRuf7XPIcSw
         dyES9mOQMrxZTm1TlyhOjNa38rI6AlCCABgAqZydbNSUE9kh299lcbNp/5yeUW5ZBfFo
         z6l9HH79ZMLbnyLIlyQg3o3yquviJpyEZTcKzUZ/JQkCYFQ8Tvq8fnk3gazkSPTwMF9P
         vHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/iyvwIiLL+/J3ZsFRLfEOyGYB0t9tKZjd1RN306gWBI=;
        b=rmhBgWRWLqaAUtSGvP5v5nVbCLAAU15lzr3sMYVsaebmXfLwbQrJNuX4MfmqHSR3d2
         FAkJS1HukDHPXvWrxhVN2HcPqavJ15YF829iXYHIp617ADOIr2kGhgKf1JpuMCfiJJgK
         cMCuzi8ey6KZpxEYkbSOS5eYRPoJq9z+EeLstJ0mAUpNnCagOWuW+a3iN+kFA/KT3TBO
         8GUAk/KK+xSCUeW8fuzajba9S0KXWLMaYnhjjlKhb+24ZPLmkQwERkf3rCke7ggZP2Mr
         d22HUT/6dOixF7TenHjrTVI9CQAm0dOO2VsuOBGaNShUxMLbAoy+3VeSvZj3ctE3aRlL
         VqWQ==
X-Gm-Message-State: AHQUAubEsvLA0ig7MbzTQ9kxYrdg9YbQprCEjKkHOCocRphbZk6Fgq7O
        1DbmNrqyGg5HxYJjPGbgjMzQZg==
X-Google-Smtp-Source: AHgI3IZwjWWSuq37r2sCvAcyjdn4L6w3lleHFXTa+dss2fskN7mZev6TTP0qoEr2/JJrJl86bZPVog==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr27515229pgf.388.1549874656025;
        Mon, 11 Feb 2019 00:44:16 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id e24sm13517117pfi.153.2019.02.11.00.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 00:44:15 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:14:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>, Sudeep.Holla@arm.com
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190211084413.b53qyx6sgkxsjhdv@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207122227.19873-1-m.szyprowski@samsung.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-19, 13:22, Marek Szyprowski wrote:
> Dear All,
> 
> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
> i2c adapters") added a visible warning for an attempt to do i2c transfer
> over a suspended i2c bus. This revealed a long standing issue in the
> cpufreq-dt driver, which gives a following warning during system
> suspend/resume cycle:

Marek,

I have sent a patchset which is not directly related to the problem
you are facing, but it may solve your problem as a side effect. Can
you please see if that works to solve this issue as well ?

https://lore.kernel.org/lkml/cover.1549874368.git.viresh.kumar@linaro.org/T/#u

Thanks.

-- 
viresh
