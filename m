Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54513C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E752D20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbS0qHgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E752D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeIHDUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:20:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42890 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIHDUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:20:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so16316618wrr.9;
        Fri, 07 Sep 2018 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zmSjm1vrRbxXXtVwZ3MXL35cfvsZSgYuylblMmh/90=;
        b=GbS0qHglW+jmVY3jyKqKs7jlzvXvTqHDi+Y6nJWLSJZNZNThX8GnFYPJF0/5ny8J5F
         BgOn8NubAvsI9+z6NFERyU73S00is/5FpNK+/rT236Y2MBzeTOrlf2EFEAW8cj+OyFpZ
         lWgJgtsWzIWOnZ5FNm45Uf4Z+Zl0KuRRSUyU6zg0WgPC7hidF8j+pwlclU/SPHw5Kk9L
         3F6C0o+IyQVH5UsValFLLUrav7wNO7KqjBVT7pVQNXh+nbfvQt8cyxT0lGdByKMBOK40
         ygTO0eKV608d3MQUllDiEv04IGzR6pLCapcByhCUi5YFO/9ap/YlNzfb921AWfyQgzIY
         t8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zmSjm1vrRbxXXtVwZ3MXL35cfvsZSgYuylblMmh/90=;
        b=GY0wLT0l0JTqlcTNHDcjUKnSDKqqijkT0gBoTcdD3IAYMng8XtO+58ljXFNg7JbCQR
         fn9QrvCFVu4iWI7Z6cDDIQ6HMu6jLcG2d4HhmXQxk11uO2n24L9ZmypnD6k6AxYqXpHa
         dGmqZ5A/84iHpbamOLD/zUO+2JIkESkXfIsxFtRc4kZ3RMTt9PHgYEsgvn6kXsL+L4se
         1tcvcepbALdBfcbmSJdo9ljv86Q6GsJYvV9M4izBdwwKbsH8bAqUMrJhVvGF7R0RNkmy
         5ar06fqN9Pl5WMETkTYCP2uMPJDNj5goUm3Eq44TtuotuEOJyE3qOztX0ggx8yhacX+V
         iUhw==
X-Gm-Message-State: APzg51CN2FS3kOoZe6NZVtp356P4zGkeDpmdH+RtGme8r3G4h1hkJiBc
        4JJTvDYiNZqObMuzmBCz51xPQmeX3ew=
X-Google-Smtp-Source: ANB0VdZjPSs/oa4pEsit/f5/XEQsmbyMCztk03sh4+628AtDX2kDhqggknBUyU8RzGYERTHzyStOgQ==
X-Received: by 2002:adf:eb47:: with SMTP id u7-v6mr7754860wrn.22.1536359860291;
        Fri, 07 Sep 2018 15:37:40 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 69-v6sm7772609wmb.27.2018.09.07.15.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 15:37:39 -0700 (PDT)
Date:   Fri, 7 Sep 2018 15:37:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/89] 4.14.69-stable review
Message-ID: <20180907223737.GA2171@flashbox>
References: <20180907210852.341064285@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:08:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.69 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:08:28 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.69-rc1.gz
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
