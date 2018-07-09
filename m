Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A46C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416282089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9Shux82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416282089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeGIJaC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:30:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44535 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932411AbeGIJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:29:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id d17-v6so1318977eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d0BFAuefsRquFUEHGaeGF+P3xI+zlj8/yhKDaRA4GNQ=;
        b=F9Shux82i0MjmCqAA6v5wA1hbdEOGyQ2kF7qo5LNSqUHXmTVWiBZjIdnhSY/OR0vbI
         PlZUReK+cI5eZAyqgznBPN4vSxeaofd0RDL236PTZ0HVSuvpZ2JJGNcmA28o2u8SsqEF
         BVbO1eAzuDClv2quxRgTjgniMS4KB56DplGIj1UN2z4xwcKjea2Zq+5Qgq+Z1I+2kfNC
         duYhD1831OfIUzPJemIXCliy8cnqxMWrWZt7BRe/TAU6mrmVp/QW6EfGJgOl3Mz1evos
         rvT7EhHembUAhsMVe54QCIXu9OaUtqgG+IdY6oZNT6NLT0jAgT1Jh9lTHUNQUuMNYoWc
         7uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d0BFAuefsRquFUEHGaeGF+P3xI+zlj8/yhKDaRA4GNQ=;
        b=pES5Wz50+/lXmZzhdeMQIeQ1rfTNqX90b+8OKO5IXuGDVuPYBosMOTsweoEDhSsTtP
         xM8waowHAHdAER7sueWJtU6KKJ+cIn50cwfX454/8Va6bsuJHjrJhyhAWyg6SmKd7b4l
         xgsoDZIS/w4x8qTY4SeUiyYWLd5yd1J6LoKhUa4sj6VyYygMYNXnJQ+6oEnN++tLdu2G
         zk7QYNYw2cZXq/WZwjEUS6htqXAtLsDMgnmECiSUtISdKEl/8xXliO8V2UAqf4t38fnY
         TZIVJGfLc7zTeqomxFymEIEi006jSmkS1b6YMyhGkdBzwK742ue4meH2L6EeRkdQebyt
         N1HA==
X-Gm-Message-State: APt69E2w3TcTyjCuoiyLZRoh4MnqkIyhg7WOrRSGA8XvFgayj5tFDhRu
        41oRsZv5xr+4cucrRIfsFGMTaNXdrgk=
X-Google-Smtp-Source: AAOMgpeq+8QkHQ01jB/uab4mf+NdaG0N+nAlc/ADXiJ7WLTHqq4pgT3ldI6QArPGZBaPgqYTwyqidQ==
X-Received: by 2002:a50:a446:: with SMTP id v6-v6mr20952867edb.237.1531128597281;
        Mon, 09 Jul 2018 02:29:57 -0700 (PDT)
Received: from xux707-tw ([109.76.156.5])
        by smtp.gmail.com with ESMTPSA id u3-v6sm697181edo.44.2018.07.09.02.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 02:29:56 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:29:54 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        aastha.gupta4104@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 03/12] staging:rtl8192u: Remove blank lines before '}'
 and after '{' characters
Message-ID: <20180709092953.hte2evscogprubr3@xux707-tw>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
 <20180707145513.15325-3-johnfwhitmore@gmail.com>
 <20180708153811.GA29737@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708153811.GA29737@kroah.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 05:38:11PM +0200, Greg KH wrote:
> On Sat, Jul 07, 2018 at 03:55:04PM +0100, John Whitmore wrote:
> > Coding style change to simply remove the unrequired spaces before a closing
> > brace or before an opening brace.
> 
> That would be good, but that's not what this patch does :(
> 
> It removes lines, not spaces, as the subject line said.  You also fix up
> an indentation as well.
> 
> thanks,
> 
> greg k-h

Just for clarification, before I assume something and make a mistake, I'm
wondering about this patch set. I got auto notification to say that patches 1,
2, 4, & 6 had been accepted and merged with staging-next. And I got this email
to explain why patch number 3 wasn't up to scratch.

But that leaves 5, 7, 8, 9, 10, 11 & 12. I'm assuming that they didn't apply
and I that I can resubmit them with a fixed up patch number 3. That seems
logical to me so I'll work on that basis for the moment. Thought I'd better
check, before I confuse people, with an erroneous assumption.

John Whitmore
