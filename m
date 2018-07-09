Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6BF208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PNtZGciV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6BF208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeGIVqL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:46:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37632 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGIVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:46:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id x10-v6so4707055pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=fTUEuQ4I6JO2qARtvHuMHWdmuJdG593gADi1O+Ngkxg=;
        b=PNtZGciVjyF/ew7+VGskkfbOMOYX8QzyoQrSCwGSLinCYcvbDFSuWPq5TxRNGwQ+mP
         0MdZYyGF6G+/XWmK9gDSs0UAuelOV19k88N9zB2TnExoeKfIwuILSGYd4VbirbE6DqR5
         j1ioIUJV11sRJsZP4rKCDijmC3odaoo3Yfu/m7tZjeE7nIk4WunocGmzuqKz/4bQEjyS
         3gyHE/lvE1IArpV4sLEuRxSi9Gt3Rs1nMGFcfaVAjxel7PaVoD6x2x8HD227dptZ/YqK
         z9+GDoDyQ1/zoctTRj4MTlw/WLiYDzbRJBjxQpkm19OEiXZELDkxhXhcvdqPpsOqzuQZ
         bBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fTUEuQ4I6JO2qARtvHuMHWdmuJdG593gADi1O+Ngkxg=;
        b=AZ9iqZbf3OYOlUw4f8tt5tpsM4EmcOP6LCznar4hByaUmUzALh2X5AaBC1FMepk9Ek
         igANgX/zNOHroq2AJQRPOL+a+QDn6ACKEkue5qzltOACGyKM7tAvy1U0FRmfd+gAX9Sr
         S7FiEUwV7Jk/izcBnO9WovVzzR9QGAfYokmxdDaj6Foo9lb9INTOjBpB0rURlYdwLgTd
         5IcwHPEj4N2P4kjLlXjrel3jvnuigja9Wel8D62aMs+3QKT8C9RS618aF2ttXHFjvZAI
         SZIzyS/xHMKZb/mzoXSQrPbw7xsvHVNOpOARc28ROwj0Ynuq+h4Y6NIq2r3F4hoxWq8Z
         rAQg==
X-Gm-Message-State: APt69E3nAphriWtQJxDsYibksXmxH1BsbTEMRn4qTYwxsXOBlCJMnK/i
        lPNueGi9YGGTrCz+exM9+oNyl2vJiJY=
X-Google-Smtp-Source: AAOMgpfye4+x7ZPdHmpP0u53vGY9LV18/P3S7mg0Bn7tKIkk5SasNRCtb0V3mYbPXIYl0WpzyN9xjQ==
X-Received: by 2002:a65:5c03:: with SMTP id u3-v6mr19310200pgr.402.1531172768983;
        Mon, 09 Jul 2018 14:46:08 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30068790pfe.173.2018.07.09.14.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:46:08 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM64: dts: meson-axg: first round of daughter card updates
Organization: BayLibre
References: <20180628095054.13433-1-jbrunet@baylibre.com>
Date:   Mon, 09 Jul 2018 14:46:07 -0700
In-Reply-To: <20180628095054.13433-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 28 Jun 2018 11:50:51 +0200")
Message-ID: <7hsh4snkv4.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds a speaker amplifier and some leds present on daughter
> cards which are connected to the s400 board.
>
> Kevin, please note that the bindings documentation update for the tas5707
> has been queued for next in Mark Brown's ASoC tree. Not having it won't
> break anything but you may get checkpatch warning.

Thanks for the warning.

Series applied to v4.19/dt64,

Kevin
