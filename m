Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B25C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CE321479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544134171;
	bh=yzBCV+vlwG9a/4A7GWu4nolhlBV47XOEOYk6RlMsoeI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rmGChw11DbKeFwFX9glspV7EUhmHbzHC86XrYo5MBB68mYPm3rwjZ/W2xL5Aj/iy+
	 xo+yeYu1a0TIxW8oxblu6Cxxv7ltv4HFSTkTCGC7mNTQsXilBcMArGfghevIvitpko
	 9iR4jeES3hslIm4sr+0rLoKt+c8tzZ5B9UjAIENk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CE321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLFWJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeLFWJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:09:21 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B25962082B;
        Thu,  6 Dec 2018 22:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544134161;
        bh=yzBCV+vlwG9a/4A7GWu4nolhlBV47XOEOYk6RlMsoeI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ry95nh9Pnjb/NkybFAwkjg1foFJ4AcTEsx901g84vEMbm4rIHx36e6X6UIauhq0wS
         0L1iv0+exTNoXcVyhOqxskIIQQ/1EmKo3RKeVqhyf+JI5U5tmlGAlH/Pw+cZSjop+r
         ccZZS+7Vjk2lTeI22fioCELf8bKa6F2bhSL6Nmec=
Subject: Re: [PATCH 4.14 00/55] 4.14.87-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181206143001.749982936@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <642b3327-b247-4e57-471f-b3e05a8b6273@kernel.org>
Date:   Thu, 6 Dec 2018 15:09:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 7:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.87 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  8 14:29:38 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.87-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
