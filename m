Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E08C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C9321779
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C9321779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbeHMWJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:09:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42271 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeHMWJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:09:10 -0400
Received: by mail-io0-f196.google.com with SMTP id n18-v6so15883518ioa.9;
        Mon, 13 Aug 2018 12:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EO9ee/E5p1yz60RD9uc6dczsMnZYVUZ0n2I9xmaJR7g=;
        b=l9kjEbeQq9YIWrfGTDnzpT4pTPLNvJ5kPRlaeoy7ilUkGW1Y1faBw8FrHLeUD2O3y1
         slangILZEl6zswNiYlVESluM3F6b1NUfWCHZrGWzjRM0jmoEnmoxLw5hUnsu+y2ek8Tx
         5yP6FGhYL6jpTnomy/ajzhFoh5RI2c9WcRGdgvSaiwCW0gRcVfganuwUvOgIiqVycop8
         tx6gl5vQqWbypqF//A6oCviV5nfvbnkjOqeGnGePile4BttxCarElenp38Ty/vOl8u7P
         e+hbQo0ScuXlVFwN84WhB2C5BoPRslwN8Ab2MFYNFHjpBH6Qp262J/3vukJl/LCQ8d8l
         2jIQ==
X-Gm-Message-State: AOUpUlG0prRG+Gy1ikXk2Jpuk2CHn7aAF23Ss0zfmaRkH+pMXwvlbG6t
        2DlQJLOjEYeqkG6NKJWeXw==
X-Google-Smtp-Source: AA+uWPxhtXNyZKL/zJXgLOUkEGUj+/xt/nw44MR8RN2TTk1qbCxzNj4XPXcWQGIz67HV0iQRcSSRww==
X-Received: by 2002:a6b:a192:: with SMTP id k140-v6mr15627340ioe.130.1534188334665;
        Mon, 13 Aug 2018 12:25:34 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v3-v6sm6602210ita.6.2018.08.13.12.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:25:34 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:25:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 04/40] dt-bindings: mmc: Add Tegra SDHCI sampling
 trimmer values
Message-ID: <20180813192533.GA27473@rob-hp-laptop>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
 <1533924522-1037-5-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533924522-1037-5-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:08:06PM +0300, Aapo Vienamo wrote:
> Document the Tegra SDHCI inbound and outbound sampling trimmer values.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt          | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
