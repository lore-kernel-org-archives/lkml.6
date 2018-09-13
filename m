Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C6C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AD220866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5ix0rLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AD220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeINASt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:18:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44597 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeINASs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:18:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so7602424wro.11;
        Thu, 13 Sep 2018 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1E2/fWe77plVCRfNnsl/ivtQZOzrCACKw13M+9MMjk=;
        b=b5ix0rLMB9ExSDplOu29tspuBzPC0Qcrw1qCouh0RvXXytE9gVY0wuU1OJT0eqZZ7Q
         KGlQNvknyKEeojaUg/AOHw5s4qGS2YSxvLs6VqZbStQk3763wet6vfku+5Ln5B6MwFnT
         7bIdcGoQ0XP9ClHg4S7looHTq0PGTG+A5TUpFmW+zKQ3djcgLMQb2IjazK2oVCmcJ5ru
         3fVHAxuUIVFiYDseoIZjNKsE7wUc1YmRGk9At9tl3yPh3bpJYq2XuDKnrOKRtCVjXRSj
         pV3QDsQIipxwGT+HZYjBD1IWUfua4C16Q63519wZbjnniq1zlxBr1tTMSLPBLILyrgtq
         U+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1E2/fWe77plVCRfNnsl/ivtQZOzrCACKw13M+9MMjk=;
        b=g2i9l73GSvHTSxaWdf7P+ILvDZBdKB2nVdqCsAZKk2NWBsm6r5oPv1AheTPxBB0pH0
         sqfOqxTw7SI1JSQJ4zKRJLbgj4ubx6WiZqe5VMnY7yLSEPvKIfAC+t6ovwfDLYymxw/m
         YkOpmjraTQ1YPfpI5vZsI/PbiXqmqORKybPXaWcyDhE+szAabds0n2a0cHZzaNwCRZtb
         QNopazf2JIoIgW3KYaJ8jxj0Z0elz9vlUBJojQrn9Sl4PHnD6xT/TxZ9uO/K2WJZZUI4
         wRbPwobtoMiBhxZ7nrrr8AKOy9ib0t83borIOV6P7GoO2/I3dv+8CIwOL4qlDGGoGDNT
         xBmA==
X-Gm-Message-State: APzg51AGkfUl8lXUG0Jtttx8iDBC8AMdyXh/NoOVFWmJZuMvqsCs8bnZ
        XbSMA+KHRlEmtuTTM6sPQsc=
X-Google-Smtp-Source: ANB0VdbXUXq7qMSxW1eumJ2Hcoy/yDPddBw+OcN9fKUcxQjYcjVPPTAFeSin1dK6UaBwVT/Bu8Skjg==
X-Received: by 2002:adf:fa4d:: with SMTP id y13-v6mr7194649wrr.155.1536865678486;
        Thu, 13 Sep 2018 12:07:58 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f18-v6sm5531610wrw.32.2018.09.13.12.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 12:07:23 -0700 (PDT)
Date:   Thu, 13 Sep 2018 12:07:05 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/60] 4.4.156-stable review
Message-ID: <20180913190705.GA22242@flashbox>
References: <20180913131745.261413581@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:30:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.156 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 15 13:17:29 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.156-rc1.gz
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
