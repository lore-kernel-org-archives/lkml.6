Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C3C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6730F2145C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoZ5TmNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6730F2145C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeGATih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 15:38:37 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33314 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeGATif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 15:38:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id k7-v6so9934955wrq.0;
        Sun, 01 Jul 2018 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IP+kMCbrzhKxPsyGPMYX3K3p2UHQ57yXkqhCI1d481g=;
        b=JoZ5TmNIMvQcHl/EMflIpJS8b9f9T1LV6mRBqQy2n+bzo6TjtFzEsRLMT3OfM+kCgj
         ibvu0NTVs0BMHAZS/UBEN3Yc45e+Lufo5XHaMrtswrFP5gJECEbiMp8fhrQ8E1wUl77Q
         VBiTQUqmgzNpGbPSw0ZGOAS3j9ZdfhohJzV+8rxeJ3VQh1Diey4eqUbQFdEnuZd4RSKl
         s7KV9nuxNC0mr9hJfA3kZ/uR4EMjmQ68YbO2AWuhr2mDFTyfKLZWu1HF4+3B7s0U9GMx
         SKGYlyMucl+REWXhxJwn9HOeJi7qc+9cYSPwAUBnfHpZhbv/cQizPNrcBjGcZIQKq5h9
         gf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IP+kMCbrzhKxPsyGPMYX3K3p2UHQ57yXkqhCI1d481g=;
        b=uBq0p3nQIf3W8ra4ge5KtLK0IbUCHXF+Yxlnhl9evTM1Vdy+dWHmYhb5BS9SK5hSGq
         dIQrFM6JH8yiMA8fHd/TWhHG8x5eoDzUfa+jFMB1gR+CW0mEbN1fR9jdPwgzoJELXPx1
         3NaOAQVvj4cNct9NlA9jd5f5F/YqmSzh3+F5yARPvdb2eVosGQfI+3U8ecmIXufVs3W2
         OOzVLcnhdu/xCdYR2APhaEdLDm17AesRpzDSK71oR61uGUVad7wv5uDtgVq6ymdcPtO3
         tHTtVcWIsZ9LQnsXSERj46LCnX7ARSGloSAoaNSdqu/CqAm8igPII6DoLb5yFBchO93w
         osXA==
X-Gm-Message-State: APt69E3Ck0+UC5ssVJD/62cyCjTwNSPt+Ds7TI+LEwrzzkYLyaNZ43Hx
        3gdd5o5D5/rcLDi1JLaYTJI=
X-Google-Smtp-Source: AAOMgpcaJLA0IeX7nT3KyN+/nNPlfGr+oyI8bpQaU1F1dSM2CRPJ3b701xDs3xIMKsF7+f6LpTYwRQ==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr7057213wre.29.1530473914360;
        Sun, 01 Jul 2018 12:38:34 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s12-v6sm5197589wmc.2.2018.07.01.12.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 12:38:33 -0700 (PDT)
Date:   Sun, 1 Jul 2018 12:38:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/105] 4.4.139-stable review
Message-ID: <20180701193847.GB14489@flashbox>
References: <20180701153149.382300170@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 06:01:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.139 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Jul  3 15:31:30 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.139-rc1.gz
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

Thanks,
Nathan
