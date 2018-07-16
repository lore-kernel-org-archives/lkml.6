Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB225ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44D1208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuaAYvpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44D1208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeGPQuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:50:17 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36220 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeGPQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:50:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id d14-v6so2772566pfo.3;
        Mon, 16 Jul 2018 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjLGXnHCUwnJZYCdZoFKWGe8SeiwXKZNmX19tW4Zj7c=;
        b=CuaAYvpywqgrbwHjbCxC1OsS+LF7NwCemqDy2pFwKaH0a5ii4d9v9c6T2+H4dJ2Fzn
         6Pktlk7ld11VwZxdagXmOBSNF1hHJfrRVYyXbVU+qvjo88H3MvWdZVAQTF2VL+ZiAVeM
         FdgnwVPPebNZm+okD3IkY6cXJSLquOzJd+tCjeOMHIGoexRdOMKhbU/Epv1LGlEBEnQ1
         NvfpT05RS/o9iZjTcvK7qnsFEu/bJnFdhWayVptNzEReKGsoEIEp3uzEcbnX4XvawRjo
         uwyOq6nCAFX68SQqEpdd7NevUolgy7+guDfSeaJ0ZT6D/9jLbJYtAWhO4IFlkd1+8lQV
         ZIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjLGXnHCUwnJZYCdZoFKWGe8SeiwXKZNmX19tW4Zj7c=;
        b=VoUHUAlvF/EFDMNFiyVvQEQ9jvVZuwxw+715xCwio1x0GnFCiLxhM9c1/fD9QaCf93
         EwVHCttTyK4iEoC0jpjtR2Qw2kD5gm78E5TwVTqHuB3tr5Y2CsV7K0XNAHrhc5rFnEmn
         jqQjm8SbalkH+4Rt45gx+NXm+OYWWu+7LZaIZ+59ZXLcdIjJALm2tlAA85q6Mc23R50X
         4j/P/3oy/LssCQTUMvCqQoZnocYGacDuEXhM0bziipw2uQRIvHB46MLERkeEolXh92H1
         rZpWn4TvBtVY3sb6v5x/52D2Lnl1KoVo1r44ydcLiMRmC4GJ/R8WaXokFjy0AysJ0HiQ
         DeOg==
X-Gm-Message-State: AOUpUlEUZwhVIU1gkzcsQ+MDqtsNG6Ai0kTZfGTiABFE/YKm95xLXYWB
        vxu+vSAxlUrHhNLJvDo/GSbQgA==
X-Google-Smtp-Source: AAOMgpfFT0yiR/RD3J3OInGNTyF5RjLyyD4MC+XOc6V/j5kCR9C4ACOIaEOQDEDFCNy7bGEPXR7uDw==
X-Received: by 2002:a63:8a41:: with SMTP id y62-v6mr15604642pgd.291.1531758129149;
        Mon, 16 Jul 2018 09:22:09 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p66-v6sm53422079pfd.65.2018.07.16.09.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 09:22:08 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:22:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/43] 4.4.141-stable review
Message-ID: <20180716162207.GA12065@roeck-us.net>
References: <20180716073511.796555857@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 149 pass: 149 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
