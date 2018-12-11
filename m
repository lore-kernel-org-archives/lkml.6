Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2BBC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F5D2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544572604;
	bh=XFTBTGO2aqk59gHKtqNJUNwJ5BhrlpsqaeTAdtAowXI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ls3gR9YvT0t6UI1zeac+yunY/plc50nyRhBVIuEA6YEOnfUQFcvHbH1uq5b/ZCBcU
	 dS8kCFKNb2vPnVoJ1GQPcTDRQYlauWCK50zLKaOqpqOgfEg7kXrzcvzkiQgmshjk3C
	 nbiPmVCkNkwA3UoriIU20et/wVGUo1J8krbVx2O4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F5D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLKX4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbeLKX4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:56:42 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E026620839;
        Tue, 11 Dec 2018 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544572602;
        bh=XFTBTGO2aqk59gHKtqNJUNwJ5BhrlpsqaeTAdtAowXI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Em37H7W4f87ng1hQwdgCk7znCwRw3XRQfJ1QSI47E0pS5fgd6rFjAPhohHSICyoix
         mdBmLNCFg4c2t3FLSNGkWzhhhE9x6IHEu9n541XlhUTrHGcrS109E97tGXHKJipdk9
         JBvRKeS2y+3lrmiaj1kUySoaZc3hOu6BthGD6cjk=
Subject: Re: [PATCH 4.4 00/91] 4.4.167-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181211151606.026852373@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <98a719dd-dfc1-182b-0170-9410b6f02d57@kernel.org>
Date:   Tue, 11 Dec 2018 16:56:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 8:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.167 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 13 15:15:44 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.167-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

