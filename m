Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965162AbeCGUVs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:21:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45988 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964991AbeCGUVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:21:23 -0500
X-Google-Smtp-Source: AG47ELtDXLBIC52+PysfDcA9NMJo/nlRj8UyRtlT/oAjcaSEafwacqwlO/vqg1MtU5pqnUPiKEPcSg==
Message-ID: <1520454081.109662.54.camel@gmail.com>
Subject: Re: [PATCH] net: xfrm: use preempt-safe this_cpu_read() in
 ipcomp_alloc_tfms()
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Greg Hackmann <ghackmann@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Mar 2018 12:21:21 -0800
In-Reply-To: <20180307192416.233202-1-ghackmann@google.com>
References: <20180307192416.233202-1-ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 11:24 -0800, Greg Hackmann wrote:
> f7c83bcbfaf5 ("net: xfrm: use __this_cpu_read per-cpu helper") added
> a
> __this_cpu_read() call inside ipcomp_alloc_tfms().  Since this call
> was
> introduced, the rules around per-cpu accessors have been tightened
> and
> __this_cpu_read() cannot be used in a preemptible context.
> 
> syzkaller reported this leading to the following kernel BUG while
> fuzzing sendmsg:
> 
> 
> Cc: stable@vger.kernel.org

Hi Greg, thanks for this patch.

1) Please read Documentation/networking/netdev-FAQ.txt
around line 133

2) If you believe this needs to be backported, you must provide
a Fixes: tag to clearly identify commit that changed the behavior.

Otherwise dozens of stable teams will have to figure out by themselves,
wasting precious time.

Thanks.
