Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE30BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CA2208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CA2208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbeGJQNK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:13:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34206 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933796AbeGJQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:13:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id d3-v6so17008524edi.1;
        Tue, 10 Jul 2018 09:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ix89qJGC3vakEfvZ9b48uJYZodPf0vp0II501ylt0rI=;
        b=et0IfjlmO4Lbqc7svzrHBBjc0NFr09FBYLZIOE2CBsGMKoKXV1wvffoKGSUG55sqgZ
         hrNmkV+P4kyarctRk6wJKMtYKANzug/G7+biZBAw8PLoXlDT+9XqnyRYvHP9XeTZMyO+
         cxtbh8TOc3a1itYmpsLNanhkKk4S+H2dkZyiLEheZdlI9wcO3s+wxfaBhvZ7jeETWvA2
         E75bx7qVG3u1rTEcmb1G1xp9O1I3P6aZoy25zjdMYJ5psuvrE8s17MaTDCR15WJFHyh/
         V7Gt39wLZI6z2G40hNduA2Rn/N+ux8dvrnQBSc4RSYnVg9+u4Iyj7waHh1PhJfm9GqDg
         GEiQ==
X-Gm-Message-State: APt69E1P6EnmuDdVXI4f9kyz32y1sVJp0JfRqjuEGzrk0Rz4Y9evuPuH
        aVpqpoY24JOvs9jnFkclCEwKPLbC
X-Google-Smtp-Source: AAOMgpfLWpp6j8cZBnAtNFSESpfETqpLO4rcxdT2jK1XRYS61ZUiO3uFlY5ZlLw23EeA5meaW6+CfQ==
X-Received: by 2002:a50:ac65:: with SMTP id w34-v6mr27627341edc.211.1531239185963;
        Tue, 10 Jul 2018 09:13:05 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id e9-v6sm5713149edc.37.2018.07.10.09.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 09:13:05 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id h10-v6so15207430wre.6;
        Tue, 10 Jul 2018 09:13:05 -0700 (PDT)
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr17706581wra.19.1531239185492;
 Tue, 10 Jul 2018 09:13:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 09:12:45
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-12-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-12-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 00:12:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64-hz6=6H1HhJJogaK8TTtsG4x1LXkA5QX_b3J0pKOAEQ@mail.gmail.com>
Message-ID: <CAGb2v64-hz6=6H1HhJJogaK8TTtsG4x1LXkA5QX_b3J0pKOAEQ@mail.gmail.com>
Subject: Re: [PATCH 11/17] drm/sun4i: tcon: Add another way for matching
 mixers with tcon
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

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Till now, new way of matching engines with TCONs was reading their
> respective ids and match them by those ids. However, with introduction
> of TCON TOP, that might not be so straightforward anymore.
> - there might be more TCONs that engines (mixers)
> - TCON ids might have non-consecutive ids
>
> Workaround that by matching mixer id with TCON index from TCON list.
>
> For example, R40 has 2 mixers and 4 TCONs. Board designer can choose
> 2 outputs, which are connected to any of those 4 TCONs. As long as there
> are only 2 TCONs enabled in DT, using index in list as alternative id,
> will allow to match them with mixer 0 and 1.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
