Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C6C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6ED258DE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGHkSGpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6ED258DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeGATg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 15:36:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55205 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbeGATgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 15:36:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so6842710wmf.4;
        Sun, 01 Jul 2018 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ty+CZE1akDuU5ael49rtLDxXWapM8e9n2mizCV8a0v8=;
        b=TGHkSGpFb1b4YhQfOJu10tNGhiuMDE4hbek/tki7aVAIClL17W0K4N6puoY2bhXIhR
         fFha+gmqdOeJEIvX2bBwAYvhk5QudeOnjjZXet6u/ciaSVg25NcVcOVjHQVMMvqai4K+
         YAkp63JYhxCZbmaNPqE38ZU6ucqMehAlW9DWXHyv3Mrf1bB4Of1ZAOU08bE5x87p42d5
         tnOzHmVvGgvxJcV9HlR0gc4EdaapUyUG+HlKnVMiOlFBi0W6zCd35qt1r05TirCCN/Bx
         pp6LxPVa0UWvQ6soGADGMYDTTynqM2ksFQ8D/OiwzogeBRZZW0MfHuAbbcDojgmKS0ub
         iz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ty+CZE1akDuU5ael49rtLDxXWapM8e9n2mizCV8a0v8=;
        b=sXpO1wJO0ryIqSNQhcoofMtMquqZ1th/HP7oFE+P1yHmR8Lizc+v6kbX4Q0jHhclPu
         mo/FMJoH1fbKqb3R805B8ty9zW0tqedQZ+OzQHf4/AnrqQBnQ+iy62rH5prll4X8iT41
         v63Q+kLQd26OnxwtlAyeBkU2/1ZR8AGWmvPj7hz12xxAGkjyp4zkpznCx03EKu522t0X
         RrgDh9OMQYdBSIbgt3RXXd32M7y8YbKDAZdTEjMfzOxIxp8qRM4lZVNy9RQbFRkHAVX1
         ZW6tSEuTdKjZdWe+1ILFeUO7VObaAOf1WTog0XmFNeWAQ7MGeGZbsv5mbA44+8JeoxM8
         NTRw==
X-Gm-Message-State: APt69E1ymshnHO7q6hZIRR8RJ3LC3ZkFDv+0hWZcvwLsw35MWRCcg78l
        1r6fwa9qIup5GRJYreuZODzUCEKD6VY=
X-Google-Smtp-Source: AAOMgpe/pey602ADmQRAvWjg1pcxbdYw51ps3dFMbtxFJiXNzL7Y83EflT8RILTGaotQz3nIvpt3Vw==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr6108476wmc.30.1530473814145;
        Sun, 01 Jul 2018 12:36:54 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j7-v6sm8583268wrn.96.2018.07.01.12.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 12:36:53 -0700 (PDT)
Date:   Sun, 1 Jul 2018 12:37:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/85] 3.18.114-stable review
Message-ID: <20180701193707.GA14489@flashbox>
References: <20180701153122.365061142@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 06:01:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.114 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Jul  3 15:31:04 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.114-rc1.gz
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

Thanks,
Nathan
