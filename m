Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4720C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7F92083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbHlLPBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfBEUET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:04:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37360 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfBEUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:04:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so1989669pfb.4;
        Tue, 05 Feb 2019 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1XL4p1KzbLT7FOu+bWY1RW80xv8ugvSqeaBarZcR3pw=;
        b=DbHlLPBuTl16vFX88Li5/4opcO4azPOjNsQ/32gAkuqWZf8wVHV1/1ybvKTXI4r2GF
         Mc0J37brpNnNNMLc/Aar3peMjkv9oHip6fWrtaEEFiwDSHJSfZd1lw+k+bLozlHr5bvA
         v0pd2d3iEkA+RTCgiFaO1GOwj7oTlilmIxq/wPf9pzQFeIFJGe9Ae1ObRdgHXMduFR2y
         NLRl4SSHGP2v3VaoIGxWfMlyGbDrMzvcOF1hcP9mFsHvfKScY7AgleWiqY9DZ3/vVi22
         htJoUjeTqYdQP12uE5TSgksT/lTzVhoROPSCd8PgNYVZFX6rD2myJekh5Qj0Sogm2nLl
         i7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1XL4p1KzbLT7FOu+bWY1RW80xv8ugvSqeaBarZcR3pw=;
        b=MNkEvCLFjxFOpi4duKkXOoajpSc7d+Tfpb7QGNblSSy2cEfSqg4pMvSQKqV82luOra
         Dtt29k7chyQGQ2WMuWh3CA4RKBXsgNCHeoq85+qhz+cEdY19usmX6zHL6T3yaOf9jz7M
         4PtnHVaylDjvVzou4j244LrYe1sBPFNzYW/VBgHXKA8An4B5m0H1FEpG/gYOZ3mLvgUF
         p0cmIukFqBvIIIAC8qv2TzPrbnVjiGJhmL+6gDn+5Lzf1MtX/z61BznNDioYfM5OvaCs
         rku1GlJIkZ4vOiyzyMH+mxJfTMjf3MbZt1vPSZSx8BCCjHxJsKdQNlxi82Mml7txsOWA
         ndOg==
X-Gm-Message-State: AHQUAuYLo6VvogPWz380gb5B6pdOiz0w0MPMC0ZWY16OCi1qOViKVB5h
        F3/0jrUlI/jWg3fEMzbQMpHt9EZS
X-Google-Smtp-Source: AHgI3IbE844zXKPQ67aKCy5V/TZIh17KVpP9nuYlo8Z4mAesiCW55UMqcEEG9J9brtleR0Jma99jrg==
X-Received: by 2002:a63:2c0e:: with SMTP id s14mr6256115pgs.132.1549397057577;
        Tue, 05 Feb 2019 12:04:17 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id l85sm6724046pfg.161.2019.02.05.12.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 12:04:16 -0800 (PST)
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
To:     Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>,
        thierry.reding@gmail.com
Cc:     hkallweit1@gmail.com, andrew@lunn.ch, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190204164213.30727-1-thierry.reding@gmail.com>
 <20190204164213.30727-2-thierry.reding@gmail.com>
 <20190204.192040.1074738183781998611.davem@davemloft.net>
 <8553086eaec167846992f1cff12aa388cee81767.camel@perches.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <ca6ca816-af03-e1f9-739a-a06cc4837b80@gmail.com>
Date:   Tue, 5 Feb 2019 12:04:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8553086eaec167846992f1cff12aa388cee81767.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2019 10:42 AM, Joe Perches wrote:
> 
> It's declared after a pointer so it is already is 2 byte aligned.
> 
> A lot of drivers wouldn't work otherwise.

Maybe these drivers are only used on arches where this does not matter.


