Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09075C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53B52087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53B52087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeH2Cd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:33:58 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38401 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2Cd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:33:58 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so5824174oix.5;
        Tue, 28 Aug 2018 15:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1HK/bEjEqyd2Kjix/+/Ps9xE73qY97vLSjQhgmL+lqY=;
        b=Kk4fhCDTlopp0Vy5p9zXGTOBC9v+J+vbsYp8BY8UfJPhHCMv3RIopIHMo0cI/BbgRm
         Wl98KY09CTlcKQW66rACCWeSX1HFr8KW1pt2oizeYcejqxa2N0AacgyPcqKtMnAbwu2Q
         fZRdIsKEI1XsTl3wnPlOnCaJ4RbSqV+lctj7xp/eb40rl53Xn1gnnt74UGCzmeMwkKI0
         y3WmtLG2m6Y6Rfgq79zj8Xu1MPOjiImvcP2gpUMTB8X7DWSrWUN+HAhB242vKrI7bwRs
         knosHT1uwz7jbcluVRuMUkD1IdVIN0pwVBluwKmGvQScaerAOOhVqkfT67D4q6ajIOAR
         tQhw==
X-Gm-Message-State: APzg51AMbH6ZGRyQkYCLzz4JaYa6oLwSUnz4B0iu6Fa5vxj92Z233x26
        MhbY5wNsOXrXgjEPofUqrw==
X-Google-Smtp-Source: ANB0VdY9MfPYujaSzvjp0AlLFtXcct+wDNSSjW+jJVsmfMwsye6V7siDXnPSsREJYcLuLo3Ylchv9w==
X-Received: by 2002:aca:f488:: with SMTP id s130-v6mr118699oih.269.1535496010631;
        Tue, 28 Aug 2018 15:40:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11-v6sm2324806oif.27.2018.08.28.15.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:40:10 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:40:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
Subject: Re: [PATCH v3 3/5] dt-bindings: mfd: rk808: Add binding information
 for RK809 and RK817.
Message-ID: <20180828224009.GA25643@bogus>
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081441-20718-4-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535081441-20718-4-git-send-email-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 11:30:39 +0800, Tony Xie wrote:
> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mfd/rk808.txt | 56 +++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
