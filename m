Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21576C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79C82172C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxEXA1j2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79C82172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeI1BUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:20:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37550 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeI1BUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:20:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so3778238wrr.4;
        Thu, 27 Sep 2018 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aA4soI/Z/0ZIeABiPMcgks4pqnEyF9/ABVmVA9GogZ0=;
        b=TxEXA1j2HnDOvDGw7N5zbn/XL+Gs4SSeYRk2PcUCv2bKKDJjyBRbH+Pi2c+ZXDNsYA
         w+8aYiGoUCmGUZrWJYb8lwE9WWK4G4/kIAVEA2XjTPHqNseKfuxVH0QdeCd6wFvKr7lp
         4rlGtMK+7+OB9QFf+EWMIfyAGkvHWtyvinC2QQY0zM/zQ53/bDA+NE2wV0SyvqPyeXH+
         3KyVXX30wssRWg+Y7V/Wm2wWRKKvxFvv95qw6cAENNJ4TfSs9u5MEtD/j/atEG8UI7zq
         zY4XUZObFn4iVOyn6nKG1qvpq20iAPFF/GFB71TU6MKffd8Qso0jELeHFNndcJx4ReXf
         LQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aA4soI/Z/0ZIeABiPMcgks4pqnEyF9/ABVmVA9GogZ0=;
        b=fuBHvboW9VZDcjWKN+qrN/hEiUUS3gPgkz/As/PruyxS3/4D5TI9B28OTIdWOUpTk/
         UTE7ho/iPKX/AkJwwyXYVN86cVNBm9g+qjs+rBltZoM7jdy7KAAZRZA+UHp1PajNl6EA
         mrOchR5x6Uc6SUy9XA4j7xcbmZvGuxelcJyX90geZCzvXZIrekaDtaI49rFLoF28Qw3X
         RnLGUJlg3sL1g51IssdViSKwhddcg++vGM3vIS0atp/oE69MY/d3opG7KeQuZxLGV1s9
         vdqYatRmDZycaWfxFfe8Co8CUSP93fJAe6bQnntckDS0yBxJHpzbwWHk/PAVEmFHT2+3
         4MbA==
X-Gm-Message-State: ABuFfohjRiCQYyLQ3F5xmIycDHro1iBGJxIODLubIAoULE4gohd34Yyf
        LPDun6vLruHNZSFi1rc0/W8=
X-Google-Smtp-Source: ACcGV61QFyNxEmmRIhOc2xUfjccQsxAfnUH+mWnzZVWrDzSzHyO9amDY08zbSuA3ChLPyldLnOCaKA==
X-Received: by 2002:adf:c3cd:: with SMTP id d13-v6mr10347678wrg.68.1538074854726;
        Thu, 27 Sep 2018 12:00:54 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d6-v6sm3465574wmd.2.2018.09.27.12.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 12:00:54 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:00:52 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/64] 4.14.73-stable review
Message-ID: <20180927190052.GC18188@flashbox>
References: <20180927090249.801943776@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:03:17AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.73 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:02:21 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.73-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Raspberry Pi.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
