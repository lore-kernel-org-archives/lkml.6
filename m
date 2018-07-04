Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA47F23DC3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA47F23DC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933966AbeGDIUH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:20:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43892 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbeGDIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:20:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id u11-v6so3411966eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ZQJNvxtKLvHxgqtMRmMAuvkJZ0vPd3+T5STEFS7JeY=;
        b=n1u6h61Bcjb6h5g4M3jovsv26dU/5GOouf9ZU9HPds/GLntV1vdsPASidKQEhvcGmB
         KkibzWWMZK3xG9M42FuVFmTeAecduzB2nvr4/LU63Ts4elwtE+RwSDAfDr0nomRTsNTS
         dF7Fej910cYNuuTQppgVrGvRX1n8ILzpMtYBel30e6AgHAx/wlKPdXNFNW+kOQhXAwn7
         Js2KXulr3k6+X6M7fXC5s3lx57Eb9kL1U4L+i3eViLQ0cri9wbrd1s8T/4kuJupj7MDZ
         WHgskCNDVGjYDk4i+tolf5N/K+au6R2skZedfoCOMGz8D9BvugzsmGDVyo756Hv8OrHn
         MD0Q==
X-Gm-Message-State: APt69E2F4sMbajiBBoV6rCzCED7goAvWhNrjDMjtDyMPK8wVwdE0PSJk
        zmRmPxwE9+AoeM0It3+DIV5eB87Y
X-Google-Smtp-Source: AAOMgpd/qOYQe2vwWXeIM5dPdAFIfd33vFcBXe2sbJLelXrVy9dyYnGHkF6c25woKse5arv/EurnmA==
X-Received: by 2002:a50:ed92:: with SMTP id h18-v6mr1647374edr.117.1530692401009;
        Wed, 04 Jul 2018 01:20:01 -0700 (PDT)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id z70-v6sm2802460ede.6.2018.07.04.01.20.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:20:00 -0700 (PDT)
Received: by mail-wm0-f43.google.com with SMTP id v3-v6so1143490wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:20:00 -0700 (PDT)
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr902739wmi.16.1530692400382;
 Wed, 04 Jul 2018 01:20:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 01:19:39 -0700 (PDT)
In-Reply-To: <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org> <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org> <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 4 Jul 2018 16:19:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v67NvccReOk1OMBpUrr+A8i_f7swc23_Ko8rxXr_tJ6HUg@mail.gmail.com>
Message-ID: <CAGb2v67NvccReOk1OMBpUrr+A8i_f7swc23_Ko8rxXr_tJ6HUg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Mark Rutland <Mark.Rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 4:16 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 03/07/18 19:42, Samuel Holland wrote:
>> On 07/03/18 10:09, Marc Zyngier wrote:
>>> On 11/05/18 03:27, Samuel Holland wrote:
>>>> Hello,
>>>>
>>>> Several people (including me) have experienced extremely large system
>>>> clock jumps on their A64-based devices, apparently due to the architectural
>>>> timer going backward, which is interpreted by Linux as the timer wrapping
>>>> around after 2^56 cycles.
>>>>
>>>> Investigation led to discovery of some obvious problems with this SoC's
>>>> architectural timer, and this patch series introduces what I believe is
>>>> the simplest workaround. More details are in the commit message for patch
>>>> 1. Patch 2 simply enables the workaround in the device tree.
>>>
>>> What's the deal with this series? There was a couple of nits to address, and
>>> I was more or less expecting a v2.
>>
>> I got reports that people were still occasionally having clock jumps after
>> applying this series, so I wanted to attempt a more complete fix, but I haven't
>> had time to do any deeper investigation. I think this series is still beneficial
>> even if it's not a complete solution, so I'll come back with another patch on
>> top of this if/once I get it fully fixed.
>>
>> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
>> timer) ≈ 150 should be a conservative iteration limit?
>
> Should be OK.
>
> Maxime: How do you want to deal with the documentation aspect? We need
> an erratum number, but AFAIU the concept hasn't made it into the silicom
> vendor's brain yet. Any chance you could come up with something that
> uniquely identifies this?
>
>> Also, does this make sense to CC to stable?
>
> Probably not, as the HW never worked, so it is not a regression.

A64 support has been in for a few releases now. So while this is not
fixing a regression, people will still benefit from it being in stable.

ChenYu
