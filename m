Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2DEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918EA22BD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918EA22BD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934468AbeGFUvn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:51:43 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37908 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934102AbeGFUvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:51:42 -0400
Received: by mail-yw0-f194.google.com with SMTP id r3-v6so4634768ywc.5;
        Fri, 06 Jul 2018 13:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aqd/TWgtm8DNR7aj4buwZFKTsrdGM2nW4cQcnmlmj8A=;
        b=MQm9jvXyvyi8UjalwQAWs+YzKPaiJyl4gBSobfI+QYPt/hGGkkd7/r+v1A9vfTUpMQ
         c4vMZKuSU5g7iCCM2Jcpe21QMvTtvGizuutw48u0QQR0Skm1qgTGfb20Kb3kdwdwfJ9L
         L/ZHvUVsazE9UrZruF2EODU4/YpqIaGRWfWa7Pybkwb6qhUvtu9sKj397d3gKVrwr4qn
         t7PPqidSqNIBLSeKB3IuOPKM40y4nvQlPDifI64xQHnOyXJtQMycg2vtwXNOTYOp4UJ6
         hjFXf4+eEI8wVfLD+rT6i/EQJ3fdcaCQR6JfoMKS/Ax0YH2isZXTkfn0880tfoNGySCb
         pJzg==
X-Gm-Message-State: APt69E2lGuA6dN1IGyBLbwPOsWbPk9VFDp3WXbMa/7zCs8i8f9Vzpvj1
        e83xJaa/WvEmeX0tesuCLw==
X-Google-Smtp-Source: AAOMgpe3UShXRtYDuKntb9YA8oSeJDgiAIvR+Wyomc0am2tjaKUXNBeWjE0tBWRUyKzcU/E47r3cRg==
X-Received: by 2002:a81:8106:: with SMTP id r6-v6mr5544659ywf.159.1530910301303;
        Fri, 06 Jul 2018 13:51:41 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id v15-v6sm4533916ywv.66.2018.07.06.13.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:51:40 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:51:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v9 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
Message-ID: <20180706205137.GA20617@rob-hp-laptop>
References: <1530832288-8156-1-git-send-email-stanley.chu@mediatek.com>
 <1530832288-8156-2-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530832288-8156-2-git-send-email-stanley.chu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:11:24AM +0800, Stanley Chu wrote:
> This patch adds bindings of new "System Timer" on Mediatek SoCs.
> 
> Remove RTC clock in the same time because it is not used by
> both "General Purpose Timer" and "System Timer" now.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  .../bindings/timer/mediatek,mtk-timer.txt          |   34 ++++++++++++--------
>  1 file changed, 20 insertions(+), 14 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
