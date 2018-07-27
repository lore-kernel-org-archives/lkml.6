Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE64AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF829208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkjXUTvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF829208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeG0NoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:44:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40460 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeG0NoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:44:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so5300168wma.5;
        Fri, 27 Jul 2018 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U1nlKN3qfwGZfuhEtOXOt5roua1a7R/hEymTy+dSlcc=;
        b=TkjXUTvpTReKCE1qyZ17HDUGg7sAi+w/Rb0zWDvZKriXOjamMDhNlhuWXfIho2YIzW
         jwkXvizDDC0eIbrtS6GcvkML73U3LjU4BP1HBOMto5b4so/8QH5HMpS02KfA5YrjrBw4
         nQOHMgATgB1YbP1Mp0xanuWeNdayEn0lGtdKQu1tX1uaO7s5dIRkEVvHYVIeIITye+3U
         Sm6LW9aNb0UQP4Cpd68anAs5mpMy8uMI5BNFCARmIwa8GPnp8HtytqzVzR/m1wkBmNaX
         e9y6POGUfHeDw8vFedRSI2flPo+OwlrhNx7yDXondFHg6neT+O4HDgmF2eRPI/1Bac2Z
         6/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U1nlKN3qfwGZfuhEtOXOt5roua1a7R/hEymTy+dSlcc=;
        b=JeChp4jcLJncidemcKYLKFIeFzFNVSTt+LjUF2DO8fWM7G7ZkGUt36V4p1ABE+HS1N
         Yaeq9VW1u3SsYN8Phzj7QxbVu1UCttBUFks2s8vc5BIEuZOwv54Qq7mS657c4i//SJbA
         dN+6K/ugSLNvPGvHhiLsM3CvLk9aS0IOHdZ0lGtrfbQmdbUiL4sx5ULnH5/4TZjjWPRF
         JxqFqXz1cSduzgPk4keFCLofkpIGibrhJ4U4K0QRsj/CQJvSSF8oMcG4ae1kXdOE5Ix8
         OvgyhRRW/ieR4RTXY1SLK2rhRlB4geCnnyx5soLRsab2gMgTk+dtUM++cc3rGHY+WWi2
         Sv2g==
X-Gm-Message-State: AOUpUlFWZMaeMeFtvY2mcg5H7ofYgbUbWNZxHc/0DUwdDzx3YvlRCe1x
        TWdEyWwTiAEShNtrG1moKgI=
X-Google-Smtp-Source: AAOMgpcJURTcQ69gSPBrQi4Mh1Ajl0v6bcUtHkPJVEktmigEBY9JO7rgLe+3vYv77bUFPSlzE94New==
X-Received: by 2002:a1c:8a0f:: with SMTP id m15-v6mr4217801wmd.33.1532694157198;
        Fri, 27 Jul 2018 05:22:37 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c129-v6sm7653715wmh.2.2018.07.27.05.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 05:22:36 -0700 (PDT)
Date:   Fri, 27 Jul 2018 05:22:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/23] 4.4.145-stable review
Message-ID: <20180727122234.GC2437@flashbox>
References: <20180727100845.054377089@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:09:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.145 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 10:08:37 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.145-rc1.gz
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
