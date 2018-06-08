Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Sk/zCZylGltvEAAAmS7hNA
	; Fri, 08 Jun 2018 15:56:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 52D6B607E4; Fri,  8 Jun 2018 15:56:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YFqOfsmZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B01E1605A5;
	Fri,  8 Jun 2018 15:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B01E1605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeFHP4t (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:56:49 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35794 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeFHP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:56:46 -0400
Received: by mail-pg0-f66.google.com with SMTP id 15-v6so6591523pge.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=19KKjaxCJTHwLDieLDI0lL7GxXca/rog49NJsj1gpUk=;
        b=YFqOfsmZ+epf9yyo+TzyLqkGwkftb/kahycAk7+CSQITW/xQRQKFl9oG+UeweKaILe
         KAxN57IVdjI5t5QxqhkreMDxO8R8Kejq0nJjihPI/9JH2r34mO8QUTPyr8tcvp5KaIYG
         oskH9fZaEkuq1ugPvp3dYzO4yEX2t4fWBn+A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=19KKjaxCJTHwLDieLDI0lL7GxXca/rog49NJsj1gpUk=;
        b=H8xMaD2BcxY5/pWh91aw/eTABWFdLEphZAj9nFr5krKjXWZfEI97Ts4TrsRaKuJFfC
         j34+oOxAzpuVW64wGo1Dk22IIxw23zNss5fXQJ7nHjsZzyUSkwTEh3mnvvpbGXPoh+pg
         nj4YEOqWz/JE9rVqwFMWuJZyV0nT34fyoThM8OsRS7pNbw6WBo8XuiWy40kW0h+w6nlk
         iAE7NztHJIaNgDIAiABEO1lssR5NBQjMk0CC0mPeL8oWHFY07VdmrpcscLHxld8UHs0e
         BdGy+gKhigLs5XljQx8wGWF2mtomfkLpsOCR0tgRyPAvS3cwaDd12XFDbBQZ0c7RIal8
         LQbg==
X-Gm-Message-State: APt69E063bLTL8CpH0H4PghtFxdHdGG865NnHb7UU8mNTnCrzd7L07Qa
        X6KW0vJaQa33JmgjMMisU0oHyg==
X-Google-Smtp-Source: ADUXVKJguXmDP9qELT1Brr+qjvaHv5Sle05ULnf13Sq7SSu4ugk4BDj/RLcxmPzncleXZJ3Qd1sFqg==
X-Received: by 2002:a63:3115:: with SMTP id x21-v6mr5650218pgx.373.1528473406148;
        Fri, 08 Jun 2018 08:56:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id w11-v6sm21507366pfn.71.2018.06.08.08.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 08:56:45 -0700 (PDT)
Date: Fri, 8 Jun 2018 08:56:44 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 11/11] misc: throttler: Add Chrome OS EC throttler
Message-ID: <20180608155644.GE88063@google.com>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-12-mka@chromium.org>
 <e1681e0f-2141-12a7-bed1-4d27a43ac9e8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1681e0f-2141-12a7-bed1-4d27a43ac9e8@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Fri, Jun 08, 2018 at 04:09:18PM +0200, Enric Balletbo i Serra wrote:

> On 07/06/18 20:12, Matthias Kaehlcke wrote:
> > The driver subscribes to throttling events from the Chrome OS
> > embedded controller and enables/disables system throttling based
> > on these events.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Changes in v2:
> > - added SPDX line instead of license boiler-plate
> > - use macro to avoid splitting line
> > - changed variable name for throttler from 'cte' to 'ce_thr'
> > - formatting fixes
> > - Kconfig: removed odd dashes around 'help'
> > - added 'Reviewed-by' tag
> > 
> > Note: I finally decided to keep 'Chrome OS' instead of changing it
> > to 'ChromeOS'. Both are currently used in the kernel, the latter is
> > currently more prevalent, however the official name is 'Chrome OS',
> > so there is no good reason to keep introducing the 'alternative' name.
> > 
> 
> I am pretty sure that somebody from Google told me the contrary, so
> 
> ¯\_(ツ)_/¯
> 
> Anyway, you will probably know better than me :)

The different names in the kernel code indicate that even folks at
Google disagree on this ;-) The name might have evolved over time.

chrome://chrome on a Chromebook names it 'Chrome OS', as do official
pages like https://www.google.com/chromebook/ and
https://www.chromium.org/chromium-os so I think it is better to use
this name.

> > +MODULE_LICENSE("GPL");
> 
> Something that I learnt recently. To match the SPDX-license tag you should set
> this to "GPL v2" [1]
> 
>  *	"GPL"				[GNU Public License v2 or later]
>  *	"GPL v2"			[GNU Public License v2]
> 
> [1] https://elixir.bootlin.com/linux/v4.17/source/include/linux/module.h#L172

Will update in the next revision

Thanks!

Matthias
