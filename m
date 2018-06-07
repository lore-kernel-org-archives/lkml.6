Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id X2SmN1jCGVsMSwAAmS7hNA
	; Thu, 07 Jun 2018 23:49:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4051E6074D; Thu,  7 Jun 2018 23:49:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgUNGI7+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9658B60290;
	Thu,  7 Jun 2018 23:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9658B60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeFGXtN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:49:13 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:46573 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeFGXtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:49:11 -0400
Received: by mail-pl0-f47.google.com with SMTP id 30-v6so7100708pld.13;
        Thu, 07 Jun 2018 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ANBWOuetEBldsKOxNMGSYXEA+tvV8a9csYSnu451wXE=;
        b=EgUNGI7+hxYdy+UWsgnK6ZlrLNHFB+DV3baZ6QOUzKK5YRzNupJjYtVVqDEzcpmxrE
         y/Cn8O8Qc9tKMctgx5jU2F7B/qsqG2h0/lQIfAgDdCGsuwkcVjPO++JPX2garM+6+Jst
         k4VhbYvASgd6VGYwKtDN0Mb5QZVJ9kSCqKYEwy70hqBcKFRMUwKgBjcHq1A21kXIE2UT
         jGnOQqMFGnWp51DD8gkp+2FORYCg8cjgQz758kyQtb6b90gZQquI3SaYWjv5T3uEdEHx
         sxPlZhXVzR8ArzJOnJOIhX1P/yV1gQEDVutJ8malRhXkTrV2Nd5B/BHY5z+VuvTqiv9w
         JmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANBWOuetEBldsKOxNMGSYXEA+tvV8a9csYSnu451wXE=;
        b=fGnn02pejRlv8ql4cC6nkO3EfSpEdN673uzYWNh71WnkiKxwsCzIZG30g7KEouV/Zd
         gYo8eTMd5KpAA5RXaZEiCsTl/tY+eZnXB4Je4Rc/Nn93g9A/UEsyy/Z9VQB46J1H+T3A
         gvJRKYB7MW+irl5cmmTm0CrviBsVUSWJAkKHvZHKhqNpdyKThISRf3zEcghjw3PYMA6W
         kDoMHFN2RT+E29+iNs5mhm65nN0Cnj5U18EEX/K6vQsQAiC2LxG8OK6h9ALi2Vg5VCIV
         DI+F7NPwnpOSniVZRpvaYiVof4SMlC5A0W1/KCsai+1NOxgfm1tAh9GZdZ+owdrA05GW
         WW6Q==
X-Gm-Message-State: APt69E2srkMZbQXY4RCP0IcHAwBJJ0pcSAbXjwPKOUQX7iBkoEeB4aNm
        3ofxQl3wnDmkwGrQjcrv2xyuDH5f
X-Google-Smtp-Source: ADUXVKK24/rfWfbC9PzosazWpi6kUg8LWsTpI+HFeGg5MXZg+rWnTG/Xo6/nO5Tg3whMVFxN6OZZfg==
X-Received: by 2002:a17:902:2983:: with SMTP id h3-v6mr4058714plb.232.1528415350216;
        Thu, 07 Jun 2018 16:49:10 -0700 (PDT)
Received: from dsa-mb.dana.cumulusnetworks.com (fw.cumulusnetworks.com. [216.129.126.126])
        by smtp.googlemail.com with ESMTPSA id y20-v6sm67971336pgv.27.2018.06.07.16.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 16:49:08 -0700 (PDT)
Subject: Re: next-20180605 - BUG in ipv6_add_addr
To: valdis.kletnieks@vt.edu, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <15599.1528402643@turing-police.cc.vt.edu>
From: David Ahern <dsahern@gmail.com>
Message-ID: <fe2d6bfd-17a3-8464-175d-3e8714e14827@gmail.com>
Date: Thu, 7 Jun 2018 16:49:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <15599.1528402643@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/18 1:17 PM, valdis.kletnieks@vt.edu wrote:
> Hit the following, after which my network connection was pretty much hosed
> 
> This ring any bells? I don't have a reproducer for this, so bisecting is problematic....
> 
> [ 1820.832682] BUG: unable to handle kernel NULL pointer dereference at 0000000000000209
> [ 1820.832728] RIP: 0010:ipv6_add_addr+0x280/0xd10
> [ 1820.832732] Code: 49 8b 1f 0f 84 6a 0a 00 00 48 85 db 0f 84 4e 0a 00 00 48 8b 03 48 8b 53 08 49 89 45 00 49 8b 47 10
> 49 89 55 08 48 85 c0 74 15 <48> 8b 50 08 48 8b 00 49 89 95 b8 01 00 00 49 89 85 b0 01 00 00 4c
> [ 1820.832847] RSP: 0018:ffffaa07c2fd7880 EFLAGS: 00010202
> [ 1820.832853] RAX: 0000000000000201 RBX: ffffaa07c2fd79b0 RCX: 0000000000000000
> [ 1820.832858] RDX: a4cfbfba2cbfa64c RSI: 0000000000000000 RDI: ffffffff8a8e9fa0
> [ 1820.832862] RBP: ffffaa07c2fd7920 R08: 000000000000017a R09: ffffffff8a555300
> [ 1820.832866] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888d18e71c00
> [ 1820.832871] R13: ffff888d0a9b1200 R14: 0000000000000000 R15: ffffaa07c2fd7980
> [ 1820.832876] FS:  00007faa51bdb800(0000) GS:ffff888d1d400000(0000) knlGS:0000000000000000
> [ 1820.832880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1820.832885] CR2: 0000000000000209 CR3: 000000021e8f8001 CR4: 00000000001606e0
> [ 1820.832888] Call Trace:
> [ 1820.832898]  ? __local_bh_enable_ip+0x119/0x260
> [ 1820.832904]  ? ipv6_create_tempaddr+0x259/0x5a0
> [ 1820.832912]  ? __local_bh_enable_ip+0x139/0x260
> [ 1820.832921]  ipv6_create_tempaddr+0x2da/0x5a0
> [ 1820.832926]  ? ipv6_create_tempaddr+0x2da/0x5a0
> [ 1820.832941]  manage_tempaddrs+0x1a5/0x240
> [ 1820.832951]  inet6_addr_del+0x20b/0x3b0
> [ 1820.832959]  ? nla_parse+0xce/0x1e0
> [ 1820.832968]  inet6_rtm_deladdr+0xd9/0x210
> [ 1820.832981]  rtnetlink_rcv_msg+0x1d4/0x5f0

I am the most likely guilty party. I have been staring at the code for
this stack trace for a while and nothing jumps out. Can you send me the
kernel config?
