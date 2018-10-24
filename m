Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D81ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03032082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03032082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeJYGk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:40:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44842 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYGk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:40:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so6638242otf.11;
        Wed, 24 Oct 2018 15:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LhIr8hbjHvuQQvBGJVoJ8v9oFEk0k6Yf7Hyh/pi1Euk=;
        b=REQT7ickiuQPponsoAl+7uNhea481JaD0lz3D/6MWcQm22OHZMtXSZdFM5t1B5LSKk
         1g1kglposyrnrdHskIUaTQNAt41sETr2IfET5Q32RXYZtgb9naTCmcsOeoCdsPsOEzLf
         N/GHvsIHB7OSn/dBIY3/9Py5ei9jajg3owdo/4K1FUO77RjAffIbI+Uo/R5RzUFs1dHn
         jYQLdsQZEVMjU6ZG/9fD0UbRiKsnV8WwJ9KEFdJNfnutROxPFRRsu8PasO1pjIWFK66M
         Hwk50Sdkuo4AC6BG9R7KV8+J4Yphzdxc0X0BXfTQrfJ/2hUqVt5Meh3tiF4Sd0BEtSpJ
         apUA==
X-Gm-Message-State: AGRZ1gJ9k8gyKL8ij0unsZTsqsJkth8BPIdFkPOUSfytpJfXOtCTCpm3
        u3vSlg3zmFeMrx307WSDpWCTDog=
X-Google-Smtp-Source: AJdET5cPOuuI8mxnir+fEmVpzrHl9aA3YyIjzAfVOKp6JTxQ2n+3RtBGnErADhDg4ZmXBW64acWNXw==
X-Received: by 2002:a9d:8ea:: with SMTP id 97mr2995500otf.10.1540419035249;
        Wed, 24 Oct 2018 15:10:35 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m63-v6sm1867421oia.30.2018.10.24.15.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 15:10:34 -0700 (PDT)
Date:   Wed, 24 Oct 2018 17:10:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     andy.tang@nxp.com
Cc:     sboyd@kernel.org, mturquette@baylibre.com, oss@buserror.net,
        mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3 v2] clk: qoriq: remove legacy bindings and add more
 compatibles
Message-ID: <20181024221033.GA5876@bogus>
References: <20181024021122.3942-1-andy.tang@nxp.com>
 <20181024021122.3942-2-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024021122.3942-2-andy.tang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:11:21AM +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> The new bindings will be used, so delete the old bindings.
> Add more SOC compatibles as needed as well.

I'm a bit confused by this series. Normally you want to update the dts 
files first and wait some period of time before removing driver support 
(and bindings).

Rob

> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
> v2:
>   - involve more chips
> 
>  .../devicetree/bindings/clock/qoriq-clock.txt      |  112 +------------------
>  1 files changed, 6 insertions(+), 106 deletions(-)
