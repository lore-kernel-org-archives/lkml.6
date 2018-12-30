Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 23:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EFB20828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 23:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeL3Xii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 18:38:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:56214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbeL3Xih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 18:38:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 058EDAC8A;
        Sun, 30 Dec 2018 23:38:33 +0000 (UTC)
Subject: Re: [PATCH RFC lora-next 4/4] net: lora: sx1301: introduce a lora
 frame for packet metadata
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     starnight@g.ncu.edu.tw, jiri@resnulli.us,
        linux-lpwan@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
 <20181219155616.9547-5-ben.whitten@lairdtech.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <58753abe-885b-96c7-0d04-ed9ae97f3942@suse.de>
Date:   Mon, 31 Dec 2018 00:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181219155616.9547-5-ben.whitten@lairdtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Am 19.12.18 um 16:56 schrieb Ben Whitten:
> Information such as spreading factor, coding rate and power are on a per
> transmission basis so it makes sence to include this in a header much

"sense" (even in British English! :))

> like CAN frames do.

Any pointer for that? My understanding of CAN was that it actually uses
the CAN or CAN FD frame for transmission on the wire.

Whereas here you use it for metadata that does not go over the air.

>
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>  drivers/net/lora/dev.c    |  2 -
>  drivers/net/lora/sx1301.c | 79 +++++++++++++++++++++++++++++++++------
>  include/uapi/linux/lora.h | 46 +++++++++++++++++++++++
>  3 files changed, 114 insertions(+), 13 deletions(-)

If we should seriously consider this new approach, please always cleanly
split it off from sx1301 driver changes. The most important changes are
at the very bottom here otherwise.

Some of the enums may be useful either way.

[snip]
> diff --git a/include/uapi/linux/lora.h b/include/uapi/linux/lora.h
> index 4ff00b9c3c20..d675025d2a6e 100644
> --- a/include/uapi/linux/lora.h
> +++ b/include/uapi/linux/lora.h
> @@ -21,4 +21,50 @@ struct sockaddr_lora {
>  	} lora_addr;
>  };
>  
> +#define LORA_MAX_DLEN	256

Note: According to Helmut, "SX1276 can do MTU sizes up to 2048 bytes".
But I have failed to find mention of LoRa-mode interrupts other than
TxDone or any such how-to in the SX1276 manual or on Google; only the
FSK/OOK modem has a FIFO-less Continuous mode documented.

> +
> +enum lora_bw {
> +	LORA_BW_125KHZ,
> +	LORA_BW_250KHZ,
> +	LORA_BW_500KHZ,

Lacking lower bandwidths. SX127x can go as low as 7.8 kHz.

Would it work to have it as an integer in Hz for flexibility?

> +};
> +
> +enum lora_cr {
> +	LORA_CR_4_5,
> +	LORA_CR_4_6,
> +	LORA_CR_4_7,
> +	LORA_CR_4_8,
> +};

If we have this as ABI, we should probably go safe and initialize the
first one to 0.

> +
> +enum lora_sf {
> +	LORA_SF_6,
> +	LORA_SF_7,
> +	LORA_SF_8,
> +	LORA_SF_9,
> +	LORA_SF_10,
> +	LORA_SF_11,
> +	LORA_SF_12,
> +};

Wouldn't an integer be sufficient for the Spreading Factor?
We'll need to safeguard code against unexpected values anyway.

An added bonus for the enum/defines would be if we could have
LORA_SF_6 = 64
up to
LORA_SF_12 = 4096
(chips per symbol)

> +
> +/**
> + * struct lora_frame - LoRa frame structure
> + * @freq: Frequency of LoRa transmission in Hz
> + * @power: Power of transmission in dBm
> + * @bw:  bandwidth, 125, 250 or 500 KHz
> + * @cr:  coding rate, 4/5 to 4/8
> + * @sf:  spreading factor from SF6 to 12
> + * @data:   LoRa frame payload (up to LORA_MAX_DLEN byte)
> + */
> +struct lora_frame {
> +	__u32		freq; /* transmission frequency in Hz */
> +	__u8		power; /* transmission power in dBm */
> +	enum lora_bw	bw; /* bandwidth */
> +	enum lora_cr	cr; /* coding rate */
> +	enum lora_sf	sf; /* spreading factor */
> +	__u8		len;
> +	__u8		data[LORA_MAX_DLEN] __attribute__((aligned(8)));
> +};

I'm not comfortable with making this arbitrary format a userspace ABI.

For example, hardcoding the frequency as __u32 will limit us to 4 GHz,
which is sufficient for 2.4 GHz, but Wifi is already at 5 and 60 GHz.
Having the data at the end means we can't easily add header fields, such
as Sync Word (that you're missing above) or a frequency extension word.

Reuse with FSK/OOK or other LPWAN technologies could be a bonus goal.

In my presentation I had suggested to use the socket address for storing
most of that metadata. The counter-proposal was to use netlink for any
global setting changes and have the socket just send the actual data.

Reminder: We can set SX127x registers before each TX, but RX remained
unsolved. For SX130x we can set some metadata per TX (multi-channel),
but radio/channel need to have been configured appropriately. Wifi cards
may support MIMO but still show up as one wlan0 netdev, so it seemed
questionable to diverge for SX130x by having ~10 netdevs and impractical
since we have a lot of radio initializations in .ndo_open.

Compare slides 16 ff. vs. slide 27:
https://events.linuxfoundation.org/wp-content/uploads/2017/12/ELCE2018_LoRa_final_Andreas-Farber.pdf

Ultimately the skb is where we need any per-transaction metadata, and
outside uapi/ I'm much less concerned about ABI changes. So from my
perspective such fields would go into linux/lora/skb.h struct lora_priv
after the ifindex, if we go with PF_LORA. As mentioned before, if we
have to go with PF_PACKET then I'm clueless where to store such data...

> +
> +#define LORA_MTU (sizeof(struct lora_frame))

Even if Helmut's comment was mistaken, it doesn't strike me as a good
idea to hardcode this here - you could just use data[0] and leave actual
MTU to the driver/user.

> +
>  #endif /* _UAPI_LINUX_LORA_H */

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
