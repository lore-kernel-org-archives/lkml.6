Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2B1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7077B206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gz36Jvme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7077B206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeITVyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:54:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43217 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeITVyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:54:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id q19-v6so3791407pgn.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/uUuBEozYKvSvRt2eYaCcp1NE2IObb0USLCxlq2OQno=;
        b=gz36JvmeNaNhgywjaCrGMsXQHDMYlbTACu+uakNEbAGtUjyahdrV/nafNI9Vd5F+MT
         Cxui9SCHM+1gRpnPSc+FT8YUk+5+9tn4K1eBvOrSTCTgCmlje7u4kDMaqG7x5Izr8xcv
         LhlfG4+uwCeK4T0tMFtGOs3+lSSjNm4aEmP/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/uUuBEozYKvSvRt2eYaCcp1NE2IObb0USLCxlq2OQno=;
        b=ABh8xNUsUH4gEqxZuKv6upGFYyjK+1ht5X+eDTg7KRZICmZk/ZsHPiJmPNBxLcZiGL
         uquzymrrh5ebmT16cwXem5QU2nFPF1MJicR+DnObOPXmyKPJ5ptmRi3PRRnZPdx9dRSE
         wH4kzBzzxPKBb9g0TcE0AKP5JTmyH6PwTNQlDOj/oWLUMhF4KAuo96L0rNkqKBS6lFXB
         EvW6c3bg8w1xugxn7vihyBwfbHlGwToy+84W8AEHwavo9p+vTR11pTvhkomtf/IOL5ab
         bW2aapUIl3Z7Tbv689kWr6VmuokNnl7JG06yCA0miBxzP7vt5ajpIuxebg4MPqmHP9Im
         i4eQ==
X-Gm-Message-State: APzg51AWVk/PKIZ3zMqxdHvv0SnR3PJuTYiViqGqr46eMZE+n9h/li2D
        2dwKhoaA+dWaqFhdHS73I8hhn8KrF6M8jA==
X-Google-Smtp-Source: ANB0VdYmZcsqcsZ5D+1lQXVN55gld0wx0Flr5dfTyPaAsRnrwYyEmnitdC9MG5SiF6l4g8tw8hoAUw==
X-Received: by 2002:a62:cac5:: with SMTP id y66-v6mr41955360pfk.187.1537459794816;
        Thu, 20 Sep 2018 09:09:54 -0700 (PDT)
Received: from [10.21.2.196] ([209.121.128.187])
        by smtp.googlemail.com with ESMTPSA id i65-v6sm41442890pfk.43.2018.09.20.09.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:09:53 -0700 (PDT)
Subject: Re: [RESEND PATCH v3 0/3] sh: make early_platform code
 SuperH-specific
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20180827090651.25062-1-brgl@bgdev.pl>
 <CAMRc=McWre+5PRuozF69YKONvzy4X31=MzZim-QjhaAZ9iAVTw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9963d3f3-ba14-0d18-d669-53fc79b783c2@linaro.org>
Date:   Thu, 20 Sep 2018 18:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McWre+5PRuozF69YKONvzy4X31=MzZim-QjhaAZ9iAVTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 15:00, Bartosz Golaszewski wrote:

[ ... ]

> Ping for 4.20. This is the third release cycle I'm trying to get this
> merged and there never were any objections.

Thanks for the heads up, it is in the pipe.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

