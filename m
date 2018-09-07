Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751AFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F872086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by3T9fcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F872086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeIHDYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:24:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42053 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIHDYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:24:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so16321381wrr.9;
        Fri, 07 Sep 2018 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s12dKhf3YAoLjkH2sOtX1NrqJWjp3BZ9pqewD/sIZ3w=;
        b=by3T9fcddUz1wWsaqz4JO0PHmsayetC/ZZ6katBE4UNxBR5GU0XZMTfgKTn2mb/DrW
         qQbaJNM2qOCXPiDnIvsMT8h/JqJAqKVig6YNfi0EGaXJBBE9fZslsduigTYMKis1iM4q
         ndWwZzSb45lXLVa72FEYgG3IhB8ggaAZ7qOMJp/PQBxu85QsM++MCk/BUqYeYlJ4sAOm
         92AJc+nkt80itoUeH7kXvVHmOrM72AILpV+tQhO9Tw8itr43cT0FfwkYNk9CkMQPqN/x
         5r5t+nQh/QSviurAvJ2kKquHM4nSn3VSlbFcd2o324Lg7MEJ8d4t+X/6O7r2A+byq6Kw
         +U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s12dKhf3YAoLjkH2sOtX1NrqJWjp3BZ9pqewD/sIZ3w=;
        b=pvQ5nh4/k1jFEPgFb4JYbjcUBEfUjGAS3/t/RjkZZaNnlIfcvCZEWdl1KUylwF+Y/k
         fvOhojZZEKZmzN2WzFqjlDkPNVHGzJxQRIbKlAirHEcywIjcayPE7sLRGOb4YKa+dhYo
         l/JdURx4QdYGyq/8BkK1eg+q3mPqYiuyWwRXhgbeAR6ZYCDQvIJXt5rdmri1A2EAqm2/
         RupB2zeH4qdmzN4tFL/bkn19gwho4uXlpSm7O0Erte0/FGauZOan1rcujrXu/rDv4ooh
         pAUrAO2pWm7owwMf23TUUTep8BkIdxORFjtByd2zboy+d40ZedIy1gF/1EwTpy6j+PuA
         k/KA==
X-Gm-Message-State: APzg51BONZ7X/Pw1h8LRBlOyM9p96cuYp9xD+E5bj6dD3bYY+LN/QzNY
        Ags/KIA4hHQXWd/WuESe7yM=
X-Google-Smtp-Source: ANB0VdbpRL8x9zPNNeHr9D6Za6oijDPFwGC+WPpirOgdZ7fBgAibAnTzQgE7qvHklmTTNlahV3F9qw==
X-Received: by 2002:adf:80ea:: with SMTP id 97-v6mr7312758wrl.57.1536360083310;
        Fri, 07 Sep 2018 15:41:23 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b5-v6sm5675340wrs.62.2018.09.07.15.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 15:41:22 -0700 (PDT)
Date:   Fri, 7 Sep 2018 15:41:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/29] 3.18.122-stable review
Message-ID: <20180907224120.GC2171@flashbox>
References: <20180907210909.523240901@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:10:21PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.122 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:08:52 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.122-rc1.gz
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
