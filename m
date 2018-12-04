Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604E020878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USC5bZrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604E020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeLDMk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:40:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34462 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDMk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:40:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so9486134qkg.1;
        Tue, 04 Dec 2018 04:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+G0Q9pR0FbL1fV5nWYYxQ1+8Itp4iVOywohPQ7iW54=;
        b=USC5bZrjx2qdOAf2LM9v42PjurF6DvRbRTBqz98M64eOU1Lq3JrsDARdbwH4dyarAE
         tHmpu9+31W2LgloxH35drY6ZOgRSTPthKHA5FpPADK40YARY3e6FF8tklk4t93Gfbi2r
         +EZYZ8taUMvtbTGamLZwjHJbdBtyiSCtfFc/nRl6CIOUJiLWmtyPeFo9DuSxLAYsNj57
         KEkc76VMxizxfihpzJpF7TcpIA+WQkS+CeEA7S/7BdDtXHeMMoAnuu+wFBdEAnHFkU2g
         /9JSFz6M0qiSFdJgKTacy7zSSIeo1GRYWeNignv8K/lGS1I2hIZ4iMH7EYthtA/XP2Hb
         zoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+G0Q9pR0FbL1fV5nWYYxQ1+8Itp4iVOywohPQ7iW54=;
        b=V5yivFuVQ0s4cdXMjwlhF3u4uR0Lm9yN6E+L99JngBW8HABhiqX55A9QAQeWahuwfN
         bPQwA7oqNNOoH6Yr5QKypkl5WJ0XUpcvng3T7hLA2fqZbeiuUm16kgrekGzwFDy9PU33
         6sNbsjqRruWnAaBAolgTFJP3tMEujohA3gadC8l1ZlHqiPvdEPMWaMUXcAdYdi/g2PLu
         fWbLRf+ksX7GmXm+V/mTxtVhXLb6B/BommDPumOIGg6N7s9SJyr41bNfXeDu//8YeUGa
         LVAiTm6ylvBitTyLUkksMn8l2RjFg9lcLA4lkuSCeZIXC+i2N5J1js4tZVZBRbb1ruKt
         RIVA==
X-Gm-Message-State: AA+aEWYCOi6lMgR1NCz/PIXLGA0UnhLuSrVhzfzMzbTSLUcK3xKbEbMg
        9KzhZsqoNh2Y5+mQ1OW4fH01U2Irp3IVAd4L8o4=
X-Google-Smtp-Source: AFSGD/VdBWdHwqPLQrMi1zs5ccqIgPKQYX37/fALFbkLnYNqAR1LyKFFRrzrTdb6M1lhQGKQEsxjuftGe/wLcx4RT8k=
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr18340773qkl.70.1543927225375;
 Tue, 04 Dec 2018 04:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
In-Reply-To: <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Dec 2018 14:40:14 +0200
Message-ID: <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     tiny.windzz@gmail.com
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:59 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> On Tue, Dec 4, 2018 at 3:09 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sat, Dec 1, 2018 at 5:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >

I like your patch, but...

> > By some reason it's not applicable.
> > Please, rebase on top of our for-next branch, thanks!

> For what reason?

...because I can't apply it, it fails with conflicts.

>  I thought that for-next branch has not changed much.

That's correct, it's updated only by approved patch series which is
not many _this_ cycle.

-- 
With Best Regards,
Andy Shevchenko
