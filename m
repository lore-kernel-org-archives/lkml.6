Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88312C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496AD2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546900700;
	bh=AUvDw3QJqTzYxCpjkh3PXUCkqhC8ZuPNfHNWgBN3H48=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Uo2IAMcEJ8I3TM1YlNQDQwR/nBIM/Xz3I8BTzAh3MXOQgPhH6mfF+uOwroelS2bj4
	 wvJ+p85KLPKWXyg5guYAP2Y524JibGFFO7FtCqbLY1dfakaC/gWJRY2EZwBlh1FWZa
	 FqScQJLw6xVG1QOWFOxDyHKhdRBvE3Mj222+8Hjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfAGWiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfAGWiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:38:19 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CDB2147C;
        Mon,  7 Jan 2019 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546900698;
        bh=AUvDw3QJqTzYxCpjkh3PXUCkqhC8ZuPNfHNWgBN3H48=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p/kwBQVpJzi0e6ADNgQPy+xZ1HEsIlqsPuylG49E3/Ikf31hNrfzjbsZYorvPklhl
         PftYqvKnCAay9QNH5MlsYLTt0aQAiqM93ZAyQgaM248WnV/QalRTZ2GxsMgBoRZ71b
         maXN+d6qLzCJ0qbAc70koTand0GZrXycPzNq5nk4=
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190107105330.372621917@linuxfoundation.org>
 <3593abcb-3c20-1b76-bcd0-a76d53dfe4ba@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <048b081b-1287-6b48-4511-1621d0d9e5be@kernel.org>
Date:   Mon, 7 Jan 2019 15:38:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3593abcb-3c20-1b76-bcd0-a76d53dfe4ba@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 3:34 PM, shuah wrote:
> On 1/7/19 5:31 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.14.92 release.
>> There are 101 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc1.gz 
>>
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git 
>> linux-4.14.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> Compiled and booted on my test system. No dmesg regressions.
> 

These results are for patch-4.14.92-rc2

thanks,
-- Shuah

