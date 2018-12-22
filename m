Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E44C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1313020874
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="nYvzddVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390258AbeLVSDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:03:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44841 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388274AbeLVSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:03:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so7446538lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X/7i4I95Yqp/eK5SlIEkVw18AF/3ZB6CWvfcwy5Lk10=;
        b=nYvzddVuHWJZzXTaSueSyFlhgsqMRsbd55xtZUn3+t5zTLLMkpN255vSAC3qwZzEI0
         4XYkkDLNCzE5OP4XnUMwwv38CAvkN9K+wQiLJoGEzWwlqXNJrYkDPLEoOKtsn/IVqxeG
         ONLe9doTSq+lnREO/U4n0lDhBY9UoXHg/9/dC8vdz46nd1le+39gxKifZXrWYV5g5/dA
         hKaLbWhv6SKfPahHWRQ6XwcoUECY9vhJIRuUNlybwKaNCoO1GsZPd2fvrZcNdzywLJOn
         zPEClkSISwoiE28D4tYxXNpxQJ1hkcsE+WyVXOJzwRCOnK8ja91rBXisvkDgHrUcLGUL
         gBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/7i4I95Yqp/eK5SlIEkVw18AF/3ZB6CWvfcwy5Lk10=;
        b=P0M+MzSFnKfA3Gtd6pZuqQghXFEcGWD/ZYQkUZSxzmpTswaeoXLFrF1+MJtscLwNty
         RNKit0AFjDqsd8qazxFtoPjTzHkvVS1wznH2pxDLZA+jRlJLDdClCUJBKkI/guVdUr6G
         5ANrDx9RT1/KOr8q17wc9zTZ7484uO5CyqYpjL5Uy4dMFd5xcCc8B78d2ydwkk9rH6Ts
         2JbAQj04EsbfL9ZPtvfttHoBXUNLAIGM5mOXRNi2KAeAB80UFCmb9At1DNehNNQilP3n
         ivcOARlw2DzJDsKhPMhAakjImiLD/y1bUl2sgQpP7slBeA0ltc3GnHNw3ueiV5h0j/ZJ
         gesQ==
X-Gm-Message-State: AJcUukdVmBOx0FQfdqK9J4OdaYAp1ysJk5QjwkyqivbwzS0D+u7jSxhq
        jCdwl4zagjl6DmiwL9kXn0rLYXypKrs=
X-Google-Smtp-Source: ALg8bN5PPdyZ/ARq171eyQ4pEDtpUk5wJOAoI7rjrj2k0sZyDv78SN1g8MvlOQwzYCWMHna7Hv1gCA==
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr3042013ljj.120.1545467733939;
        Sat, 22 Dec 2018 00:35:33 -0800 (PST)
Received: from [192.168.0.199] ([31.173.87.160])
        by smtp.gmail.com with ESMTPSA id j197sm5297535lfe.24.2018.12.22.00.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 00:35:32 -0800 (PST)
Subject: Re: [PATCH net-next] staging: octeon: fix build failure with XFRM
 enabled
To:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181221205726.2924-1-fw@strlen.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <973d7244-7864-f0ff-0fe3-0061b6dffa56@cogentembedded.com>
Date:   Sat, 22 Dec 2018 11:35:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221205726.2924-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.12.2018 23:57, Florian Westphal wrote:

> skb->sp doesn't exist anymore in the next-next tree, so mips defconfig

    It's net-next. :-)

> no longer builds.  Use helper instead to reset the secpath.
> 
> Not even compile tested.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 4165079ba328d ("net: switch secpath to use skb extension infrastructure")
> Signed-off-by: Florian Westphal <fw@strlen.de>
[...]

MBR, Sergei
