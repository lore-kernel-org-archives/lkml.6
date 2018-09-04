Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7FEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC10520867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC10520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeIDNJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:09:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42557 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeIDNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:09:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so2589784edw.9;
        Tue, 04 Sep 2018 01:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SCrRS11HN1cCTS6i+ECLNGBqGRuhnAHmB2VZqFqfIk=;
        b=JzADPmmkNtnVzdNRoRY7wtCXc+LRiASUKtJgqcWCbcNI8+Ip7KXgGefTxUyqG2Fcpd
         HM55uxIkazkrByB5q2R72uSRVSdQu2K7t0OiTeRueBHnNlf3dE7ojfoDXtjvCAFCltE/
         I8C8lCMFqa9gDSSW9DLakMHZx1BSV3GFQ0hqrsEumfSFaW8mhgmW2YsVF/AQKRkMNFGU
         E8UN85V7da1R8YffQN6MlZpanWTZbLZC9pBWemOxjtAh3nXdBvRnYp03YlTjTlqoltA6
         o2yS5GBnvUhbmpBDXD0Ea3E3M1+uRZY7SSzoutafiMQbE0SsjCG3akcVgIomEg8TRkok
         abPw==
X-Gm-Message-State: APzg51A/r6KSHIm4LxsmsEdYOLapz4Hm0P9HAQeV9XCbkmRqDChhjE7n
        xhFVdeAjRoMX7pE90NDsvVs6mTHZ0+o=
X-Google-Smtp-Source: ANB0VdbbK2Zl6BOnDs+c1CO/nZatEZDduEpHMVIMRvxYFbNF+F6qyo5AkZ8XVEwbffBBduarmjdlRA==
X-Received: by 2002:a50:a93c:: with SMTP id l57-v6mr34602262edc.229.1536050708991;
        Tue, 04 Sep 2018 01:45:08 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id x7-v6sm9533331edx.65.2018.09.04.01.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 01:45:08 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id y139-v6so3450573wmc.2;
        Tue, 04 Sep 2018 01:45:08 -0700 (PDT)
X-Received: by 2002:a1c:6646:: with SMTP id a67-v6mr1769903wmc.157.1536050359281;
 Tue, 04 Sep 2018 01:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-2-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-2-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Sep 2018 16:39:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v66V=7ArH0hssVZbBhD1v9P86oOXSh+1pY3e9xrzCHXBeQ@mail.gmail.com>
Message-ID: <CAGb2v66V=7ArH0hssVZbBhD1v9P86oOXSh+1pY3e9xrzCHXBeQ@mail.gmail.com>
Subject: Re: [PATCH 01/27] dt-bindings: sunxi-sram: add binding for Allwinner
 H6 SRAM C
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> The Allwinner H6 SoC's DE3 needs the SRAM C section being claimed in the
> system controller to work, like A64 DE2.
>
> As H6 and A64 system controller are quite similar, code is reused now,
> and the A64 fallback compatible string is added after the H6 compatible
> string.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> [fixed typo in compatible string]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
