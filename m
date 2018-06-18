Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2BEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402752075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402752075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935893AbeFRSh4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:37:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50342 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935648AbeFRShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:37:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so15731724wmd.0;
        Mon, 18 Jun 2018 11:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ALWTLGELLtPMo+MLoHew4G9PbGb68EYWOEp8z+bA0a0=;
        b=P3vslxUk1XY8vUOdOdEkct2xomWRSfcXMKce7NnV0z69HRrb793HGjfUZBAY6diq7T
         MCVQk8JDZrI1M1w5d7XZEjGAjbNlGOaBxSrLxCtW4ZOBpIAmiLDeVTh95tGDhiiexT0Q
         XijbXe6oJadudEPR9uP2zecBgR2q95eoF7km3phkdhDFlQLAa7Nmay/qtr9riEykL/us
         8YobfeDuhPOMAeQKWYWBPS9xllsiEY1dItq1lEcNF4gBGBzx64EpxfNmjKrKWgpJnaRZ
         wIBE6iSqiTyAhTHLamuTY5SAmA5zTRE8jSWkXDStfd96CiEMXd2rf+2n0oQHkfdDXlzm
         6FNg==
X-Gm-Message-State: APt69E1dx2GPksNHKGJKIYpsJwoaKbbM410tZU/f+7H0Q1ja7NJR3tnp
        rX8WvPbjjXNLg3ZsOc/rvQhHj3ur
X-Google-Smtp-Source: ADUXVKIcHXzqEDXJtubWVCpslFL+XRdflCC1jBel+zd6wbL+Im5mSgfWu8VD6LD7lN+3NOthhzawIA==
X-Received: by 2002:a50:bac7:: with SMTP id x65-v6mr12061391ede.113.1529347073075;
        Mon, 18 Jun 2018 11:37:53 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id h11-v6sm9564758edh.16.2018.06.18.11.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:37:52 -0700 (PDT)
Date:   Mon, 18 Jun 2018 20:37:50 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
Message-ID: <20180618183750.elfphari7vw2v2sl@kozik-lap>
References: <20180618174216.24801-1-krzk@kernel.org>
 <20180618174216.24801-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180618174216.24801-2-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 07:42:16PM +0200, Krzysztof Kozlowski wrote:
> The decon, decon_tv and dsi nodes have only one child port so
> address/size mappings are not necessary.  This fixes DTC warnings like:
> 
>     Warning (graph_child_address): /soc/decon@13800000/ports:
>         graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi |  6 +-----
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 12 ++----------
>  2 files changed, 3 insertions(+), 15 deletions(-)

The patch 1/2 should not have any impact but this one could have and I forgot
to mention that it was not tested.  If someone could provide testing, it
would be highly appreciated.

Best regards,
Krzysztof

