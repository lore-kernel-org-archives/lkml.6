Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0A920892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544054069;
	bh=WnWBSUKiHd9cHkvvEba2LPyTdBeu0Q5UdJ1OqL2ktG8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=KHqRUKMw9iW7n5wwjdKqXWXaMWIHnW2w/LZPX+/Y9hJm6PRWPq+VjjEt8fO3q3FhD
	 l714w6vKoJCERKxn2oGYWJqUQbzNTcMa/B+BQYESZZPfuXRjTHRbcKraSSY2zpPFdw
	 vHpP/3CZJi5CrYFHzd7B3BxJr7RFIw08oKeiSZDk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0A920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeLEXy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbeLEXy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:54:27 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 851B620700;
        Wed,  5 Dec 2018 23:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544054067;
        bh=WnWBSUKiHd9cHkvvEba2LPyTdBeu0Q5UdJ1OqL2ktG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pQ/dgrrviTVCW9+LyZNsMLepr1pHDJsnUUdnrPWPv2u32YJoFqj7QsVngIzHZo/Lg
         LW3vy8ZL2qu3GKf6ZdXWLf57yvwL3JboR8aSVAmctiBezO+Y1eDAJvLdCXDTuVevwO
         wePjTjwowK2juIGIZQoMrm3dxbNUPnehQazRsLM0=
Subject: Re: [PATCH 4.9 00/50] 4.9.143-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181204103714.485546262@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6386bd4e-96d8-820a-6b58-8515ee022599@kernel.org>
Date:   Wed, 5 Dec 2018 16:54:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 3:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.143 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec  6 10:36:59 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.143-rc1.gz
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

