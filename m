Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A44CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390662075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390662075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeKTGcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:32:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33461 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbeKTGcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:32:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so3851075plo.0;
        Mon, 19 Nov 2018 12:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FXEN9sbWgJdXq5ENTlF0EfG53hto/zlyMzbGXm54vqo=;
        b=ZSitquTm6zhTz/KXsYktCiaUZGwl1kOOYZ8gszQmzkWDmbnwXx5yzxa5PP6UpAlJnf
         pAuG5YVAJC3lVwNbMpvK70fKlV7sT9rMIAKUMnZW2S4weXszfGZOTXYoGhtQYyY60bu+
         E9+Uv+xkO4yNWmD4/pgKAfCe/PsHVYPRZeLcw+PG1qFOtVak7taUq1Jc0tLtlDnfNu1x
         4Z5r/dF2ZZcwhabgrlzWGbHBb/+F/t5ia3dKcgGCoVTYNoiER9idSrHgr3aFeEAuVKTZ
         Huxmav6peAqomqEt2ghj9MmtqlGKf8XLGyEsoZytVjRpXrKS8ltnjHcD2dZW07ZevSD3
         bNgA==
X-Gm-Message-State: AGRZ1gJEqwPdO38Y84pNSsFTM6aEMURmTs6UVTWvseyn8R2ryrcStx/q
        WCiiD7p0lxQw+58acZqwu1I=
X-Google-Smtp-Source: AJdET5cAZXGPUwtnVs3MrbNIyBSTspI4WijU1VSnd552Ro7uc3dF3s4rMdIzc51PYpMiUv/YRqJytg==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr23638565plx.231.1542658031719;
        Mon, 19 Nov 2018 12:07:11 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id t66sm16366348pfd.54.2018.11.19.12.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 12:07:09 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 19 Nov 2018 12:07:07 -0800
Date:   Mon, 19 Nov 2018 12:07:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, mcgrof@kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH v2 1/2] firmware: add nowarn variant of
 request_firmware_nowait()
Message-ID: <20181119200707.GP5238@garbanzo.do-not-panic.com>
References: <20181112160143.4459-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160143.4459-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:01:42PM +0100, Lucas Stach wrote:
> Device drivers with optional firmware may still want to use the
> asynchronous firmware loading interface. To avoid printing a
> warining into the kernel log when the optional firmware is
> absent, add a nowarn variant of this interface.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Thanks for the patch Lucas!

> +EXPORT_SYMBOL(request_firmware_nowait_nowarn);

New symbols should use firmware_* prefix, so use:

  * firmware_request_nowait_nowarn()

Also, please make new functionality EXPORT_SYMBOL_GPL(), the old functioanlity
must be kept as-is, so in this caseEXPORT_SYMBOL().

Other than this, you should be aware that there has been significant
discussion over how to properly evolve the API of the firmware API since
last year, you may want to read those threads. The short and skinny of
it though is that the firmware API has two main diverging modes of
operation:

  o async
  o sync

The async functionality diverges from the synchronous functionality in
that it is data driven. The synchronous functionality is functional, and
experience shows that while data driven can avoid collateral evolutions
we *don't prefer it in the kernel*. So we should break down the async
API to match the sync functional design.

Internally we can use flags for small modifications, as we use them now,
but since we don't expose flags for the sync case lets try to keep
parity for this API then.

A good example of what we need to do. The uevent flag is only set to
false by only two drivers:

  o CONFIG_LEDS_LP55XX_COMMON
  o CONFIG_DELL_RBU

As such, this functionality should just be wrapped into its own single
functional call eventually.

The conversion of the async API to functional does not need to happen
for your changes, but new async API should follow the functional driven
approach. So please make your call work as functional.

Please let me know if this makes sense or if you have any quetsions!

[0] https://lore.kernel.org/lkml/20180628031332.GE21242@wotan.suse.de/T/#u
[1] https://lkml.kernel.org/r/20180421173650.GW14440@wotan.suse.de              
[2] https://lkml.kernel.org/r/20180422202609.GX14440@wotan.suse.de 

  Luis
