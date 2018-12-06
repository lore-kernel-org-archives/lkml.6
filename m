Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36F21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544134120;
	bh=V/zOhHCdshtm5riDh0gRIY9V2onkzNC8gdKljsmX5l4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rLqgaAYRR18Bgj7bgRqY/eMrB4ir4BZGq7GWKSrza18h9LlkSThxenmWr40nDOdP3
	 PTLtsxocOZMpRlQ3MoG76ZQv3MbuIwObcDXL5M6swskGgaeptdJXwUNK+Mtcc3ZVO1
	 8ziRn3otyjzHxK3sKzUYm+B4g9J0K8mo9tWqIL7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A36F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeLFWIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLFWIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:08:39 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D6E2082B;
        Thu,  6 Dec 2018 22:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544134118;
        bh=V/zOhHCdshtm5riDh0gRIY9V2onkzNC8gdKljsmX5l4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UPn3rXYBPkBFg1WwIP0NK2X17E9IVFRRKHr7Ir5ynohyiK/AreDAooVrcvhOE9PcX
         elenqiBCV3zq8wu6NJ6uDZzz1+g31ZpIqlmkuqMzz1b3MUu02h0lp2b3P/CgtK9aR3
         yxAon/+lSzxSUDNRpM6xVVqsWQGs6A0gV8Blwi78=
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181206143011.174892052@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <66de0a3c-f67c-c935-f64c-943b76b93146@kernel.org>
Date:   Thu, 6 Dec 2018 15:08:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 7:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.144 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  8 14:29:43 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

