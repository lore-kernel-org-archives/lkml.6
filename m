Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E46C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5672085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1O52GoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5672085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJKCVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:21:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44029 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJKCVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:21:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so2953519plb.10;
        Wed, 10 Oct 2018 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DDI1OXyZWnZtoenQ6ZVbzI67d8+Dk9EreHqZPd2QU2U=;
        b=B1O52GoDos9pDRsyWQj/1sbW2xBCuWs3Q1uFa5PHywm5btKMuKXafHPtmzDu0u+S3u
         zU8krp6rdM+z9J+Z+qz1GSwoGy/Un/ZfCu99llf9YERJCBHwIbzBgrXZ6QV/XXaaLPQt
         cforrf9R5L8Tn+NDHlAws/dM9fZuLOT6q20vfIhViRP6ct11MN/+RaNCeUOtiiiKUzfm
         iRm0ZJJfA4NTfPoq7C0Nf8+zPJgzk+t41mgBYXcNw1LoQUVm2vCvoDTwXzqftfoKfZ0j
         egAhi+EWusQ1a6T9YCtoiidRW51cPLCcZxmKZgrfHUzWfvLF//zrlXZtNRfbQbbyXjli
         3/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DDI1OXyZWnZtoenQ6ZVbzI67d8+Dk9EreHqZPd2QU2U=;
        b=ewiCDy3BvhTMeAvYCcu3DWCS6QHA5J3tiegbrJXsNnxsj3iThwItUJls1ojfWwMLJg
         jzXs/YKGARSwC7atiJISzHju+K91V1gj5kde4IFc4AAE6i+PtGFnqdNKTRxNEHDdYQdD
         Tezv8ZioJyVYjyr5Z9lyTltx75J9hXoihyi+1G7ZT7qyW/VjjHUL609PIq85t3SANIBa
         2Fo6qjZyVb5TnNwbYvS4SVcfpGn4lzBeVg30sF+aF8EkHKbAW1kWJjsnHxrMO4Yd9UBV
         8g4RyEt+NXGmsgbREZFUiGxg82aHMgPveOcMiw8Mc77c6cVddj4T9gAanJfXmV1Obz34
         K6tg==
X-Gm-Message-State: ABuFfoj92abFTigTmPyYiYEyYaJrMv5BZyFU0BkDcg/rVrXXbffYM4O2
        Df+1IoXeS1c3YXfr7NfWvmE=
X-Google-Smtp-Source: ACcGV62bX1WrNlOx8zDGRRyAOfQPUCE4pVFiy64JCOu9JCqZaDydSJbOSD3uVs7ajt+yxynPA7Qb7A==
X-Received: by 2002:a17:902:680e:: with SMTP id h14-v6mr34325874plk.177.1539197903606;
        Wed, 10 Oct 2018 11:58:23 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y1-v6sm38380939pfy.89.2018.10.10.11.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:58:22 -0700 (PDT)
Date:   Wed, 10 Oct 2018 11:58:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010185820.GI47260@dtor-ws>
References: <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
 <20181010170219.GA47260@dtor-ws>
 <20181010181148.GI32006@sasha-vm>
 <20181010182840.GB23517@kroah.com>
 <20181010184039.GH47260@dtor-ws>
 <20181010184947.GJ32006@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010184947.GJ32006@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:49:47PM -0400, Sasha Levin wrote:
> On Wed, Oct 10, 2018 at 11:40:39AM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 10, 2018 at 08:28:40PM +0200, Greg KH wrote:
> > > On Wed, Oct 10, 2018 at 02:11:48PM -0400, Sasha Levin wrote:
> > > > I think Greg's last estimate was that about 1/3 of the kernels in the
> > > > wild are custom based on a kernel.org stable kernel, which means that we
> > > > have no visibility as to what they do with the kernel. If you don't know
> > > > who your users are, how can you prioritize some subsystems over others?
> > > 
> > > The numbers I had was 75% of the images a major cloud provider was using
> > > was either a kernel.org stable kernel release, or Debian.  The remaining
> > > 25% was an "enterprise" kernel including CentOS.
> > > 
> > > Also note that all Android devices are now required to follow the stable
> > > kernel releases as well, so add a few more million to that number :)
> > > 
> > > That being said, for a well-maintained subsystem like Input, whose
> > > maintainer almost always marks patches for stable releases, having them
> > > picked up by the autobot is unusual.  Dmitry, if you want your subsytem
> > > to be excluded, just let Sasha know, other subsystems have been excluded
> > > at the maintainer's request, and that's fine.
> > 
> > I am hesitant to request to exclude input from autosel just yet, on an
> > account that I might miss something. But I would like autosel to acquire
> > more smarts and be less trigger happy. I think it would be for the best
> > for everyone.
> 
> Keep in mind that it learns based on your choices, so maybe in a while
> it will be a perfect fit :)
> 
> Maybe to make it easier, just reply with NAK on the patch(es) you don't
> want in the tree and I'll drop them.

OK, I will be doing it then. Should it be a certain string so you can
script or a free form?

> 
> I was discussing more about the general case and stable tree policy
> rather than drivers/input and AUTOSEL, and didn't mean to try and
> dictate what we'll take or not. Sorry!

Me too and I am not trying to be dismissive of your effort, I am just
trying to have discussion on the criteria that we should use for stable
candidates.

Thanks.

-- 
Dmitry
