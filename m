Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82965C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8BF204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8BF204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754663AbeFTSYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:24:21 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43998 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbeFTSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:24:18 -0400
Received: by mail-yw0-f196.google.com with SMTP id r19-v6so181566ywc.10;
        Wed, 20 Jun 2018 11:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTHtEwj77Mp7Am3wJd5EMI+41YD1lx0d64gxaWTr3G0=;
        b=D8XsMrJcOFG/w5VFv3J/vcT9umOkzY2exCj70bj65uyI7GFgGYMEwMQcNUe6dgKAb7
         5jIgPQy8Tseq0fEK01Qdi2zfavPC6ZkQokO9IZiOzqIqdznHE72R3/plkGBdnvfxKmA4
         UxbICjNSt4GbAqtv5An7+n7mN037njf9Uga9pHKG/jLE3VRWbdov7eGlRLTIDn2kZM5B
         qg+AHjgtEMx7SQkfhxMixWYOYy0MEHBtNiXgZXx0EiFj79PEOXm27bc49ffuiuJobNjF
         wtQq/dR9M8zb1kbQwygxChlUMXAqdfIkemZRyrBA8DBDQMBBus+U27IPXeAdSaDyKkLL
         2dNg==
X-Gm-Message-State: APt69E28IpsUx+tCcsr6VEdspUIJJ4z9uUECja9sc0juzdjdBjj6W1gP
        MVAbMSV7sUQOxG+6EcQBZA==
X-Google-Smtp-Source: ADUXVKLeD0gtZkTF3ngGC4pL8MhhQWLnp1dZ/DwGERomt/l/vKlZ3BOpXAdW+U6uU5qHLbhkqBX6WQ==
X-Received: by 2002:a81:b70b:: with SMTP id v11-v6mr10201292ywh.182.1529519058010;
        Wed, 20 Jun 2018 11:24:18 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id k84-v6sm1051749ywe.52.2018.06.20.11.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:24:17 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:24:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] dt: bindings: Move tegra20-emc binding to
 memory-controllers directory
Message-ID: <20180620182416.GA13759@rob-hp-laptop>
References: <20180617145539.4758-1-digetx@gmail.com>
 <20180617145539.4758-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617145539.4758-4-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 05:55:34PM +0300, Dmitry Osipenko wrote:
> Move tegra20-emc binding to the memory-controllers directory for
> consistency with the other Tegra memory bindings.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt      | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (100%)

Thanks.

Acked-by: Rob Herring <robh@kernel.org>

