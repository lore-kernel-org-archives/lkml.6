Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C162C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF70921479
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fztLfO0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbeL1QFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:05:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37075 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbeL1QFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:05:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so18961288oth.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezGYfVxiwhlDU503aVqkNVICSduystT0QEAYy84RgY4=;
        b=fztLfO0DXWBYQ35Nz5OkG1AxRjZhZABkT878ZN8nmYN5+7yD/I3qbE1Pvukiqb4Ouo
         ATCsUH5/2VLHV5RwcVW7gX+OFDDORrWMtsfA/IFKVWTMOAZCnSRvHRLzOMXVC6ysavux
         lrdou3MbozxK716J+y6cye7q8fjM3mkpjsrRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezGYfVxiwhlDU503aVqkNVICSduystT0QEAYy84RgY4=;
        b=UZIUN+iY2o1alInN84CqAPjtl7hdxPCD1HGryzJKJCKsN+HMdD1jbuFleM/EcpwVJQ
         MG4ZLuesqczFZSVyeYZGI4/9GDYPQy5YK6KhGkEpBt2gskGhi4MfGWlB6SYaMdSCedPQ
         jKvFc4aQePN9BUSwS9b6MjZqjeK9aNz5S/Ozbw/Zobwo+CSr7YyRZWrfQKJ6VCKqf5jQ
         tN9mdhyPphhTO0DhtWgbSXfyEhnNce2zgOWlfrkQCBSrJ5mLxacolsuqNi32OGyinRiu
         1XnEJBalFHrHEs6P2lN2cvQbi3MgspXYleAc/WpDciHnREzausCKIMnkiBroRXMeCMhv
         sqaQ==
X-Gm-Message-State: AJcUukc1USZg1JVOOYbSrV8JUyZ0ByKRURcC454qjRAA0fzPwKO4RYss
        4nnKZElKdP722HDlwfEnHwn4dw==
X-Google-Smtp-Source: ALg8bN7r1HuYdAqB7iSYNL/3a4xAII9XX5thrOd0eQZVkZNOPfV+ymfot699NE25EOSTCek7SiO2SA==
X-Received: by 2002:a9d:8e4:: with SMTP id 91mr18438655otf.169.1546013150937;
        Fri, 28 Dec 2018 08:05:50 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net. [107.207.74.175])
        by smtp.gmail.com with ESMTPSA id a1sm18537313oto.71.2018.12.28.08.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:05:50 -0800 (PST)
Date:   Fri, 28 Dec 2018 10:05:46 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kishon Vijay Abraham <kishon@ti.com>,
        David Brown <david.brown@linaro.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
Message-ID: <20181228160546.GC25288@hector.attlocal.net>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:13:18AM +0100, Marc Gonzalez wrote:
> The private copy of readl_poll_timeout is no longer needed.
> Use the implementation in iopoll.h instead.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
