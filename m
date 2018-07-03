Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0704C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EAE2425D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EAE2425D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeGCWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:11:09 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35400 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbeGCWLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:11:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id e6-v6so421651pgv.2;
        Tue, 03 Jul 2018 15:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UlCpYE4Umt9nfNXBy6NbRAHwI1CWGN/7B8C7Rr7dgwk=;
        b=EKpiHQBldXhKQhkLxnuVIW+MH/pNaiLPxyNIkYI2RX4p3uU1a0Tyrd5h9nnP5WEPN+
         xO+1vU4XLpJ81qPoEeGNo5A7nKf8dW2wpY1U9HKAiKDK/dpZFxP/VFVb6bD5BElP1ais
         zp1bo8K+eMjU+YeJABW0L+L45kGfGgGG0XQSB2KbX9yhAT/LKxxSEQejt0fb5JHum5e8
         Rc6e+Y4W/ItAIROOG27nBZjPUwGykWP2g0A00BsSyWCF6DRlc0PEAHDX3DbKqaM7VAot
         DBKtRHlEsyVZISipu/39vX28V500BkxrikykzuIa3QqPPf5NDju/bCHbj8z3q/zzH4M1
         qjAw==
X-Gm-Message-State: APt69E3qHjhHkMbBcQP2xynSRXUv/b0VFe40t1po3B2O/uT9HyCWtmZA
        Pe5UDx7gFyl4Wt71h87mWQ==
X-Google-Smtp-Source: ADUXVKIKQ+GufnJQOyP1jvGKWrLwmlrPdho8Xjas3KeeBIaJhMV7z9QYv5fbRKa6cbxZlOF69n8IoA==
X-Received: by 2002:a65:4005:: with SMTP id f5-v6mr25937567pgp.302.1530655864937;
        Tue, 03 Jul 2018 15:11:04 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id f24-v6sm3096583pfe.39.2018.07.03.15.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:11:04 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:11:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for mediatek
 MT6765 Platform
Message-ID: <20180703221101.GA6829@rob-hp-laptop>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
 <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:04:05AM +0800, Mars Cheng wrote:
> This adds dt-binding documentation for Mediatek MT6765. Only
> include very basic items, gic, uart timer and cpu.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
>  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
>  .../devicetree/bindings/serial/mtk-uart.txt        |    1 +

These can all go thru different trees, so should be split.

>  3 files changed, 6 insertions(+)
