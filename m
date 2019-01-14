Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393B520657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8Uogyfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfANM5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:57:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53940 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANM47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:56:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so8793178wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eE6TJ5VZ3Nk1FjdARea1smiBFbzx1XYTfg4oJ2JGHJs=;
        b=g8UogyfyF0r7CuNlezSUf9iYT+RPRjoDO3uSz6mkbnuX//PjptXFIYAVK7rVeOrQ24
         5nMTLDJRVxI34R3QTHgPQHZe/r5rYJ1EVouM7l+ZQGaIU2hq9N1IG2uiUdOTLV/EQ0yI
         RKztBsreD1gDWBPCG0c+aPZIToZ0LEDFqzkGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eE6TJ5VZ3Nk1FjdARea1smiBFbzx1XYTfg4oJ2JGHJs=;
        b=X986XT7g23AiitOsJCSYa7y7Sw1YzIHw/9IWG61geEV17cFpqXgcGWs7yusKIphvUp
         mqi4pSzqS0t75uOTVKFz3JGHSsET1IqDEYvqlvrSMyocdeymzEt+HSsQ84LkPY3KMgo3
         3mAtQ478x8y6x1thQYFxHnfVwZAb0cCT0OCE4K6SAbVQueO+HU5p/EiZJJiLVJNy2YLk
         ZhuOU+2WZ4xHS3WKGsrF6hSjctUOUH9+rOQaq2UsBLCkyAksu33ONJ7KxwqLnrAn0pvJ
         F34tYj5xUoqHhC/jE/pZ1Xjk7qwUGVPy49C17w6w/uqa3k2o+7239jazwYvgsAyqjiTR
         7ClQ==
X-Gm-Message-State: AJcUukeXLSRVZaMdrf7uzeH6hvcYfbBT8es3QJZBTX411vkWHiVVuQrC
        aRmi2PKxk8DWHYa/qkdsRlVtcQ==
X-Google-Smtp-Source: ALg8bN5NhSGY+TVdXYyzaakXfLtjuIvc/XiBQFmC7Emp99x4wNII47joUaHwiYlnjHKyGw4Iw3Eozg==
X-Received: by 2002:a1c:834c:: with SMTP id f73mr11802641wmd.126.1547470617138;
        Mon, 14 Jan 2019 04:56:57 -0800 (PST)
Received: from [192.168.0.41] (45.70.136.77.rev.sfr.net. [77.136.70.45])
        by smtp.googlemail.com with ESMTPSA id 129sm45849167wmd.18.2019.01.14.04.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 04:56:56 -0800 (PST)
Subject: Re: [PATCH v3 0/2] Allwinner A64 timer workaround
To:     Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20190113021719.46457-1-samuel@sholland.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9738319a-4154-62be-2325-2873dfb326dc@linaro.org>
Date:   Mon, 14 Jan 2019 13:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190113021719.46457-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2019 03:17, Samuel Holland wrote:
> This is the third version of a patch series to fix system clock jumps
> and other timer instability on the Allwinner A64 SoC. It has now been
> tested for a week, and I've received no reports of date jumps with this
> version. So this is, as far as I can tell, a complete workaround.
> 
> See the commit messages for a detailed description of the issue, but the
> summary is that, when a high counter bit rolls over, indeterminance in
> the low bits causes CNTPCT/CNTVCT and their respective TVAL registers to
> jump forward or backward. Backward jumps (or the next read after forward
> jumps) are sometimes seen by the kernel and interpreted as the timer
> wrapping around after 2^56 cycles. This causes the system clock to jump
> forward approximately 91 years.
> 
> changes since v2;
> - Reduced workaround threshold from 11 to 10 bits based on reports from
>   other hardare and the U-Boot version of this workaround
> - Added TVAL handling based on Marc's suggestion
> - Added erratum documentation and renamed symbols to match
> - Added Maxime's Acked-by
> 
> changes since v1:
> - Add an iteration limit like most other arch timer workarounds
> - Added Andre's Tested-by
> 
> Samuel Holland (2):
>   arm64: arch_timer: Workaround for Allwinner A64 timer instability
>   arm64: dts: allwinner: a64: Enable A64 timer workaround
> 
>  Documentation/arm64/silicon-errata.txt        |  2 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
>  drivers/clocksource/Kconfig                   | 10 ++++
>  drivers/clocksource/arm_arch_timer.c          | 55 +++++++++++++++++++
>  4 files changed, 68 insertions(+)
> 

Applied. Took the opportunity to add the stable@ tag.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

