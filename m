Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3061C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953C921386
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953C921386
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934127AbeGCQ74 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:59:56 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32797 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933063AbeGCQ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:59:54 -0400
Received: by mail-yw0-f196.google.com with SMTP id c135-v6so948069ywa.0;
        Tue, 03 Jul 2018 09:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hW3kkaZDxU2p3iRe1vpCj4R2OMghIg2DGt1uu8I2dyI=;
        b=ShVVJ/YizPPBckmFdjtg1ZTE4Q+smtK2Hdr1WE1/qMnrIhViEDIQlCWMUqxxQBhqt7
         BGHvGMv6FWGgwHZSg3Au3PazYCfWerlkr+Pwxa9Bao1u7Y+vtAg8temjpEcTI68V9vwu
         8jgnWX8SQeBWVocFsaYI+28m5akBvmwJMkNZGnhtZk4fIQ7PWplzagk/ucjDCsgwCuhv
         kD2USnRQWFEV++MQh+6hhV0UPVWRZF+LoPsti49HJqmvFmWsYLrY+Z+1AV3stabue1vZ
         w/ZwRUGJHWpJ/nRcaq+POYkIuj+PWnBwnTR5CMj3q5Xl8ILu9QSWTOgu3w+F2Ar83TBQ
         wWBQ==
X-Gm-Message-State: APt69E2ftW92uahenckQhrq6RNjdSA77xWv5u6BIgpRjTbOYmnfRfp9y
        H7Jj6rroXOAXGcu+0XT0oQ==
X-Google-Smtp-Source: AAOMgpc+TizcURV7SujNvOochN9g+43apNS2x5Dt/RfeJTTWDldrLvZB74+F0ZIz3I/7uF+SDYKdwg==
X-Received: by 2002:a0d:e846:: with SMTP id r67-v6mr7798907ywe.19.1530637194006;
        Tue, 03 Jul 2018 09:59:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id f9-v6sm518399ywi.3.2018.07.03.09.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:59:53 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:59:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
Message-ID: <20180703165950.GA23752@rob-hp-laptop>
References: <1530532746-619-1-git-send-email-abel.vesa@nxp.com>
 <1530532746-619-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530532746-619-2-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:59:05PM +0300, Abel Vesa wrote:
> This adds the binding for the i.MX8MQ pin controller, in the same
> fashion as earlier i.MX SoCs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt

Reviewed-by: Rob Herring <robh@kernel.org>
