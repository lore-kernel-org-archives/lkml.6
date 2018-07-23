Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91753ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A51D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeQC9k6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A51D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbeGWQNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:13:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38838 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbeGWQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:13:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so1084281wro.5;
        Mon, 23 Jul 2018 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+orxmb8DHxkqFPbOLEF1q7ijKbEWKk6WGJmsMfWj6Y=;
        b=ZeQC9k6zN7p7HWhzFrIxHIGADFkgBG/HFysEhbWp9C9dpkIUhde/dUec5qxaTm3Pbq
         RCELfYW8ct3RVq/ZVbfq2CCdm0vw9jBpc+mKtLsKHOjFgyF7ePrgLpMlw0VxhEPqzevN
         F1XFKS07cGJoSTDy24STj6L5tt85cdE9uWiuRaCrUxEJ4O3d+Je+ZzfHXhI2+esOWXdp
         RAk+3w5qc0g+bojDZWSQP4L0/dLi5c0K4QzKxXtTVDMg3jIGgHN8RU5fAfBb3jSsU4Oq
         kYQ9PVOeQWhxkPyTVkVcm6LqVLWCJkxSWqOs3D847hk2ak4RUimsMFabYC5lwRzQgJDV
         Ke2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+orxmb8DHxkqFPbOLEF1q7ijKbEWKk6WGJmsMfWj6Y=;
        b=O3UZQ1oCnVh8oUHpd+GcXqRjeMfYRmqPiEXOBKv4BzY+ZSgGI1X251AY0YNF56S/Ol
         +TsecVwAwxcezWa77yK9A4OSL0NPpR9vGWsWbJMQuR5CxFYHixmNURsKKDf+ZbfUzx0E
         6AYyXRqvc2kXic6E0RpzvlCyClLyKYzC5Chl5yELoOhQ8sfH291b8WkHBUP1hah4h94X
         qu+xNLyFqCN/LBry2fIyI8hSd0AouCipg7/+77VlyQdxi0uLUeEEpiZZJUuPDWya73qa
         /zQJ6/rYXtHVywaAq0F8PIKlhI7rpQS2BL9k1Me8gKoXcrS4tz2H0hjrJS4HPM64Y/ED
         OXWg==
X-Gm-Message-State: AOUpUlGZ5kMIHwMV5y41kcskb6Gc6o0fUlIi3uQvPtV0u1o/6LBod6+q
        oHcM8iUWz/Dtie9CBrPLBNw=
X-Google-Smtp-Source: AAOMgpfmflPjni0677pvjGNwZYho00a59sGNR950A8ZqeGr7NjOtTtFrxRevB3N7rGEH2kd5KedDpg==
X-Received: by 2002:adf:e491:: with SMTP id i17-v6mr9261058wrm.145.1532358731448;
        Mon, 23 Jul 2018 08:12:11 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id m207-v6sm2834293wma.31.2018.07.23.08.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 08:12:10 -0700 (PDT)
Date:   Mon, 23 Jul 2018 08:12:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/28] 4.9.115-stable review
Message-ID: <20180723151209.GB31725@flashbox>
References: <20180723122425.241418073@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723122425.241418073@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:25:00PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.115 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 25 12:24:13 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.115-rc1.gz
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
