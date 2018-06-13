Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 44A86C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9857208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/j8qINn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9857208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935278AbeFMLGj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:06:39 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37442 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935121AbeFMLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:06:37 -0400
Received: by mail-it0-f67.google.com with SMTP id l6-v6so3261002iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mctu3tvLzVeasiSNbT3iivkQ7r4RunVh9ZCDPYUFuW4=;
        b=V/j8qINnk8lmBUsccj6hGp79uCmuGLL5n4Vy5HiPfp8xQrNfpj7QzO5So0HWuJAqxX
         5/E59WH7zNo7Ws7YLSllxqPggGQffxKLSpzjUNt2Jl3Xq6vN0HeNVAi1sOj+MAanq3VT
         ec4sCyXkhutVlPLCbDCldOBwezyH9xkUQ/qGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mctu3tvLzVeasiSNbT3iivkQ7r4RunVh9ZCDPYUFuW4=;
        b=RQ58GPFrkiPYYoXTu+cWePuteb/VXr9yYFfAeuVpXrOadgrRGExqqSUAm/X0dmaHSn
         VKJk+FV0fSc+z/J9ay2wBfjwb8aOgjV67Pr69LR5O+bFzOX8dMBggos41mo+rQkVdLiN
         YCnO6sCOYCZn5zaAf5/n3azxHzFSd09NKNQ3/s60vZ8OvdX8CaDiBBoNvplNt/TVCgyX
         w+JHCq4ATkf0WkB9wZWN6kHjFYRtFpii4BfpQsJGXWKceOEp90+HApvN6158EW9jXk9W
         LG1834dLCSXQ6QO00dsgiEv/iBvQMnuP08YpAbB9OvmqIXYsGZ5AwGoh/IMKYdg3qRWT
         rXug==
X-Gm-Message-State: APt69E1jACwMF2WQWtqWFot4t8rOWpXs8GGnzDxpPsia8uwGgBj00b5N
        hrdooR5ZPeRPn3YZbeSQPjsg/1L6UQE+gmPLRSxWsqGc
X-Google-Smtp-Source: ADUXVKJCYTOUHt7TeusuwPTknBVyFcNVJM+ByzRPhBodtkmPX9lTMVPU1BIeX6JvxwbfhEaC/JUM6nPYpJIY4RLaM54=
X-Received: by 2002:a02:5206:: with SMTP id d6-v6mr136505jab.112.1528887996615;
 Wed, 13 Jun 2018 04:06:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 04:06:35
 -0700 (PDT)
In-Reply-To: <20180607181306.9766-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180607181306.9766-1-ctatlor97@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Jun 2018 13:06:35 +0200
Message-ID: <CACRpkdaKMr0qm91Q4LyjBGyKG_H4vvMr7bnRJeai+f2Eg-9r0Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] fixp-arith: add a linear interpolation function
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 8:12 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:

> Adds a function to interpolate against two points,
> this is carried arount as a helper function by tons of drivers.
>
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

The linear formula seems to fit the most natural form of linear
interpolation.

I bet some John Carmack algorithm type people will soon
start to optimize this... :D

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
