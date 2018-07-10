Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5D8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E51020C03
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmCWjsdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E51020C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeGJTJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:09:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35791 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbeGJTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:09:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so129219wmh.0;
        Tue, 10 Jul 2018 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZforgS3kWlrv/qzGh/kPg+qtHACpYmPnA8kXyPMbFMY=;
        b=BmCWjsdStCLGNJxss8mcXYo/tSYftC8UIvBKjNHakYNCfl2p3Kk4iIqDwAiYHdk93e
         MfYMO06jodjvw08D+lTqADJW4yDpfpLj30atwdlt5isFAXcP3ajIww2kw6pyHz+CX3S6
         7ztTEqwR+zIY/KxXUbkRpJvDnanEwhBgpvlQmvjRveAmsUKhfuPNSOScMlz7fmexyXqZ
         PbEQaFUslRhrcOBDrme2H+pLeX9JhGBUa00M5EcwhChaOp2X2XRvxIloSMs7+mB5040+
         Jx26UfsHcbDyFZJElykhLuOBamdoAO3CH4fk+kzgN2sBaSxRaASyid+D4dWt6H46d9Vw
         sCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZforgS3kWlrv/qzGh/kPg+qtHACpYmPnA8kXyPMbFMY=;
        b=Sxrji/9z8q+c6fP1TPo8Qj6WdkG18SxhBO3Y7xYtjxlABSIZP9zgFjAhl3rF4KfPs6
         difHW+YPok84ryyYGM25SuLKITf2ukCzzHmH80w6cnvKfKh4XoAyp8m8/iO4O39116Tz
         gjUg5+Ks+/VtzkUES1Wqj5BrqGaTj0h1UddHr/6CSzLfrTf9vMGeugP29ctmorWtCZfF
         0OK5jBqx4CSlgU+8k/wYBdeC+AWBT2FMx4PZGeKCclQ7gXqCFYwFTbAC9E9a7KtbbvoV
         qM4TAp+0U84V0fy9PbNB0yDlXzuuxFpliuZ2066IYrdHAyYkqn0ZTXbie24v6K8GTSaE
         WD+A==
X-Gm-Message-State: APt69E09NZIfGCXnqlu8kghBdla0f5/pqC2iA4ZseLPqjyHWBwhMhXU/
        T/TejVy6HHZ/b+qP8jYmf/w=
X-Google-Smtp-Source: AAOMgpeDz8TaNknnQaeWpVBlvvafC19RlQITE+7bMcbNdFNSjFMw4nXTd45Jn6Sg3BhFmk9q4zAMFQ==
X-Received: by 2002:a1c:6b90:: with SMTP id a16-v6mr14942644wmi.74.1531249773708;
        Tue, 10 Jul 2018 12:09:33 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 24-v6sm43894766wrz.94.2018.07.10.12.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 12:09:33 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:09:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/52] 4.9.112-stable review
Message-ID: <20180710190931.GB7871@flashbox>
References: <20180710182449.285532226@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:24:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.112 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 12 18:24:30 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.112-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed on my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
