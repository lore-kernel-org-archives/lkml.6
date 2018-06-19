Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49889C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F9720652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bosd8eNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F9720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967008AbeFSQzq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:55:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33069 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966514AbeFSQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:55:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id l10-v6so385867qtj.0;
        Tue, 19 Jun 2018 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91iEo171XzEqqH8ZKwcBt6mRRYlqisWn8b2PWI9r+Yg=;
        b=bosd8eNaM0Rv3nEil+iSdJfjQaKclN24Dp7A2pTPHWIJJHe38/5oZlnyGOtlQpZTdq
         olEOu/wOJ3lYijMu1tv0MbtaGgrs4ouq0W5Dxuk0VCeRC7TDKjSRRsLYOUqQmmxAOIEC
         gyTuWqGR9CqFUxZOHovDDkLDhwkX3xI3uT0wXpQ/NSfZhokJnlbld1I6VVjxUXCujV5M
         G+teq9gNyiS5MVGfnLB437eM0oQEySUsiPHOLA7ifyYjhhyvZCzQWHBz7VZ+aB0QSInC
         zD/kcPFMzn0xTAwaMT7EcvkWc347scE8hYDkjQCVOJ05kpKBuY5eUBR0i/ZnAM8fCqQe
         T0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=91iEo171XzEqqH8ZKwcBt6mRRYlqisWn8b2PWI9r+Yg=;
        b=cotaSyqkj739f+igrUlvcM44nsk94PNesN0RNAFZi8iKmlR5ny/CQRNOPdkxoLLqMl
         +31C+8wOiJ64k6a0IRIVqjz49fAa2WQSVncXIWGU5910U28V8a7Fnd4WcEubb/RarZAg
         P7ICeNZv/p0XdR8iL03LxIxCEXFLAcJD2eScUehHofJ2YxD4zIfx0T26oaQi96mQlPBT
         zLZ3lFiaKeQ3Axifi831Ya0cFOJ8+j2wLQzRvdx9Jn/rs6qZ7wlIj1KwlChafh/wyFJj
         6n0Yb20q1bPVYXz/OtF8HQ4h5hZfLFGXJJt71EpjaQxCIjjdH+SJ/ZZicz6yit8Ava5/
         cGvw==
X-Gm-Message-State: APt69E0sGhVtNSmSXROMWjBPZmfXfDq4PILB6wKthWsMJtuKupMQmww/
        8CZoKtykcuQicwfFuBb7+MOosP8H
X-Google-Smtp-Source: ADUXVKKsF4huckFuEGwoNVfcj0wQF2wn2ob5AdJe6/ufCJysPmax9vl7BmchTAEZdcx46eKCmHvnOg==
X-Received: by 2002:a0c:becb:: with SMTP id f11-v6mr15141892qvj.18.1529427341663;
        Tue, 19 Jun 2018 09:55:41 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id j13-v6sm164160qtj.23.2018.06.19.09.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 09:55:40 -0700 (PDT)
Subject: Re: [PATCH 1/3] net: ethernet: fix suspend/resume in davinci_emac
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
References: <20180619160950.6283-1-brgl@bgdev.pl>
 <20180619160950.6283-2-brgl@bgdev.pl>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <db1183b9-6ed0-ed74-c461-cdac5bfc7a60@gmail.com>
Date:   Tue, 19 Jun 2018 09:55:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619160950.6283-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 09:09 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
> Deduplicate bus_find_device() by name matching") and adds a comment
> which should stop anyone from reintroducing the same "fix" in the future.
> 
> We can't use bus_find_device_by_name() here because the device name is
> not guaranteed to be 'davinci_mdio'. On some systems it can be
> 'davinci_mdio.0' so we need to use strncmp() against the first part of
> the string to correctly match it.
> 
> Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index 06d7c9e4dcda..a1a6445b5a7e 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -1385,6 +1385,11 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
>  		return -EOPNOTSUPP;
>  }
>  
> +static int match_first_device(struct device *dev, void *data)
> +{
> +	return !strncmp(dev_name(dev), "davinci_mdio", 12);

	const char *bus_name = "davinci_mdio";

	return !strncmp(dev_name(dev), bus_name, strlen(bus_name));

Or even better yet, if you want to make sure this really is a PHY device
that you are trying to match, you could try to use sscanf() with PHY_ID_FMT.
-- 
Florian
