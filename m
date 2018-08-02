Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7B6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0B121528
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mguwLddo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0B121528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbeHBReh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:34:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44622 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387636AbeHBReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:34:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so1377598pgp.11;
        Thu, 02 Aug 2018 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YCftVgHtT7c3oZvbwROuQpmIH500fzi6kXTA6A4JDhE=;
        b=mguwLddodmyBUcgWtMdNUvWzdZhHlp7slrPc6YScTjk++FA74aUOBsW/IGu8C8ZqAg
         eV6Q5pTC3izMSgL4RkBCcZ2+CTEzfe6uZ0+SITZBvS+xej6PNZzZXglpBDWaWX4xdsZM
         DK/90G3Pn/cTZxcFCCz0JmjtdMmZcF09Xy/WW2OGiJOTZQNbh+m7RU/o/nPJllKtWpe6
         OvHhLr40INZZ/ExQjFy83GNIGGfC7t9f+vND1w1pRJm9aq5coGypu3KKtYGFBFETVyds
         t1VyuMJiCXMnUVuF3pgL58Zr9urQHDRR5ZAD5Zxc8JAAJGUqC2MhQUTMmKbU+yVF61bw
         JA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCftVgHtT7c3oZvbwROuQpmIH500fzi6kXTA6A4JDhE=;
        b=ga2sSLx1jF7ncR99zlP6nV7vKog2onX0YqI2ICqJWWcRlKJ1w9PDyYUMujqxf/L8DM
         dBb0mVjhwgudI2vNbSppHohMCV+qiq+tOw/zY22s37FQu0TuhiSygy7m70uP2du5WR/F
         /V8MPwk5Ci0m3eSZ9ueXn2V6M6hQK2S7/R4sM/cppcn5YOmDEC2h4AGSRah5BAjInYma
         qQEm1n/TRaFLnJZCMgaOXo6zYmKalBSwwM5Mf1tnYhvki3NXdAaJb9eugmryKL9L9SLB
         2DGGXew1i6KwC0V8G+6dCgIlIbA1qB7cI05QUB/TvNxBYuAHZF5PxtYYYKmLHUQsb7tK
         lDNA==
X-Gm-Message-State: AOUpUlGaRW7aWWQVIOE2pFvlP6ywauVdJt/0hAh3I+02BFcUnu9e38Nl
        nhbHXN4RwoAmWDTtzf4ojJ8=
X-Google-Smtp-Source: AAOMgpf3EBpee+CqfD6s72s26pwTTUQcCcpKyXbQy+8p8U/0RTrhBMYqskQWJ8E9O9QDH5eG1FTq1w==
X-Received: by 2002:a63:5106:: with SMTP id f6-v6mr3245701pgb.95.1533224574118;
        Thu, 02 Aug 2018 08:42:54 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q81-v6sm4855403pfd.15.2018.08.02.08.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 08:42:53 -0700 (PDT)
Date:   Thu, 2 Aug 2018 08:42:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/144] 4.9.117-stable review
Message-ID: <20180802154251.GA5137@roeck-us.net>
References: <20180801164949.023217860@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:50:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.117 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Aug  3 16:49:15 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 190 pass: 190 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
