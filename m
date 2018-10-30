Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE0FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FF12081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FF12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJaGoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:44:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33095 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJaGoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:44:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id c25-v6so11887493oiy.0;
        Tue, 30 Oct 2018 14:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U81coF5iD9cczsJ0JkzH7TdPY+YbTrgLWARf4DC9+xg=;
        b=p0cEL/JttX0YTAMaWdTlrRoBY0syA5s/LPCMW2X72jZ8IeD3EQp8Oo29abQVHIvqt/
         Wt+lfpDl6nYE7i2mhJ7J85VTF6CC1ksQUCitg72KsD4a+zSZpRNi/7dOdogLhAMbwSrO
         mcaF1th9reOGRuKysv7ac+sIw/ixdlwzfvikucJ4Dr7IjjHzNc+1HwT/Y7YoGPw/dgq3
         YDi6ptOqtmsuZciUoEnVGlDPTcUR3ZD0Bs5gzTAIYTA8IVbQP+PoDlTG2dU5sZLVDGWO
         fYPG15zNeC3KR2r3bnhXr5tbVFpots+A6fp8Ta0dc7MDmvGBsuivimwcEBmoBFkcNXWK
         kXJw==
X-Gm-Message-State: AGRZ1gLGLnLNB+PN7nmdTxZwu7H1PxX8PF7Kt6aClFTd7ZXSkyMHVYrf
        kMpDDjQNWq2fi11b9nhghw==
X-Google-Smtp-Source: AJdET5emImIOKW3Rn5rdndna9lwhnldy17/ennnmeNzmvFdzFWXp05fIwkcYlZROojVXaInEhTBnwQ==
X-Received: by 2002:aca:5a8a:: with SMTP id o132-v6mr292583oib.66.1540936133948;
        Tue, 30 Oct 2018 14:48:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p3sm2359101oti.27.2018.10.30.14.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 14:48:53 -0700 (PDT)
Date:   Tue, 30 Oct 2018 16:48:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH V2 2/2] Documentation: can: flexcan: Add stop mode
 property to  device tree
Message-ID: <20181030214852.GA20627@bogus>
References: <20181026085814.23370-1-qiangqing.zhang@nxp.com>
 <20181026085814.23370-3-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026085814.23370-3-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 09:00:40 +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> The FlexCAN controller can parse the stop mode property to enable CAN
> self wakeup feature.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
