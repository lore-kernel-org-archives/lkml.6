Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbeEWRfm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:35:42 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:36022 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeEWRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:35:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w4NHZX5Y004714
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
 <fa5c2615-40b3-62bc-3dda-59f9ef574686@wiesinger.com>
 <76c3f5ec-0ab2-c06d-98e8-277284bb1a8e@gmail.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <779f2be3-3e74-e650-5240-efaf1003d77c@wiesinger.com>
Date: Wed, 23 May 2018 19:35:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <76c3f5ec-0ab2-c06d-98e8-277284bb1a8e@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2018 17:28, Florian Fainelli wrote:
>
>> And in the future (time plan)?
> If you don't care about multicast then you can use those patches:
>
> https://github.com/ffainelli/linux/commit/de055bf5f34e9806463ab2793e0852f5dfc380df
>
> and you have to change the part of drivers/net/dsa/b53/b53_common.c that
> returns DSA_TAG_PROTO_NONE for 53125:
>
>
> diff --git a/drivers/net/dsa/b53/b53_common.c
> b/drivers/net/dsa/b53/b53_common.c
> index 9f561fe505cb..3c64f026a8ce 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1557,7 +1557,7 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct
> dsa_switch *ds, int port)
>           * mode to be turned on which means we need to specifically
> manage ARL
>           * misses on multicast addresses (TBD).
>           */
> -       if (is5325(dev) || is5365(dev) || is539x(dev) || is531x5(dev) ||
> +       if (is5325(dev) || is5365(dev) || is539x(dev) ||
>              !b53_can_enable_brcm_tags(ds, port))
>                  return DSA_TAG_PROTO_NONE;
>
>
> That would bring Broadcom tags to the 53125 switch and you would be able
> to use the configuration lines from Andrew in that case.

What's the plan here regarding these 2 config option mode (how do you 
call them?)?

I mean, will this be a breaking change in the future where config has to 
be done in a different way then?

Or will it be configurable via module parameters or /proc or /sys 
filesystem options?


Thank you.

Ciao,

Gerhard
