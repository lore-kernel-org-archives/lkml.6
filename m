Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CFDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A940215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A940215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeI0X4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:56:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40879 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI0X4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:56:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id j68-v6so2894668oib.7;
        Thu, 27 Sep 2018 10:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R4zDYzwQqhcxwF+yg1NcBmBqzc9E9jFi8A3YACh7UBk=;
        b=P49RAqOIP9PqOhN7LSmS5kh1867mS1epWNruN0CAAeS/VCDB7d38ghmxARhM/r9tVE
         6UuQJV4xOGvdNRA/okFM0D/ncqau2ugKMeO6U/ruUCvkwQx4PIjYwci2Q2mMNMuADMcR
         YLPmUwWl+IV5cAmIhCpSCn25ByvTQEeDuV7ruzjaSRrozewh6L3TZI0Rf/3vLSJZICk8
         z30umIZ74IPAgalKSdXaZ0f5No2DFO7lJdXmxqk/dDqEsHVgYCThR8Lz5Pqu/KMy9T1e
         5OEaPpxuZPe+kljBRxZcjGZflP8tNj/giCD4ijXWObtoHI1z55QzcBje+3LTFBJST0in
         Dv/A==
X-Gm-Message-State: ABuFfog4vXeOpFtCgfxzU1AzHUQiax5uoQu60CYx924Q2J3+3f3Ok5gs
        Bwmxq9vKtVJFbiesLo4q7A==
X-Google-Smtp-Source: ACcGV62qixWTnHQHiKYb1mW8NCllAIGhnf2uuc/O/NDkDv/is4xyA2mm7GTTLcGxZRGBSwv59xvxDQ==
X-Received: by 2002:aca:728c:: with SMTP id p134-v6mr3923639oic.141.1538069799300;
        Thu, 27 Sep 2018 10:36:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q63-v6sm881833oia.54.2018.09.27.10.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:36:38 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:36:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V5 27/30] dt-bindings: interrupt-controller: C-SKY APB
 intc
Message-ID: <20180927173638.GA5231@bogus>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <962274d8ec61f3900b19c07bbe8923674c94d044.1537789737.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962274d8ec61f3900b19c07bbe8923674c94d044.1537789737.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 07:39:30 +0800, Guo Ren wrote:
>  - Dt-bindings doc about C-SKY apb bus interrupt controller.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../interrupt-controller/csky,apb-intc.txt         | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
