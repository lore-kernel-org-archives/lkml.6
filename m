Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 862D4C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4B208DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCkm2iS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED4B208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964860AbeFNQtd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:49:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35416 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936054AbeFNQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:49:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so7179130wrn.2;
        Thu, 14 Jun 2018 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JO1h1Ave1vC08Sk2Yb4+9TS8w5WJO2xCrmWr505QqfQ=;
        b=rCkm2iS0Wx2RThbZEZtBxwicvMiZAWDndGCoNwJVBktaKpRqNOAUfvAg6TDddg/s45
         ramszufmuvohRpjDpW44Bm44zE2ofSU/3SZmqJc0RwwDm8Low9PHduDb5cN+PaNBAZRU
         lWJZ7j5lg4SVoxPJhAPL7zKiVJu+pzwQBxxMi8+TgpBeDw1HAateaAVSCXp3/g0mVJ/p
         Xivrb0YBT6gkSq+rB0muF9hSTYpB6XqlCVO1RP+GcXCPcTKDanXF+J7oKZ4xF3CRxPUi
         Nr4rv0Njs1dTZwUFHzdDbo1UL9wXajnRZA2ewplFwMOt1VGUmg9F2D2AGTQi0L+e/tCX
         TZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JO1h1Ave1vC08Sk2Yb4+9TS8w5WJO2xCrmWr505QqfQ=;
        b=LeVkQJhoGGx1v5Ti2y+fYukNH6HcPsrIWRnRQsKlv5yK0qinzQ8EzRmQtTRnVeXZqg
         ypCbz1P8N0V5od9z+bDDyF5U4Z2EbmGQIMz7ULWOIPIpP3f9RsLIgP/nRIGhUSeZZvB7
         60N5O+CxuS1t6dDpKlxU3/JRVIG9l63JDacbxE1iLs4GRy/qloaMn+pdIxvTjfEg0Bry
         vu5Tz2tWgZt4j6L1dBavOGUzCg98pTxrxBIKxSwW3+BSWh9aeHD//iScva36YVeHh5bV
         ToJggVJCddmcCt9Dfn617QzA1Y/gJrxiVKtrSGb/a00t80zudTKdy2ZEb6hvPzsKTH9R
         MJuA==
X-Gm-Message-State: APt69E0KpfBJ9rKm++Wfq2+u9t2fP9S0dUNRF5u8dMbf7FKrFI+B9yHG
        0gx2KdHmAKJDV87CmM7/IFY=
X-Google-Smtp-Source: ADUXVKJ0wsNlzVAzoQfruYtHrzd07OpptEVuiD+Ed+pBznSIvBClgQeoMPa3XJc7rVMR4PkaFC27QQ==
X-Received: by 2002:adf:c70e:: with SMTP id k14-v6mr2815937wrg.16.1528994970056;
        Thu, 14 Jun 2018 09:49:30 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id p196-v6sm7443742wmb.20.2018.06.14.09.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 09:49:29 -0700 (PDT)
Date:   Thu, 14 Jun 2018 09:49:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/30] 4.9.109-stable review
Message-ID: <20180614164927.GA19754@flashbox>
References: <20180614132600.255515394@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 04:04:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.109 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jun 16 13:25:48 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.109-rc1.gz
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
