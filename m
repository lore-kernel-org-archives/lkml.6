Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794AFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8E5208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8E5208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934176AbeGJPVe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:21:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45217 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933979AbeGJPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:21:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id i20-v6so3845665eds.12;
        Tue, 10 Jul 2018 08:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qEno4xkGoxX5pl8wmkatEtEx/qINXMH2gkDu+0Gf3u0=;
        b=fBdOZjaqgvCgTjKp/bfnOzLbonjbd/3qk4IS4mt06GtIAyTWEC/0mRYj2Y3mc9/C5N
         XQAFstljEBMaWAF8D5D3yP6G7bsXTPk3nr9ufxh9MzFD4a4OHbcbFxP6wqWy/vaxca+2
         RENag3bR6ecLLsBlmUXyB0pjbq4HZA2/vdlfyP7MhBGU8EOjhYKn6d6qKCBHCIhiddtX
         HdtCWsnA0eADkwW1na48y7lP1oTpDWRfACuQ1TWp7ms3ATrnqB2EzePWS57/4xQWyzlO
         APX4WqG3eraxNHAW4i96yKmABq/Y7AcU3MS0oe2dgys8+n8bMRqhpDOdioefDlyItrXV
         o9Xw==
X-Gm-Message-State: APt69E1vfD9cyvFgAEgGeThRrulNAK+wm7QHxeALOVCXZVXppQDZXC6+
        gy3qKLZ01gRjt96x7lRaw/bo/i0V
X-Google-Smtp-Source: AAOMgpco8r+4V5bv8a100R+Gqv3279ulYWV3HoV6Rw9g/rQZLOVwGAmeealZKVEGXRV527LOxPGljQ==
X-Received: by 2002:a50:afa3:: with SMTP id h32-v6mr27062444edd.129.1531236088884;
        Tue, 10 Jul 2018 08:21:28 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id s19-v6sm1948552edd.53.2018.07.10.08.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:21:28 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id j5-v6so8526445wrr.8;
        Tue, 10 Jul 2018 08:21:28 -0700 (PDT)
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr17563271wra.19.1531236087982;
 Tue, 10 Jul 2018 08:21:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:21:07
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-4-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-4-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:21:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v67NgyW8ATtfS_abjYhLkRa8L-cJZ5=xHurZ+tJJ=0uijg@mail.gmail.com>
Message-ID: <CAGb2v67NgyW8ATtfS_abjYhLkRa8L-cJZ5=xHurZ+tJJ=0uijg@mail.gmail.com>
Subject: Re: [PATCH 03/17] ARM: dts: sun8i: r40: Remove fallback display
 engine compatible
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 1:50 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 has pretty unique display pipeline. Because of that, H3 display
> engine compatible fallback should be removed.
>
> Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
