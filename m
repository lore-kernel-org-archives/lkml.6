Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C19C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1641B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1641B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbeFTSOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:14:16 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36053 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754232AbeFTSOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:14:14 -0400
Received: by mail-yw0-f194.google.com with SMTP id t198-v6so180537ywc.3;
        Wed, 20 Jun 2018 11:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6319KDGvgF4QEk+D2vmUpGDXgwevDrnuxhYuOO6zY24=;
        b=g45yidx0Hqgs8+/6OXP0InCqVp9TpYJx/cGGLEJM1vYMK2EKi4Yi9YokFYjfA+ErYC
         fatXFeelyPjFFd8UmGEGDwEjtkhq/wNMZwH07Qv6BJAJAiqprwppM5IUXhptIjin1z9y
         e8rZqLBeEfha+QCcL8qxoOSZL6MbZyC49r+kiJV/AmnjAIPdZVf1g535xkQpPW+11iIa
         E0fV2hIAUP8YXUymDk3YUkZ5Q0qH3m+v0rAd8KNf8R0/D4fGFxvmx8EsZKT7NLLgMgny
         w92h7j/kQ3Vw+OdL3KTPqxrO1TIW9PZtsXbRQ+8RxUF7QfnGjWr5ZIdJNWD2PovScBeB
         F0SQ==
X-Gm-Message-State: APt69E3yBxjLToqbBDv8Hr9+GmbPGZSZuwtiyoL4aFqWtuTxgW4Fh3SF
        kaD6y8wkGqnzA/4YpZG/2Q==
X-Google-Smtp-Source: ADUXVKKUOql7TD9AYZ2Q8A+G+II3oVmyURVAt3HyBLJ2V5mnEgwiQiut2G+CyncDxvLQUChme9oJpw==
X-Received: by 2002:a81:a617:: with SMTP id d23-v6mr11054864ywh.145.1529518453434;
        Wed, 20 Jun 2018 11:14:13 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p22-v6sm1082443ywp.105.2018.06.20.11.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:14:12 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:14:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     heiko@sntech.de, sboyd@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 1/4] dt-bindings: add bindings for px30 clock
 controller
Message-ID: <20180620181411.GA1689@rob-hp-laptop>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
 <1529029011-15021-2-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529029011-15021-2-git-send-email-zhangqing@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 10:16:48AM +0800, Elaine Zhang wrote:
> Add devicetree bindings for Rockchip cru which found on
> Rockchip SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,px30-cru.txt           | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt

Reviewed-by: Rob Herring <robh@kernel.org>
