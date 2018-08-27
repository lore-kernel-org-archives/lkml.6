Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09179208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fPxcVE4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09179208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeH1BpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:45:14 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:51489 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1BpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:45:13 -0400
Received: by mail-it0-f54.google.com with SMTP id e14-v6so745782itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=js6UumBJMFeYXnlsy1VDfa3nJZ5MCSv02eQ+0t4cRjU=;
        b=fPxcVE4QEvewgDWWxQKEa39o/9ZNSgp3ug25wNnj8sh8pxJVuwW88Joev9QMoPwvXd
         FwWTzoqizIFv+dGBAz5s6ZwR7ufS/gsMtG3IYbQM6DUEjMyCxtdbLNX2njtlorb/HPZK
         VRGtwXPTa+3y/NuE/in0feBFy+gectwSHvqQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=js6UumBJMFeYXnlsy1VDfa3nJZ5MCSv02eQ+0t4cRjU=;
        b=uB4ygHsmB9vihjn7KgkN9+2wkF1GOccoRUtU5KCIyVZ9NG3vp8JPEaXzxzRmfG+dhf
         BWH8uV27qyNo4qOS0v0CIAlQaVEctyhO2YCVCwmKXgZhUGdoIaW1h0gLtQqPhKHoKs7/
         Z/Zm/g/JFtn3ZOufgHbNEWF0x7Ok4NvvRQcvNSmB3B2547H89e3irzxiSpiZMfw23gK/
         VuZd4vALV+fvW4/jqwuHxxlO/coNVe+y85qLOdb25OeNb+SPG+e1Pg66Wi/DM+s/kk9X
         FmuBTA2MCR4sIGMHvXQQR3E6Bg0OpNNgPmOX231Jk/z/qTkmYJUo+VMoDMmskV9BcWH3
         RBUQ==
X-Gm-Message-State: APzg51DFaIdWDcpFHdsA7xp6Tak0FMZp7KMoG96pk5OWzi9DFaWss98g
        ++smGrRpY8+M30uVFoEPbHpzy5Z8sFxYHx/xKQMdug==
X-Google-Smtp-Source: ANB0VdaVoLvAiOTYIOKU86wg3Bs2EzFmYnalVIUoZdNbK7tDbuG/zKXiTjZAFpWnEYXk/Bq8QEeEa0RaCcn/U5BVXWk=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr8585370ite.123.1535407004002;
 Mon, 27 Aug 2018 14:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
 <20180827134459.GA16094@roeck-us.net>
In-Reply-To: <20180827134459.GA16094@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Aug 2018 14:56:32 -0700
Message-ID: <CA+55aFwO72FivHHBdVky96wSgESNZza4A_g2QsovWfgxf7qH=g@mail.gmail.com>
Subject: Re: Linux 4.19-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 6:45 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 132 pass: 129 fail: 3

Thanks for running these. Looks like everything but the sparc thing is
under control, and the sparc thing might be one of those "big builds
don't work on sparc" ;(

          Linus
