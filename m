Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E601EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F4820874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F4820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbeGWSP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:15:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42147 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeGWSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:15:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4-v6so1594371edp.9;
        Mon, 23 Jul 2018 10:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gMVxA94XhlCxWF2CNoxSM39SHWF4wOIUemjEFVpSB4k=;
        b=hqglQHS5QB73X8A6Euvpo0DA1q13ZLzDDeKzJYqKB+8wbawgXSrPXk3oLsphwD20th
         GBcm+rDPacjRFVMFmjjIBh8/oGijJmBLCxFNOEm6XeNbrityGAM4rX9MpQtAWSKiM4dX
         VTHm5en6hvgyiQ5TluYnDqN/IgKzxeqcFSvrvh77id5vhxsbU6oF83KUVeUtFAtxReLu
         ZS2LWfE656e2i1YRk0/X0YZIimVzJnl53MnqZKBt9ORi2IL9xLoZDIF8k7dY8XqzNBit
         im7GUzhSGpfb0Mj78vZw0uBSgycifTCM8QoygRkd58m87IraknF9Dv+UT4S5uupdlKEZ
         bqKQ==
X-Gm-Message-State: AOUpUlFAZQ4Hqn4f0UH+MpxMDSouLhB6eLDV7n4rHYhmGsuKRjIhDYlp
        yss0oIczjHCYDEZM+i2d5EY=
X-Google-Smtp-Source: AAOMgpe/ULbp4387/a2wIpyti1FsKAm/pBYqckFLMMiSuGYv7FrnlW8aH2ryuYb9H9TVIk2LzVRYMQ==
X-Received: by 2002:a50:93a6:: with SMTP id o35-v6mr15001095eda.300.1532365993975;
        Mon, 23 Jul 2018 10:13:13 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id f25-v6sm4615707edt.57.2018.07.23.10.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:13:13 -0700 (PDT)
Date:   Mon, 23 Jul 2018 19:13:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Simon Shields <simon@lineageos.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ARM: dts: exynos: configure max77686 IRQ pin on midas
Message-ID: <20180723171311.mowgm3j3ikdhnj36@kozik-lap>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-5-simon@lineageos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180721125128.31498-5-simon@lineageos.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 10:50:52PM +1000, Simon Shields wrote:
> This pin is externally pulled up, so we need to disable the
> SoC's internal pull-down.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

