Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF9B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14FF20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1UxaopC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14FF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeG3QGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:06:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35717 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeG3QGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:06:02 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so5640330plq.2;
        Mon, 30 Jul 2018 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1hWa1mX8s05v3DYpMzpwCXIWjKn9aExRyXaVZHcy3/k=;
        b=K1UxaopC5P9vJGepF9IHO6j3i6v8PWJ3F6jjjOXGUQq9RzRRnsbfyBhOfqen08mB8r
         6Qx+e3AMJFb180l11V2AMHvLDrhlzNQoA39s3nuKcIKG484svcMlXSnOWW35j6IpGIf2
         jYT62PDy73FmlN8dpgYbTTSr3wO7YFBLeYuEcPIPjkuoBVI3Fybg7T5sP6CO0ALO1+Mf
         PI2PiYjF8/Uc2PdzR+bjDiRGlUHv6oStsH+Qnrri0ZCFtLAKDNh1r6qGGYMcYZKuv5K3
         d8Ed4frPSW43dfxFKiAcu7StCJCTAdAF18kiJhj7OBSGGiXS0J8Ew1MuzaqK8cnL0Rfn
         1p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hWa1mX8s05v3DYpMzpwCXIWjKn9aExRyXaVZHcy3/k=;
        b=oEevBD/djjYWcNOAaJHqybXzWPKSXfkZUmz/eTEU79bcjWuMJ+atLvSCWJ52V+tweB
         6yZn0RyqBrVSyalHfgZQ44pnpzMA45lUOP8IpsTDa67Z7q0GqB8H13oO/hdwxl5RAGK/
         tqxIWpnNhPHMHBzKZke0ZkHUQ2KPV2eO92aRc6/5fRKiW8U0GOkF4y1meH6FJFVZqHc2
         hIttnPlpw05m2sVQPfjYEqSZCTnX8wmaJvd6M1Qi9GsgW0NNeJGhC6073YHRgFk0ngkk
         PJis1Z8R2Zvcd3XMEw57edsTCDdPRISx37jghetAvydmrtBIovULFogxOLPkUFOv4jZX
         zOGQ==
X-Gm-Message-State: AOUpUlHXKP75228vbM2uRyqZj5GJeXeofExrza6HBNdEB3xqMkzPnXA1
        xNknttzRSN8cqS1KLiC0+ds=
X-Google-Smtp-Source: AAOMgpfWsN3g22NKyhQ+AdbvDdubEzNyuQ1w+yXkK1zx3oeeBf4D6+IQaWpVP29e6Wy5GBk6OImixA==
X-Received: by 2002:a17:902:1703:: with SMTP id i3-v6mr16392697pli.263.1532961046116;
        Mon, 30 Jul 2018 07:30:46 -0700 (PDT)
Received: from localhost (c-24-4-233-174.hsd1.ca.comcast.net. [24.4.233.174])
        by smtp.gmail.com with ESMTPSA id n24-v6sm24781375pfi.161.2018.07.30.07.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 07:30:45 -0700 (PDT)
Date:   Mon, 30 Jul 2018 07:30:43 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Message-ID: <20180730143043.qu66ttzwyjbw6si7@localhost>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730100154.27906-3-yangbo.lu@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:01:54PM +0800, Yangbo Lu wrote:
> The ptp_qoriq driver initialized the 1588 timer with the
> configurations provided by the properties of device tree
> node. For example,
> 
>   fsl,tclk-period = <5>;
>   fsl,tmr-prsc    = <2>;
>   fsl,tmr-add     = <0xaaaaaaab>;
>   fsl,tmr-fiper1  = <999999995>;
>   fsl,tmr-fiper2  = <99990>;
>   fsl,max-adj     = <499999999>;
> 
> These things actually were runtime configurations which
> were not proper to be put into dts.

That is debatable.  While I agree that the dts isn't ideal for these,
still it is the lesser of two or more evils.

> This patch is to convert
> to use module parameters for 1588 timer initialization, and
> to support initial register values calculation.

It is hard for me to understand how using module parameters improves
the situation.

> If the parameters are not provided, the driver will calculate
> register values with a set of default parameters. With this
> patch, those dts properties are no longer needed for new
> platform to support 1588 timer, and many QorIQ DPAA platforms
> (some P series and T series platforms of PowerPC, and some
> LS series platforms of ARM64) could use this driver for their
> fman ptp timer with default module parameters. However, this
> patch didn't remove the dts method. Because there were still
> many old platforms using the dts method. We need to clean up
> their dts files, verify module parameters on them, and convert
> them to the new method gradually in case of breaking any
> function.

In addition, like it or not, because the dts is an ABI, you must
continue support of the dts values as a legacy option.

Thanks,
Richard
