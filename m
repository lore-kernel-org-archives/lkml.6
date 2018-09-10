Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB818C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DFD20658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DFD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeIKAwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:52:55 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32950 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeIKAwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:52:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so42681069oip.0;
        Mon, 10 Sep 2018 12:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hX/7rOjW/N+ns3WqMfPJjH7FP8qemVeGzBpNc7r8bkc=;
        b=SxlkDTjf8YSIuYxv7QsKepFjEkecf9esISCtAIfVt7r6YGgeAwwGgr+jIg8tcadzi6
         SSudyFYn/czuU1OiVlwFmG3Wk1KHcPxCKHWYThMtY/8NNaZkCERxW3/At0k+Km8XrDIJ
         hSQ+90aZsWFNhKg+FRrb1o5pkFxUrNwfvw5DBHDrfNHgS18vjp1R9TO875eZpjaeCT1s
         7e+vN4lE1yJ7HXkHn7LExuvywJb++1FzSBRt99HKi8vR8vXAKG1dqWJw/HlVZrbxIWNA
         vRyL6MyFuxgkvPHj1gWzvrPbEtzOOGCufESBx9lce2GPEZUp7jNbLFaRdMG/UI++uejN
         wzoA==
X-Gm-Message-State: APzg51DXHUKTujjNNq2Nnjw9VHzG89GN8uzsJmvPqSE+OE9Ld64r02un
        vE6KHOHFekdpBJT6sl6Okw==
X-Google-Smtp-Source: ANB0VdZLPESQ+bSrHRrwfeH894cdkTiAldAKY2m8T306v1wCnsAdbbtKDfvmfC4DBC/nSpFg5xuEYg==
X-Received: by 2002:aca:aa8d:: with SMTP id t135-v6mr21414552oie.218.1536609434199;
        Mon, 10 Sep 2018 12:57:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s145-v6sm33549409oih.16.2018.09.10.12.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:57:13 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:57:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, andrew@lunn.ch,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH v3 2/3] dt-bindings: net: dsa: Document B53 SRAB
 interrupts and registers
Message-ID: <20180910195713.GA14119@bogus>
References: <20180831192039.11842-1-f.fainelli@gmail.com>
 <20180831192039.11842-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831192039.11842-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 12:20:38 -0700, Florian Fainelli wrote:
> Document the Broadcom roboswitch Switch Register Access Block interrupt
> lines and additional register base addresses for port mux configuration
> and SGMII status/configuration registers.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/net/dsa/b53.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
