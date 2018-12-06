Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E9521479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544134206;
	bh=MbKMwhEajRhmJXcsKTmraGfUBdWztG+qTO2ePOblv/s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=iqTnjyXIx3e8FXzYZAALsdj9DSel4CMT053ksJoflQFqktf4riTNk15bZCx5VbJ0+
	 K2xnkNYUdcHlrOP/1zZhMlY2H4cnjKOMFEqoRU/48Y6h87L68oziv3XjMQzmQHCP8a
	 jsgB51RKoGzL6Ra4MfHbATIiSudH059TEnRhnEgs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E9521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLFWKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLFWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:10:04 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0FF2082B;
        Thu,  6 Dec 2018 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544134204;
        bh=MbKMwhEajRhmJXcsKTmraGfUBdWztG+qTO2ePOblv/s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X7wDe8HoXKPJXih0CbsyGESxkwP1DLsNIVDvn992JFRKpgKS/zw8tQ4Zjn4GPd9dK
         ASeJWpWchKxwW2iSMjsWfd5nqQPK+ELeexvaaZ5KSuqEohTFz6ATe4/SwKmlXnpscX
         I7liHsrUlD4ax/r1Q/JaJpHtSy79CxNl/+o1KaJE=
Subject: Re: [PATCH 4.19 00/41] 4.19.8-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181206142949.757402551@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d6d42f05-629f-e41e-c50d-2e53316cd6bb@kernel.org>
Date:   Thu, 6 Dec 2018 15:10:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 7:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.8 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  8 14:29:30 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

