Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608C3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8642084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qugjfvp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8642084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbeGTOWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:22:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51947 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeGTOV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:21:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id h3-v6so9070667wmb.1;
        Fri, 20 Jul 2018 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KX1FlnJhfRwTh0fZhZdpipvQszw0nNm4ynHgYHhQI6g=;
        b=Qugjfvp13SN1qKxP3XYeLXkcsa/96F2VfFaJufqz0B3MaIsbtLP6Qezqbr6vG+DuII
         elm4ot3Tgo/pn2TdkxKgjerKs2RQiqIvVxiOBGWFIbPRjMUAxAuCDJfcoautXYU168F1
         jmrS5I/MDgbEKo2Pw1KZFrcuzlRJ4TSW3+YVoJ5JjeD343ypKQVFPypZx5ZWvH2oTfE1
         sR421bhRIJGs1TLc07D4jntCHq1gVCvdo9IyKCb6i6CWXr72ZU/SucGQx83D1j1Yhh5X
         +9Dsj9CQ4R+eqyEfU+atRu8nzGoL28t9A/8tV8KabWiKPPytpqpUO3q//aD7ZyV0/gRc
         C1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KX1FlnJhfRwTh0fZhZdpipvQszw0nNm4ynHgYHhQI6g=;
        b=airyWW8ViEPsLj5bCIQBist+9T+VX6rtHxno0nSroiBajCfPgm69SqtAN2+507pdlH
         cF8pb8c3ige7Q5XfbDsLThsQSFm2GiOldCn8rKBRE+SUX5q8SOJJ5VhC5qaByedXYcuF
         1ZuCXPGYz/k4YUJqy2HaiKVMNYygR6BJ7GtKX89VAE3ilKR0h/MXzDHLXp2SWZQOW+We
         3K/amf1dfVngWPFeVovTT7fq86S04Gt0PHWoShkBdyGge2S4queFKj745dgFxlrUAUkW
         F5XvvT67ZVWAUUT3+EUDaec0EsITJl1ejrsd0TllnZPLFh9XalC6WZYst8A+KcHtTxAc
         vwyw==
X-Gm-Message-State: AOUpUlEJiXj8Nz4RdvkjxsvUb8KFQZwVc7hW/runxbSJMtm5EFKcQYPZ
        AVP1nvm8XSlfl5VSH+hxG6I=
X-Google-Smtp-Source: AAOMgpfLszM2h9RWF04apiGP473RhXYBgItr9JUhs22Qg2fdyDGv+FhNVa6UwnqXsPoHPPHxGDeKZg==
X-Received: by 2002:a1c:7908:: with SMTP id l8-v6mr1506050wme.80.1532093619105;
        Fri, 20 Jul 2018 06:33:39 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w21-v6sm2152124wmw.29.2018.07.20.06.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 06:33:38 -0700 (PDT)
Date:   Fri, 20 Jul 2018 06:33:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/29] 3.18.116-stable review
Message-ID: <20180720133336.GA31668@flashbox>
References: <20180720115158.974693829@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:10:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.116 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 22 11:51:47 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.116-rc1.gz
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
