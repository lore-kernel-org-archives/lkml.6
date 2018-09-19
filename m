Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4BECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1AB2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU1noni9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1AB2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbeISWtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:49:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43383 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbeISWtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:49:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id 38-v6so2970483plc.10;
        Wed, 19 Sep 2018 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xTYRykhfcCjPz/wqRS/ktm9SXXcQUk4+5Xie24W8AlA=;
        b=TU1noni95N2j+PYWC8PTSy5OuLrTup3MANvP3MxWY/B+BBfd9TJAHopkH173sXmI+Z
         kS8V5KzKuZcukf8RFodzLAugmhtSc+JF5e2OzgHxwZIjGAola9w5WK0HPXzIHQI5gNDS
         p/Mwuk/IPr/3wBBh/OgP9REj9aifjtbWcn2dKP5w/0HQ85PZ+Mm1pULhRWHnBJuGMus/
         pkPwqlsWzbKSZdgon4Ke737vPWmzXgEUuC8QrEGe9NRvOIR+5wWoMl9x1NOHUmGqKFlH
         O84kMSHqsJFBPgOl9V3HQfpjjkgNkNEMEFVcI+29+LoVs7LCXZqUUJiydAlrmpBjGV2G
         iw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTYRykhfcCjPz/wqRS/ktm9SXXcQUk4+5Xie24W8AlA=;
        b=YT1RPW7etcxnHTuTEOZU7+VdIDQstp6Hq5ifGRBCNCRE1uc3lD0G+LBm1YPmv6vKZs
         jcK8+AJKgJqi2m9zyDpbn4ZSy5si8e0Drx/wyQz8D+FsWXWX8R0JfJNLpA6XsHhk0MK+
         cz9p77Gu/pH0yxSpyBSjKm7pAGonBiRbhEylEqHZ6WcSy15WGDwyfW9UXM9FsDKzq0Cx
         U2bl5QwvVlm7gmPCQp8l0QffU+ovLuPvrM2bauYnCcNPhkUIKLt9cnjzVLiwa58Iivlf
         e4hF3gwzPrWh1zehPq7Lm3yU0p36czTKnmX2KmOrrrm0eb39IzqOU2c4WMs19P7s+oNP
         VXxg==
X-Gm-Message-State: APzg51DKfS4CfJ2cpsLDLykIqXX/qVO+rR/o32M4kJs0NDriJMPuHEC4
        UgPbfuajhhBw7h/pcQnZycNWJft0
X-Google-Smtp-Source: ANB0VdaRwtpsMuwgpWB3+xjgFn2wWSOCyvTzI3HTIHeQZT/fQuf762GTvpHdlXiw5DXNmnvLTEDV9w==
X-Received: by 2002:a17:902:4a:: with SMTP id 68-v6mr34495155pla.276.1537377042198;
        Wed, 19 Sep 2018 10:10:42 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e202-v6sm37691797pfh.16.2018.09.19.10.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:10:40 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:10:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/20] Input: iforce - remove "being used" silliness
Message-ID: <20180919171039.GA116719@dtor-ws>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
 <0541f46d-1f4f-05f4-8e93-6663f6c13bd9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0541f46d-1f4f-05f4-8e93-6663f6c13bd9@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 04:51:26PM +0200, Tim Schumacher wrote:
> On 18.09.18 02:47, Dmitry Torokhov wrote:
> > The kernel is supposed to handle multiple devices, static flags
> > in packet handling code will never work.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > This is a random assortment of iforce patches that I made a few weeks back.
> > 
> > Tim, I do not have hardware, so I was bound to screw it up, but if you
> > have some time I'd appreciate if you try them out (and if I indeed broke
> > things if you could identify issues that would be even more awesome).
> > 
> > Thanks!
> > 
> Hello Dmitry,
> 
> I tested those patches and I didn't find any obvious issues. The basic functions
> do work (i.e. buttons and axes, don't have a HAT so I can't test that), force
> feedback seems to work to the extent it was before (I only have fftest though,
> no games that support force feedback). I'll go through a few more applications
> and see if anything not obvious is broken.
> 

Thank you for taking a look.

> Unfortunately, I only have that one wheel and I can only test USB connections
> at the moment (unless I find a proper serial adaptor, but I'm not sure if that
> would even work).
> 
> Are those patches planned to go into 4.19 or are they intended to be merged in
> the next development cycle?

Definitely not 4.19. Could be 4.20 or 4.21...

Thanks.

-- 
Dmitry
