Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64668C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A9F21992
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG4d3SMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A9F21992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHHAtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:49:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36056 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeHHAtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:49:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so707542wmc.1;
        Tue, 07 Aug 2018 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ugon5rp7ghxLY5UpjAL8+DfvBhd+ayxEpUX1SdBS69g=;
        b=VG4d3SMXdhW8s2tfthcJEq7z4MkSsyGg5pZJkuUI9oSLNW/kDvuzn1yGcEzTJWhHwy
         +XWmVKs8aAb39Nk4uo9Amew1v41jNmWimpIh/8F53kvskgi72iVKKpg8Ma86XZ/KyF6K
         KtHAoUjwKasdikiK87z7Q5FZMSNMdUZIw2ujrJzCTDJ1h4vfdN6fD4s90xXHkTONDeqy
         /tZBIZLsSDJhO61x7T2eTAuGypA3dc7REoVzErxps5qKSILvLxJI4EphEc2utochWL7o
         ZYO7XmhqdbgD9DEa6TUHxORCbrCTsHnN3QqLNYLbDKe+wh+v7r7mdwOVfA4/65BMVgcV
         xXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ugon5rp7ghxLY5UpjAL8+DfvBhd+ayxEpUX1SdBS69g=;
        b=ubHs9h1V4xlBWC7Em/LcwXdhhchTWhk0592SKFRkW1hEerekXhVipCKu1fsGJIdBpy
         LgPua3WbGkEn8UY+oLgJK5BjYrf1vhD9cei5GYkiJdExFRsIj0eadNFfmJ+Qg2HaDjnM
         Pka0WroJ+dolGHzUZpqyaxuwAnq9+b9wBxJr88auQDDNuJedvFX1MpNF4cWHr78ehf/l
         PvLt2S0WJz9tr2rINVIoqFcLCzwwDuF1CFylumPD7KB737G5FvlWFtzQc7dTjNhT4jGK
         LEdgjHx56NnHoearC1uOQFKBn7RNDI+9Lt9fIGHbaC3FJwL2ZNaH2lNmPyWdoKy3rmcK
         bMQQ==
X-Gm-Message-State: AOUpUlH/tnQLfRi/8/hr60N4qg6D2ggLY2eHyh3JU5RVxkeM1aXpZWCu
        FYltNdp7RRDjV3lAsaIjVFthU8l2Bjg=
X-Google-Smtp-Source: AA+uWPxWyiEqwUdtoMJrrJIwfvUng+z8vhm1MnGmbUdqDZlPV6l3YNmtcR5uFeD5KVSqMR4cmZMnTg==
X-Received: by 2002:a1c:3351:: with SMTP id z78-v6mr166152wmz.23.1533681162695;
        Tue, 07 Aug 2018 15:32:42 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id m2-v6sm3252043wrw.76.2018.08.07.15.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 15:32:41 -0700 (PDT)
Date:   Tue, 7 Aug 2018 15:32:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/17] 4.9.119-stable review
Message-ID: <20180807223240.GA20628@flashbox>
References: <20180807172342.071526922@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:51:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.119 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug  9 17:23:30 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
