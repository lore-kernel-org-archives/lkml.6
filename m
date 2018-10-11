Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A2CC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E41020652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0eygDq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E41020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeJLF30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:29:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34720 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJLF30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:29:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id j17-v6so9644520lja.1;
        Thu, 11 Oct 2018 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CS+y3ZkrmTL9hSYRq2DNNyBiHoo8b+AzaBGL/BI8oPg=;
        b=s0eygDq90lz4jJ5atLI2GR9Kt/cRk81ulxvDoLpq/b8cvYSvTaW+xWTERZ3P/hidZz
         JiWuJXA/WCriNhudxXc2YwomclahZjN/imPcqfpgt+xFi+s54tV7jaPfWTfZcSmDSXMG
         1yZ0mTcwO1eTzKOy5ysjZkkvdWOlXNgsebPLPjmjDOJ09nzK20TkG4Gzf+wieItHS/OQ
         B49sv7WMBlDhF/tCFwu9FcMgV/WP/3q7brcp8nbNWMGyC2b9zhAXTMtHgev4RMDxe7OF
         NBvXl1PiLW4DfoatgVMQbPyTrE0o3LDZMHPYa5D9+wU8eQZPcybamIm3qM4UeBDvMCbH
         uAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CS+y3ZkrmTL9hSYRq2DNNyBiHoo8b+AzaBGL/BI8oPg=;
        b=grpwkrrIbditwaqpUHkto3G4eW9XnWFjSXVpq4KzRqLiYmfH6WoaDTifxQohsw72EY
         p9Q+/VVwSPLrZf32uPX2q1OXwbrjpq6TNHZ6pkfgohf6pQvsLK5eLTna+O6CjfOs6sLL
         s9U875qOZK/bCDFA0y+50sdPX3Kx7B6IeKhLjbuDWM99Zpa4hJMt+eH6wcotS/a61W4n
         /9QaiPQ3GOfoPUbzD2HxcHg4u5jRooOeAJfdonRcq3EQ8TEgOGFOQ1Sc3GFRojN+EdIZ
         5Nl2p19zPkV+fVIzEzEKXfxYyo2Il3nI7H5XiJyPCK4EOzDXgstUi40lLg4sUnJLUOoy
         YdoQ==
X-Gm-Message-State: ABuFfogxQHw/1IwzD3KSci880hdKSfwAbmHfUoh5kNYAhWzieGuMyfaP
        lwUNmriIy/yjq7x1H9NK2RM=
X-Google-Smtp-Source: ACcGV637PzmGjWGsLa1AUhgPcWbwxLVb/eoz/5OZ9CUfL+1P8op3KlkrDX2vUqBVuOFK/h/QcrjLWw==
X-Received: by 2002:a2e:4e01:: with SMTP id c1-v6mr2490126ljb.157.1539295211706;
        Thu, 11 Oct 2018 15:00:11 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id n195-v6sm6028137lfb.26.2018.10.11.15.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:00:10 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id DC4A046072D; Fri, 12 Oct 2018 01:00:09 +0300 (MSK)
Date:   Fri, 12 Oct 2018 01:00:09 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
Message-ID: <20181011220009.GF2401@uranus.lan>
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
 <20181011205601.GA32757@avx2>
 <20181011210256.GE2401@uranus.lan>
 <20181011213006.GA13485@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011213006.GA13485@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:30:06AM +0300, Alexey Dobriyan wrote:
> On Fri, Oct 12, 2018 at 12:02:56AM +0300, Cyrill Gorcunov wrote:
> > On Thu, Oct 11, 2018 at 11:56:01PM +0300, Alexey Dobriyan wrote:
> > > 
> > > As the comment in the beginning says this test is specifically for addresss 0.
> > > Maybe it should be ifdeffed with __arm__ then.
> > 
> > Is there some other reason than allocating non-mergable VMA?
> 
> IIRC the reason is to test address 0 as it is effectively banned
> for userspace so if it will be broken, it will be broken silently
> for a long time.

This is rather a side effect of the test because the primary reason
was to check procfs numbers conversion, right? Don't get me wrong,
I don't mind about __arm__ define or similar, this is fine for
one architecture, but if there comes more we will get a number
of #ifdefs which is unrelated to procfs numeric routines at all.

> As for "unmergeable" libc here doesn't map /dev/zero. I know how to
> avoid even theoretical breakage by creating binaries by hand but it
> will be probably too much.

Sure.
