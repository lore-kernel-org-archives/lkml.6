Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD86C282D0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4832184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548813087;
	bh=caZ/kYG6FJohv1co6rwbPb/YwgejF20sCfrIlTh5PeA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=geZXaZxrbuPcCNl/fXWLkhPACW56wKzz7pQqSOE+8/rA1Gg5Mecyl4gISQWguAcx5
	 rF6L3cVyHyecpnEx7ZRTkrnwI+9FacnaJK9F6YMd9gkiRni0pteBpmS2fP8diS1Ulo
	 qRE6nMNgBsPeijiFn8lZdfzfTohFMb6mAnNIqfNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfA3BvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbfA3BvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:51:22 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7829121473;
        Wed, 30 Jan 2019 01:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548813082;
        bh=caZ/kYG6FJohv1co6rwbPb/YwgejF20sCfrIlTh5PeA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ll9f1LuFg8NktCc2YDKfjrb4o+MVYzM9q9J5uhef9kO2suyKHRC/gy7cbn3ZlH+EA
         NJdmpWRt5p0jHcBrNuxvWbZebmJqchGKyvWgVZWJGjXtAqdz/+jmekNLIQMZaugz5e
         g17DE/GKh+/dkyEg3U0sH3XMPRyDDidrdr+RNfk4=
Subject: Re: [PATCH 4.9 00/44] 4.9.154-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190129113139.826927690@linuxfoundation.org>
 <20190129190220.GA6116@roeck-us.net> <20190129192624.GA21847@kroah.com>
 <20190129194323.GA32069@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <93ef15ea-9391-47ab-4e37-46c46ef9bf59@kernel.org>
Date:   Tue, 29 Jan 2019 18:51:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190129194323.GA32069@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 12:43 PM, Greg Kroah-Hartman wrote:
> On Tue, Jan 29, 2019 at 08:26:24PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Jan 29, 2019 at 11:02:20AM -0800, Guenter Roeck wrote:
>>> On Tue, Jan 29, 2019 at 12:35:55PM +0100, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 4.9.154 release.
>>>> There are 44 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
>>>> Anything received after that time might be too late.
>>>>
>>>
>>> fs/cifs/connect.c: In function 'zero_credits':
>>> fs/cifs/connect.c:527:34: error: 'struct TCP_Server_Info' has no member named 'echo_credits'
>>> fs/cifs/connect.c:527:57: error: 'struct TCP_Server_Info' has no member named 'oplock_credits'
>>>
>>> Seen with:
>>>
>>> arm:s3c2410_defconfig
>>> arm:nhk8815_defconfig
>>> arm:cm_x2xx_defconfig
>>> ia64:defconfig
>>> m68k:defconfig
>>> m68k:sun3_defconfig
>>> microblaze:mmu_defconfig
>>> mips:defconfig
>>> mips:nlm_xlp_defconfig
>>> parisc:defconfig
>>> parisc:generic-32bit_defconfig
>>> parisc:a500_defconfig
>>> powerpc:defconfig
>>> powerpc:ppc64e_defconfig
>>> powerpc:ppc6xx_defconfig
>>> s390:performance_defconfig
>>> tile:tilegx_defconfig
>>
>> Ugh, this is due to CONFIG_CIFS_SMB2 not being enabled there.  But it's
>> removed in newer kernels.  Let me see if I should just drop the
>> offending patch, give me a bit...
> 
> I've just dropped the patch now and pushed out a -rc2.
> 

rc2 compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
