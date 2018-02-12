Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeBLSVp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:21:45 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:40706 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbeBLSVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:21:43 -0500
X-Google-Smtp-Source: AH8x227QOqbqLBqwP4bgnfJpizW1nuhzOoK0foESqLEJTQZ5u5NibEZeEQauZBE3himBTvWwq8IYnQ==
To: linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com,
        wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
From: Philipp Rossak <embed3d@gmail.com>
Subject: BUG: A31s Not booting anymore
Message-ID: <e155f7fc-9c22-d8ac-d142-805812aa9988@gmail.com>
Date: Mon, 12 Feb 2018 19:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

When I try to boot my A31s (Bananapi M2) u-boot is showing only Starting 
kernel ... . After enabling the earlyprintk I could capture this log: [1].

After reverting those 5 commits from Chen-Yu I was able to boot again:


clk: sunxi-ng: Support fixed post-dividers on NM style clocks
7d333ef1cc1b8c8951f3a2c41f6406e2295d8be9

clk: sunxi-ng: sun8i: a83t: Add /2 fixed post divider to audio PLL
10e6eb4f2c5b35ae71c9bc0db83d74238719b453

clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL
e952ca3c6b2ffdfbf9618e4bd3e9aad1ff3f5eb4

clk: sunxi-ng: Support fixed post-dividers on MP style clocks
946797aa3f08e2f6f5992f3ec2be44791e9b9260

clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module clocks
83fe3be4d1974f5f50c5e2039a1609f4960e8579


I allready tried to fix it with making them save against zero:

if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV && \
     	cmp->fixed_post_div with)
                rate *= cmp->fixed_post_div;

But that didn't help.

Any ideas?

Regards,
Philipp

[1]: https://pastebin.com/64Fzzqvg
