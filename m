Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0042C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C64A20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYk8UEWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfBADuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:50:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43546 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBADuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:50:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so2484774plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 19:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dnJny4uhEhe7lSqDgB/6BIGfujg3swil9O1FBbC8amE=;
        b=aYk8UEWosKj5RexzzsV1JoQ2eLErO2RoUMCNaU9nMDoFsqSJr29od+M7wK1JX371yt
         t5gtS4HOsOGoYxT+sXeluMnJsXiBsl5uPUFLz8YdYckc1mVcEG/dfxkQcNCpLidylmlq
         VFEaAJmepp1QqGoiQ3IWJkJLo8GMv1aPVe2To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dnJny4uhEhe7lSqDgB/6BIGfujg3swil9O1FBbC8amE=;
        b=tEjVlu39imeYMa0wYuCeinIrw24mdWYFl5knJr+O/O4WP5I440mAlfJfEsqcJrjxz3
         GLkQ3Hr/diV+3tCxCQFl7fYY59dQhrvaoa9BYAPsYdGiZQnnU/ut1KMIqbS49MkETRd2
         3zo0cONUjHwWxasoGDkZ8NN/ZOPuX+J23wPwCWWzLLAKuxxQ/z7+bfzM/33L25rUZ9+1
         W0qb050tvdySGfV1MqYyYJbfXg1SJJ7Zr0dCYvvpyaAuzlKECuK7WjQYii+M5FF1kPpP
         FXs66sOQ8vaIgdLAxnqakFbRQ7DdWvMzRgprZswEQIUlkMOyUVhOnX3gG3QKIxm+NH47
         ZSuA==
X-Gm-Message-State: AJcUukeaH2C8niGSV3TBeHzpWOSbxOlo2nrg1R+rr6DjZ/lQqzFOGoDT
        n0IXzZ4XfSHRM7AOh6roMH2hTkKVUA==
X-Google-Smtp-Source: ALg8bN5Y8lXv+UyUpoZ2zLoZOVfbtpxACC5HXSO7v1P4+AY3PfBcgydwM6PMd0p4rciJt8fwxwrjgQ==
X-Received: by 2002:a17:902:5601:: with SMTP id h1mr38567576pli.160.1548993013015;
        Thu, 31 Jan 2019 19:50:13 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72ca:1df8:3db9:68de:e3db:c028])
        by smtp.gmail.com with ESMTPSA id f64sm26113585pfh.0.2019.01.31.19.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 19:50:11 -0800 (PST)
Date:   Fri, 1 Feb 2019 09:20:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
Message-ID: <20190201035005.GA4283@Mani-XPS-13-9360>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
 <CAK8P3a3Y_w5_ZavpyUh0VKrS8FeUPTJKkchtGGLc1qe3nG2mfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Y_w5_ZavpyUh0VKrS8FeUPTJKkchtGGLc1qe3nG2mfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Sun, Jan 27, 2019 at 10:24:09AM +0100, Arnd Bergmann wrote:
> On Sat, Jan 26, 2019 at 5:11 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Hello,
> >
> > This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> > Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> > processor subsystem, a single core RISC-V subsystem and a Tensor
> > Processor subsystem. This patchset adds support for only ARM Cortex
> > A53 Application processor subsystem with UART, which enables the board to
> > boot into initramfs with 2 CPUs.
> 
> Nice work! All patches in this series
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks. What is the merge strategy for this patchset? Shall I send a
Pull Request to arm@kernel.org with topic branches?

Regards,
Mani
