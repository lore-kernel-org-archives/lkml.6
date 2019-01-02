Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFC1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047F8218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="anhQs/sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfABNQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:16:45 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46775 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbfABNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:16:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so17772350qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0suPthCD8NW6OMTActNHayzx50LoSrAU2VHPhzc8svc=;
        b=anhQs/sD4o9t+Ya1LUCMbt0LZMmH+aKTam/2dGqpucwZ5iokz1W/2DdHt2keOPNAqr
         BUlKwHLVq5mURCUwHIDKiFYk0dswxlqkp1RmNfIzgGXXIzIDats6LJScB2LzmvJ8Cys3
         AoMkd5PMsPI7OyM71aALlU0YJgeKHyQ30WDbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0suPthCD8NW6OMTActNHayzx50LoSrAU2VHPhzc8svc=;
        b=P280/VDkZn+gBIF6tOgFlgIWeM3MNf1NvfZgZiZPO37lvbPB788aK97lQkM5ax71F9
         UL0LwpHDXiBi/gdIkzVzYz1A5oC4o6QVVFBSR3IhPYXenUe4/dRmkJfbskjLm3f0iYBh
         pnbdSbNOFMU/Lzt1Ugi3qaHsNEKZqxx0CR2NGICBZ6KnmCZfc8uzbnWmQmq1Zq95T0sa
         TKVuDllxP4hPiVVer8oVlrq/EqbbkABrfsVMnT+kJYGyLJqdUa565FLNVQAVXu2jdFvo
         hnsjlhzPXwp6x3bE6NEPgva6ptcFyPv/Govokcy+YwKaksyp/TMkeGsV4qjcLWA6iTa1
         UkAg==
X-Gm-Message-State: AJcUukf/e1+Kgend5Coq53Yk7LcoYObWoY+ftJyEgKELQO67LjWNXgKp
        gEIsVxkiCGxl/3N8BN4tkBqwqQ==
X-Google-Smtp-Source: ALg8bN6VQhHxPCT7eoCx2ul0dDNkLyaHbo2i9g14Fz717hp+XfkKpEjp2feXRBo/qtw1OiSFE+Wqdg==
X-Received: by 2002:a37:90c3:: with SMTP id s186mr40150143qkd.339.1546435003361;
        Wed, 02 Jan 2019 05:16:43 -0800 (PST)
Received: from [192.168.1.132] ([189.61.226.82])
        by smtp.googlemail.com with ESMTPSA id o2sm21597220qtp.48.2019.01.02.05.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 05:16:42 -0800 (PST)
Subject: Re: d_off field in struct dirent and 32-on-64 emulation
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
 <957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
 <87pntmu9iw.fsf@mid.deneb.enyo.de>
 <ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org>
 <alpine.DEB.2.21.1812311657050.27287@digraph.polyomino.org.uk>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=adhemerval.zanella@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a5092631-2ddf-1790-5f27-777646ef3d34@linaro.org>
Date:   Wed, 2 Jan 2019 11:16:37 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812311657050.27287@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/12/2018 15:03, Joseph Myers wrote:
> On Fri, 28 Dec 2018, Adhemerval Zanella wrote:
> 
>>>> Currently we only have nios2 and csky (unfortunately).  But since generic 
>>>> definition for off_t and off64_t still assumes non-LFS support, all new
>>>> 32-bits ports potentially might carry the issue.
>>>
>>> For csky, we could still change the type of the non-standard d_off
>>> field to long long int.  This way, only telldir would have to fail
>>> when truncation is necessary, as mentioned below:
>>
>> I think it makes no sense to continue making non-LFS as default for
>> newer 32 bits ports, the support will be emulated with LFS syscalls.
> 
> Any new 32-bit port that uses 64-bit time_t will also use 64-bit offsets 
> (because we don't have any glibc configurations that support the 
> combination of 64-bit time with 32-bit offsets, and don't want to add 
> them).  That should apply for RISC-V 32-bit at least.
> 
> I've filed <https://sourceware.org/bugzilla/show_bug.cgi?id=24050> for 
> missing overflow checks in telldir when the default off_t is wider than 
> long int (currently just applies to x32; not sure why we don't see glibc 
> test failures on x32 resulting from the quiet truncation, as the issue is 
> certainly there in the source code).
> 

What about csky? Should we still make it use 32-bit offsets as default
configuration even when kernel does not support it natively?
