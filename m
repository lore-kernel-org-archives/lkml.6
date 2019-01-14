Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C706C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B5920660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfANJZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:25:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfANJZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:25:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5D2FA78;
        Mon, 14 Jan 2019 01:25:14 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 729153F5AF;
        Mon, 14 Jan 2019 01:25:12 -0800 (PST)
Subject: Re: [PATCH v3 1/2] arm64: arch_timer: Workaround for Allwinner A64
 timer instability
To:     Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20190113021719.46457-1-samuel@sholland.org>
 <20190113021719.46457-2-samuel@sholland.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <472c5450-1b60-6ac7-b242-805c2a2f3272@arm.com>
Date:   Mon, 14 Jan 2019 09:25:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190113021719.46457-2-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On 13/01/2019 02:17, Samuel Holland wrote:
> The Allwinner A64 SoC is known[1] to have an unstable architectural
> timer, which manifests itself most obviously in the time jumping forward
> a multiple of 95 years[2][3]. This coincides with 2^56 cycles at a
> timer frequency of 24 MHz, implying that the time went slightly backward
> (and this was interpreted by the kernel as it jumping forward and
> wrapping around past the epoch).
> 
> Investigation revealed instability in the low bits of CNTVCT at the
> point a high bit rolls over. This leads to power-of-two cycle forward
> and backward jumps. (Testing shows that forward jumps are about twice as
> likely as backward jumps.) Since the counter value returns to normal
> after an indeterminate read, each "jump" really consists of both a
> forward and backward jump from the software perspective.
> 
> Unless the kernel is trapping CNTVCT reads, a userspace program is able
> to read the register in a loop faster than it changes. A test program
> running on all 4 CPU cores that reported jumps larger than 100 ms was
> run for 13.6 hours and reported the following:
> 
>  Count | Event
> -------+---------------------------
>   9940 | jumped backward      699ms
>    268 | jumped backward     1398ms
>      1 | jumped backward     2097ms
>  16020 | jumped forward       175ms
>   6443 | jumped forward       699ms
>   2976 | jumped forward      1398ms
>      9 | jumped forward    356516ms
>      9 | jumped forward    357215ms
>      4 | jumped forward    714430ms
>      1 | jumped forward   3578440ms
> 
> This works out to a jump larger than 100 ms about every 5.5 seconds on
> each CPU core.
> 
> The largest jump (almost an hour!) was the following sequence of reads:
>     0x0000007fffffffff → 0x00000093feffffff → 0x0000008000000000
> 
> Note that the middle bits don't necessarily all read as all zeroes or
> all ones during the anomalous behavior; however the low 10 bits checked
> by the function in this patch have never been observed with any other
> value.
> 
> Also note that smaller jumps are much more common, with backward jumps
> of 2048 (2^11) cycles observed over 400 times per second on each core.
> (Of course, this is partially explained by lower bits rolling over more
> frequently.) Any one of these could have caused the 95 year time skip.
> 
> Similar anomalies were observed while reading CNTPCT (after patching the
> kernel to allow reads from userspace). However, the CNTPCT jumps are
> much less frequent, and only small jumps were observed. The same program
> as before (except now reading CNTPCT) observed after 72 hours:
> 
>  Count | Event
> -------+---------------------------
>     17 | jumped backward      699ms
>     52 | jumped forward       175ms
>   2831 | jumped forward       699ms
>      5 | jumped forward      1398ms
> 
> Further investigation showed that the instability in CNTPCT/CNTVCT also
> affected the respective timer's TVAL register. The following values were
> observed immediately after writing CNVT_TVAL to 0x10000000:
> 
>  CNTVCT             | CNTV_TVAL  | CNTV_CVAL          | CNTV_TVAL Error
> --------------------+------------+--------------------+-----------------
>  0x000000d4a2d8bfff | 0x10003fff | 0x000000d4b2d8bfff | +0x00004000
>  0x000000d4a2d94000 | 0x0fffffff | 0x000000d4b2d97fff | -0x00004000
>  0x000000d4a2d97fff | 0x10003fff | 0x000000d4b2d97fff | +0x00004000
>  0x000000d4a2d9c000 | 0x0fffffff | 0x000000d4b2d9ffff | -0x00004000
> 
> The pattern of errors in CNTV_TVAL seemed to depend on exactly which
> value was written to it. For example, after writing 0x10101010:
> 
>  CNTVCT             | CNTV_TVAL  | CNTV_CVAL          | CNTV_TVAL Error
> --------------------+------------+--------------------+-----------------
>  0x000001ac3effffff | 0x1110100f | 0x000001ac4f10100f | +0x1000000
>  0x000001ac40000000 | 0x1010100f | 0x000001ac5110100f | -0x1000000
>  0x000001ac58ffffff | 0x1110100f | 0x000001ac6910100f | +0x1000000
>  0x000001ac66000000 | 0x1010100f | 0x000001ac7710100f | -0x1000000
>  0x000001ac6affffff | 0x1110100f | 0x000001ac7b10100f | +0x1000000
>  0x000001ac6e000000 | 0x1010100f | 0x000001ac7f10100f | -0x1000000
> 
> I was also twice able to reproduce the issue covered by Allwinner's
> workaround[4], that writing to TVAL sometimes fails, and both CVAL and
> TVAL are left with entirely bogus values. One was the following values:
> 
>  CNTVCT             | CNTV_TVAL  | CNTV_CVAL
> --------------------+------------+--------------------------------------
>  0x000000d4a2d6014c | 0x8fbd5721 | 0x000000d132935fff (615s in the past)
> 
> ========================================================================
> 
> Because the CPU can read the CNTPCT/CNTVCT registers faster than they
> change, performing two reads of the register and comparing the high bits
> (like other workarounds) is not a workable solution. And because the
> timer can jump both forward and backward, no pair of reads can
> distinguish a good value from a bad one. The only way to guarantee a
> good value from consecutive reads would be to read _three_ times, and
> take the middle value only if the three values are 1) each unique and
> 2) increasing. This takes at minimum 3 counter cycles (125 ns), or more
> if an anomaly is detected.
> 
> However, since there is a distinct pattern to the bad values, we can
> optimize the common case (1022/1024 of the time) to a single read by
> simply ignoring values that match the error pattern. This still takes no
> more than 3 cycles in the worst case, and requires much less code. As an
> additional safety check, we still limit the loop iteration to the number
> of max-frequency (1.2 GHz) CPU cycles in three 24 MHz counter periods.
> 
> For the TVAL registers, the simple solution is to not use them. Instead,
> read or write the CVAL and calculate the TVAL value in software.
> 
> Although the manufacturer is aware of at least part of the erratum[4],
> there is no official name for it. For now, use the kernel-internal name
> "UNKNOWN1".
> 
> [1]: https://github.com/armbian/build/commit/a08cd6fe7ae9
> [2]: https://forum.armbian.com/topic/3458-a64-datetime-clock-issue/
> [3]: https://irclog.whitequark.org/linux-sunxi/2018-01-26
> [4]: https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/drivers/clocksource/arm_arch_timer.c#L272

nit: In general, I'm not overly keen on URLs in commit messages, as they
may vanish without notice and the commit message becomes less useful. In
the future, please keep those in the cover letter (though in this
particular case, the commit message explains the issue pretty well, so
no harm done once GitHub dies a horrible death... ;-).

The fix itself looks pretty solid, and will hopefully make the
"AllLoosers" HW more usable.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Daniel, please consider this for v5.1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
