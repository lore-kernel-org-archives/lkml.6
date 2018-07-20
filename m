Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C44ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164A520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164A520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbeGTSeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:34:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36887 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbeGTSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:34:22 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so15627822itc.2;
        Fri, 20 Jul 2018 10:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m2uLI3pIp2IkriHjjh2E1emJB2Qo/cgiq0iN8NL8KAA=;
        b=aytRNiqcZHhrMNubd2k93AAZdF5jn2prQbCBJadbVfmghdxXeGz0g/wkd3Me6tMsZI
         wcHOl93q+WC6HiBHwTA8bUomEUCrNKm7uIsU8ZvjBzYARIwHDiZ5zeHH7NtHGJMR9cyA
         fVk/vBJwgVPteghGcPekPokcvpABa6q/0wrJzrpRV5mjYfBoq5jg8jDz7BH+u9KJlIZS
         YfoBGC6d+dH1LHTQ/zqvF+RECCCuEoxndvI2sQCc0dw+anyt4YPnh+FBDyDCZwMCuJFD
         a0obXKoGkBN+cbQEbhk9oaP3vMuzn44epiBszAmIHjX5+UwB7PB82tQ4BjyBISDJbl++
         2X1g==
X-Gm-Message-State: AOUpUlE0/OedyQmMF7PitbiUDDzTBtLuaTaEGWoSqYpyFXY5w6Qioh5V
        eDe6N7zKERn8AeN19e6ivQ==
X-Google-Smtp-Source: AAOMgpdqSfXYa4vPjwLVbLZbXhic8PCkdM8f5ohhAcpBHPVRvaqkS6m5E7O32LIoVGeLMYsEUDIu4A==
X-Received: by 2002:a24:5cc8:: with SMTP id q191-v6mr2751084itb.63.1532108703835;
        Fri, 20 Jul 2018 10:45:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e19-v6sm739847ioc.46.2018.07.20.10.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:45:03 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:45:01 -0600
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
Subject: Re: [PATCH v5 03/11] dt-bindings: mediatek: add MT6765 power
 dt-bindings
Message-ID: <20180720174501.GA32241@rob-hp-laptop>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
 <1531817552-17221-4-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531817552-17221-4-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:52:24PM +0800, Mars Cheng wrote:
> This adds power dt-bindings for MT6765
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    |    6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
