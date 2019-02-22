Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1ED2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550853702;
	bh=A2meraKvvJ6OdMeH4x4K/YBVJu0Gw7UDRLgeycrcOLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jby+Vr1m/UaLZe5U+94iRZ6GoYZ2Cqi7wdL7phB+09yT7HdPfdCVqx5q2NWugZe6F
	 aHLojC1JxGyTTaDkPrso4yy5t7vBkYUDcyzsTK5+VnWMBdKD0jH5zSfkt9F9/P7ie4
	 3cuZTbQMvIZbMJ/TLRq9KOPUJKG2mw1MaBV5grw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfBVQlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:41:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38660 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:41:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id m1so2385043otf.5;
        Fri, 22 Feb 2019 08:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XMd6d5tyjUw6DCRtlAjkYupHm7RKPdnmR4ieEeDu3s4=;
        b=mj6dGZrtk54tNDRVxo8KxqFIt+5hGUH0dKEeunzAqgWcbw/ZDMcEjyPk8YYD5uVd3h
         a4nSkuAal31eQclZdEzRKUzo96qUtVRM/66Ki3TsrzO523XWDoKvtb+TMnCzVo5S0CPV
         OY4CvNfslKW/MoXRsGbkbaSHzZGoA+60YqGCfEs4a/zoMS618fBmvpOAtxg6+IoUsk2c
         ZRLc8/sKL9ws9zyQgTKrwOqhrYVw5KzR7jChdGjtj2maPb22LzgxUWnt6aKLYDWADEoG
         XgFs3sHB05gNjbUlAJFKRpyIqJPDsjPw+CbE+sglr5K/oDh6mvLk4adBM3Y1+gy8zTbZ
         DHbw==
X-Gm-Message-State: AHQUAuYPb2nWaUOU5TW5NtXIJxu3a7B1L2Xen3WNNfvtzXGY8vckEBgW
        urZ/BORZChFsEStqdwh1pA==
X-Google-Smtp-Source: AHgI3Ibwxyp38dJDZl+owediDt3iGPWdSU0G46lSSkxo+oDaaxei8z19jackp/IDcMahcGQJH1Kx1A==
X-Received: by 2002:a9d:220c:: with SMTP id o12mr3099431ota.19.1550853699201;
        Fri, 22 Feb 2019 08:41:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x127sm734264oix.25.2019.02.22.08.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 08:41:38 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:41:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v7 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Message-ID: <20190222164137.GA23340@bogus>
References: <1550740301-10097-1-git-send-email-yash.shah@sifive.com>
 <1550740301-10097-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550740301-10097-2-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 14:41:40 +0530, Yash Shah wrote:
> DT documentation for PWM controller added.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
