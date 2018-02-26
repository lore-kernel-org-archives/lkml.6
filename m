Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeBZPyJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:54:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42033 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752168AbeBZPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:54:06 -0500
X-ME-Sender: <xms:nS2UWqCq3xByYGDslgHFo0WU3ZRsp5L0mldDUykgSjLJyBX9ZBoLxw>
Subject: Re: [PATCH v3 6/7] arm64: allwinner: h6: add the basical Allwinner H6
 DTSI file
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180223123555.64009-6-icenowy@aosc.io>
 <20180223123555.64009-7-icenowy@aosc.io>
 <20180223152038.2bflylwa6vj4gzfj@flea.lan>
 <81D53DC5-7622-430E-A530-ED0DE5397DC3@aosc.io>
 <20180226092645.xghkmfowenzlbm42@flea.lan>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <b9bc5944-b9e3-91d7-8012-c87a2b2d17fa@sholland.org>
Date: Mon, 26 Feb 2018 09:54:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180226092645.xghkmfowenzlbm42@flea.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/18 03:26, Maxime Ripard wrote:
> On Fri, Feb 23, 2018 at 11:22:06PM +0800, Icenowy Zheng wrote:
>>>> +	psci {
>>>> +		compatible = "arm,psci-0.2";
>>>> +		method = "smc";
>>>> +	};
>>>
>>> Is it needed? The bootloader should fill it with whatever version it
>>> has, shouldn't it?
>>
>> But we now use ATF rather than U-Boot PSCI. U-Boot will not fill ATF
>> info.
>>
>> See A64/H5 device trees.
> 
> So if the PSCI version implemented in ATF ever changes, we would have
> to update all the DT everywhere, but only if you're running the new
> version?

Yes but no. PSCI 1.0 is generally backward compatible with PSCI 0.2. In fact,
the Linux driver treats them exactly the same:

        { .compatible = "arm,psci-0.2", .data = psci_0_2_init},
        { .compatible = "arm,psci-1.0", .data = psci_0_2_init},

For the H6, however, the oldest ATF source available (which I believe was the
one in use during bringup) is based on mainline 1.4, and is already at PSCI
version 1.1:

[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.

So we could go ahead and bump the compatible to "arm,psci-1.0".

Thanks,
Samuel
