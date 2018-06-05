Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeFEM3s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:29:48 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35109 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbeFEM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:29:47 -0400
X-Google-Smtp-Source: ADUXVKKPIwWc812VoIMXGynY3LBiTIx5/TIABFa8uT0Nhb9IGBvzLCSBUz6VP22KEF9LUqL26ppUvqCbXRUahM7J8ZE=
MIME-Version: 1.0
In-Reply-To: <9ce783dc628699f02c45650c942f6735e93a18c4.camel@redhat.com>
References: <1528200262-11834-1-git-send-email-laoar.shao@gmail.com> <9ce783dc628699f02c45650c942f6735e93a18c4.camel@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 5 Jun 2018 20:29:05 +0800
Message-ID: <CALOAHbDLJjy-1s7Tyzwuc4WDz5qtqmoZRcKptj-7efo1E-22Vg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] ipv4: replace ip_hdr() with skb->data for optimization
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 8:20 PM, Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2018-06-05 at 08:04 -0400, Yafang Shao wrote:
>> In ip receive path, when ip header hasn't been pulled yet, ip_hdr() and
>> skb->data are pointing to the same byte.
>>
>> In ip output path, when ip header is just pushed, ip_hdr() and skb->data
>> are pointing to the same byte.
>>
>> As ip_hdr() is more expensive than using skb->data, so replace ip_hdr()
>> with skb->data in these situations for optimization.
>
> IMHO this makes the code less readable and more error prone. Which kind
> of performance improvement do you measure here?
>

Correct the cc list.

Hi Paolo,

There's a "+" opertaion in ip_hdr(),  using skb->data and avoid this operation.

Thanks
Yafang
