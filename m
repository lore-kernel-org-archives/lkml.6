Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADB726100
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADB726100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965163AbeFYUqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:46:17 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44144 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934686AbeFYUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:46:16 -0400
Received: by mail-yb0-f194.google.com with SMTP id a2-v6so5123881ybe.11;
        Mon, 25 Jun 2018 13:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5QzYU+lJDMJ42RYJz11qeXsn5SJF2ACCWmEw1sZUoI=;
        b=TZoUs8VHuLzqrcAKwbhTjylVcrw62/ud0YWZj6TAEUyLVsccxSf63Ki/4npxiU5PoU
         Ruh/QYaDX1/XNvKf1W2XsFcLVupQuOUa93o9OzrzOCAAkpY3rGmJOkBlxnw06kwCpuK2
         uVLNvnHyqFSkctTa7fI2o14j7EFkbBtYcNQdg9m3TkD2lKXqt7rcKSzukNO2gVPcgAC5
         Hi79yER2CIAt7TIPS4/M1rBbrTg8jJmXbEHcApYi3Yfi4gMAKdACGu/DH8KlOTsYwU4q
         mRxqtDNCN00+5qVqaRFZHM57cW7TmfjLvU0Q9jLtSB5gh6LKl/4ZRisJ/WoRm6Zgcuoy
         uZwg==
X-Gm-Message-State: APt69E0Jz1Wul5bAxt8/BSzt4NvjG6JS7CCdbn0anboATBy0I7aorFoa
        nUZtt7AC/Rol0IqCj17ZlUE0Enc=
X-Google-Smtp-Source: ADUXVKJfhJOuXgmOmFVGgN4Y4QvWwmOdTlBAkiLIPEijFCRUmIofO5qa4ElhPWo/IVP37orm0iYDgw==
X-Received: by 2002:a25:ae02:: with SMTP id a2-v6mr6943157ybj.436.1529959575459;
        Mon, 25 Jun 2018 13:46:15 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g145-v6sm5925278ywe.17.2018.06.25.13.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 13:46:14 -0700 (PDT)
Date:   Mon, 25 Jun 2018 14:46:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/6] dts: bindings: Document device tree binding for
 CATU
Message-ID: <20180625204612.GA15054@rob-hp-laptop>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
 <20180625112213.23492-5-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625112213.23492-5-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:22:11PM +0100, Suzuki K Poulose wrote:
> Document CATU device-tree bindings. CATU augments the TMC-ETR
> by providing an improved Scatter Gather mechanism for streaming
> trace data to non-contiguous system RAM pages.
> 
> Cc: devicetree@vger.kernel.org
> Cc: frowand.list@gmail.com
> Cc: Rob Herring <robh@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
