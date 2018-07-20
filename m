Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9863EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49698205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49698205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbeGTR1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:27:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56099 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbeGTR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:27:36 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so15474969itl.5;
        Fri, 20 Jul 2018 09:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VLyyGIaJpsgxLUJmC9DG1Wsu2CeZ3SC0J/GXQRemiBo=;
        b=bqawq2V0k/sgHDvO3gp/89uIevW7CYIwr2lq8wtThH8ESdRaKUZqgypN/Wfr8prqZ5
         lAhJcrfyvPe26xL+WtsmLpk8KOf1y6ww322L6bXLuYnin6Q2xrGDrL4nM0fxyLwCTUkx
         Oc9uiHrjQMeGPKgtSTw6Js5vATE1ioTGHFoxRP5410JENXUIZSZvqc+qPboq1zla5CUe
         mpGlYnZN2zaW69MGNpwipyly2MKXe/mjONBEIZT9Ajy6PY+R0ysZs0Ljvw9tp+/O7Fp5
         Zib2suxTpSeoaOyeDhmVWmByyabNnUo3mXb/yTrKEA5ANcvQOKs7DRQnMdQzF5rcpm7/
         /lcA==
X-Gm-Message-State: AOUpUlFMBF7mjxIATa78qr367ToNLAhCJQqp7Kp/n/gno9qpcbLa1K66
        i+2fuxaKu8hmp47qHe/rSq0xF3pDlw==
X-Google-Smtp-Source: AAOMgpcuMAgnX0D5AhJlUZ75p+2VVTm4cKwCmpTb8Tbm/uPftFfyqp9U9V9mgCvrnXQh5Xx5tNnOuA==
X-Received: by 2002:a24:5a53:: with SMTP id v80-v6mr2534955ita.34.1532104711637;
        Fri, 20 Jul 2018 09:38:31 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v126-v6sm672368iof.31.2018.07.20.09.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:38:30 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:38:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, jagan@amarulasolutions.com,
        djw@t-chip.com.cn, jacob-chen@iotwrt.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com
Subject: Re: [PATCH v1 1/7] Documentation: usb: dwc2: add description for px30
Message-ID: <20180720163830.GA23635@rob-hp-laptop>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
 <1531813747-8804-2-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531813747-8804-2-git-send-email-cl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:49:01PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds the compatible of dwc2 for PX30 SoCs.

'dt-bindings: usb: ...' for the subject.

> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
>  1 file changed, 1 insertion(+)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
