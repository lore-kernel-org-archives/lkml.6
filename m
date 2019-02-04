Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285BCC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE46217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSJgksZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfBDHSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:18:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34432 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfBDHSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:18:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so6369491pfg.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 23:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wqy4+JpXE1cgPX11Uy1+BdyXJ1v//t+GbY1O5JovKWs=;
        b=WSJgksZbFzw8g9125I/YE37zmRvUbbnEUaE4SKkcZAR7ThkIvpXfiBa74jtZ+n3YHU
         zUSPn51m4eixznYK/gqZE/YpEqg4bPjokt5TxZa9QebhD0BcJjYZKvH8X8kaTFHhaiVO
         7Cy0izMQ6eTqznIMmYK+SD8CF/lSSyobSYbzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wqy4+JpXE1cgPX11Uy1+BdyXJ1v//t+GbY1O5JovKWs=;
        b=i/0jt9ln9By1gZQi4dl4NjMpAbzrazEyJ4kq7/pZFixIOdtbfJE65RxbU50kgphoJO
         QczcZ7FEb3cjySbgVHOFUCZPxP2Typr997096hM7syzvaC6ZkX+HGXJgaa7vABkIIl4H
         8JF2toT4flA25rc+p4OSPlnyyb4Yw1YSOt7h411otO5MV6Lmn8eEWRwf0rdBT2VXPcI/
         NPFRxG7x3sqwZCsL0HQQLxibtS2DzJzBKMsMyBjWPTYnZQnHnH/IjF26jmcUYpVo4nfB
         Q71MGpIRyjI8hjkQi7I4THuJBoOnLTaQRuUvMIAcwVRlq9uPwRkgS/UEFXxGvijfiVWT
         kveQ==
X-Gm-Message-State: AHQUAuZySZvyw/7WloT5FesPyyvs3Z5VLCS9CRB9YIK2FZRb901KMzT4
        YzmEwb9wFaIF9DcKmVx2nvpuUA==
X-Google-Smtp-Source: AHgI3IZw+Nk5OKaKMoyWiypL3ucQ9/NJt0LZm2Tii/Lwd0ewxn4swowaaS6LVxOSPhKcnsAf+bVO5g==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr12118966pgd.344.1549264692693;
        Sun, 03 Feb 2019 23:18:12 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id l19sm28827775pfi.71.2019.02.03.23.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 23:18:11 -0800 (PST)
Date:   Mon, 4 Feb 2019 12:48:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, Thierry Reding <thierry.reding@gmail.com>,
        jonathanh@nvidia.com, Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
Message-ID: <20190204071809.versc7prqit3vzgc@vireshk-i7>
References: <20190204063501.1348-1-tiny.windzz@gmail.com>
 <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
 <CAEExFWvcWAmzKtnCdnVNJz1kh1QQ-Y8-LRpH36YacQerFpOS9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWvcWAmzKtnCdnVNJz1kh1QQ-Y8-LRpH36YacQerFpOS9A@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-19, 15:00, Frank Lee wrote:
> On Mon, Feb 4, 2019 at 2:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 04-02-19, 01:35, Yangtao Li wrote:
> > > of_cpu_device_node_get() will increase the refcount of device_node,
> > > it is necessary to call of_node_put() at the end to release the
> > > refcount.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> > > index 43530254201a..140a9266b64a 100644
> > > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > > @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
> > >               goto out_put_pllx_clk;
> > >       }
> > >
> > > +     of_node_put(np);
> > > +
> > >       ret = tegra124_cpu_switch_to_dfll(priv);
> > >       if (ret)
> > >               goto out_put_pllp_clk;
> >
> > Fixes and stable tags ?
> Hi viresh,
> 
> Like this？
> 
> Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
> Cc: stable@vger.kernel.org

This needs to be something like:

Cc: 4.5+ stable@vger.kernel.org #4.5+

Also I don't think your patch is entirely correct as we will end up
doing of_node_put() twice in error path.

-- 
viresh
