Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F861C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3872084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bY4lmZcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3872084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeJAOvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:51:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46044 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeJAOvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:51:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id x16-v6so11190015ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qS0r9HVgqdKGty1MY0LULmO0HK3jFHwvnrkynDjoFgw=;
        b=bY4lmZcgdw9sdwVhEYhqVe2bFwCf4jeuiZ3jSxc1JUkHfBayiYWxjQP5FuX0CwFWzM
         yr6J4sS+n1ZGE7wnkfrAuiwN9aCIh+UVZEtNymGSqdJRwWvg6n+VPoQlrArue13u+P5J
         bhwWdwWZ3gkZmF0G5UwboiLEi3N6MQDEq/7b8pihsWBoop3SreKrdD5OenP6fmDpfBNp
         yW7Pslrhls2wbuHDE7wSLCG6GpRTXB+yCkj+x/L60+n/miZNN6brrem95ZaBuqv5zOoY
         xu4qdqlhM8cpi0ZYmG78t9D29xZqr0yyRqvZ9DR3PhDNFS5/s4RFL8/FHj+c4r5EqTq6
         RZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qS0r9HVgqdKGty1MY0LULmO0HK3jFHwvnrkynDjoFgw=;
        b=EBVpo/lu1OUGWT+P04x/Dz9vff62cw5f1g2AkOM6t7EwybJQ/pAOphx6jx5Qance4O
         4fk/Fh1J0rjnm1QmAbq7Ux5WUojT4+eZDlE8PSPLSalCc7/pe7hfSFyoBNVfFySfHAJ7
         gMtW1k+XVa4Tf5ahKhHRysnycZMB9xvllUAy3nwxIVq2k6P7sW+zM+/hwE7sjku6YUbt
         Vg0b8w+8BKlr4GInjuQ/0V5iGI8Zc1QsWqOLkydLPwtmcUPaFUhn8PtOL8R+VRJS+Owh
         r2giludmCYxlHhKE8WXlnYbZdOg0jb9Wl4p9j76Ls2nn+G4sAZl4vITEiK6mW0bXChLs
         fFHg==
X-Gm-Message-State: ABuFfohNQFEa8GnDSmncFA7IjYQInYmYgp1ejDi6NArPbRH1TsnTYq3S
        NOo0ou5nxwu1AHu/fQWwS+y5QT5XSsk=
X-Google-Smtp-Source: ACcGV63ojtXA8iJ3soyZYguo8x8Ja+iCX1XSEUrXAUwoX9xg8Il+1kI0MyhJax+CDg0wLN/N3nlOsw==
X-Received: by 2002:a2e:638d:: with SMTP id s13-v6mr5367467lje.117.1538381687613;
        Mon, 01 Oct 2018 01:14:47 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.84.210])
        by smtp.gmail.com with ESMTPSA id s68-v6sm2028431lfg.17.2018.10.01.01.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 01:14:46 -0700 (PDT)
Subject: Re: [PATCH] ipw2x00: clean up clang warning on extraneous parentheses
To:     Colin King <colin.king@canonical.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180930223809.18136-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b7ab11aa-0ec5-0c29-9170-4e62f5ab4ac3@cogentembedded.com>
Date:   Mon, 1 Oct 2018 11:14:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180930223809.18136-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/1/2018 1:38 AM, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are extraneous parantheses that are causing clang to produce a

    Parentheses.

> warning so remove these.
> 
> Clean up clang warning:
> equality comparison with extraneous parentheses [-Wparentheses-equality]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]

MBR, Sergei

