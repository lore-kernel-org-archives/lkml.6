Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE99521A3B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g64/m/ZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE99521A3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeHFQZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:25:02 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50642 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeHFQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:25:02 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so15833545ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rYoxsb6mB11+EEGRUDwY5xjmxxrQk5IY/XKCQuxpL48=;
        b=g64/m/ZXVc90phe+gXiHGOHKLhvuU+fsqOaJYMTEvNdW1E46vZdcE5VBeR2tevii9E
         kPYY9x8mCpe9x5Mn8ZKK2U3fFbAZoCjSRB26WVWGHpdFlr1J+zTxAUm3c0UUR/b+e6NL
         WEWtH3x+zpv3hiv3mxT3qqCY48IYz1pFCiSh0iHANo/dXKaGIXDe9YH0fA7BP6wW2cUh
         Yfa1TaTcQKQQYxX9HOExN9B0zrX1R7VxhfSlXA+UTqAxMfep7s+i89QlAtKuX+VjFpVY
         VKQ36h2ti/qOG6I4tcTZtqrbWup9sGMKC+CG6C7OlTunMAXcDiTYKYWqkPdWxWjN5fQe
         nB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rYoxsb6mB11+EEGRUDwY5xjmxxrQk5IY/XKCQuxpL48=;
        b=YHQDBYGJeJh4zI1hW+BdvKmR8ULZgSeeBgXzSksXaXJYXrEIqTm0731nyTEUaNpHw+
         985Uk5+5Z9hzYpRW+gK490YN4yQdc+UwyhC5STRkdHLr4vK9sDUf3joiZHYcABSR3AQV
         j5/v3Q3MUdcJg+2SQihw5m+R3tsLU6LyG6E5AdhIw29viaxQ07h6/luhw4+Pj+NhVbAG
         wzIPhC8Wk13hzz8JjJNQqYuZqT3dhYHN12NdGMtetji/9XXqwOvy9YcAikxIhQ+ZlZPL
         X05ZaJinyjisJQrTHp+6ExVCoLSCm4iAzAehxUwDJIqB5oBwtlZlDUGUbZhq097L4JfD
         tV/A==
X-Gm-Message-State: AOUpUlFTSPd9KNODIuripA0D+dgHXYN9YPMm5Ak3S+qK42z1GQcl6zOb
        yt+SkgiSidMzCCrYx5HFDPegNqoxAY4=
X-Google-Smtp-Source: AAOMgpeMxsm9jB+VNFlZFvZbFS39/0MLb4UQGsQmVPalTgvKZ22wKJMUneD3PeHCh9IWa3z0I+HarA==
X-Received: by 2002:a24:8a85:: with SMTP id v127-v6mr15606500itd.98.1533564942747;
        Mon, 06 Aug 2018 07:15:42 -0700 (PDT)
Received: from [192.168.1.55] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d74-v6sm1370103itb.23.2018.08.06.07.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 07:15:41 -0700 (PDT)
Subject: Re: [PATCH] xen-blkfront: use true and false for boolean values
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180805000859.GA20132@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <40c7f420-804c-6ea4-c4aa-11dd35bf9ce5@kernel.dk>
Date:   Mon, 6 Aug 2018 08:15:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180805000859.GA20132@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/18 6:08 PM, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.

Applied, thanks.

-- 
Jens Axboe

