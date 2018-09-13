Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B2CC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B19B2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vT7H+NHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B19B2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeINAVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:21:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42497 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbeINAVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:21:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so7619000wrr.9;
        Thu, 13 Sep 2018 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDCYJtX/zksqPe3mHmWKy5Wj8M7yBG67g1ioNaml7Ss=;
        b=vT7H+NHXcRe7C8BqoCYugElGGLDv6biRPJyQYKDk8Eu25ORc33qvvsOtY3//tYQ3Ci
         pnGEoFnFzvS6PJ3NZo9Ns89i9dorgboPo8aVzsrFEhT7IMJIBbQzPfHU4eDncPFTRHqu
         KmPJOvHU7/vaSfo5lUt+wYy0lN73uGQg/jl2Z7LIi5JCNB0SH4TTF+CT0R7OXPXuXiEc
         X4iImdGxmvSYuQWQc62xmYc2hcqFXFNkhPdhglFXK+bCncv/DbQym1V3op9uxtH3u6ci
         Il7dltrJpQuSMHI9Tc0vNOxTVGYgzgrAdKJZMNsLuBDgeJmIW2tjfAAU20kX2MO8+jFV
         h6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDCYJtX/zksqPe3mHmWKy5Wj8M7yBG67g1ioNaml7Ss=;
        b=aVAC5hs/VuLali+h6MLwUpJQ2zTytC9ZAQujfS6mPWgz3vO3e5KOX9wec5BxPs180+
         MidGxenHT1wAMk8/BXGYFcCQN4QyYbkPQY8EyBKI3LHEpqDRVqqicvHFxWr9T1t25Zs9
         Tc+3w9llP509XW51UNE/zPpe9aWvQ1oIdyLUDin2fpUxl8UlnAdM6lzLdVzvXfkwsGmo
         ivL3f+y97e2ll793LYGGaQKMgvMMET/1PyMegAzVKYGQRdtjHkbQfQ8g1QRow7JjZJow
         TkfuO3BH07IXChyEJjni/wsXbJyxLCVXw3IvC/vqgNuuf+1jBML6tfvKInuJEhjP66Qb
         jw3Q==
X-Gm-Message-State: APzg51DUO4EYOC+3bCoVt0Zy8mwQ3XLU5zY05MOvh4CSqINEvv8XawTg
        l7ANZeepeL6enqCrcG/VQr4=
X-Google-Smtp-Source: ANB0VdZ7MNppUZgWlY44i5sRLAhvE5rQVlSCIr0xUgfGiz7igPtIx997T4bC0mAClIST0G2YSjtPwg==
X-Received: by 2002:a1c:19c2:: with SMTP id 185-v6mr6121526wmz.79.1536865829358;
        Thu, 13 Sep 2018 12:10:29 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g7-v6sm4497558wrw.30.2018.09.13.12.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 12:10:28 -0700 (PDT)
Date:   Thu, 13 Sep 2018 12:10:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/115] 4.14.70-stable review
Message-ID: <20180913191026.GB30873@flashbox>
References: <20180913131823.327472833@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:30:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.70 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 15 13:17:48 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.70-rc1.gz
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
