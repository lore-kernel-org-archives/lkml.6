Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn9EwnLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE96D60263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeFFN2o (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:28:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40500 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeFFN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:28:42 -0400
X-Google-Smtp-Source: ADUXVKJX2hY3HFxucNqSwaBJA3aHGzji23lV+HPo0BENsQWBc7r88MWtq9MlZu3khrGnedweSvQGBQ==
Subject: Re: [PATCH 4.4 00/37] 4.4.136-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180605170108.884872354@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <965820e9-cf8a-a1f0-e23d-0b2ba910d613@roeck-us.net>
Date: Wed, 6 Jun 2018 06:28:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 10:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.136 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun  7 17:00:49 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 146 fail: 2
Failed builds:
	sparc64:allmodconfig
	sparc64:allnoconfig
Qemu test results:
	total: 128 pass: 124 fail: 4
Failed tests:
	sparc64:sun4u:smp:sparc64_defconfig
	sparc64:sun4v:smp:sparc64_defconfig
	sparc64:sun4u:nosmp:sparc64_defconfig
	sparc64:sun4v:nosmp:sparc64_defconfig

Failure caused by 'sparc64: Add __multi3 for gcc 7.x and later'. Please drop it
as well as 'sparc64: Don't clibber fixed registers in __multi4.'. gcc 7/8 support
for sparc in v4.4 will need more work. Sorry for the mess-up.

Guenter
