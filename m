Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeDJGdU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:33:20 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42280 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJGdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:33:18 -0400
X-Google-Smtp-Source: AIpwx48wzO3JDXnGt6V/2jIV30feYFicC7VTwwalwQoH696t2axJs18TN7Zm4ZqqsF8RG//qGbiHMBKWd88mc7DWpyE=
MIME-Version: 1.0
In-Reply-To: <20180408013210.GD3036@codeaurora.org>
References: <20180406142832.2243021-1-arnd@arndb.de> <20180406142832.2243021-3-arnd@arndb.de>
 <20180408013210.GD3036@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 10 Apr 2018 08:33:17 +0200
X-Google-Sender-Auth: OJnPoXsJE1L4OOub2uy89dv5JBw
Message-ID: <CAK8P3a3JCYn=QE9A6+ZBOfXex0FdeVAJ0HJdaHVcvGzb2AeQkQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] hexagon: export csum_partial_copy_nocheck
To: Richard Kuo <rkuo@codeaurora.org>
Cc: "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 3:32 AM, Richard Kuo <rkuo@codeaurora.org> wrote:
> On Fri, Apr 06, 2018 at 04:28:23PM +0200, Arnd Bergmann wrote:
>> This is needed to link ipv6 as a loadable module, which in turn happens
>> in allmodconfig.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/hexagon/lib/checksum.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
>> index 617506d1a559..7cd0a2259269 100644
>> --- a/arch/hexagon/lib/checksum.c
>> +++ b/arch/hexagon/lib/checksum.c
>> @@ -199,3 +199,4 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
>>       memcpy(dst, src, len);
>>       return csum_partial(dst, len, sum);
>>  }
>> +EXPORT_SYMBOL(csum_partial_copy_nocheck);
>
> Acked-by: Richard Kuo <rkuo@codeaurora.org>

Can you take the two patches you acked through your tree? They are not urgent,
but with those applied, I got very close to building an allmodconfig
kernel without
warnings, using the toolchain I uploaded to
https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.1/

        Arnd
