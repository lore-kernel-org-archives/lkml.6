Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53227C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EED21908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiaWeev1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBGOlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:41:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45690 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfBGOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:41:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id j3so6246pfi.12;
        Thu, 07 Feb 2019 06:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ECYie6JEK6ZFfWte/AW/0fTBDsqNoqPJfpyOu1ERqs=;
        b=RiaWeev1aGMKYGdyedMs2aLMAqLncqtZMTkiKCvXCpx7oqdm/Hj+fuzvsBOR87wHOa
         bXLd6adLg3kyZkMd6kWojJLDcZHygLfXqZ3GsAaTtp1jsPUM1kptxx3o/Wx++fKT/+56
         dCqiwuCDWB8vhHCVnaV/FP1pBM8GFFNZBQn4wsZ4KxBDwCU/RugYkcpDMBqMR0b+wPtS
         u/1V8giCGcUm8BF9FUW3qACQIy1KNf0ci2eo/hDoz/nmOHYpXjnMVPA+ox9sd5+KER8o
         7v09moCDiSmwnkFsw17jTp3Vz/yXMRKiiiyPOKhUZU+qegXnGkIhXX1E9+lXLoTnmrrd
         lAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ECYie6JEK6ZFfWte/AW/0fTBDsqNoqPJfpyOu1ERqs=;
        b=SQKF2tCP0vCqx+xv1dq1ZC12TX7O0Ka5WH+/DeNTDOnvE850GRibKL/iwIvJLds01V
         qVXOwS261mUWpTK7hlnNwd2s8pKAxURb08Pdi0STp1wBniCfiWUO1RJHPQjBJEH5DShv
         dtyObzKBWlfme1UTAZHFstLAgdEQpmdYjO3qqGjHaIoUwLX2+xpU+u2JUjPU7EBT2c6J
         E5r48G0ySlKWNEEl3+l70ZqSKSAYUxZmatN8+k5iYddhX9zUN4PfX3ViIOoqZ7svxCDj
         WbkwG/PbpgIujlv9iRFDo3hycEFRlgRdktW/4WAD+MrmSZDm74osrbq3VXtQHBw5OPqG
         5t/w==
X-Gm-Message-State: AHQUAubvX9TmMO0nNRfrKQjYiyUYgXYch3wE1WnBZ96PkOpei48uJrLq
        2rRjx8F44eb/ABL2S60HI4lJ5Oas
X-Google-Smtp-Source: AHgI3Ibw2VFSS86Cd+dgYqcZHHqQU8TnBtDz27tq47q3lIoNvSLoaEUvYLAqkL/Bz4ShVdAqG9lR6Q==
X-Received: by 2002:a62:5486:: with SMTP id i128mr16133942pfb.215.1549550464022;
        Thu, 07 Feb 2019 06:41:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l82sm25652041pfg.127.2019.02.07.06.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 06:41:03 -0800 (PST)
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190207113025.552605181@linuxfoundation.org>
 <2780bab7-047c-33c2-e0dc-cdc0cec46400@roeck-us.net>
Message-ID: <abf78f65-b3c4-de63-8d11-7d014bd1e42c@roeck-us.net>
Date:   Thu, 7 Feb 2019 06:41:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2780bab7-047c-33c2-e0dc-cdc0cec46400@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 6:20 AM, Guenter Roeck wrote:
> On 2/7/19 3:41 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.4.174 release.
>> There are 34 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
>> Anything received after that time might be too late.
>>
> 
> Build results:
>      total: 171 pass: 170 fail: 1
> Failed builds:
>      x86_64:allyesconfig
> Qemu test results:
>      total: 291 pass: 291 fail: 0
> 
> The build failure is interesting.
> 
> Relocation offset doesn't fit in 32 bits
> make[3]: *** [arch/x86/boot/compressed/vmlinux.relocs] Error 1
> make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [arch/x86/boot/compressed/vmlinux] Error 2
> make[1]: *** [bzImage] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
> 
> Unfortunately it doesn't tell me _which_ relocation doesn't fit.
> 
> I may have to revert to an older compiler. Wouldn't be the first time.
> Let me try...
> 

Confirmed. This builds fine with gcc-6.5.0 and binutils 2.26.1. Sigh :-(.

Guenter
