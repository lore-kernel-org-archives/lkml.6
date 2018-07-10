Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB503C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C11420C03
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHOW1fPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C11420C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbeGJTKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:10:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35835 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbeGJTKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:10:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id v3-v6so130875wmh.0;
        Tue, 10 Jul 2018 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0TkTvsrS4sg6VYZhMpPtiBot4ewxvu/d5KRVTMBAGS4=;
        b=XHOW1fPV1mFQS2s7PU5QyKNYAqsdst9mrobq0G0RXM67HvaAqZTd2100Uhyp0IkcLs
         SgfPQZ8wEkcEVXVvZWeHvEWcIq3wPSAE3cN1Vpoxkj+Qb0Tp+OiAGQgDi/eVY+uhf4H1
         7P/yDoNL2KGnQWhzUcVjsNIUjDiaUWQYgufP6gQN+aOluY7whi/irgom7g9Te5SajXSs
         Nvqu9OvSRrnnMgp/fFXVBaN6dcV9Wib7cBLVye/tuHANeUJHck4YDTQJ2g9Q/r8UQHBZ
         G281Lmit0Fbon4guwSRCjaqrJftWi+wH2CwJLfMEs/MJXhXT9UkI8c43SSnfMs6xwAvv
         9fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0TkTvsrS4sg6VYZhMpPtiBot4ewxvu/d5KRVTMBAGS4=;
        b=YvJSy/WcyfqfmhuSRWLO816wIoZvYRedO9Vv+aGq+MfYTl6ybHIpHUXVd2tJLphdbg
         TUWGnmFvnkgvUxAR1+pWQqUGQOXVT7HvKQLxny5O1i6aaHzoXJY/OKAqAl3jLJ8vgpus
         NwPa2htbCAL5CMrcNvzJefmrLWNk/LbzAPwp18GUOjU6zGcpU/5I6wE2+/IAoW0Bj07Z
         jdxwzZb6Z1xmA7JOTqOiRbkn6mlGro3MzhUU7jAmxaB5oK7cHFiR1A+cs0y9ODzg79Yf
         07GG3ihmQTMqfaaroOd8a3SAjrExKH1ohebxZH3R1c/lwkoQ0fF8ThtGm5i8+P2ZK5ke
         BRzQ==
X-Gm-Message-State: AOUpUlHZ+gvVZdyOOF5kyzSmxX5Zwo34dXBr0KwzM6bChBLDQh74T3UZ
        tXgGnvzW2qPjZV0a2c4cf98=
X-Google-Smtp-Source: AAOMgpcWUHicakB7uzxi3SA5UALOOuDLb1h1v0fSgntPPNXsuLZcYYcebDE8Ydx0jWTwt85nyzZAUw==
X-Received: by 2002:a1c:c904:: with SMTP id f4-v6mr1911597wmb.140.1531249811381;
        Tue, 10 Jul 2018 12:10:11 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f76-v6sm64818wme.30.2018.07.10.12.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 12:10:10 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:10:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/47] 4.4.140-stable review
Message-ID: <20180710191009.GC7871@flashbox>
References: <20180710182337.047502999@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:24:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.140 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 12 18:23:24 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.140-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed on my Pixel 2 XL and
OnePlus 5.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
