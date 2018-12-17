Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CE0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20364206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHp/XKhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbeLQN4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:56:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40939 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbeLQN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:56:36 -0500
Received: by mail-io1-f68.google.com with SMTP id v12so6410635iop.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RFb7liArRYYdHEiLLH1H1p5O47yr8gfAj4Sf2ve1XvE=;
        b=iHp/XKhf9ycFQPgKz+H/zGa36oOT/ftU9QWxG8ijQfY1IItwHaaUKNTN9f7zJwngFJ
         CPxik4UanF0f8o67zzJje75SFkdK6Vrw7BsWa25njMIWRi5IdmRpnIfWzgX1i5BuDIto
         ejZBKyXBp7REgzgukyth8/qmSA2nqDGRu0yWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RFb7liArRYYdHEiLLH1H1p5O47yr8gfAj4Sf2ve1XvE=;
        b=IMpFk7+dNUoBAo93G9974DZ96aIwN0cWg28H3tS4N1W5deTi3CyHMrWZB7GmfcpoQL
         Z59ioRtOJNfwM8P3TVJaEnzzgiY8fDH92Y0kSmCg2zmbIHoqXVhqKThd8JKS4BD5c/Av
         rXWLDzrlSFYZXkeS/FRnAUD1CnTs3kBNhLTYEFyWFKBCOs5EWzJ2EL3VkMxAfoh85zhF
         ohCY63oFPHKqVmBu3al2XF69qLWL2jWwWQolag3DbKM37NjpCt/jU98+dKecAugZHZU/
         IgEHpF01j37FwIgV7DNAnWWNRdMPF6qXWKTYBcqaMWUpmOCVX73a3XVDehi+z+knaEAd
         KAFQ==
X-Gm-Message-State: AA+aEWYUaonfEdn4nkJAwiPDaPPxIo1keZX1g0/l3he2mi0uqGUdbvwW
        ZMdVC+8DKJL/j5fnyxSZ1MWSGQ==
X-Google-Smtp-Source: AFSGD/WM+R35koRxxwwRKK2U3AfYR4ZTNwlKcM/bo4oFx+soIG7w7hN6mf2qtjlBUnzZJ743+84/Cg==
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr11048524ior.169.1545054994152;
        Mon, 17 Dec 2018 05:56:34 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id p198sm7472998itb.30.2018.12.17.05.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 05:56:33 -0800 (PST)
Date:   Mon, 17 Dec 2018 07:56:32 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
Message-ID: <20181217135632.fisfyfkt4473q7ze@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20181214115747.053633987@linuxfoundation.org>
 <20181215170102.es7drxdtiz7gzaib@xps.therub.org>
 <20181215171145.GA2086@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181215171145.GA2086@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 06:11:45PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Dec 15, 2018 at 11:01:02AM -0600, Dan Rue wrote:
> > On Fri, Dec 14, 2018 at 12:58:05PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.19.10 release.
> > > There are 142 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> > > Anything received after that time might be too late.
> > 
> > Results from Linaro’s test farm.
> > Regressions detected.
> 
> They were?

My mistake. There were some false regressions that showed up and I was a
bit distracted when sending the reports and missed that.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

> 
> > 
> > Summary
> > ------------------------------------------------------------------------
> > 
> > kernel: 4.19.10-rc1
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > git branch: linux-4.19.y
> > git commit: 4875bf1f86d7bdc8dbf3222ab4028239446fab3f
> > git describe: v4.19.9-143-g4875bf1f86d7
> > Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.9-143-g4875bf1f86d7
> > 
> > No regressions (compared to build v4.19.9)
> > 
> > No fixes (compared to build v4.19.9)
> > 
> > Ran 18346 total tests in the following environments and test suites.
> 
> This said there were no regressions.
> 
> confused,
> 
> greg k-h
