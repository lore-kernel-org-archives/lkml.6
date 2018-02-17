Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2837347-1518875679-2-5078789823593169598
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518875679; b=gD7Z10uhoy95dPcV38SlZUejrE5EBCbon2MO7OrsESRRCV5
    0QO53MMdW6Lw1rMSYDbqypSGjWLYmkQHQjGnF8rgDtKmTfUeIqByKuffBQTwIvg5
    mM6dxQ2985AbdIu4x7gLdXF+fw8igAX5GsPDk0ktfXktXwW7gGfUnDhA+rPmUCwK
    Le8ElLxVgqsdn/cTPUt45R5RB46Zp2oChcOuuFyAFoNB6scnUJhFcE1OqyIvCmP1
    Lz/0ZTv/6E3NCw0A7TMJ+IeCxaSLq2DFyoizcAvFdTgtC2nJutq1eEaI3xULBROh
    nrTyX27jc2MtuAsZi+R1791+1tiW3nrD+oyGxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518875679; bh=3VNn2RLb9Q1jh5F0/FxXYTgLEGdjRZrDMzoTtdrJKNw=; b=l
    Iz1HJJKLW+9txKu/xBf1XN0/AaKSHnmUhfU3IVVqiHq8kcPMy852mVVj2TKvIySe
    XsZJc/+V2StRUUUQCXbq1GzyjEZJBxFSsT1b53a1Hk3yDze2781nbG4VyRbbyhR1
    0Angv7JA5JoU6SVJXIzuxfAxjLjT0TmA7BvIBpqN3seJpXbuP4sUhCM+ko/DPKJX
    DIwsLZsH8Kzj3CZ1Xi5hXJ1MeiDSPJwv/LzriSb/qosp6m1AW4IIVo87VkQH/urr
    sFmutJ8gfvv1eufqgYcqaBZ5eCwHeYia72mllIFcMN+osVejlTPeE+aTlO3UpVfi
    O+iuuPnNSY5wI8wdiD9xA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HDtUvvyg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rlRoVReF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HDtUvvyg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rlRoVReF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbeBQNyW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 08:54:22 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41319 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeBQNyU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 08:54:20 -0500
X-Google-Smtp-Source: AH8x2250X3oVjLObFlgZwch1nB3dya/62Qn/hIyhvZaT6EG++Vfx/4O3V4r6LBIxjfUsh2Fnn5H7eg==
Subject: Re: [PATCH] clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops
To: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180217130504.8668-1-wens@csie.org>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <694c5137-0020-bb62-68c7-f9729c101462@gmail.com>
Date: Sat, 17 Feb 2018 14:54:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180217130504.8668-1-wens@csie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 17.02.2018 14:05, Chen-Yu Tsai wrote:
> When support for the A31/A31s CCU was first added, the clock ops for
> the CLK_OUT_* clocks was set to the wrong type. The clocks are MP-type,
> but the ops was set for div (M) clocks. This went unnoticed until now.
> This was because while they are different clocks, their data structures
> aligned in a way that ccu_div_ops would access the second ccu_div_internal
> and ccu_mux_internal structures, which were valid, if not incorrect.
> 
> Furthermore, the use of these CLK_OUT_* was for feeding a precise 32.768
> kHz clock signal to the WiFi chip. This was achievable by using the parent
> with the same clock rate and no divider. So the incorrect divider setting
> did not affect this usage.
> 
> Commit 946797aa3f08 ("clk: sunxi-ng: Support fixed post-dividers on MP
> style clocks") added a new field to the ccu_mp structure, which broke
> the aforementioned alignment. Now the system crashes as div_ops tries
> to look up a nonexistent table.
> 
> Reported-by: Philipp Rossak <embed3d@gmail.com>
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Philipp Rossak <embed3d@gmail.com>
> ---
> 
> Philipp, can you give this a test and report if this fixes thing?
> I don't have any A31/A31s boards online to test this.
> 
Thanks!
That fixes that bug!

Philipp

> ---
>   drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> index 72b16ed1012b..3b97f60540ad 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
> @@ -762,7 +762,7 @@ static struct ccu_mp out_a_clk = {
>   		.features	= CCU_FEATURE_FIXED_PREDIV,
>   		.hw.init	= CLK_HW_INIT_PARENTS("out-a",
>   						      clk_out_parents,
> -						      &ccu_div_ops,
> +						      &ccu_mp_ops,
>   						      0),
>   	},
>   };
> @@ -783,7 +783,7 @@ static struct ccu_mp out_b_clk = {
>   		.features	= CCU_FEATURE_FIXED_PREDIV,
>   		.hw.init	= CLK_HW_INIT_PARENTS("out-b",
>   						      clk_out_parents,
> -						      &ccu_div_ops,
> +						      &ccu_mp_ops,
>   						      0),
>   	},
>   };
> @@ -804,7 +804,7 @@ static struct ccu_mp out_c_clk = {
>   		.features	= CCU_FEATURE_FIXED_PREDIV,
>   		.hw.init	= CLK_HW_INIT_PARENTS("out-c",
>   						      clk_out_parents,
> -						      &ccu_div_ops,
> +						      &ccu_mp_ops,
>   						      0),
>   	},
>   };
> 
