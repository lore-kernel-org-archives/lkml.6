Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeEGSOO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:14:14 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44674 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeEGSOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:14:12 -0400
X-Google-Smtp-Source: AB8JxZo0PVKrWXOawBDrI+KL1mqt69Z9PWeTj7okPep5JKTxZNeIg74fqwYjcC40gfjjWA1AV3Vjyg==
Subject: Re: [PATCH v2] net: dsa: drop some VLAs in switch.c
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        David Laight <David.Laight@ACULAB.COM>
References: <1525706596-13601-1-git-send-email-s.mesoraca16@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <d7fa9cf7-7c7e-b01c-8925-ce6dafc8721c@gmail.com>
Date: Mon, 7 May 2018 11:14:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525706596-13601-1-git-send-email-s.mesoraca16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 08:23 AM, Salvatore Mesoraca wrote:
> We avoid 2 VLAs by using a pre-allocated field in dsa_switch.
> We also try to avoid dynamic allocation whenever possible.
> 
> Link: http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> Link: http://lkml.kernel.org/r/20180505185145.GB32630@lunn.ch
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  include/net/dsa.h |  3 +++
>  net/dsa/dsa2.c    | 14 ++++++++++++++
>  net/dsa/switch.c  | 22 ++++++++++------------
>  3 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 60fb4ec..576791d 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -256,6 +256,9 @@ struct dsa_switch {
>  	/* Number of switch port queues */
>  	unsigned int		num_tx_queues;
>  
> +	unsigned long		*bitmap;
> +	unsigned long		_bitmap;
> +
>  	/* Dynamically allocated ports, keep last */
>  	size_t num_ports;
>  	struct dsa_port ports[];
> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
> index adf50fb..cebf35f0 100644
> --- a/net/dsa/dsa2.c
> +++ b/net/dsa/dsa2.c
> @@ -748,6 +748,20 @@ struct dsa_switch *dsa_switch_alloc(struct device *dev, size_t n)
>  	if (!ds)
>  		return NULL;
>  
> +	/* We avoid allocating memory outside dsa_switch
> +	 * if it is not needed.
> +	 */
> +	if (n <= sizeof(ds->_bitmap) * 8) {
> +		ds->bitmap = &ds->_bitmap;

Should not this be / BITS_PER_BYTE? If the sizeof(unsigned long) is <=
8, then you don't need to allocate it, otherwise, you have to.

I would actually just always dynamically allocate the bitmap, optimizing
for the case where we have fewer than or 8 ports is not worth IMHO.
-- 
Florian
