Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916BAC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1AC2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5TLPZeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfBENyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:54:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35188 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:54:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so1423367pgs.2;
        Tue, 05 Feb 2019 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CG27SVma1msaIA63Y9mdwSfWlyIBBU58oZSdMpf632Q=;
        b=J5TLPZeJw8v3Ant0M8dn+SxYQsaCzXSLzafWq2aDHpNWXnrfw5Bx4Gt9O6NSDty3CE
         EQRCuCTDSMiW6FhJyvfrzeH0UOEiVHHoBdlBsqCbjqZfRec2rELTHt5XiGsA3R7DyRpG
         j7l2asiciLmL0vb02IFOiVMDYezF3OEykIcDMigc5FIGx+RxFpAim06wjAl2XCaU9EUz
         2M9Qu34VVQOrEL4fmaNHXygkaldL136Y3cwEpPzi9cYYWcpeRVTCpfVFHI2IFIn0sMVS
         dpxKWEoIPR/D/LTnV3uj2JotkQXUNTLrGLZLzVG5rAc05FtPK1rO0TeG6FlWxsujtfWn
         D4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CG27SVma1msaIA63Y9mdwSfWlyIBBU58oZSdMpf632Q=;
        b=uPqgUFSYUCJeN6W6N/NvRMMU6fOgjwH/0/Cng+ugDmo9jP/mHXGWcyiOCH396nptHu
         pGKrPtcwGIjfEsFK0u8OJw7qY71IcLcAxs1fZ9sIJv/G8ZKDfD1BrKQYwjx211z12ku2
         8pByRjwgzgIF1d2zADTi6Jp4eoZgzwdKH2q4t8AGFnvWFfBAemU8oPDyxNGcvyZMhZD9
         6GGVRsT0WwG6wA/RtDST9xpiy2t/CXvtAVjFyZ7zZheWw/ASRHEwENtHOFiei/r7efKx
         VhFLaRiDKhJ9hx1QSGJFGb4VT/+cVRbrHXjqHsOiFkrXwf3Ml//J6RL5nhx+qm/wfTmV
         DtbA==
X-Gm-Message-State: AHQUAuYiJPw0xit6+rm9b3nBjRWDoB4mBORv+trlYFLJz3AcMf/kg8Xr
        ZY69UuzZpSNJOr3KtcTO5dHjwqON
X-Google-Smtp-Source: AHgI3Ibn1nS9z5hqRpGfxHCkgZcGO/htgAw3JbvkhM3/IIP7O2c7gUpb68dqcltI9SSFzvzDW/PK+Q==
X-Received: by 2002:a62:6303:: with SMTP id x3mr5287067pfb.110.1549374888180;
        Tue, 05 Feb 2019 05:54:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o1sm7967245pgn.63.2019.02.05.05.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 05:54:47 -0800 (PST)
Subject: Re: [PATCH 3.18 00/31] 3.18.134-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190204103557.903263774@linuxfoundation.org>
 <20190204214444.GB18895@roeck-us.net> <20190205084625.GA12210@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ae7ee607-9d7c-5b4d-545d-ab4f7bbcbc18@roeck-us.net>
Date:   Tue, 5 Feb 2019 05:54:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190205084625.GA12210@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 12:46 AM, Greg Kroah-Hartman wrote:
> On Mon, Feb 04, 2019 at 01:44:44PM -0800, Guenter Roeck wrote:
>> On Mon, Feb 04, 2019 at 11:36:15AM +0100, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 3.18.134 release.
>>> There are 31 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed Feb  6 10:35:28 UTC 2019.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 155 pass: 153 fail: 2
>> Failed builds:
>> 	arm64:defconfig
>> 	arm64:allmodconfig
>> Qemu test results:
>> 	total: 222 pass: 222 fail: 0
>>
>> Error log:
>>
>> Error log:
>> arch/arm64/kernel/head.o: In function `el2_setup':
>> (.head.text+0x130): relocation truncated to fit: R_AARCH64_ADR_PREL_LO21 against
>> symbol `__hyp_stub_vectors' defined in .hyp.text section in arch/arm64/kernel/built-in.o
>>
>> Looks like this is due to commit 8640f2308921 ("arm64: hyp-stub: Forbid
>> kprobing of the hyp-stub").
> 
> Ah, thanks, let me go fix this up...
> 
> Ok, pushed out a -rc2 with that patch dropped.
> 
> greg k-h
> 
Now fixed:

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 226 pass: 226 fail: 0

Guenter
