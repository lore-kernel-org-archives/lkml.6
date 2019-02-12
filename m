Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452F2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14784217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A/xtyrIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfBLQQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:16:05 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:35595 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfBLQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:16:04 -0500
Received: by mail-it1-f182.google.com with SMTP id v72so8928131itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BcbiwYoeQ5EFhhDuBwroyRQ+sI20g7wH4KgP+AYudGY=;
        b=A/xtyrIfUNy9SE+lMTaGWod/Ahk16uh9S1uJRG8I/Yeogq/6FKslvnPNZ1Y4POeiIE
         qxNbewnGi6nRAbi3CJbaFc+O9teeJF8i1MsTi+wXwBF+Sv9fi4Sf66jVNLXFxRVW4FHJ
         9q5ytJeZiDg5wd6TwOj33M1rMNB7nOohAwuo05BuNGfSVE+KV/h4omh1llNfJqomrzbT
         YJYWst6MKzVEm66IOXwk3ZUE9xOvWheY3AwbUvEC8yOAnHsn21aNk6WINi9/7nCXX8sz
         Lr2iP0rjt9FPJZdu3aqC8Mfo+FyxfSlj16K8BM/XxBte2qUDA1OXeUg1L/MvN2p8CxFL
         6XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BcbiwYoeQ5EFhhDuBwroyRQ+sI20g7wH4KgP+AYudGY=;
        b=JbsckwF4qK5QiRqll6s/w4wiGXZUWM8xSStm6/I1uRxZkguJRXxWlcp/8JXbXs3S4l
         R4pDX/1K4LsBI/gDuTyeyIWk/65/GfuZR3hr4oK1vzXmt6lcLY/ysRiLjkKQ5SzIqXN9
         iAC2HFTp6hiilNHFfHTxY9FXmDZfcp+5kcTxSep2NccLSlGbqgcdkR/aziC0oJ/6t6VE
         L27WWgJYosm9kDyial8DXmdgt6SoFt2OVaz3IBiJuyNgvp4kUq9CSEM6mOOYEqGqadrt
         pRPKS098r2A1h38Q7lHp9jaXjYES3GYaVn0f0h26q0vQVlD6BlQwl049u6/PyUkiuihb
         zbcQ==
X-Gm-Message-State: AHQUAuZbg4vJfzIQWsfF87iFuIbjWcGhda6U9tVa7VMSkECHx6qq+zuI
        TPVbGGXpzoB3KCXwAqQuSsrdhQ==
X-Google-Smtp-Source: AHgI3IbdLxICyFu6EDFSuhU8UQ3XIDrIwnK96R1Uk/Vg5H1zWGMNafFt22QCYjCdOUONpj/pqcz/qQ==
X-Received: by 2002:a02:97ee:: with SMTP id v43mr2353260jaj.67.1549988163583;
        Tue, 12 Feb 2019 08:16:03 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v6sm5960745ioh.37.2019.02.12.08.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:16:02 -0800 (PST)
Subject: Re: Bug#919356: Licensing of include/linux/hash.h
To:     Ben Finney <bignose@debian.org>,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
Cc:     Domenico Andreoli <cavok@debian.org>, 919356@bugs.debian.org,
        Kristian Fiskerstrand <k_f@gentoo.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "debian-legal@lists.debian.org" <debian-legal@lists.debian.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <jens.axboe@oracle.com>
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
 <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
 <20190211072259.GA19224@nouveau> <20190115083241.6c6ftrw73xuv26j6@dumbo>
 <2977287.v5rPGuGa1n@merkaba> <86va1p7c7z.fsf@benfinney.id.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8a87da85-3aef-a113-f93f-c96ab465c96f@kernel.dk>
Date:   Tue, 12 Feb 2019 09:16:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <86va1p7c7z.fsf@benfinney.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 11:27 PM, Ben Finney wrote:
> Martin Steigerwald <Martin.Steigerwald@proact.de> writes:
> 
>> Well the file has in its header:
>>
>> /* Fast hashing routine for a long.
>>    (C) 2002 William Lee Irwin III, IBM */
>>
>> /*
>>  * Knuth recommends primes in approximately golden ratio to the maximum
>>  * integer representable by a machine word for multiplicative hashing.
>>  * Chuck Lever verified the effectiveness of this technique:
>>  * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
>>  *
>>  * These primes are chosen to be bit-sparse, that is operations on
>>  * them can use shifts and additions instead of multiplications for
>>  * machines where multiplications are slow.
>>  */
>>
>> It has been quite a while ago. I bet back then I did not regard this
>> as license information since it does not specify a license. Thus I
>> assumed it to be GPL-2 as the other files which have no license boiler
>> plate. I.e.: Check file is it has different license, if not, then
>> assume it has license as specified in COPYING.
>>
>> Not specifying a license can however also mean in this context that it
>> has no license as the file contains copyright information from another
>> author.
> 
> If a work (even one file) “has no license”, that means no special
> permissions are granted and normal copyright applies: All rights
> reserved, i.e. not redistributable. So, no license is grounds to
> consider a work non-free and non-redistributable.
> 
> If, on the other hand, the file is to be free software, there would need
> to be a clear grant of some free software license to that work.
> 
> Given the confusion over this file, I would consider it a significant
> risk to just assume we have GPLv2 permissions without being told that
> explicitly by the copyright holder. Rather, the reason we are seeking a
> clearly-granted free license for this one file, is because we are trying
> to replace a probably non-free file with the same code in it.
> 
> It seems we need to keep looking, and in the meantime assume we have no
> free license in this file.

FWIW, fio.c includes the following mention:

 * The license below covers all files distributed with fio unless otherwise
 * noted in the file itself.

followed by the GPL v2 license. I'll go through and add SPDX headers to
everything to avoid wasting anymore time on this nonsense.
 
-- 
Jens Axboe

