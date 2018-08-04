Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5143C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67832217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSf8NAbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67832217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeHDLaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:30:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54487 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeHDLaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:30:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so8715093wmb.4;
        Sat, 04 Aug 2018 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lNxNa8DfUgbGYzDqxw7LGxHozbQ7S3Aax7LE+mBXtVw=;
        b=gSf8NAbW/yam05G9IfYRsp1+4SChW8gH5ZFNWYMWEaPOuWjvlcen/0mPkxET6/j0JQ
         5IpdQR6239M8TtbH6TdRjMi46Fd7djcOWHh/314gk4/4gH+b0/Sye9n4PXmIsIp2ri/e
         C1dUchKO89ckxNADvsdqfE6+5oK1EB2LlQthJhPF1lYNbwYw+4KcsGsj3tWGzB/CiYT3
         MAcZdO2iAPqz4iC4Ql8POCm3XCiuTgcZ6SUxy/0MjeqBQ8UnVhez4bQ2VvCFmtHhwDVf
         X4Us+R+6b4u41W0Um45jrWy7h72p5JxYqhS1WR6E45AVZDnBr2QYt7XSkjC4zx2MfNUy
         bYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lNxNa8DfUgbGYzDqxw7LGxHozbQ7S3Aax7LE+mBXtVw=;
        b=buUl378LNhi+MIVk11k3lRRC71ryubh+G5RI5a7Uz5MzKmRl4B7msoR3jU4vePH63k
         ucbDVKmhh+iumWaTVgQk9GRinqB56RPGpSEyh+AEfcGIK9CioxgbFpqa+rpGLYOuCXRl
         4qANPlok3A4aMzp+t5254e1gu4y2m4xWaFtvQPmMXcBGWZ4tsSNQ+HTJ5JjMLt6k1lOp
         ZrU5Py5/WNw4uGreQkI1NknPiha0LlOpBVK2sOASWNKu2ncO1G0qmx/tnNbHf40nYS1j
         zQAQU4keXXyME9OSBLwCgJvVmawt20PphkhRGkxu+FBiSeSmYPWI16snHhvgUzFD7w8P
         2cQA==
X-Gm-Message-State: AOUpUlFE+9kBN/4Te8ylcXoPmwKH4VvDKVKApKA+sjH86DR3s3P1enCA
        gdvapcoIhKxDZDzBnB1nxFs=
X-Google-Smtp-Source: AAOMgpftKa2/+AQ0Nxl1OvunNK9pSRIt3We2oAGWmeZAwWATxRlOslQif91Ca55jY/Vj22orat6vEg==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr6726309wma.85.1533375002393;
        Sat, 04 Aug 2018 02:30:02 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v5-v6sm8924792wrp.87.2018.08.04.02.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 02:30:01 -0700 (PDT)
Date:   Sat, 4 Aug 2018 02:30:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/32] 4.9.118-stable review
Message-ID: <20180804093000.GB27721@flashbox>
References: <20180804082649.908295462@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 11:00:50AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.118 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Aug  6 08:26:35 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No issues noticed in dmesg or general usage.

Thanks!
Nathan
