Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A724CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A3A217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546465506;
	bh=C4xf8m9HmuamVyotpMDOEoaTiDHVn4QNqPVzicxfrzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zFMLyudRYJAQk2W0PtJamMAZd4/rAHViMOQwak302vzwdqqUTNM+ztyPiof0wEmVe
	 duyxTpTcJ4GUVVQ2ZuyiQJcnmmRbQchTRv2TDHt2Q7SmYgW8urpiAXNt5m5x7Mf4qO
	 /FgiRWvK1Ss5dzucrD1ZQyG6Ksn6/0FL7QhwKsTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfABVpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:45:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45766 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfABVpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:45:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so26226418oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rwziIHzw53tWysSUl6JTfhi0XVsEkPMvbKTwIciO5w=;
        b=RcSZ8wN5aMAscVwhwWsSEFvif/MNR9I+sVXL+UY0TgSMdB8wBghr2CMbu3sB249a6O
         c5XGFzGVuks9dUBGDov8KIdbmfMHd26/kZzdGlHcDhjGsP8bzfo/eIxcmkjMHFPHii/9
         ccOZlpYv9w8EY2ysPAiLG7UQa1oLbE+dc75Hs4sj9DgVoESfxJBLlEwi3wec8fYKNwpc
         w95DtyBm5uCj+IGIsNGVEZ8bfAgoDfZRaNB6oM96/ImZ9sWviA3vBNvGqWXjN0LQnXbR
         QhIt1vAJD/mdgT/GQ0wRftCSXNN4llCKkXVlxR6qvx+ZvGt/T8b31c38XnrB9x6n0hyp
         pABg==
X-Gm-Message-State: AA+aEWYStctNbWAdQ5TRco/TDzHMz3eCgnNbuVgT4hgBR0DdegUWeS2+
        kbqPD2E43jd6t5jweYnkiUg+d4wVQpMQzgSSG/A=
X-Google-Smtp-Source: AFSGD/XmHJ8CMtX37HupwpF8JV2QlfV3TU2PhHyiBuCmGKnF3te9x7uVz+EC2fE6ghRBMkuJ46RhBRjYCuSm/7x17Pk=
X-Received: by 2002:aca:b642:: with SMTP id g63mr28702206oif.195.1546465501890;
 Wed, 02 Jan 2019 13:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20190102005704.GC17624@shao2-debian> <CAHk-=wh2sparb1qw4h5QTCR+YF7xsssLgZtNtthRA6QiJjKfbA@mail.gmail.com>
In-Reply-To: <CAHk-=wh2sparb1qw4h5QTCR+YF7xsssLgZtNtthRA6QiJjKfbA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Jan 2019 22:44:50 +0100
Message-ID: <CAJZ5v0hXEqtaiV56sGCOd1VzsRETkS39YiLV-OfnFWiZH4tcAQ@mail.gmail.com>
Subject: Re: [LKP] [mtd] c4dfa25ab3: kernel_BUG_at_fs/sysfs/file.c
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alban Bedel <albeu@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 8:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

[cut]

> Greg, Rafael: it does strike me that the "BUG_ON()" in
> sysfs_create_file_ns() could easily have been a
>
>         if (WARN_ON(..))
>                 return -EINVAL;
>
> which would have made the machine boot and probably make things easier
> for normal users to report. The kernel test robot doesn't care, but
> non-booting kernels are usually not nice to debug or report for normal
> human beings..

I agree.

This isn't a good enough reason to crash the kernel IMO.

Cheers,
Rafael
