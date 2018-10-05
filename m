Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D31C64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D9120834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb3lkbQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D9120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJEI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:29:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43173 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeJEI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:29:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so6031233plb.10;
        Thu, 04 Oct 2018 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tmWxSPAo71SGrCZnOiSxbBYGXmMj2k6zWLxS9s7nklQ=;
        b=Mb3lkbQZ1ZIoDLTtLbrtsIlXUj0bBWZS4IXumLm4LxPj1aK884WQ39DizU0q44X0JP
         8KslcY6XWewZteeTqf7q+Syvuhrkgq34k4H0zjIvEkGmSRTxwF/MljPwFgcmqVXUZYg5
         H4BhKX/xjg6ipJhMQNOIHOfKUhhExWlMt8NBz9B8s7B+RXRx53+KLgWRStqnK15jGexq
         /zZOMkJbALSlS9CdPShiL0eY1UNM2Cz4ASa8RjzoexJrQEv6AJ2ItK/QO1ubZOwlCWGa
         hxYTc0WoArwv4/Ixj8m+BFP4TVTz7LYa29ShXtuyrYxjDzbI5joR2958dWe7lNNBayyK
         x/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tmWxSPAo71SGrCZnOiSxbBYGXmMj2k6zWLxS9s7nklQ=;
        b=iicVBnBQKm8fGlMs/WTtfrjRCDI7Rjhy0L5ufhXC0ppM6FUFvqv51kGLrecpEK0RD+
         gHAYuisTiwlP++ueD6o2Wj5tYHohYuitWDTQG0hRcBPgBdEyTi+9usAq3DNPNeuQ0z13
         0DyfmHyOzcx8HpypECqOcgJDP+6jpFWrpbR1Q/qH8Ke45oT7uSG7eVIiTjgic37prvCC
         n1wb8pY8K32UvDUqwHbBE4HG5gAkTdoypb+Vs649EVPAHjHL+XRJzjFmYFE1gfSpdqAH
         mDrjq0oHfmklW0a3t5kAMYoYriY6RuPQw+xxhx+uPjSDJjHBifugMrujDkUputuyb3z0
         cz7g==
X-Gm-Message-State: ABuFfogC886hq+45pM7nUicckoByombWBLce++XdZSSOKxiPgB659Ng8
        92N7kEBPFRv9QG7EoJh5diSY2A8b
X-Google-Smtp-Source: ACcGV62m74kVe6sVho+BMfvNBBhAqQENtQdi7oGcTMxxQ60+azPH+xvwfDxbADAde6v2l0MKL23yjA==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7-v6mr8894641plp.14.1538703185141;
        Thu, 04 Oct 2018 18:33:05 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x23-v6sm3767506pfm.113.2018.10.04.18.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 18:33:03 -0700 (PDT)
Subject: Re: linux-next: Tree for Oct 4
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20181004183449.36bcc93b@canb.auug.org.au>
 <20181004134644.GA9130@roeck-us.net>
 <CAMuHMdXfhbFi8HYtqd6BeACyG64_eQvoiSQ7DMpyOmdXEXPymg@mail.gmail.com>
 <20181005094445.4d0b68bc@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <01c4a73c-7901-2fbb-8f87-95ff21dc5126@roeck-us.net>
Date:   Thu, 4 Oct 2018 18:33:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005094445.4d0b68bc@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 04:44 PM, Stephen Rothwell wrote:
> Hi Geert,
> 
> On Thu, 4 Oct 2018 16:21:42 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> On Thu, Oct 4, 2018 at 3:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> Time for a status report.
>>>
>>> Build results:
>>>          total: 135 pass: 121 fail: 14
>>> Failed builds:
>>>          arm:allmodconfig
>>>          i386:allyesconfig
>>>          i386:allmodconfig
>>>          m68k:defconfig
>>>          m68k:allmodconfig
>>>          m68k:sun3_defconfig
>>>          mips:allmodconfig
>>>          parisc:allmodconfig
>>>          powerpc:ppc6xx_defconfig
>>>          s390:defconfig
>>>          s390:allmodconfig
>>>          s390:allnoconfig
>>>          sparc32:allmodconfig
>>>          xtensa:allmodconfig
>>
>> Most (all?) 32-bit builds are broken due to commit 571ed1fd2390f74e
>> ("SUNRPC: Replace krb5_seq_lock with a lockless scheme"), presumably fixed
>> by Arnd's "SUNRPC: use cmpxchg64() in gss_seq_send64_fetch_and_inc"
>> (https://lore.kernel.org/patchwork/patch/994909/).
> 
> I have added that patch to the nfs tree merge in linux-next today.
> 

Most of the boot failures are hopefully fixed with
https://lore.kernel.org/patchwork/patch/995254/

Guenter
