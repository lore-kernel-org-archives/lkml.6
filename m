Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0140121902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbfBROWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:22:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41248 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbfBROWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:22:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so6414042wrw.8;
        Mon, 18 Feb 2019 06:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=etGkhTvKF17koD8vPLM+zWlFSjZnwqXjn212Pn8gLVk=;
        b=lBY3mliJBmTph0vVN9b0/0pNFnRtX4ViYsPB252fTKjQXief4xPV0RJtc2sOzwd5cl
         LyV18FR+ad8DJJs9ht/OacL/Gg+O+8xQdu2Iqm1u0EdJZ6qv+054oG5KgCC0Dz0AIi4e
         AFVPzvTTGiB8PMK3x6eIYEO9nQGfJspP8PnqJLMY9DLfF4MldKX9pdhfh/HnhBB1uBcB
         rmg3zWI1SI4He1KYWkwQNbdEIO8Kc5KDs3Z6pKi6QRec67JDYMjA1/IVhzsyQ2TS0ph/
         phgWxUZdoDcqB4qNsy4GS9a/sVG6D9iTMeETE1JzdMxmBtEtJCBUvFAqZGzq1DfkSqhi
         8bhA==
X-Gm-Message-State: AHQUAuZGuLOQB1IIt6J5MbL/HOWPEfAAh5EvXpVwnIT6NVJ5ZlfeodwQ
        kK3S4HTBpBQBqgSJnix72/0=
X-Google-Smtp-Source: AHgI3Ia7srUw+wXI1mipaUKytpIAM8FYDnScR8VgV4x2MU8+sKOPsrRVg+XxLOve0pZu5o7x0KBCyw==
X-Received: by 2002:a5d:4605:: with SMTP id t5mr16615528wrq.311.1550499734506;
        Mon, 18 Feb 2019 06:22:14 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id v4sm15532614wme.6.2019.02.18.06.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:22:13 -0800 (PST)
Subject: Re: [PATCH] [V2]r8152: Add support for MAC address pass through on
 RTL8153-BD
To:     David Chen <david0813@gmail.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, hayeswang@realtek.com,
        mario.limonciello@dell.com, bigeasy@linutronix.de,
        edumazet@google.com, f.fainelli@gmail.com, david.chen7@dell.com,
        kai.heng.feng@canonical.com, zhongjiang@huawei.com
References: <20190218140057.17030-1-david0813@gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <91332458-c2c1-b7c3-5135-ab0741108020@suse.cz>
Date:   Mon, 18 Feb 2019 15:22:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218140057.17030-1-david0813@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 02. 19, 15:00, David Chen wrote:
> From: David Chen <david.chen7@dell.com>
> 
> RTL8153-BD is used in Dell DA300 type-C dongle.
> It should be added to the whitelist of devices to activate MAC address
> pass through.
> 
> Per confirming with Realtek all devices containing RTL8153-BD should
> activate MAC pass through and there won't use pass through bit on efuse
> like in RTL8153-AD.
> 
> Signed-off-by: David Chen <david.chen7@dell.com>
> ---
>  drivers/net/usb/r8152.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 60dd1ec1665f..86c8c64fbb0f 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -557,6 +557,7 @@ enum spd_duplex {
>  /* MAC PASSTHRU */
>  #define AD_MASK			0xfee0
>  #define BND_MASK		0x0004
> +#define BD_MASK			0x0001
>  #define EFUSE			0xcfdb
>  #define PASS_THRU_MASK		0x1
>  
> @@ -1176,9 +1177,9 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
>  			return -ENODEV;
>  		}
>  	} else {
> -		/* test for RTL8153-BND */
> +		/* test for RTL8153-BND and RTL8153-BD */
>  		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
> -		if ((ocp_data & BND_MASK) == 0) {
> +		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK) == 0) {

Can you ensure that BND won't have the BD's bit set and vice versa? I.e.
should the check be something like:
  if (isBND() && (ocp_data & BND_MASK) == 0 ||
      isBD() && (ocp_data & BD_MASK) == 0)
instead?

thanks,
-- 
js
suse labs
