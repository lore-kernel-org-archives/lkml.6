Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 77163C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9F9208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+el4Y2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9F9208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936112AbeFNQ5y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:57:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32972 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936072AbeFNQ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:57:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so3839439wma.0;
        Thu, 14 Jun 2018 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FMkBVUVBK6Q0oAx453Nq7oKO/sfoULIFDGCtZn3uPJ8=;
        b=j+el4Y2cI3/D0sod2YHEC+zoh7mJCRGsFGW6BMegiDnAEu5tN1VgfoRrZuqGtUwfEW
         pL9LX+RvPxapzb2o0mgMP48G2HILXwA4YyJxvFOwUIEjg4yw6pwMK0ckekx+WhmyaYCS
         he5vvNPkSBLkVSgAA18M8hqeFqArFERzR1upPvqbmUhyUYNTcL6+/hInTkaL8XaCM4V6
         gNjWVI7Zws2cuVJGm5p2GTQCC/CCCtAgTYfU6WevCi5AguTYLsGWn1+8YbQYoh5XgXrc
         tvk0Rd1pL5r4VabqMic/H6u/bGnFAZYoC74qkJjDVMLcZ7XctljHmkFGfsFXlZh3fQcn
         aXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FMkBVUVBK6Q0oAx453Nq7oKO/sfoULIFDGCtZn3uPJ8=;
        b=riuCbs5nWdCGCnGzRAFLZ6JGfEgoIij8ZRvCvLz1VciGhUQNRzkFCHvWiYxccBll0l
         fStG5ZhhUdJUdeniMkP+YhuDfPqcCRqd8V7rIxEtPDF6mp2qzDT8VV/h2zb7BeQmu09W
         TQRqdY6GLUq3QiK+D6TkhmXevg+fkHo5kn7qDNt48rcIsFgqsjqvHgHZsx0DCirBn3wX
         jI7v/uOQJeU4BnosEiSWXIsFCR7LLDZSgv+VV8jgbg9HPP+y9l6Kbx5zD5hWWRcN6z/3
         tx1q3AnMSBVkJ6PtYs/K24RR1SoZgGN3hxTQQzXmm5LLdVMHh4BcjkhNE4dybscFH/vb
         nsqQ==
X-Gm-Message-State: APt69E0CjIJqG7ld3Qhe8QFe8M2Krl7y7MieXWagdrHVCEE+cVdevTda
        0Ts6VHFQxLpTwSzpuBBw1II=
X-Google-Smtp-Source: ADUXVKL6axu08+E+G4XE6XT3IkjuMqpOm/t5hINP0mn1F1KIbeUcq1EELqDrTlh2G1k5BKcMWSD9Kw==
X-Received: by 2002:a1c:96d3:: with SMTP id y202-v6mr2460807wmd.76.1528995469373;
        Thu, 14 Jun 2018 09:57:49 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id m16-v6sm4027890wro.91.2018.06.14.09.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 09:57:48 -0700 (PDT)
Date:   Thu, 14 Jun 2018 09:57:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/24] 4.4.138-stable review
Message-ID: <20180614165745.GB19754@flashbox>
References: <20180614132724.483802160@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 04:04:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.138 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jun 16 13:27:15 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.138-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL and
OnePlus 5.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
