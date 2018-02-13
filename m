Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932970AbeBMAR5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:17:57 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34386 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932877AbeBMARz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:17:55 -0500
X-Google-Smtp-Source: AH8x2246CP6eBGX4H+x3bKpC8b5JcV+2jLpaAcAB2FPabfji6fynVxqKQ2rlu5RMmfwVnb1vhKw4Nw==
Subject: Re: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
To: Timur Tabi <timur@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
Cc: tchalamarla@cavium.com, rrichter@cavium.com, opendmb@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
 <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
 <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
 <f5d6d768-d354-56b5-ce0c-4f46d4e6d642@codeaurora.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <126b2cc2-a61e-b30d-1ff9-ea30af7abf57@gmail.com>
Date: Mon, 12 Feb 2018 16:17:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f5d6d768-d354-56b5-ce0c-4f46d4e6d642@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 04:10 PM, Timur Tabi wrote:
> On 02/12/2018 05:57 PM, Florian Fainelli wrote:
>> That is debatable, is there a good publicly available table of what the
>> typical L1 cache line size is on ARMv8 platforms?
> 
> I don't have that, but I was under the impression that we moved from 6
> to 7 because more and more ARMv8 platforms have 128-byte caches, so that
> is the "new normal".
> 

That does not seem to be the data that I am collecting from ARM's
website and some quick googling:

The following cores appear to have a 64bytes L1D cache line size: A55,
A73 (fixed), A35, A32, A53, A57 (fixed), A72 (fixed) even the Falkor
seems to be that way according to [1].

APM Mustang also seems to be 64b L1D according to [2].

[1]: https://en.wikichip.org/wiki/qualcomm/microarchitectures/falkor
[2]: http://www.7-cpu.com/cpu/X-Gene.html

And then we seem to covering what the ARM64 mainline kernel knows about
non-ARM implementations: ThunderX and ThunderX2 (formerly Broadcom
Vulcan). There is possibly the Qualcomm Kryo is different, but wikipedia
seems to suggest it is a derivative of existing Cortex-A CPUs which have
a 64b cache line size.

Let's see what Catalin and Will think about what the default should be.

Thanks!
-- 
Florian
