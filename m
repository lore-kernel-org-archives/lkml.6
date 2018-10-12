Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11720C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF0420645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP0OWXwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF0420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeJLXM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:12:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39473 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbeJLXM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:12:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so6386854pfe.6;
        Fri, 12 Oct 2018 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+JoSq1t9gr338NKCydJM+RE6bfSKRpeQnTmjbyAR5I=;
        b=gP0OWXwP1TvVb7m/qM3Du+M+3Wjl7uPl5PonPRMAvi4Ix5KbxrOq62N8FEV8XMD9UN
         3mwqG+gzTD974wG6UGlDuWIr7oxjFHUYFnp2JqAdPLNHo9URLubO0xxE3HBznr7UgBgv
         dqig2kZxLas6qWFTIfKhkfsTttANuSNqeUuqfN+PmQ43vLuuI59RUXNsOnGvhPG0zJ2e
         TYsAS5BZPBd6V4K4ehgUnBnOqc8G6N+Ag3dh/BJMz2SdXaR+1nqZmTlSjidEtWJ6SfbF
         1jOgvDDZ+VYi5TBpZuU2WR5Lek3+4oOlyZLS35hGkG9OmpLj9bb0zfmsGOoZ5wcPD1IT
         vjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+JoSq1t9gr338NKCydJM+RE6bfSKRpeQnTmjbyAR5I=;
        b=UI2T7AlXUnXQD9jqrFrrouXDcNHpRnPSctpsHO3N7/crWa7/VNHACcd1/w9MZJrQC5
         ko0xaB/H8C+xUfm3c/w1Jm7OwHCU99KLKHkDVZGoHK67fJ2aMcZ0CROyq5VCDkk4e6YE
         q4jSQy8Rz9TE2ApLxzmk3i744xPnJEuU9RZRtF8XHq4B4FOJWrw14wsc6Bmhv7i4YTVl
         9ZAa3JdXY3R8vbepjgjCZIW9vWhhLRyW4YfPhbyicUvr4c7+ULDBEvvGMdLF1TIsx5Zi
         Ka2ipg11dG22EW6MHs0+/7TxONv7SHv+Gh+XDAhJ86HofinuzKToNWNYm79lVHkzRAG4
         t8DQ==
X-Gm-Message-State: ABuFfoibcrnfzgW9iAYayF7PfocOcmCSvq6CvT4LGInGMg+WzU2N9UKK
        wd+48GJve6EZ0jqO6ifNDK528Oab
X-Google-Smtp-Source: ACcGV60BlP+i0LKNDlmhfWKITZaEqOFHwYbuNDuoZ2pCZD4z7a01klrHfvrsPsjQfNgkwZZyOCXuJw==
X-Received: by 2002:a63:2bc5:: with SMTP id r188-v6mr5940266pgr.160.1539358758505;
        Fri, 12 Oct 2018 08:39:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t85-v6sm2980163pfi.73.2018.10.12.08.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:39:17 -0700 (PDT)
Date:   Fri, 12 Oct 2018 08:39:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
Message-ID: <20181012153916.GA13257@roeck-us.net>
References: <20181011152549.500488630@linuxfoundation.org>
 <9b2c52e4-56ce-37a3-b515-a6ff831fe17e@roeck-us.net>
 <20181012133704.GB3706@kroah.com>
 <10e12992-7e33-9569-5a4f-2a8124d3aae4@roeck-us.net>
 <20181012142110.GA10817@kroah.com>
 <20181012151506.GA17468@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012151506.GA17468@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 08:15:06AM -0700, Guenter Roeck wrote:
> On Fri, Oct 12, 2018 at 04:21:10PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 12, 2018 at 07:06:13AM -0700, Guenter Roeck wrote:
> > > On 10/12/2018 06:37 AM, Greg Kroah-Hartman wrote:
> > > > On Fri, Oct 12, 2018 at 05:19:16AM -0700, Guenter Roeck wrote:
> > > > > On 10/11/2018 08:33 AM, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 3.18.124 release.
> > > > > > There are 120 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > 
> > > > > [preliminary]
> > > > > 
> > > > > arm:allmodconfig:
> > > > > 
> > > > > drivers/mtd/spi-nor/fsl-quadspi.c: In function 'fsl_qspi_init_lut':
> > > > > drivers/mtd/spi-nor/fsl-quadspi.c:170:5: error: 'LUT_0' undeclared
> > > > 
> > > > That is really odd in that there are no patches that touch this file,
> > > > and I do not even see "LUT_0" anywhere in the 3.18.y tree.
> > > > 
> > > 
> > > Bisect:
> > > 
> > > 
> > > # bad: [8c4ca12b60ea371a32db58cf78b6cb4e2ba4515c] Linux 3.18.124-rc1
> > > # good: [921b2fed6a79439ef1609ef4af0ada5cccb3555c] Linux 3.18.123
> > > git bisect start 'HEAD' 'v3.18.123'
> > > # good: [aed5b0190528303a3f4d319f95d7e38c94ca32ab] USB: remove LPM management from usb_driver_claim_interface()
> > > git bisect good aed5b0190528303a3f4d319f95d7e38c94ca32ab
> > > # good: [10441f560c0ad0aeed00402088d71d4d299d6537] r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED
> > > git bisect good 10441f560c0ad0aeed00402088d71d4d299d6537
> > > # bad: [0661a919177560337d962f43daa46dde2fa4d89e] mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys
> > > git bisect bad 0661a919177560337d962f43daa46dde2fa4d89e
> > > # good: [d4b130cc92bbef445de4ffe4ecd068935375d591] ocfs2: fix locking for res->tracking and dlm->tracking_list
> > > git bisect good d4b130cc92bbef445de4ffe4ecd068935375d591
> > > # bad: [1f002a3e6d7250a62966399bd91eeec308c0b756] fbdev/omapfb: fix omapfb_memory_read infoleak
> > > git bisect bad 1f002a3e6d7250a62966399bd91eeec308c0b756
> > > # bad: [5396a79f029d54c1e02409335c7dfde43c55e4a4] Make file credentials available to the seqfile interfaces
> > > git bisect bad 5396a79f029d54c1e02409335c7dfde43c55e4a4
> > > # good: [7da4d144b6922e94aad8c0d405e4cc63a44b8ec5] dm thin metadata: fix __udivdi3 undefined on 32-bit
> > > git bisect good 7da4d144b6922e94aad8c0d405e4cc63a44b8ec5
> > > # first bad commit: [5396a79f029d54c1e02409335c7dfde43c55e4a4] Make file credentials available to the seqfile interfaces
> > > 
> > > ... and reverting that patch fixes the problem. No idea why; maybe because of include
> > > file changes.
> > 
> > That patch _adds_ two .h files to be included in
> > include/linux/seq_file.h, not removes any.
> > 
> > Ugh, that's a mess.
> > 
> > I've seen the LUT_0 thing show up a long time ago due to some other odd
> > arm thing.  But I don't remember how it was ever resolved.  Maybe I'll
> > just let this one go and see if anyone notices :)
> > 
> See commit 04850c4d8613127a9b488321c0ad83bff7519311. I'll check if it applies
> and fixes the problem, and let you know.
> 
I confirmed that commit 04850c4d86131 applies and fixes the problem.

Guenter
