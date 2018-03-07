Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934737AbeCGUuF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:50:05 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36006 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934509AbeCGUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:50:03 -0500
X-Google-Smtp-Source: AG47ELuQMG/WUIuZZymqgCDw3r1qoW38TEORBuchfjnFJ4PDRfoe7/kxmmU/sgdFBQ2b71YfPFIURg==
Subject: Re: [PATCH] net: xfrm: use preempt-safe this_cpu_read() in
 ipcomp_alloc_tfms()
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180307192416.233202-1-ghackmann@google.com>
 <1520454081.109662.54.camel@gmail.com>
From: Greg Hackmann <ghackmann@google.com>
Message-ID: <b33b7912-1cc1-142e-5e86-0014fc7d437e@google.com>
Date: Wed, 7 Mar 2018 12:50:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520454081.109662.54.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 12:21 PM, Eric Dumazet wrote:
> On Wed, 2018-03-07 at 11:24 -0800, Greg Hackmann wrote:
>> f7c83bcbfaf5 ("net: xfrm: use __this_cpu_read per-cpu helper") added
>> a
>> __this_cpu_read() call inside ipcomp_alloc_tfms().  Since this call
>> was
>> introduced, the rules around per-cpu accessors have been tightened
>> and
>> __this_cpu_read() cannot be used in a preemptible context.
>>
>> syzkaller reported this leading to the following kernel BUG while
>> fuzzing sendmsg:
>>
>>
>> Cc: stable@vger.kernel.org
> 
> Hi Greg, thanks for this patch.
> 
> 1) Please read Documentation/networking/netdev-FAQ.txt
> around line 133
> 
> 2) If you believe this needs to be backported, you must provide
> a Fixes: tag to clearly identify commit that changed the behavior.
> 
> Otherwise dozens of stable teams will have to figure out by themselves,
> wasting precious time.
> 
> Thanks.
> 

Apologies, I forgot that netdev has its own stable rules.  I'll
double-check which kernels are impacted and resend with an updated
commit log.
