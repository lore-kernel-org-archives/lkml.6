Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78432C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ABE21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ABE21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeI0FHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:07:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42154 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeI0FHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:07:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id h26-v6so634050otl.9;
        Wed, 26 Sep 2018 15:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qeO21+Ho/mf2yrQ++MKDVAx9VNlfFTwclJqrDTS7d38=;
        b=iSIeKwpkztgpgU1CFQ9IiQC4Uv06SzmtpdxD8ozPr4kSOQIURfacmqwHlRc0OafBkY
         lmfVfSE0KVL7xPnmEs3gEjYeEPzfKHDsIWJ9+Ck46ZMxz7eeocT7/k/y/kKWKZIzFHDp
         K2jESaMd/rDTKwaPBf8mEpaQUWy3iR0VUHxFyQUyMqyej4Md2SIkT2NLO/FloLEb4E8B
         +cfAB6TNL8vbvijqtc1io8tOdHyim4vSMY50JVGXeneUIHosOfMRFy/pSQIi3VDWPbCS
         RICftUyo2Eyygg7b3RyVNtcCKSSmjURtlo98A6oGBppuZhL5lYGuS44L0T3R56YqEGUi
         YVNA==
X-Gm-Message-State: ABuFfoiysPeteEhVycmTCW21+N0XqxJh8yfhvKw+79dvLQoFl6agjBUz
        CUhVsK41hyBvVTVw8V8PlA==
X-Google-Smtp-Source: ACcGV60Bj9nZMpQzY1FzJikgRPEtSiu0t1IZ/kc2umbsLWLryXr1tKp89gvoP6K4DG8gyzwpP0L0ig==
X-Received: by 2002:a9d:40cb:: with SMTP id t11-v6mr5764298oti.275.1538002311667;
        Wed, 26 Sep 2018 15:51:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v20-v6sm129773ote.48.2018.09.26.15.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:51:51 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:51:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 1/4] dt-bindings: mrvl,mmp-timer: add clock
Message-ID: <20180926225150.GA15157@bogus>
References: <20180918205455.25464-1-lkundrak@v3.sk>
 <20180918205455.25464-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918205455.25464-2-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 22:54:52 +0200, Lubomir Rintel wrote:
> The timer needs the timer clock to be enabled, otherwise it stops
> ticking.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Made the clock optional, to keep compatibility with DTs without it
> 
>  Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
