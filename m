Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D972081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNaVpntR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D972081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeK1Pa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:30:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37633 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1Pa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:30:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so1644749pfb.4;
        Tue, 27 Nov 2018 20:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GID37MQBN16VcYggGpmJcxIOlTJkY+8yNbRh6SByU3E=;
        b=iNaVpntRBRNk6oJlfl9mmJNURzxn2V7E7CAMNOXCu2Z75wJY5Yqkx2O1l7jeR8liJo
         +ZlnKYMAe3PkXe+ObkF6FBAsbX1vN121IVxxCY60CXX+5KSuxorQa/JhuKLxno9Zgtqj
         rTllit23CsDKfOFAS/lYw5fkiI8VBY6+4tds1u6uhjAn9pJVM59yVDbXp8tZ3mUGTb60
         UnJ3sq984eNo2vfvxUx+QM0YGAWnyrbkXv4mMCVI8uRKY6cZJQkEDgzN6lKyU2On1fj5
         T2I9bK4bCBbaRyoCKzFARLd1yeraqHbPSmlbAerHutDeOEV6LtFK6Qh28T0r7dT0f+sk
         0ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GID37MQBN16VcYggGpmJcxIOlTJkY+8yNbRh6SByU3E=;
        b=o3Wkb4rDy/VFsJN8YU59Io043PGXzjiPAKPs+qwsr7YK/fryrpVOHeGxNgxJFlOSm6
         iq9zGUaJuFSp6eI7ZOkpwGCtkCQW+RLZg/Wny2uBsmN8lWiC0PeUp34Gio7dteESGqLK
         3JKK8sinoz51IbaT5drrJNsCqFNd/Jk9EXA13jFPjGQK/PZp+Lihvd4Ly/XuUDpQWHa6
         SBSuNztVCPs8vZCgh0KsgyoII4IdtxWxjH7rJkGv8rD4vU3lXrkU2O8BcsTgdL3gRP11
         aPzGs8Gy0dXFcWHQV2+78iIn+WGs19wxGbau/fnseqe7bElau0IEA2Fl3h0ed6cg8ydL
         gRZg==
X-Gm-Message-State: AA+aEWYN+MXphPx7/L3UirxMg1P9D24s/XnWMG5TDZOE/iwlVY0Co3ee
        Wlv246FvfVjpcOM9C+8awzqW2p1o
X-Google-Smtp-Source: AFSGD/VWEaxdQvIgH3wt9yhUKVCdIg0LTQWxWKH3a7Mq3B+AptU1sxqK3eF+2VC/HNwsqFDnQP3yaA==
X-Received: by 2002:a63:9f19:: with SMTP id g25mr31792123pge.327.1543379414317;
        Tue, 27 Nov 2018 20:30:14 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:19f4:5015:4ec6:8457? ([2601:282:800:fd80:19f4:5015:4ec6:8457])
        by smtp.googlemail.com with ESMTPSA id p11sm5661461pgn.60.2018.11.27.20.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 20:30:13 -0800 (PST)
Subject: Re: linux-next: Tree for Nov 27 (net/ipv4/af_inet.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20181127152539.55426063@canb.auug.org.au>
 <f43a02d1-db24-369f-90df-8f7326144195@infradead.org>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <c2d499b0-94fc-6ba7-8780-a57d886729ea@gmail.com>
Date:   Tue, 27 Nov 2018 21:30:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f43a02d1-db24-369f-90df-8f7326144195@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 8:47 PM, Randy Dunlap wrote:
> On 11/26/18 8:25 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20181126:
>>
> 
> as reported for linux-next-20181109:
> (see https://lore.kernel.org/lkml/499e91d0-7349-641f-9826-7535713176f8@infradead.org/)
> 
> when CONFIG_PROC_FS is not enabled:
> 
> ld: net/ipv4/af_inet.o: in function `inet_init':
> af_inet.c:(.init.text+0x42d): undefined reference to `raw_init'
> 
> 

I'll send a fix.
