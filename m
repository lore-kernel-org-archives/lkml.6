Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A83BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F86121992
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFOFl58c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F86121992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeHHAtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:49:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38923 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeHHAtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:49:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so685158wmq.4;
        Tue, 07 Aug 2018 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vALuH7lzVoY64kk88QUicFKMQR+m1+qLQJ56chFgtBY=;
        b=aFOFl58cswGGRSjHGQKk3OyywxnyW7FAw5nwlBrQCXfe0W5ejHmB2+WAJCrhIG6Twi
         3dC0/t/FzRqPX4Ao0BT9Kh0cE0wgebiYkLlDODJz8nBhlubFvwl0d9zEkqVOOdbviDCU
         Chv/+8rLYq+QnSpMIMKnCGxsdV+QYpzcBgwzMM19A2AkK0ROoC5CRb4UPuwjdnccbxSc
         RHN8aX3dY4+htaWFWIVz/Zlacx7BxxmbhROm02oioVtXbKWOf8dEW3BBGrssmWQVgMbP
         /bSxTKo6acgF92zVjk/bSPUNuB39CUwOcrM1DW8su1EjYZi9DKfyDvkRzkNEw0oSFkBK
         C3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vALuH7lzVoY64kk88QUicFKMQR+m1+qLQJ56chFgtBY=;
        b=EVymUxcnqtu/bkjuOUjqxzIMAW2h9FmDns37v5QHesksvxispr/Bfs1LFKwS+/RF4d
         NcW9uaPieD742KCwQFvAartv3Kb/MC8ZFa7rYShlsv3PGnCfG9yu6EPEORU6cgIOYKQP
         p0o3tCnI7mlZAnhuQfUTRNMlfOPcxjGIiPk7gL19hrE2WnYRDxIocc9wUlR/tUAaCUUN
         AhXb9zHQ0eqa8X9u5AyYpYFV6Bj3+jY6l1/QJ0AKi8CJc0Eol3aSmGiBARZ2jWKWVajh
         57yGZIb4yUECNzVwDIbMqh3NZ6eOa9ICG0DWhAjhj2hvLkifpad6+H5M8QJq6G7q55S7
         KwwQ==
X-Gm-Message-State: AOUpUlF1lcuutS9RswKmNMfex1M3Xq+9S9HMqYiYd5DF6jnXIgrnGfU0
        grgPqVh566K43urtP/Xhd78=
X-Google-Smtp-Source: AA+uWPyFO7+4wQARzlguTjzzZyBAfBlsW0Yui1cxEGcm5O+hehv8DuYPuKR54eHH4Q+QPu8ZBvketQ==
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr152597wmd.137.1533681186226;
        Tue, 07 Aug 2018 15:33:06 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h83-v6sm3871691wmf.46.2018.08.07.15.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 15:33:05 -0700 (PDT)
Date:   Tue, 7 Aug 2018 15:33:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/12] 4.4.147-stable review
Message-ID: <20180807223303.GB20628@flashbox>
References: <20180807172343.326201671@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172343.326201671@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:52:04PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.147 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug  9 17:23:34 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.147-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
