Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F97C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8E12596F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaT3eQjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8E12596F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeGATjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 15:39:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46627 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeGATjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 15:39:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id s11-v6so4187799wra.13;
        Sun, 01 Jul 2018 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ruKKpHxGMI/8gSpRSvjKxMx94jjWErPGe6EhMwypW6s=;
        b=EaT3eQjtSgQFHjuS3NZ/3NygxGzRYtVXDFzN4wjEnZs45dwPp1NJjCSMRQp3utx0ZI
         TAmR6D7SJVo1UkCnSVI1Qu+hBm/6wF7MV8LD1Ftp9feoadQJNQIqnP/2DjBQdzbXH1nM
         dNI5bEu6wGe1aOiR++1Wd2M0RloQvf7728p8IwPventiXQ0/vwUMfrfiO0L1ij+7fGoQ
         KBilgzxZ8oohXhfzewe+vvo0pq62MN0z9iUaxkBU/DQzPhgXkkHUkM7Kk8Lg/RtpO139
         FOoCQ8EI47zKTiKTot84EjmgqmaZiEt+nJFV7wVqmzL3BimRidFTC+QB8Mfp+l95Gbyb
         5mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruKKpHxGMI/8gSpRSvjKxMx94jjWErPGe6EhMwypW6s=;
        b=Y+bAozOYJ+gVKSZ/ubsIOSdvirnsUtUmzN4NR7leeZ3AcgIF8DaEfS6nr0CAQRlzHC
         Pb6pIuUHA5z/Lq/HgwAv60GLuD5KqaXKjYFvBhshIr4qX10jc7NAh4EOnMkjUaa5LHbD
         qtn9JyMePDNYcDd56b6x9OcArBXio7rHv3Rll9MsUJN+Ij7+SV+IVdv4O05SqQ0cctNb
         KI6PPDezA/YWVrG+9P8h9MadiFZNRF8EN/Zdel1FLTpRcnB30CZ/2fMS9lL05JlnQqGf
         SolVGAC8vigbWsUMUTi0yuuPnYdGOOBGpAd2Vy0qH3dMA4bI/mA9WFynNVDhVCtG/WqH
         G/2g==
X-Gm-Message-State: APt69E0aah2DnjhBne9cOc2F2EOs3TfdUwIUpOb3LRDtRUSa6seMirvC
        m6AEXlHOs2bExqmQYYDUSE0=
X-Google-Smtp-Source: AAOMgpfZvuQOVQ7wKuamCE6koa+qBYldKnHm9V2+akkq1k5o4SzxZ8hGmFnYT5eylEdRm0l10IKgqw==
X-Received: by 2002:adf:9186:: with SMTP id 6-v6mr7866233wri.51.1530473961081;
        Sun, 01 Jul 2018 12:39:21 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v67-v6sm2829320wme.8.2018.07.01.12.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 12:39:20 -0700 (PDT)
Date:   Sun, 1 Jul 2018 12:39:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/101] 4.9.111-stable review
Message-ID: <20180701193934.GC14489@flashbox>
References: <20180701160757.138608453@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 06:20:46PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.111 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Jul  3 16:07:40 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.111-rc1.gz
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

Thanks,
Nathan
