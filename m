Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50C1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6A426051
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6A426051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeFYTHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:07:45 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34075 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbeFYTHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:07:42 -0400
Received: by mail-yw0-f193.google.com with SMTP id n187-v6so1702782ywd.1;
        Mon, 25 Jun 2018 12:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZEN6ciwF8W4wsmzhAsYkFTL4MPRR8QfsJSSZqjD6q7k=;
        b=FOb6WjXErBPOaR2P1wM66u0zWfd2HrRhEahvcZTqZS/Ks6slo+Wc+C0eUlrJ6UHBJZ
         ffEsKI3UoJy5MAxs2i9zA+4fUkequvtd0fCBKrgk86+gwbaJqDsmlpW+KauA1jNl6Pnt
         mmezHEO3LczyZWpcNE2v6BTdmBHxOiLoRklNmTKuuzX0957C/XxEXm7gzL5tKSHnmjhZ
         wV8e8O1/RSZNd8fjQSOvMsR+HvsUtWYDUwT/FVH03D2RNsn78fp/t8uRBqd/PObYfQFp
         Ef9M3rd9WI3pk5Pn7QbtBuHXbTr5J06PN9DgSqBW7/3NalAubSuI6E+K+TKBJJa44PJ5
         hEQg==
X-Gm-Message-State: APt69E3HAKF5UPE5C0HgbsLgiCZVJyOAH4I288N7yHS6XchvM+3dVSkr
        4KlX8Up/l4jm8h/RG1pxcA==
X-Google-Smtp-Source: AAOMgpc0d+jv4py4HgmaZfZGlPMkji801Lc68wYWNGzHNYIkmJARP37PcJoANuRLzKuLPQ6VewAGwQ==
X-Received: by 2002:a0d:e447:: with SMTP id n68-v6mr3451062ywe.112.1529953661601;
        Mon, 25 Jun 2018 12:07:41 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d203-v6sm6000690ywe.5.2018.06.25.12.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:07:40 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:07:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     mark.rutland@arm.com, jassisinghbrar@gmail.com,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Message-ID: <20180625190739.GA10143@rob-hp-laptop>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
 <20180620122042.10950-2-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620122042.10950-2-mperttunen@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 03:20:35PM +0300, Mikko Perttunen wrote:
> HSP interrupts can be routed through exposed "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings. At the same time, add the compatibility string for
> tegra194-hsp, which is backwards compatible with tegra186.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Edited commit message to not say that doorbell interrupts cannot be
>       routed to shared interrupts.
>     - Added tegra194 compatibility string.
> 
>  Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
