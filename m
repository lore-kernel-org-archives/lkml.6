Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A349FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAC5240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAC5240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbeGEVWI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:22:08 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35178 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932095AbeGEVWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:22:06 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so19602204oik.2;
        Thu, 05 Jul 2018 14:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZezKXB+YamWK2wgILGXp1v0faqNZlliHKKOQIKciza0=;
        b=EwuTRHm8y8R1Y/aZZfd7p2rfQeXkidh4tgiTE8Xl0apRTko4KV0RlPmvSy2cUFCBw5
         SzGA3O6n/ibCCwzN6vFm9d+xFuimePGqzjxFEGTNjrj/LtJOEAGWh87PnW0A2Zfb5ZI9
         ULEnpVYy1rbo2pJUnsykxesKE6fJtUT7+1YHdjnjyuPW4kJBWpeBd58YK+BSQW3TNymf
         Gia6tmVb6AJfNSYIMyZ6dbMe89VSyFG2c+umnVIF0AIq4B62ZKK+VDelvBvlFM3YOE9+
         BT17kKXCM9xJQmNcAHxFM3i5IzdN0nD9RDiSbre5EM1/B4RprwOZVZANxXM2AGtC2UyC
         cRKA==
X-Gm-Message-State: APt69E0OjhXbg/vTRGFkVZ8TFMELw4d6zQ6VsBqzGaOtFFmYEcbgTQEu
        lY3v8fX/jMlbpTWYvzEvUw==
X-Google-Smtp-Source: AAOMgpd6Gaztv/wZ1+yrlpqxoGIsK8kGzQ47u8pY1+Fv5DeTBFvJFkr3tcW30Zmx5yEmE6phnPqTkw==
X-Received: by 2002:aca:3d4:: with SMTP id 203-v6mr7942447oid.321.1530825726117;
        Thu, 05 Jul 2018 14:22:06 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id m3-v6sm3687887oif.26.2018.07.05.14.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 14:22:05 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:22:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     alanx.chiang@intel.com
Cc:     linux-i2c@vger.kernel.org, andy.yeh@intel.com,
        sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        andriy.shevchenko@intel.com, rajmohan.mani@intel.com,
        andy.shevchenko@gmail.com, tfiga@chromium.org,
        jcliang@chromium.org, brgl@bgdev.pl, mark.rutland@arm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
 property
Message-ID: <20180705212204.GA10449@rob-hp-laptop>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
 <1530522740-2798-2-git-send-email-alanx.chiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530522740-2798-2-git-send-email-alanx.chiang@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 05:12:19PM +0800, alanx.chiang@intel.com wrote:
> From: Alan Chiang <alanx.chiang@intel.com>
> 
> The AT24 series chips use 8-bit address by default. If some
> chips would like to support more than 8 bits, the at24 driver
> should be added the compatible field for specfic chips.
> 
> Provide a flexible way to determine the addressing bits through
> address-width in this patch.
> 
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> ---
> since v1:
> -- Remove the address-width field in the example.
> since v2:
> -- Remove redundant space.
> since v3:
> -- Add Acked-by.
> 
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
