Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5716DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED89F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF6VGVhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED89F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeKAHys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:54:48 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40160 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAHys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:54:48 -0400
Received: by mail-yb1-f194.google.com with SMTP id g9-v6so7360894ybh.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fBb6mZEhuUibIX4f8cmjRv4bmvRxh7LEv3uQb6XAG7w=;
        b=fF6VGVhfsPQATetqZM4gSGkn88H585pSLKlkgKJY/xzFEY4P/o8WCs7rp+HV64C2rw
         fb20blrK0kdTJe8tVNqrDba4pD1V/Fq0uASLK8GtohCJxSsJ45tU2+2XUDIbjUpbdqBn
         cnhYDMNHF0QhGE9vEYu5c964ODR7bdBnl1Ez6djYgmK7vxAjMBNdtvR8Go2mHpw1hxv2
         A/u8vUOTQxJ8qBNFXbVESqaeCD6KVOZiY+P1ztHdZLMWKC3cKFhs5B8IsVgEMknCYgWU
         G2KJE6OhgIlA3oPQ71h6GvoopC0gkGN/EUt1nNV1pty1olt7eFEMtzeGToBqlyHRVbAI
         ghdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fBb6mZEhuUibIX4f8cmjRv4bmvRxh7LEv3uQb6XAG7w=;
        b=rT5Wtnl1Xtrw/FuGoDaVYQmFHwbDcxVmS6F8eAQ7/QPa/9a2jMei4tF//kaEQ37aZB
         fYcDm27/hwzHwOsqZuACNoa3ynKLxrge6NvfKHkp+uqqRA3eOkkJseVelqZP/J7q9sZh
         Gsd/1poS9xMvg7/3y2sd2eP4UYtOetw6aBOj6SkWf0SWMeqMr8asYxqeLSe72sH/6wUP
         gzQWZYXS8O7F+R2gcrEjU6Cx2y+ESK6MDaRZIuomTT7HkixEIos+qqsYiqf+WqtQgmKr
         X/SgoTA3JT42DNFSHuQSH7MYi3hdbmf+8wLQPMyAJxIooxkizDuRIUGYaYbRCCn33wTb
         qMZw==
X-Gm-Message-State: AGRZ1gKFXqg9qaBK/Bz7iWQb5WD6ShiCasP2dXk5pK6dd9M2dCtng/UQ
        +atdfUQBqjxG7g/UBh7HfNrPdnQ1
X-Google-Smtp-Source: AJdET5d9Qv6GrnJ+wLiAxwLbDl7PnbehdJG2b44ky6wBWtjZDKZTOmTwZMCwx273ltgbPmP7l/wvwQ==
X-Received: by 2002:a25:3008:: with SMTP id w8-v6mr5333393ybw.39.1541026479521;
        Wed, 31 Oct 2018 15:54:39 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id g21-v6sm9305885ywk.5.2018.10.31.15.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 15:54:38 -0700 (PDT)
Subject: Re: [PATCH v2] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, ebiederm@xmission.com,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20181025190110.7564-1-f.fainelli@gmail.com>
 <20181025192621.GB16785@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <caf4adfa-9938-0f53-75c1-48bce6095093@gmail.com>
Date:   Wed, 31 Oct 2018 15:54:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025192621.GB16785@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 12:26 PM, Andrew Lunn wrote:
> On Thu, Oct 25, 2018 at 12:01:08PM -0700, Florian Fainelli wrote:
>> Some software such as perf makes unconditional use of the special
>> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
>> enabled in the kernel.
>>
>> Facilitate the debugging of such situations by printing a debug message
>> to the kernel log showing the task name and the faulting address.
> 
> Hi Florian
> 
> Nice. I wish we had this a couple of months ago.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew, submitted as 8807/1.
-- 
Florian
