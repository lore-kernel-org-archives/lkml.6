Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B327EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600CC20836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEF+HMPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600CC20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeH3UtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:49:12 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46879 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeH3UtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:49:11 -0400
Received: by mail-vk0-f65.google.com with SMTP id b14-v6so4460999vke.13;
        Thu, 30 Aug 2018 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IN+CH2S3yXGTJ3H7dYQ7pJhYeNJDueejxnUvmQQB+Q8=;
        b=TEF+HMPWuQS9hbcZUhqV9YRDu4cxQpDjr1A6/1h4mFubKWj4c32tLaK4TXvKKpBnL1
         6FyLLxqQhr8+oIx7bZsrmyHcY2Lvt9+MP41YPNtAyD3SewwYQN69MvEOl0Ktp5yc7Gp8
         qQIjysEOWmPxe426Hn054TkYMjJlVnJVCFQvLXPtILO7XqTpDL6q3Cn2tgmXMwXhaLl6
         CpVfPk4tveBJMa1QsgyqgVaye48AldSWO4Inh1D/1Re1T6U9Qb2UtLJHsJ1FnC/Pnp3U
         vvOcNUnjq9PwGJ/uqbu0cE/+D7ogikNyA/BKTNE+6k/fGElowAalNFKgYClxJXOhgwwX
         +xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IN+CH2S3yXGTJ3H7dYQ7pJhYeNJDueejxnUvmQQB+Q8=;
        b=oqFz7PTn2YvScVgZnkUycd+qbqqre4TK6q85iCKD84DXMDgqS0/efyGW2rDiFGuB75
         wi5puPvD0fgm42/I/LW47jr6Rj1a+0gpO+069m8cT85KlU4xN6JZ47whOwJi45JPjmDr
         SxmKRG1tJTcPrwuMQ5ofJ3qdkKOZnxppPi06+t6La4kUH/3P/ml9CPT69/gOQOTde2i1
         g9f0Dn0XyfIynNHUub4GPq9hV3pDTO3J8Hr4ogPcd9Gjud9CWAzLmVICOD1vkZ5kYYSO
         HhEKTyGAVa/dHZnYsnzlulkeqEC1ide73oMH6w9YI1piLrjWYXwGfsrGkU5FltWsXN/7
         uuPw==
X-Gm-Message-State: APzg51AzBwUtJkUVvqcKFRobPLicrkELnxofSFzi9VFi36rfxLHzqfY8
        DkzUTzUyu0wPV1BBXqCW45154EWmeiXvi8I6Y+d7+w==
X-Google-Smtp-Source: ANB0VdYLZat8JinIxGEPcF1rWeIXzS9WbUeJn5X5u7odaNTBD+23NQxM4V9zxCOUbHhnPt6JEb/VxUhEMpwITx8Iq0A=
X-Received: by 2002:a1f:2413:: with SMTP id k19-v6mr7090517vkk.128.1535647570523;
 Thu, 30 Aug 2018 09:46:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5e5c:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 09:46:10
 -0700 (PDT)
In-Reply-To: <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com> <000f01d4406f$6ce8f160$46bad420$@codeaurora.org>
 <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Thu, 30 Aug 2018 12:46:10 -0400
Message-ID: <CABo9ajDf09BHsq0NOs99NSD6zOV5N-CDvgvQrGi9p_wLjpJ24g@mail.gmail.com>
Subject: Re: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
To:     James Morse <james.morse@arm.com>
Cc:     wufan <wufan@codeaurora.org>, mchehab@kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 12:32 PM, James Morse <james.morse@arm.com> wrote:
> Hi Fan,
>
> On 30/08/18 15:40, wufan wrote:
>>>> @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev,
>>> struct cper_sec_mem_err *mem_err)
>>>>             p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
>>>>     if (mem_err->validation_bits &
>>> CPER_MEM_VALID_MODULE_HANDLE) {
>>>>             const char *bank = NULL, *device = NULL;
>>>> +           int index = -1;
>>>> +
>>>>             dmi_memdev_name(mem_err->mem_dev_handle, &bank,
>>> &device);
>>>
>>>> +           p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>>>> +                        mem_err->mem_dev_handle);
>>>>             if (bank != NULL && device != NULL)
>>>>                     p += sprintf(p, "DIMM location:%s %s ", bank, device);
>>>> -           else
>>>> -                   p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>>>> -                                mem_err->mem_dev_handle);
>>>
>>> Why do we now print the handle every time? The handle is pretty
>>> meaningless, it can only be used to find the location-strings, if we get those
>>> we print them instead.
>>
>> For ghes_edac the bank/device is informational, and nothing would go wrong
>> if the bank/device numbers are the same as another entry. But the handle
>> is now critical for DIMM lookup, thus pull it out.
>
> Is printing the handle to the kernel log critical?
>

I don't see why we would need this print. The bank/device
print is enough to map what is shown in dmesg to an SMBIOS
entry if that's really needed.

Thanks,
Tyler
