Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2E5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D816F208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2UaBokl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D816F208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeG0NnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:43:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39574 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbeG0NnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:43:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so5241787wmb.4;
        Fri, 27 Jul 2018 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJsjqD/4MUdHvwrPmlY4ZrsHpG3Up38xc0iYIZKPg9w=;
        b=I2UaBoklsiMLsCPoAv0/03yHgMXA1ADTOeARrCOAd4lsn/Yc8ETi0xShH5h3H8NQcj
         Y3QiuY8c+Tp+SqG9TCm8HCNiNfJ7ZF+62L/WEvI0c6SF/YjAOMiHe/DrOgwka13kQ86c
         5WzTASDJMA9VDAZMwwtrLavymVBFmDB2cj+C9AYMAokD856FjqsfYLmOasSPppOTxhK6
         hN4AdxUebnuEdAZGnZNAHQ5ZnfGJ7B74lnrUH+xbfyF+QTZbxSCCZUU8bLoDVl+2HaQ5
         cBHaQcoHDQ9qPv0IhcPjxDmhFAAofiqqkBfPFhuLSXVBQx3PjmHxWitF7V8tN7FAPdXG
         xEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJsjqD/4MUdHvwrPmlY4ZrsHpG3Up38xc0iYIZKPg9w=;
        b=Z3yRZGbag4gsNw+JqmrlZJlNUk+lAcA8UELEACgy6hygI/Q6GtgOofNF+sh5FS9mVG
         nBSam612Pp+ml6NkjXvbMmy2iMCyqhqO4FcghdqHGRnBqN1dz2SUm6PjoNnESCmZILAn
         USllffJf+nq2bf9JMWlnSSy6Tkt5cZOBhSLKRbYxnjmHeIn+mKMDv35MPvf+SjOdUAoT
         N/4y2cj67YAAjfpRit7rZDXgwAnj+97O+SFsx7SnXRZMffX+dDKH7x83kwYv6RzOF/Lf
         4DNvB1jaT5M4eQmbXrVmCAM2mwuq7ykbOqImJj+jILfl1bKkVOAKaR0ZOhtINu68SIWB
         UKsg==
X-Gm-Message-State: AOUpUlEG2Rt11YA1azdZuBh1tyZiLqZNJG1nth5ZgNw60+38RV4jf5EJ
        aEupsP0nblIbxeZ7AwGqWcQ=
X-Google-Smtp-Source: AAOMgpctFtoO8vUecO01IyBsxZs1pJMW38sGqVlrRMrcBHOtkITw/oaQaX4k+r51xix9wy8iy+w1rg==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr4034769wmy.81.1532694086206;
        Fri, 27 Jul 2018 05:21:26 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a14-v6sm3987424wmb.44.2018.07.27.05.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 05:21:25 -0700 (PDT)
Date:   Fri, 27 Jul 2018 05:21:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/27] 3.18.117-stable review
Message-ID: <20180727122123.GA2437@flashbox>
References: <20180727102649.049641021@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:26:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.117 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 10:26:38 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
