Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeDEXLb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:11:31 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.36]:44943 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751117AbeDEXLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:11:30 -0400
Subject: Re: [PATCH] clk: samsung: s3c: Mark expected switch fall-through
To: Stephen Boyd <sboyd@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180404010931.GA30291@embeddedor.com>
 <152295987121.91052.16578276622043986934@swboyd.mtv.corp.google.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4d52473e-019a-58da-c475-49bcd16c2ed4@embeddedor.com>
Date: Thu, 5 Apr 2018 18:11:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152295987121.91052.16578276622043986934@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f4E2S-002WFy-VN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:60844
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2018 03:24 PM, Stephen Boyd wrote:
> Quoting Gustavo A. R. Silva (2018-04-03 18:09:31)
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that in this particular case I replaced the comma wiht a dash,
> 
> s/wiht/with/
> 

Thanks for this.

>> which is what GCC is expecting to find when there are other comments
>> in the same line in which "fall through" appears.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> This code was compiled with GCC 7.3.0
> 
> What's the GCC warning? Please include in the commit text.
> 

drivers/clk/samsung/clk-s3c2443.c:430:3: warning: this statement may 
fall through [-Wimplicit-fallthrough=]
    samsung_clk_register_alias(ctx, s3c2450_aliases,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ARRAY_SIZE(s3c2450_aliases));
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/samsung/clk-s3c2443.c:433:2: note: here
   case S3C2416:
   ^~~~


> Also what's the implicit-fallthrough level you're using? 3? Can you file
> a bug so GCC can update their regex to accept a comma in addition to
> whitespace characters?
> 

Yeah, I can talk to the GCC guys about that.

> And maybe we can change the level to 2 or 1 in the kernel's makefile so
> we don't need to patch comments for this.
> 

Yeah, with level 2 I don't get that warning.

Thanks
--
Gustavo
