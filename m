Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965437AbeEIQNn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:13:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:56607 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965421AbeEIQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:13:41 -0400
Subject: Re: [PATCH bpf-next] xsk: fix 64-bit division
To: Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>, ast@fb.com,
        netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, magnus.karlsson@intel.com,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e9890e95-16b4-4540-301b-43f17a824808@infradead.org>
 <20180507174350.3534-1-bjorn.topel@gmail.com>
 <baf737cf-a0c4-b542-8d37-fd9cdfe7101d@infradead.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <17967788-2811-892b-0126-1bc49a5b9929@iogearbox.net>
Date: Wed, 9 May 2018 18:13:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <baf737cf-a0c4-b542-8d37-fd9cdfe7101d@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 08:25 PM, Randy Dunlap wrote:
> On 05/07/2018 10:43 AM, Björn Töpel wrote:
>> From: Björn Töpel <bjorn.topel@intel.com>
>>
>> i386 builds report:
>>   net/xdp/xdp_umem.o: In function `xdp_umem_reg':
>>   xdp_umem.c:(.text+0x47e): undefined reference to `__udivdi3'
>>
>> This fix uses div_u64 instead of the GCC built-in.
>>
>> Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
>> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
> 
> I don't know why the subject says xsk (instead of xdp), but anyway:
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Applied to bpf-next, thanks everyone!
