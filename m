Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C98CC282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0AD20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548823210;
	bh=sWztnXumqLW5zBYIV/BtBLHZ3+PJFpMZmwmMo1enlEM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZOUeknde2fMDFsZ+3XAY6Zo36iig6tQe9uqMmDjCavlwrpKB0zZp7izPIcAjIE5EC
	 2DyX+JWUYh6xJzTsw2iDXptsA5jFPK3oQ6qLbjZwlDLDP9xLSC6ZpC8x5M0CdcdbsB
	 YC7tvh7lmUnihyJVJ0WHDYv82S6RvDIlxEPlFces=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfA3EkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfA3EkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:40:00 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4542087F;
        Wed, 30 Jan 2019 04:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548823200;
        bh=sWztnXumqLW5zBYIV/BtBLHZ3+PJFpMZmwmMo1enlEM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Nch66RjUoCmoSubb2+ZhiH1Ra9NJjtLgWHKGmtMLw2WAT2A8RYrn/BHbecgwL1MvU
         zYWIrh4D+vf9nt+plzQ5ZAAUGPHblDXkDgQXlHapkuNGfLIptJdr9a1uOMSQ2VyvBu
         oS5YDcsZmQSzGiZv5IW0NVLVWATQ0NDDEY1zng/s=
Subject: Re: [PATCH 4.19 000/103] 4.19.19-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190129113159.567154026@linuxfoundation.org>
 <20190129172848.GE27005@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <75d821de-ba62-54eb-c9ec-fd015cd2533d@kernel.org>
Date:   Tue, 29 Jan 2019 21:39:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190129172848.GE27005@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 10:28 AM, Greg Kroah-Hartman wrote:
> On Tue, Jan 29, 2019 at 12:34:37PM +0100, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.19.19 release.
>> There are 103 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu Jan 31 11:31:30 UTC 2019.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.19-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
>> and the diffstat can be found below.
> 
> -rc2 is out to fix a reported networking issue:
> 
>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.19-rc2.gz
> 
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
