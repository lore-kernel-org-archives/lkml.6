Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62374C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA6120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547582621;
	bh=0adMhxUtyzq22HjpgED11cw0g8HFnQtRZw74xtJLvdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+rTvRUtgaej+w9stR6yLsrqjgmyzajFwTp7610ffJfsZDI8gt4TsVZJNqyMtIbJi
	 8BXZr2OGhRZ69HEhcplacm0szUD+X2mYPnjZGBWmqGfJA3ibsXaiebOnHgStZcNjh5
	 KRcM3WJiuTZG6D70Ge/wFqeq/RgmRTJDA5r90/Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389660AbfAOUDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:03:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34259 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbfAOUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:03:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so3746994otk.1;
        Tue, 15 Jan 2019 12:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QqvTBDV1uQq+GdW+1OSVJwQpsI0+7RfGV3b1bVoHRo=;
        b=KRTVvPsJTVGVjLku0xwFvKf18g7IagEWz500T4uUxkrq2qWsNEjlSJhqiNYolHn4lJ
         ZF9UIUypyXC0Il1fFdIbbqeIQhSH/GI6TyRnx9dUZ7mdA3v9W6sdhVhpO05jno40b3uF
         WbwFGk4uexfiXuiLqJnJMdqq94IWzLIfUAOMIwi55X8bGqqR9Lfl5y/Wx8wINfEZw/gB
         E6K9PwDjgkjQCjrm7wJvfRfoSyye24NXW5cFsiE4SCUKiBtx0RIvsOyKb1vczhuXmT41
         kV/lEk6z/5Lf804ImKZX3wQK7fze9F/+sxv1ThIodHGv7iZFDrDVkxehQyj+zk6aCrnT
         HLqw==
X-Gm-Message-State: AJcUukctLrCnWXoby7tirACxVQpKUtNrBU4T/Q00havlwWuarEv3IWc/
        JMhekuutqUIoi0SkQVZdWA==
X-Google-Smtp-Source: ALg8bN4I5eDMwMY2RHE5IZ5Pg3F4bAdM6ABnyFSQgcC3NxuQZGzLmpU/jFqKuQzkGziRhBB+h71nXA==
X-Received: by 2002:a9d:6d95:: with SMTP id x21mr3087488otp.99.1547582617993;
        Tue, 15 Jan 2019 12:03:37 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id y80sm1874026oie.40.2019.01.15.12.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:03:37 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:03:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 1/5] dt-bindings: leds: Add pattern initialization
 from Device Tree
Message-ID: <20190115200336.GA14333@bogus>
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
 <1547045089-19128-2-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547045089-19128-2-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 15:44:45 +0100, Krzysztof Kozlowski wrote:
> Document new led-pattern property for initialization of LED triggers.
> The property format is trigger-specific (except being array of
> integers).  For pattern trigger, the explanation of pattern format was
> moved to a common file shared with sysfs ABI.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  .../ABI/testing/sysfs-class-led-trigger-pattern    | 51 ++--------------------
>  Documentation/devicetree/bindings/leds/common.txt  | 12 +++++
>  .../bindings/leds/leds-trigger-pattern.txt         | 49 +++++++++++++++++++++
>  3 files changed, 64 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
