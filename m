Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D2DC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDA921581
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbVKRa0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDA921581
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbeHOEZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:25:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32993 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeHOEZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:25:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so9925216pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R/dSXm1U+oMTZJvbM+HvIefHaXvMTPgkOu4CPkg8DnE=;
        b=kbVKRa0WYe4/TU1hjtJT66V2Krv47MraHrc8wUMzAtar0eWvUAkzFdDPDuo085DEXJ
         9BzVIjGpevSmMOcfXxre5+NzvxiPxbSk0dzpwWTZxlCqqMlg4kR8DTxD/vJb5SGoo2Zp
         ZQ6eYHVck7SUUdWGP5bjDXEAIHwuPEV079AbQAE4zLGR00WXan9rwQKY8faFYwvODjlR
         w4k63ga8UgOrYxaCUCAYfyvDwc1QD14+s1MshlF275ZYdb89PjYXTNGJfvEk5QSZEt10
         /iKm2r9e3YNxKslSPzeStnz/uCUx/IQwX36l532WlotfVEfjKq5cX5eSA4Rd0EeyqHT/
         0TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/dSXm1U+oMTZJvbM+HvIefHaXvMTPgkOu4CPkg8DnE=;
        b=hXjGgFBxwrj2weCr2UxlhaUKAt3+ChkkIpUOM1eCTtK9JvUza8T8nsyRs7MTXW/Vza
         MVRh0bpL18vMAc3lEm2aEtga74JhFB4hr1QwFLjcW9pt3T3M+PTG1MedzfCpyHfTEldk
         4vARJMChcptqfZQi/z9pev2NNUNcDhtOcH2Ly/5Zr8ONVSaM0EQf5whkWTna60cWpO0b
         1V/NaX1HIYe/X9DXYpablF7Q8ZVzID9BzfVv0rSxePdF/4ytqh+sre303+zt74T1jrhQ
         xWgOlXKg6wbxY3ZQR6rrTvSUCjsZT4dCCqupJp2ovdMOh4cazJ4NIsz0knz+nnNEDbrM
         1lbw==
X-Gm-Message-State: AOUpUlEK/kmsRkIHzFz2hGosmmp69JzUdzon5OFrMZmAOV7/KWVID0du
        j3+Ao5jqQIk87epuJKhLN4PCow==
X-Google-Smtp-Source: AA+uWPzA7fpG0qlJ//wHUni03GKmrwoQDkG6ML+ERyDradm24mI5xBbp1wIDiXFLsABfFMQrVOp0XQ==
X-Received: by 2002:a63:2506:: with SMTP id l6-v6mr22988247pgl.237.1534296919094;
        Tue, 14 Aug 2018 18:35:19 -0700 (PDT)
Received: from wnukowski-desktop.sea.corp.google.com ([2620:0:1009:11:cdf9:e330:7b8e:1961])
        by smtp.gmail.com with ESMTPSA id d22-v6sm45317760pfk.69.2018.08.14.18.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 18:35:18 -0700 (PDT)
Subject: Re: [PATCH] Bugfix for handling of shadow doorbell buffer.
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        keith.busch@linux.intel.com
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>, yigitfiliz@google.com,
        Christoph Hellwig <hch@lst.de>
References: <20180814221735.62804-1-wnukowski@google.com>
 <20180814225716.GA3224@localhost.localdomain>
 <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
From:   Michal Wnukowski <wnukowski@google.com>
Message-ID: <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
Date:   Tue, 14 Aug 2018 18:35:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/14/2018 04:16 PM, Linus Torvalds wrote:
> On Tue, Aug 14, 2018 at 03:17:35PM -0700, Michal Wnukowski wrote:
>>
>> With memory barrier in place, the volatile keyword around *dbbuf_ei is
>> redundant.
> 
> No. The memory barrier enforces _ordering_, but it doesn't enforce
> that the accesses are only done once. So when you do
> 
>>              *dbbuf_db = value;
> 
> to write to dbbuf_db, and
> 
>>    *dbbuf_ei
> 
> to read from dbbuf_ei, without the volatile the write (or the read)
> could be done multiple times, which can cause serious confusion.
> 

I got confused after comaring disassembly of this code with and 
without volatile keyword. Thanks for the correction.

> 
> However, there's a more serious problem with your patch:
> 
>> +             /*
>> +              * Ensure that the doorbell is updated before reading
>> +              * the EventIdx from memory
>> +              */
>> +             mb();
> 
> Good comment. Except what about the other side?
> 
> When you use memory ordering rules, as opposed to locking, there's
> always *two* sides to any access order. There's this "write dbbuf_db"
> vs "read dbbuf_ei" ordering.
> 
> But there's the other side: what about the side that writes dbbuf_ei,
> and reads dbbuf_db?
> 
> I'm assuming that's the actual controller hardware, but it needs a
> comment about *that* access being ordered too, because if it isn't,
> then ordering this side is pointless.
> 

The other side in this case is not actual controller hardware, but 
virtual one (the regular hardware should rely on normal MMIO 
doorbells). I spent some time going through the code of internal 
hypervisor and double-checking all guarantees around memory access 
before asking the same question: "what about the other side?". This 
execution ordering is mentioned in NVMe spec under "Controller 
Architecture", and it turned out that the NVMe driver itself had 
missing memory barrier. 


Thanks,
Michal
