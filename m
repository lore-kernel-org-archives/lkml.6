Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C379FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CA521711
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRlx5lWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CA521711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeHNXIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:08:05 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32831 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNXIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:08:05 -0400
Received: by mail-qk0-f194.google.com with SMTP id 27-v6so14352703qkv.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYiRpzod1eU+LsUlb4ElxIu4GJ5HT1AJFTgJkdkYw3I=;
        b=qRlx5lWVNBFiaZRPiBdcTfBsOU02Uqxk0OyWP5QWTn+dHRY9f6t9wwTsejOUoAZg3d
         BpUaTgw4CxR3mY+Zbf9nqkVW9XJAPtHUsK51/jYloaKLajE4gscY50f//fkEXetmhQlW
         6/ScMJB3m+D9jrJGuUTmpTr/ARYuHqEBSzvXL3MQFnxGeF/n1Od/Vm4JAgbBOw5hGmsV
         kZlZ+BmL4SgoDVx8Wz+yqmvUHeUI18i4VbyrGbYqQxNNZdkPBOOX1bNG1mASTG18IPCI
         iqGBJ1o8xGMw8zngeuS9D+sPZPZAIJcKxBuUPmZ7pD0O7+txuQGLFHZKNezFYFl+syqd
         gk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYiRpzod1eU+LsUlb4ElxIu4GJ5HT1AJFTgJkdkYw3I=;
        b=ep1QMBJD3f/0SrQIRXc6NG22IBKy7B32/tyIsvX0q0M2WpIQRDXKbZ8DEcR1gO6g4w
         qzqTCOPVMHq1O3yG0A7K5AydB8toYm1nk9BrR6fhYsPp0C3bOIap5tau4jA7a2m3lWMc
         S75FHrZxidEoq+8I/wEZnuTFOKpm+jyyhwH1ia0hSBaILwYPNJY+CPmP7Cdn01Jd8W6O
         SMnjKIjnHLL8scZqJP41+6qQVybVf/Bzqt9JF44U47Sd3NIfDeHf/J8BQ6yUsYXtopwS
         gjCkAAjFQf6mckhTOUp+u7CQbThAT6M+XX1nvghHbSdeY7sNhGrmWJxldEKV3ZPUYcWs
         tqGw==
X-Gm-Message-State: AOUpUlEGrpkFi3pLpwuL+BF4vQOSjzO3JGr2hyoK78vdEjnLQmwjWIe/
        bxBkeSvTtxTfXdX55i+rRg9Jyo/anFAqztedwDs=
X-Google-Smtp-Source: AA+uWPxYjwYDBr6CbWIP6B+p+bTF27SwBlgqGlMMPO/z/CVN6fITmVgfErsYILurFYDRcpFgGJVpTjsl8p/E+jm4Dqk=
X-Received: by 2002:a37:6812:: with SMTP id d18-v6mr20837479qkc.215.1534277954427;
 Tue, 14 Aug 2018 13:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180814170904.GA12768@roeck-us.net> <CA+55aFy0SFGaNmzCcpwMCeY_f3ZTG54NmV3SosbK6=QdE20=5A@mail.gmail.com>
 <20180814173623.GA5117@roeck-us.net>
In-Reply-To: <20180814173623.GA5117@roeck-us.net>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Tue, 14 Aug 2018 13:19:01 -0700
Message-ID: <CA+8MBbJ=09jAHNZTFrwMFFGbUSWEMYCDxKTMvM2XE+daVa599g@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        riel@surriel.com, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Aug 14, 2018 at 10:20:32AM -0700, Linus Torvalds wrote:
> > On Tue, Aug 14, 2018 at 10:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Does that mean that gcc 4.5 and older are now officially no longer
> > > supported for compiling the kernel ?
> >
> > I guess we might as well make this the excuse for making that official.
> >
> > Maybe it's trivially fixable, but I don't even want to look at it,
> > since we've talked about updating the minimum gcc version so long.
> >
> > > If so, would it make sense to update include/linux/compiler-gcc.h
> > > accordingly ?
> >
> > Unless somebody cares, and comes with a trivial fix to make old
> > compilers happy, let's just do that.
> >
>
> Only implication is that it is the death warrant for unicore32,
> since the only compiler available for it is gcc 4.4.2.

My ia64 test box only has 4.3.4.  I seem to remember some pain points
with newer versions of gcc on ia64. I need to poke around and find one
new enough to get past this problem, but that still works for kernel building.

-Tony
