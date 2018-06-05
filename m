Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeFEPI6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:08:58 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37448 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFEPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:08:57 -0400
Date: Tue, 05 Jun 2018 11:08:54 -0400 (EDT)
Message-Id: <20180605.110854.1668470026592587341.davem@davemloft.net>
To: laoar.shao@gmail.com
Cc: pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] ipv4: replace ip_hdr() with skb->data for
 optimization
From: David Miller <davem@davemloft.net>
In-Reply-To: <CALOAHbDLJjy-1s7Tyzwuc4WDz5qtqmoZRcKptj-7efo1E-22Vg@mail.gmail.com>
References: <1528200262-11834-1-git-send-email-laoar.shao@gmail.com>
        <9ce783dc628699f02c45650c942f6735e93a18c4.camel@redhat.com>
        <CALOAHbDLJjy-1s7Tyzwuc4WDz5qtqmoZRcKptj-7efo1E-22Vg@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 5 Jun 2018 20:29:05 +0800

> On Tue, Jun 5, 2018 at 8:20 PM, Paolo Abeni <pabeni@redhat.com> wrote:
>> On Tue, 2018-06-05 at 08:04 -0400, Yafang Shao wrote:
>>> In ip receive path, when ip header hasn't been pulled yet, ip_hdr() and
>>> skb->data are pointing to the same byte.
>>>
>>> In ip output path, when ip header is just pushed, ip_hdr() and skb->data
>>> are pointing to the same byte.
>>>
>>> As ip_hdr() is more expensive than using skb->data, so replace ip_hdr()
>>> with skb->data in these situations for optimization.
>>
>> IMHO this makes the code less readable and more error prone. Which kind
>> of performance improvement do you measure here?
>>
> 
> Correct the cc list.
> 
> Hi Paolo,
> 
> There's a "+" opertaion in ip_hdr(),  using skb->data and avoid this operation.

Paolo is asking what performance improvement did you "measure".

I don't think this can possibly show up in a benchmark at all, and I
agree the code becomes less readable, so I am not applying this,
sorry.
