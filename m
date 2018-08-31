Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E13C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4CD2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQEPPi8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4CD2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeHaXY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:24:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44996 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaXY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:24:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so23532905oih.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lc9fm95V2WdxCn8kPB0ZOs9ykONInjGymx4GcY0zwUQ=;
        b=bQEPPi8wy6UxUsjavOTr6QyUXNDg2ND4CGc5TMp3Ght8jlIAi7BBAQNL15eA2gPtKL
         crpH5z7khGeAgBPlBIt9xfM6ZWxHEgiEGqQN0xRy1pHGyVVfNVSxF2nCssuZOFGqj7i4
         0kFKZMJBgVjqi1nkZ49mfNOBzM4/4VFfR8vmVpQALuvIXfMsZq4TiwXqY1OFapyjCya0
         PA9peRYKqqWtEssuUS7nk4fo/I7MySGZYcy4+ifkVcpZsaq+AdK3JWVPbwdfsi+zlLlF
         xhdVWOzs8kvVYThwgNCndoUIiVdW/D3zkfcpob8r0icAFPHoxz1W68tu/XMEYKC5639X
         iaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=lc9fm95V2WdxCn8kPB0ZOs9ykONInjGymx4GcY0zwUQ=;
        b=KOlCJrvcURAyDwTAZtdFap4lky7IhaDi8QcliXFZRJPRhBHf+IeJttWbuwXpYNhVAi
         +s8qL4GXngkMCFmS9L1W6gk0fRBhWieKAc9pErGxCsuNxpA+YHLZ0F4BGyThiv/+jH+4
         u0FK9/8UCaeFH11+r7bTY0NcYg6OI26Fo6H9HNySwCPrFwAyJ3OIRkBg+nwJiZ7K7unz
         gHeguZYCxprRTJThk2+4jrtmzJqmK/aMxNerac35enaXw+ak3r0kY/Wt4TT8teDRdxs2
         VRDUlWM/68XaCdH1z9INvMosx4ZAa/XHdz4A9XOHJCB39rFscJiKRnwY8T75jfCkvIVC
         Qsow==
X-Gm-Message-State: APzg51BeDKEcki8r0pC5Dnt8eMAJrjRZ9Qq+awh7cLdSg6yQsGD9/C09
        6IzS7GlBgn+Gyxhd84XaRg==
X-Google-Smtp-Source: ANB0VdbOlB6QeRPEDbg74Sk8SBgdqSzff4vZREP1tq45AYZr8bVaVnRukx2nUXngjtS56Dp+Wv9a7w==
X-Received: by 2002:a54:4f94:: with SMTP id g20-v6mr8160812oiy.130.1535742935690;
        Fri, 31 Aug 2018 12:15:35 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id m11-v6sm10958362oif.27.2018.08.31.12.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 12:15:34 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:910d:22e8:ff84:3fdd] (unknown [IPv6:2001:470:b8f6:1b:910d:22e8:ff84:3fdd])
        by serve.minyard.net (Postfix) with ESMTPSA id 8C8E4677;
        Fri, 31 Aug 2018 14:15:33 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH v2] ipmi: Fix NULL pointer dereference in ssif_probe
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180831150034.GA22019@embeddedor.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <6efd45da-8b35-b1c8-bd0e-148c578c99f5@acm.org>
Date:   Fri, 31 Aug 2018 14:15:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831150034.GA22019@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 10:00 AM, Gustavo A. R. Silva wrote:
> There is a potential execution path in which function ssif_info_find()
> returns NULL, hence there is a NULL pointer dereference when accessing
> pointer *addr_info*
>
> Fix this by null checking *addr_info* before dereferencing it.

Thanks for catching this quickly, before it went out.  It's merged into 
my next tree.

-corey

> Addresses-Coverity-ID: 1473145 ("Explicit null dereferenced")
> Fixes: e333054a91d1 ("ipmi: Fix I2C client removal in the SSIF driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>   - Fix typo in commit log.
>
>   drivers/char/ipmi/ipmi_ssif.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 2ff3679..764d305 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1641,7 +1641,9 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   
>    out:
>   	if (rv) {
> -		addr_info->client = NULL;
> +		if (addr_info)
> +			addr_info->client = NULL;
> +
>   		dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", rv);
>   		kfree(ssif_info);
>   	}


