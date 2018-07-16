Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF985ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AB2214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpZZkMFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AB2214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbeGPOXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:23:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37921 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbeGPOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:23:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so2261913wro.5;
        Mon, 16 Jul 2018 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vj7B/gTPydTDWiHS4sLv1sCO21f/oL1ZVxQAIEXCl+M=;
        b=HpZZkMFBHWv+kl1GUpsknObColU6TOXybZuWGqXIHYkiyOQA5nqCIULeRSrfauGNK/
         F7ZFRc4S8kxdQnUSGiJiufHNg/TvbzNe1vkqhV1vMGUHQ1XYfigreYBdwjsB5lZnZvg1
         OHy0ffA9/dhm3bxPi1Hhopa8bA2ISQgu1V6YVL/Ov/lA+3roy2B2mB5XfO4NrSkjZsjY
         Wm8mTRcjo4QzksM2aBktEmOylw79cQH5Gcx6cDYvKi357NvYWfiosT3DZTCQtmB9kiPs
         f+AMuQniItbFP59YAU6yo2vwkqAx9yFtYIBwipyjCVzl4bWlUaRHBScGKmC5WpKCTezP
         iaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vj7B/gTPydTDWiHS4sLv1sCO21f/oL1ZVxQAIEXCl+M=;
        b=gPXlXVK4UhcAFbvtZeJIq9LLs2vqSzDgvYPIr80ZEgdC5eWQRBY7HW6jpKW/tK2VNj
         60F9WHGFIPB7ELlQW8MPI+cafy5u8a/leRp1FjqB0r3Fi8ms552hhlfzIkZAMXiw7qD7
         nLAnDr4BcFCWAbg1ofgvwSmd1GEB5eGwMkJVT6qRHMvq9osLAqF+Ez7dLF20axacOZnu
         nT7QfQALBOl1dbaBDWd3bTczAgYgc331HBQtdc5DxBV9uzh+6/OfBqTPNdDBdUe5U9H3
         +BEICKZm7QmE64+k7f9eiRw6w2dXQatBfv3teYGj0NGg9ywiGQhmIRSFmWHNGR3R65s9
         TR1g==
X-Gm-Message-State: AOUpUlEO/pC0GjKpCbFWZ/k7nRvdukNVZGw5nSvvOQmX6jjPmcaAvzE/
        uvacp0LeZ39sHgfqyHN3+iPv26BfxOM=
X-Google-Smtp-Source: AAOMgpeBEyoWM6PJEsvF2b1AcIkungIjuMnbBBTM6upFSzCX7Aia9AjoGh0tNNZY1zzcmGcwgEmHbg==
X-Received: by 2002:a5d:4210:: with SMTP id n16-v6mr11553235wrq.55.1531749357953;
        Mon, 16 Jul 2018 06:55:57 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t70-v6sm11797498wme.7.2018.07.16.06.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:55:57 -0700 (PDT)
Date:   Mon, 16 Jul 2018 06:55:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/43] 4.4.141-stable review
Message-ID: <20180716135555.GB4433@flashbox>
References: <20180716073511.796555857@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:36:05AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.141 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 18 07:34:50 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.141-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No issues noticed in dmesg or general usage.

Thanks!
Nathan
