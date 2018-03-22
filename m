Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeCVKQT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:16:19 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:40860 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752004AbeCVKQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:16:17 -0400
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
To: John Fastabend <john.fastabend@gmail.com>,
        Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
 <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
 <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
 <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
 <00cc2d41-6861-9a9c-603f-ba8013b2e2ce@theobroma-systems.com>
 <4e33aae4-9e87-22b4-7f09-008183ea553a@gmail.com>
 <983427eb-2e25-f201-c953-4cff22569deb@theobroma-systems.com>
 <ffdc6ca9-bf64-5514-bac9-7b107f9b443b@gmail.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <9cf7a278-7269-9571-c378-ad98a5cd281b@theobroma-systems.com>
Date: Thu, 22 Mar 2018 11:16:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ffdc6ca9-bf64-5514-bac9-7b107f9b443b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.18 21:52, John Fastabend wrote:
> Can you try this,
> 
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index d4907b5..1e596bd 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -30,6 +30,7 @@ struct qdisc_rate_table {
>   enum qdisc_state_t {
>          __QDISC_STATE_SCHED,
>          __QDISC_STATE_DEACTIVATED,
> +       __QDISC_STATE_RUNNING,
>   };
> [...]

Tested, looks good. No OOO observed, no side effects observed, iperf 
numbers on Gigabit Ethernet look the same.

Thanks,
Jakob
