Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A54AC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BB420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BB420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbeGYA3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:29:09 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36338 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389034AbeGYA3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:29:07 -0400
Received: by mail-io0-f194.google.com with SMTP id r15-v6so4847016ioa.3;
        Tue, 24 Jul 2018 16:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FqLSrqW+i1yFjDo2RWaHCkxAmyZY0DwheUM2ePu1OIk=;
        b=j0ELPBNt0PaBUujvR1oawt4WmzewsQA2e5ZmmluHYu12pj1R9qHFydsR3fU3E6Lqfx
         XzgaepLnPRG3k5EupYyidaSOhQJWRrSZeZsaVM2qAHiAmvivkWzS0+nzS6MXi/E9S8MS
         KsgHill8w3FDI+J4l8a88JkFdA12Wj5KO4UIxENR8Rg1LlAMrbOhY2n+E7i3Ne/TEXK2
         mlIX/GatXstZtQY9kE0zkG9VAZ853mR5kHBRwPnvLnWw7z70xvqHz05f47JL8m3z7CUZ
         vKyb4BLhevagw4JidtPoxhVtMMyMFj/Gv7cUQGUGWiLLtqTgJ9V0/G1yb/ZX0ozPL7Bp
         KrbA==
X-Gm-Message-State: AOUpUlGZ2UV2uuF/luyQoOJhcUVKMfs9Rg/CeCgeIDu4Px4wQb8MZZwj
        9e4BKFcS4PSmnGNTbymrnw==
X-Google-Smtp-Source: AAOMgpffFhQcF+Lqp766wOSxg6nPQX8Ca3vKXZOjmFmJ4d7xW1sJ2n3+6dP2jIYS/8q9PfWgnY1tAA==
X-Received: by 2002:a6b:9651:: with SMTP id y78-v6mr15514805iod.283.1532474419986;
        Tue, 24 Jul 2018 16:20:19 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id a64-v6sm1470978itg.28.2018.07.24.16.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 16:20:19 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:20:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pengbo Mu <pengbo.mu@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ran.wang_1@nxp.com
Subject: Re: [PATCH v6 3/4] arm64: dts: dwc3: description of incr burst type
Message-ID: <20180724232018.GA16709@rob-hp-laptop>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
 <1532341959-3478-3-git-send-email-pengbo.mu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532341959-3478-3-git-send-email-pengbo.mu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 06:32:38PM +0800, Pengbo Mu wrote:
> Add description of 'snps,incr-burst-type-adjustment' to binding
> so that configuring devicetree.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

