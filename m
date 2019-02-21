Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E782FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DCD2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af7xu7it"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfBUDO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 22:14:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39656 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfBUDO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 22:14:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so13015714pgp.6;
        Wed, 20 Feb 2019 19:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1YmuQn00Z+bREscdfIwV5Lu3dbgN2Wzv5Ixy2R7PifE=;
        b=af7xu7itBTlgXPqR200jpFCx3tNHLzwXY8vzApXIRPza5c+q04zZVB/0PIIrL0CDei
         woZuqoZfGZ/wfN8Q0E1IVKp3HgCeaY+btNPCBNX1qhNCgA7P5Dxp53z9KwK+21ugAqIC
         NrY1Af0nqxz229x7RFlmjxI7L35/dW7gdsPQrXxadiHBToZJ76e1TRpfmDUCaZukdX93
         sK4UmEe79srW640P0p5RC7iEwKKapPCdRnJomhA4ZQDuLgY5E1ZCAkqXEXQeQ7Vis+kH
         UpLydhHzG1I+Gt2PzqRz4GPoITk2rX9vrWFW6qMJVpoNtLac7cyhjwejhA80zojyRYUT
         i8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1YmuQn00Z+bREscdfIwV5Lu3dbgN2Wzv5Ixy2R7PifE=;
        b=sOkMUFBE/eskrL3ZRq9fPiBSp5RtBnjBLuHDowbJ9MCpzOlbWNaCtZBtMmqszr4/T2
         RTivOi441/h3J4X6XeY5FRDyFBWuDdiJgkhgT8FIC/serjSpAqIvPY6y5nfPYUg82oUF
         2CizfugZX9A6dyzCTA3AJU4/fZklC4WyzOOkl9ZZAyb3fq1UMTVhSV53WSzsl4LgsIjC
         PFxkgsdnIaVHI7RxeG/m9GZIBVGbiiXJnxDa7gntrXzKt6ILDLwWdRx9NpReW9pLv5Li
         xlWb7/9Y6yccKdXkBbwtYqz4edJ8c9/U1hPWayIpGevRsNUJhU1GC4ndiqg8+aLkEi7D
         eURA==
X-Gm-Message-State: AHQUAuYkYkxJ6YpEqWVQzmInW1baO8gA9dhYP4T8JJgItZWAErSZumKR
        sJBFHxNV2yGkYWme9KdYKcYkgBTY
X-Google-Smtp-Source: AHgI3IZqWHV8FBtGFUZrxH4ScmY3ub2ovciQuUjCZYO4CDAHFcfgtMtF8jCsL2+L1wrgDrWJFP1X3Q==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr37451696pfu.3.1550718897175;
        Wed, 20 Feb 2019 19:14:57 -0800 (PST)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n1sm39800240pfi.123.2019.02.20.19.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 19:14:56 -0800 (PST)
Subject: Re: [RFC PATCH net-next v3 15/21] ethtool: provide link settings and
 link modes in GET_SETTINGS request
To:     Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
References: <cover.1550513384.git.mkubecek@suse.cz>
 <00e931c1ecd29bf302a190c7d7a3f2cbd0388542.1550513384.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <f2f8ccdd-c8bb-7f0a-5df7-dd54359e859e@gmail.com>
Date:   Wed, 20 Feb 2019 19:14:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <00e931c1ecd29bf302a190c7d7a3f2cbd0388542.1550513384.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2019 10:22 AM, Michal Kubecek wrote:
> Implement GET_SETTINGS netlink request to get link settings and link mode
> information provided by ETHTOOL_GLINKSETTINGS ioctl command.
> 
> The information is divided into two parts: supported, advertised and peer
> advertised link modes when ETH_SETTINGS_IM_LINKMODES flag is set in the
> request and other settings when ETH_SETTINGS_IM_LINKINFO is set.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---

[snip]

> +#define ETH_SETTINGS_IM_LINKINFO		0x01
> +#define ETH_SETTINGS_IM_LINKMODES		0x02
> +
> +#define ETH_SETTINGS_IM_ALL			0x03

You could define ETH_SETTINGS_IM_ALL as:

#define ETH_SETTING_IM_ALL		\
		(ETH_SETTINGS_IM_LINKINFO |
		 ETH_SETTINGS_IM_LINMODES)

that would scale better IMHO, especially given that you have to keep
bumping that mask with new bits in subsequent patches.

[snip]

> +	if (tb[ETHA_SETTINGS_INFOMASK])
> +		req_info->req_mask = nla_get_u32(tb[ETHA_SETTINGS_INFOMASK]);
> +	if (tb[ETHA_SETTINGS_COMPACT])
> +		req_info->compact = true;
> +	if (req_info->req_mask == 0)
> +		req_info->req_mask = ETH_SETTINGS_IM_ALL;

What if userland is newer than the kernel and specifies a req_mask with
bits set that you don't support? Should not you always do an &
ETH_SETTINGS_IM_ALL here?

[snip]
-- 
Florian
