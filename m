Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581062192C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNItTatU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404485AbeLUSqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:46:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41442 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbeLUSqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:46:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so5598873ljc.8;
        Fri, 21 Dec 2018 10:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9SN8LImLyDjwxI7cdHrCSZgKb9HBIBdcYlEOiHmK7PE=;
        b=WNItTatUbUjMWZLEJMMSg0/NRVug8/MNTSdPXEK9cohyLfkFrWkLV+J1+EA9ZSwWZR
         pL+zFN/R5toY+yIyorGQh8arn64pmvaVHUr1GPLLepfFief4pwZbUPm8KpqBBlFA8/ei
         TltGCNeZz+mY25hIcZjIkIbjzBhH1JRt/xuBVya24svLR+dxlw5JDz9zXpqGKbUuXRMV
         fom7J6vWysKI3ynEACs6aO6QJ1i5atpeXzeP6ru2kR90Xs8W70IgCXIPIwwdeGNMfe55
         FI6YYe1J62ndW4Up3Np4x6t7iPXXQBZvvtYqToRDCDV+0sT2Jphcq3iDJZe+q/g4uuTq
         EeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9SN8LImLyDjwxI7cdHrCSZgKb9HBIBdcYlEOiHmK7PE=;
        b=QcLECearp9Pl1xASsEebR3AHXKhxjTWCbIVyP8LG4f7e7l/ezVpoarcFXSSka4TYLS
         DpJlY+l/YwBdROIJQdG1Q4npwKFPFRCHzh5js3/HKOaAWLvm/XphBVORgDuM2+Gs8oEC
         cRHyMQcq32P09E41OiR+Beig5h3OIcG0sye54xHC6iQBoPXyNYQ5KTm3w2seDnVQyh/5
         AmU8fBp4a4DIEV+yizIDP9bBU0R3elMBn/MZ9GSwq3Yi783FAT2GbEfhEhBc9ljwsQEn
         i/UbWdaWLLCCcOHQOVsmc8OOlQXhDAIRbYi3XweSSBNMvfTjQtes9XqANsqC3ekdC6qP
         y/sA==
X-Gm-Message-State: AJcUukeNz1fckaT0qOpPS7oe67agFW91gwHNQ/P6718K4clNsTYtoYO0
        dL112M6EexUfhK979/eURz9zDf/JHCs=
X-Google-Smtp-Source: ALg8bN5A7ixJIaEhK+HJ1WGLkJa9Mb4Im59RfMZDB3PQ0GgyBMakdY9zgvZFwFwnBVwrExsYnyCnjA==
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr2530570lji.14.1545418012645;
        Fri, 21 Dec 2018 10:46:52 -0800 (PST)
Received: from ?IPv6:2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2? (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v5-v6sm4847827lje.78.2018.12.21.10.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:46:51 -0800 (PST)
Subject: Re: [PATCH 01/12] x86_64: memset_user()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-2-igor.stoppa@huawei.com>
 <20181221182515.GF10600@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <f2661969-a0d8-45e1-4334-c9b74d08f143@gmail.com>
Date:   Fri, 21 Dec 2018 20:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221182515.GF10600@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2018 20:25, Matthew Wilcox wrote:
> On Fri, Dec 21, 2018 at 08:14:12PM +0200, Igor Stoppa wrote:
>> +unsigned long __memset_user(void __user *addr, int c, unsigned long size)
>> +{
>> +	long __d0;
>> +	unsigned long  pattern = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < 8; i++)
>> +		pattern = (pattern << 8) | (0xFF & c);
> 
> That's inefficient.
> 
> 	pattern = (unsigned char)c;
> 	pattern |= pattern << 8;
> 	pattern |= pattern << 16;
> 	pattern |= pattern << 32;

ok, thank you

--
igor
