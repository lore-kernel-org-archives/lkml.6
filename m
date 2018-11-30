Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBC4C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF762146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF762146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeK3VQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:16:22 -0500
Received: from www62.your-server.de ([213.133.104.62]:58880 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeK3VQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:16:22 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gSfht-0001eZ-0m; Fri, 30 Nov 2018 11:07:33 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gSfhs-000X48-Nu; Fri, 30 Nov 2018 11:07:32 +0100
Subject: Re: [PATCH] arm64/bpf: use movn/movk/movk sequence to generate kernel
 addresses
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ast@fb.com
References: <20181123172902.21480-1-ard.biesheuvel@linaro.org>
 <20181127182203.GA19721@arm.com>
 <c8f11ce3-1ab4-5e54-85f6-2431c7eb8a7a@iogearbox.net>
Message-ID: <adb5d79f-189b-b5b7-ff22-a6c4807e0f25@iogearbox.net>
Date:   Fri, 30 Nov 2018 11:07:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <c8f11ce3-1ab4-5e54-85f6-2431c7eb8a7a@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25166/Fri Nov 30 07:15:29 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2018 07:24 PM, Daniel Borkmann wrote:
> On 11/27/2018 07:22 PM, Will Deacon wrote:
>> Hi Ard,
>>
>> On Fri, Nov 23, 2018 at 06:29:02PM +0100, Ard Biesheuvel wrote:
>>> On arm64, all executable code is guaranteed to reside in the vmalloc
>>> space (or the module space), and so jump targets will only use 48
>>> bits at most, and the remaining bits are guaranteed to be 0x1.
>>>
>>> This means we can generate an immediate jump address using a sequence
>>> of one MOVN (move wide negated) and two MOVK instructions, where the
>>> first one sets the lower 16 bits but also sets all top bits to 0x1.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>>
>> Denial, Alexei, shall I take this via arm64, or would you rather take
>> it via davem?
> 
> Yeah we can take it via bpf trees, thanks.

And now applied, thanks!
