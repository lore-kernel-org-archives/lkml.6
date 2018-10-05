Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E431C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EED213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EED213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeJFDV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:21:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47046 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:21:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id k64-v6so11394843oia.13;
        Fri, 05 Oct 2018 13:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xORmg2/yqLwp/FIEDVZ7rbMCdSefSAS7PpPeXT0VoLk=;
        b=Qho8BdrFr6pESWmLlFCnfy/2sowkkKxHpJnEFjOVnWI40Az6cejJjlUlQp9+t9XqgY
         Q36u9+K8P2/j+siZLMMhXYNlVh63LZDBjBJh3Xh8rLrD6USLHFaTBQW1grCpqXz7jAMs
         QtenfWeCGZxKV4HREHjk/gKJsIO9matmMxmrxGQWIo9JXpjTGhOKKv6x2f5wZwbb8g/a
         NsM6rT0BKFy4T6hwErRqW2IxCHEhD9mNTnGgdqoFqjmrQl2l0fV4LZmvUBv0FOO7LW75
         xVmixQPVlwV6h66RvoaIA88RZzs+uXm9hSbDHDsoSH7BW+Ai2jA6wCEyLK9LyfreXVH1
         5+hw==
X-Gm-Message-State: ABuFfogkY/Kf39+mVtm7RVMPfgbm9hPlYnFyf2gF67GvytWBBP1xZAfq
        E9+u5LEMfBwBtEzOZrf2ng==
X-Google-Smtp-Source: ACcGV60LOav/rCwawykpUWcbWuFZv4ltmCTqO3Se1roRQgWoF80ZXBz64shlvoxvbuxzNmk3dm7ghA==
X-Received: by 2002:aca:b3d6:: with SMTP id c205-v6mr275663oif.133.1538770870139;
        Fri, 05 Oct 2018 13:21:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x65-v6sm2863104oix.47.2018.10.05.13.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:21:09 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:21:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, daniel.lezcano@linaro.org,
        anurup.m@huawei.com, Jonathan.Cameron@huawei.com,
        will.deacon@arm.com, zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V10 8/8] dt-bindings: timer: gx6605s SOC timer
Message-ID: <20181005202108.GA20389@bogus>
References: <cover.1538672812.git.ren_guo@c-sky.com>
 <6ed886ec014de868e0a84a62e339e45de4ea1e5f.1538672812.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed886ec014de868e0a84a62e339e45de4ea1e5f.1538672812.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:22:28AM +0800, Guo Ren wrote:
> Dt-bindings doc for gx6605s SOC's system timer.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/timer/csky,gx6605s-timer.txt          | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt

Please add acks/reviewed-by's when posting new versions.

Rob
