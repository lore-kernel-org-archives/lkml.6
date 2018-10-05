Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6C8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDD1213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDD1213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeJFDWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:22:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37545 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:22:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id o13-v6so13925373otl.4;
        Fri, 05 Oct 2018 13:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSTXl2C9owvKl/AdOXG7++SVCx70CVfJ45BpYxit6r4=;
        b=rNnLeZTY8SxuF15Vz2sGKlQ9MiLsn3N2OE/qErYPzoHqZYtRmSwrTobjDjmMntJ0/h
         66cfAlrZk3vY7iERYo5GjyY4iE4qBsU7QaDcQ+kxTOW2PpYxfeZrWAgREAMkY39Px9Lr
         odfTHKmEzv2+21YZNfqAIjnIpDVQggOlQyEX6H1LGvCcU5+V2PYU8phl7EUz68IG8zuA
         KCTdXm4YOlQRDfywSjDQNlQSRsmi+f18MQw0SdPLO2wy6NyrAODri4ZiEFA1U626pu0R
         hvzZ+FSeS/O5aUL4HWKLMgdeWWpHgOZ83mBMjaYlfQe3ZtbJ2R6zO3jYuFtTHxjFCnR1
         lZrg==
X-Gm-Message-State: ABuFfojTCauZDZwoUgf2XnI8PSOa1ciuYCjzjyydiSntwvStM1gtFjPV
        08Loqwnfc6nObcJ9e1SD6A==
X-Google-Smtp-Source: ACcGV61cGn8/YPlSapVrHwIvRmtuhoT9B/l5z93sBqHGqR1Vvufncw8ct5M6ZzU6S7bpFXG1SxkxeQ==
X-Received: by 2002:a9d:2926:: with SMTP id d35mr7943284otb.266.1538770951545;
        Fri, 05 Oct 2018 13:22:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a5sm3144606otj.46.2018.10.05.13.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:22:30 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:22:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V10 2/8] dt-bindings: interrupt-controller: C-SKY SMP intc
Message-ID: <20181005202230.GA25493@bogus>
References: <cover.1538672812.git.ren_guo@c-sky.com>
 <22b6f2800b7f0d6ad1ac5b845b34fc9c924f019f.1538672812.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b6f2800b7f0d6ad1ac5b845b34fc9c924f019f.1538672812.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 01:22:22 +0800, Guo Ren wrote:
> Dt-bindings doc about C-SKY Multi-processors interrupt controller.
> 
> Changelog:
>  - Should be: '#interrupt-cells' not 'interrupt-cells'
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
