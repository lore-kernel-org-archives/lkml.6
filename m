Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27FDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB01C2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJb1b5bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB01C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJKCEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:04:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38399 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeJKCEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:04:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so3068658pff.5;
        Wed, 10 Oct 2018 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSJZk+AVUMX7z4IZUbnUfGAuyttU8unAMJPx5XClbBQ=;
        b=MJb1b5bogPa+TTetjiVNWMfUhhFTMB91sDzZZqFXQAq3tkfVOWPBJCEQYNRqH72LU0
         o2doJ/u2nag/Xvs8OymB1/AWgIJnStQ0COSxDOklX3hpDf2h44HBI9yZhMcTZhFUN7Y4
         yDl3wt82Ke46Hd22cIXw0d3hYLk4pRnfR1uvoHHhBTWpO0xEUQMYVDKiakkSXVmCDLkt
         Q12f9jqZEsBYtvqQ18MCJQi5U8wDuWsZTsCHY2Hqfq9uFLhRVhyFs6UwXREnDbqHjrb3
         pR++NhVnF5LZrQvC1hV4CCF2hGgxSp+WJWCYRP32TrdLtDnqviePDmD9dmGUI4TNNAyQ
         RY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSJZk+AVUMX7z4IZUbnUfGAuyttU8unAMJPx5XClbBQ=;
        b=KOEMnbM8IJxGUJxSb96v9BHt/jEuYfp3VoGdf2bUrPY3Zvb9Zdr0SW+25vartyZFhk
         AeW0w+CETcIo6xAg8ZGbkQ/I/9SDNL5eUIXaLvMrF5VMlAqKufNiql13hsnFZ67Ar1Os
         XGqK+fyd+s5TJ6vD9SPTF11DnNbvTUGeAJqYdOz5FsmbxTnQ2QcL7TGn8CeS8/sIjwtC
         OGwcr3/ucE2GfkuBqPxMvptheEbQhXpYb0PiVliFut6dGl855TR8HD6CFSoMrGzU51bP
         WQ3bPVk26vKcu0sZ2yLFcm1fgUihdDZxiEIKdH3Ea/gItUeS03Ldr78NhOgIW8td7uxf
         Z8YQ==
X-Gm-Message-State: ABuFfohGr2klWqAS8WwVDjAlhOSf/nQDL6nCre9lYgUe3wNSOSXyYe/1
        F1tbkpVk76/UHoHzoi0Kn7o=
X-Google-Smtp-Source: ACcGV638zzgRuarLd1ZUghua/xOo5BsLSNchbQBnEetzGZxm+b57ScYe5NTS0g0rEidmq+4xpxwrZQ==
X-Received: by 2002:a63:7419:: with SMTP id p25-v6mr30807328pgc.395.1539196842574;
        Wed, 10 Oct 2018 11:40:42 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 20-v6sm25654683pge.77.2018.10.10.11.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:40:41 -0700 (PDT)
Date:   Wed, 10 Oct 2018 11:40:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010184039.GH47260@dtor-ws>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
 <20181010170219.GA47260@dtor-ws>
 <20181010181148.GI32006@sasha-vm>
 <20181010182840.GB23517@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010182840.GB23517@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 08:28:40PM +0200, Greg KH wrote:
> On Wed, Oct 10, 2018 at 02:11:48PM -0400, Sasha Levin wrote:
> > I think Greg's last estimate was that about 1/3 of the kernels in the
> > wild are custom based on a kernel.org stable kernel, which means that we
> > have no visibility as to what they do with the kernel. If you don't know
> > who your users are, how can you prioritize some subsystems over others?
> 
> The numbers I had was 75% of the images a major cloud provider was using
> was either a kernel.org stable kernel release, or Debian.  The remaining
> 25% was an "enterprise" kernel including CentOS.
> 
> Also note that all Android devices are now required to follow the stable
> kernel releases as well, so add a few more million to that number :)
> 
> That being said, for a well-maintained subsystem like Input, whose
> maintainer almost always marks patches for stable releases, having them
> picked up by the autobot is unusual.  Dmitry, if you want your subsytem
> to be excluded, just let Sasha know, other subsystems have been excluded
> at the maintainer's request, and that's fine.

I am hesitant to request to exclude input from autosel just yet, on an
account that I might miss something. But I would like autosel to acquire
more smarts and be less trigger happy. I think it would be for the best
for everyone.

Thanks.

-- 
Dmitry
