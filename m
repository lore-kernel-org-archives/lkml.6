Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCB4C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440282084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544572646;
	bh=aRwOVL2vBhd3pPq9DYuoDzhd6Hc+qD3fuFSJL5eERK8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GyxjILQOTse1iQifmX/qK0waTlCVBECi5H3F/mbyLceSrqb152PqxDlQsm4C4ZRgB
	 3sf3ARjNI1TgRroZX9nsnIF/i3URE2orkmvx1a2hJOzp7LMQB/v7aOd+4Zx1rynAA8
	 GqGt5ntBiiy6CcDGGELGOzmtoQ01Yed1V6t+pYKo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440282084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeLKX5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbeLKX5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:57:24 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93EB20839;
        Tue, 11 Dec 2018 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544572644;
        bh=aRwOVL2vBhd3pPq9DYuoDzhd6Hc+qD3fuFSJL5eERK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PY7oNGiPk8ZDM2mlcamXHg/BrW2oBNdM0Q/Iaaz8I8tUZA3CNuQDlMHu7g+SG2Drx
         Zk3YzLT2iq3RbpFKvLCWgJHwgdgGg0RrMb5GIacSRdcHMx95pIjs2bRUNjfKl/FmUN
         xXOvNi7aPdZsg3VuDsvUBUviKD8rGdoBMmqkVqog=
Subject: Re: [PATCH 4.9 00/51] 4.9.145-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181211151612.328911565@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d8f89215-8861-4e71-4545-245bde92b5aa@kernel.org>
Date:   Tue, 11 Dec 2018 16:57:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 8:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.145 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 13 15:15:52 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.145-rc1.gz
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

