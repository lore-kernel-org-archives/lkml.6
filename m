Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B8E2172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcHpeQ90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B8E2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeI1BSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:18:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38830 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeI1BSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:18:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so3777778wrw.5;
        Thu, 27 Sep 2018 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qV4b25+pccC5PYRTdZepp3VK3f6fKdj67wa1WNRcJyE=;
        b=vcHpeQ90JSY2jg/ceg9H3Z+yYcU5HHp/yJWKH/Id6RHzkvZSF/wVkJKD1GN7goyYXF
         1kgy0B9+uJ33qU3LKCMoObqqecK7ZMJ1XPBTCGJS/pCq45FTdoF0h6JlPX3eP9UwTUWN
         hpdKJsDIqULs4cGVHQx2VoNhmGWxKgsi8PfuoC3NLT00hggg004CeHg7sB8Ov1jeV3Bw
         o/SOBqqKvnUtubqtE2q5RwYMrkpaeGKnLX7+AIUskdeDNXNG9H2mYfYR3DJSj78FFH/E
         xwHP2lD5qHsux5XDMIX0SfCPaGpF2B/VOPH7Wb/lV1O7N/8NybeSUtg8fxQRdL90CJ7f
         a/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qV4b25+pccC5PYRTdZepp3VK3f6fKdj67wa1WNRcJyE=;
        b=icQWghljxJK6CLmo1AtpP/DE6jUP7yv4QxX3UboNeHWOZZ7OGUXoh/W1kL9euenzEr
         1Bzia+C5Ne9edmrdaBb+i94w68z2N7btH80hfn+89k7t3csp+hZTFwnqa/Jmo6GriJWu
         CbM1MLFpJYHXo/D2sSpinwKNrF+xnifkjIWZc3PkAFUdtAwHBXFwNW5i1YI5T8FXkid0
         qClHRp79Mjlzc7dUFdUQpwwIBiHBgEWJ4qxMpjCXkN1GmwT9keFX3xzhMI3O7e1iNcZl
         5zd/hkoQcumEDHXA91/xO6TYS7IwBwpSSCQp13yn9x0cV0vcHyUcD7e11DlhOSKq7duU
         eoBA==
X-Gm-Message-State: ABuFfojfkUHDMMxcLo2vTVzC7KT3hnYWVBRFUXw/br5ipun6XVRF5haN
        npW1UB09TXUTLMdMLafJ8gs=
X-Google-Smtp-Source: ACcGV60eaRA3NPGYl2JH6A21dY561HKzHyaJzKLHndvkFux+NYhtplmBm33X+H4ThEm3FgAlAL7eXA==
X-Received: by 2002:adf:ed88:: with SMTP id c8-v6mr9819575wro.264.1538074744042;
        Thu, 27 Sep 2018 11:59:04 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r140-v6sm5008207wmd.7.2018.09.27.11.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:59:03 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:59:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/44] 4.9.130-stable review
Message-ID: <20180927185902.GB18188@flashbox>
References: <20180927090117.997362691@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:03:49AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.130 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:00:54 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.130-rc1.gz
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
