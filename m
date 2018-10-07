Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EA5C6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038CD2087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucor4zh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038CD2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJHFpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 01:45:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34303 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeJHFpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 01:45:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so7456409pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b266GM1yQfrbRLCypggYHjvbfLc3kmfgBJWn7HxwsjY=;
        b=Ucor4zh2yRF5fq1VvlU8xZW1ganN/aSPqOpQ9/2iwEHwJsINPROjhte6HbHqqU3b3u
         7CNcSv/IbNHtiXX2JrzbfueDH2spTrY+Fnd0YzLUhSo/GKr84V/YEZCPWgrKxnglkiyL
         NV+6TT3tj1rofXtKf3bPJoR0k4C6MB/uyGnu6HoGE50Z4xe3BoFtNWt/Hk8HiUs9BatS
         YVuFHLeCarp/WfpMQ7YQJYyV960hVN0xPN6OseKKLkQMDgz4leNL8vOFtFttpTsTkBLT
         hO93QjiHtdd8Kv3mA6lQ4Aupv1D5o+40a+EL/D9aFH2yJumYTODhbmokcRcAX1ACuXxi
         zKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b266GM1yQfrbRLCypggYHjvbfLc3kmfgBJWn7HxwsjY=;
        b=US5dZVdS2cMgVMG8nMMqo9ZYe7ZjZpwiOQiMdY1VvXYABZQlKO8yABBEy+sT9007yl
         vFt2P/ilhZovR+zKdb0CSBRiFKQFrz/vQpaiar4jrquPJ4FCVCgxCT2v6wxY9dspjWqH
         o9b5NeLtmbcyYX52n8a2jAWYKtJ3Tt6DVbMwiw6ZZqCRPbm8mNjjDQsCujjKMtrdrDSC
         Lqbw6e4xvD9iL2sS0+2xaRUUYt/0H1uaz4gcaJ+bRUBt9x2+AgVDQDyUb2zvGxcvkkrm
         Av7daTj/UQ4BFg9TKSVEVzEQLIQCKdYTn6dsgrVxkN6GfflCsBnAApBVttxYO9+5SvCd
         eQJQ==
X-Gm-Message-State: ABuFfog0mYq8DrWVQTPTQbEVp23Zss1oUdjJ/JAUxxYcZFcd7sP7aDv3
        +CzODJ1J23SLt5FNfoert6g=
X-Google-Smtp-Source: ACcGV61JaVJDV6uoKsLZNLzyITMsgJiq2hw25VfTaCL4ZYTH7AS0JWvRk0S7oebt60iXjmzqGKpHdA==
X-Received: by 2002:a62:5251:: with SMTP id g78-v6mr22458236pfb.256.1538951785340;
        Sun, 07 Oct 2018 15:36:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h87-v6sm14589061pfj.78.2018.10.07.15.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 15:36:24 -0700 (PDT)
Date:   Sun, 7 Oct 2018 15:36:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 4.19-rc7
Message-ID: <20181007223622.GA12196@roeck-us.net>
References: <20181007154529.GA4493@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007154529.GA4493@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 05:45:29PM +0200, Greg KH wrote:
> Hi all,
> 
> Yet again, it's time for a kernel -rc release.  This one is bigger than
> -rc6 was, for a variety of unrelated reasons it seems.  Lots of
> different trees being merged this week, much more so than the previous
> one.  Highlights include two sets of networking fixes, lots of different
> driver subsystem fixes, arm and arm64 and x86 and riscv and powerpc64
> fixes, as well as scheduler, iommu, and vfs fixes.  Not a huge quantity
> overall, just overall a lot of different things.
> 
> Given the current rate of change, and looking at the travel/conference
> schedule happening this month, it seems like we will be having a -rc8
> just to be sure 4.19 is solid as well as not having to be in the middle
> of a merge window during a conference week.  Please go test and make
> sure any remaining problems are sent in in time.
> 

Build results:
	total: 135 pass: 135 fail: 0
Qemu test results:
	total: 318 pass: 318 fail: 0

Details are available at https://kerneltests.org/builders/.

Notes:
- sparc32:allmodconfig is no longer built.
  Starting with v4.19, nds32:allmodconfig will be built instead.
- CONFIG_OF_UNITTEST is now disabled.

Guenter
