Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0FFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01FC21890
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01FC21890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeHQSNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:13:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38149 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:13:51 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so12173125itb.3;
        Fri, 17 Aug 2018 08:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1kQ50pp8b1uiBlyDMXB1abZf24Xw1fbi6qeksYY8h9U=;
        b=D12mJElc+SkosiUUJ3a1qRrY4b+kmKfMnDdHukgIOscinw8WlLSB2bPgFJSCkMLEpP
         YWqDd7p78ggVk5pkdubuIvli9q1DFcEr6gpuTlU6A1tVEVBtY8bZ98wfOrhgahf+PeZd
         jzmuVmZGZy0M0dl/ykgNNHwca547zT3YJtIX5GC/B+zmV6R0Ytq1q4J7JDuhGmb5clkz
         ZoknshCzUYzQ+7bClYDqB8lWzw1qC2vgVxWY1JM4+7+I1CbB+jyz781Mm+48SmW2CeAb
         ZHlaqqb2ACpjaOVRmHA3vqudkYc8FhMfowlw1Hz4lXt2kyr2nonEwTRT8G7USa7lxLwT
         7jKQ==
X-Gm-Message-State: AOUpUlGsZECGxe3W8u8/XUwC+kHN86UIWpt1S0aS5CO3Fh+rMChFyXjT
        OMSXTko7iIJnDPa+hbHNIo0UPYA=
X-Google-Smtp-Source: AA+uWPwgJfv4BghPuRJcMvQrK6vHNPyn/f4sKrcsx5fhAhemqJT00F7HpFk8m38LOOYfL5cQH4gdpg==
X-Received: by 2002:a02:4ac3:: with SMTP id s64-v6mr31178505jad.93.1534518606844;
        Fri, 17 Aug 2018 08:10:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v3-v6sm914400iob.70.2018.08.17.08.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:10:05 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:10:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Bauer <mail@david-bauer.net>
Cc:     David Bauer <mail@david-bauer.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: 74x164: add lines-initial-states property
Message-ID: <20180817151005.GG20845@rob-hp-laptop>
References: <20180815201855.29738-1-mail@david-bauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815201855.29738-1-mail@david-bauer.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Wed, 15 Aug 2018 22:18:54 +0200, David Bauer wrote:
> This adds the ability to define the initial state of each output line on
> device probe.
> 
> Signed-off-by: David Bauer <mail@david-bauer.net>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  Documentation/devicetree/bindings/gpio/gpio-74x164.txt | 5 +++++
>  drivers/gpio/gpio-74x164.c                             | 3 +++
>  2 files changed, 8 insertions(+)
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
