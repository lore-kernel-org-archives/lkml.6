Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB0A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB0A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbeGTSfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:35:30 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38479 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbeGTSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:35:30 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so15621866itb.3;
        Fri, 20 Jul 2018 10:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5WGPJTrfre7lGgn7Ewh/lkfjiiVHd5nRTGBc0GrxZQ=;
        b=HsqJJBVsB+B/JJaK0hSPsS5sF55DsN67W/TWUIQVaOmd0DlY/v8BlRObImgffq1b3w
         Gyo7/uhkszFGaKaVwsZMInhI+FOdZMIQh3+bZN+AA56Ri7amtO6nakuD4oTmdQBSqOlJ
         zVBJjsMwMIO1Jv6aUe1bhE3so5je0O20jQzvaRuGF5PX3SE5yeDqCJs/OcnYbY2F8f9X
         XF1jD97CxQ/Odr+qO7ACTlM/skfEDW2HosIp03JqVFuX6FekeDaEyFDYEI71j/8TilVJ
         c7QK5FZqSYxzMxQvyPeIb7bSc44isdUiF6BwZp5YTPW0AhnMQ/VILf48XvaxhaJHwk4R
         +0tg==
X-Gm-Message-State: AOUpUlG1dcLOriKLnn3UCQ9T92RFyUl1Zj16R8MMiYndYrsUI4g3/0bk
        HdT2FIl0WDh+7GcKvlFMRA==
X-Google-Smtp-Source: AAOMgpfO3fmHBfwXX2//Ra4KbvypTQypnRR7ZyweQk7AoaXel7kwvKUNNV6YvV/aqPD27QcjF9zg/A==
X-Received: by 2002:a02:6a2f:: with SMTP id l47-v6mr2712944jac.71.1532108770889;
        Fri, 20 Jul 2018 10:46:10 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id w13-v6sm1235227itb.29.2018.07.20.10.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:46:09 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:46:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>
Subject: Re: [PATCH v5 04/11] soc: mediatek: add MT6765 scpsys support
Message-ID: <20180720174609.GA679@rob-hp-laptop>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
 <1531817552-17221-5-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531817552-17221-5-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:52:25PM +0800, Mars Cheng wrote:
> This adds scpsys support for MT6765
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c        |   88 ++++++++++++++++++++++++++++++
>  include/dt-bindings/power/mt6765-power.h |   14 +++++

This file goes in the binding patch.

>  2 files changed, 102 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt6765-power.h
