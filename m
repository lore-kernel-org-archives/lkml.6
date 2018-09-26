Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7499FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238CD21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238CD21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeI0Clf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:41:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41111 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeI0Cle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:41:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id e18-v6so284760oti.8;
        Wed, 26 Sep 2018 13:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLsq9nbIcCeAcz39CtUuEizhU8LOMb4oIBAsIrRzfao=;
        b=hyjfVyl4vj5tEx2Lgjenpp5YOiDfPWEFIhT0FGtjL1B5oU0L6C2xsKnhF7+6MkV/Pd
         XYRzTRPs6t4d8Ub0LWPpQa/lDOaCbumLYFbkbuVdJr78YSGHa5eJfTXeqn+ALLYEVBJ4
         vMhpdiVyzkzajnCdhrcq6RnOoXYrhQNWWmbrv9lIEb5ZsKULiYccOfK3HM/0rzbovmjj
         8n7Syvb9sYw27x4ReMfLdsNbYePvwuFAkTqBzG9Sj5CYZ4WijO9Aicsa/2UJdMJlmZ1n
         Yty/BlTGRFR3e9FeQ51Gg64d4QX4oWHVMNwotxbhXUwrCkrEt9f5Vc8ZegQaU3dqcAP1
         9XkQ==
X-Gm-Message-State: ABuFfojvWP0HD9G6ycnIyDtCdNyeWJZkvgyjtvwkQYXSqrAoCOAeUdBQ
        qmGwn38dZIuQjI+ceGo1pw==
X-Google-Smtp-Source: ACcGV620AwsBwRNtGc4bCRkVJHDPIUbxdgHz1QlkkOmuBVLxcQtmymEJWMNiFaoCiMVSelLv+kDv+Q==
X-Received: by 2002:a9d:4b81:: with SMTP id k1-v6mr5274106otf.387.1537993613659;
        Wed, 26 Sep 2018 13:26:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 104-v6sm2306987otf.49.2018.09.26.13.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:26:52 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:26:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: Document the Synopsys GPIO via CREG
 bindings
Message-ID: <20180926202652.GA19379@bogus>
References: <20180911150925.19460-1-Eugeniy.Paltsev@synopsys.com>
 <20180911150925.19460-3-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911150925.19460-3-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 18:09:25 +0300, Eugeniy Paltsev wrote:
> This patch adds documentation of device tree bindings for the Synopsys
> GPIO via CREG driver.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  .../devicetree/bindings/gpio/snps,creg-gpio.txt        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
