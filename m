Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCAAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B2A20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RV9rLyE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B2A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406421AbeKWEQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:16:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44424 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeKWEQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:16:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so8573450lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zwz9HYjr7SS7F4m3d3+GngAuieRQGxTBo/FkFzC1Ld0=;
        b=RV9rLyE8HBCCBPb1CrK0KONqz3G6vT+gKItTB/d+WODfAB+oeKAI1leURXUDw5Fx8a
         G3xlOp5X3ls1ELpKEnZD7Oh6U9zu6rxj3SYTT+S0YYsrqWF+1q2IFoN/oYq1z+jqU48a
         4flFRsKBtu3FU0+JADkLKzzc3qhtCLv4wfLDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zwz9HYjr7SS7F4m3d3+GngAuieRQGxTBo/FkFzC1Ld0=;
        b=KkQb15hrrXs0ppUSwBSv3fWqkjmzl4SMbWyQXWrRw/18v5Btaq//EvgP5esmoTvYA9
         6MNGuIvB4FTKApFZQi+mAp27Vjy/k1eNWqCOZmQ3BJoDAtXsY3ctMpPBDdcIsvOXgO73
         YvgWDq9pZcdi8L9JMZAsO21J1VxF6IT5eC76lYvlAchlVJoyJdN/fyhgZtBv9ca/qWN4
         ikuQj61xnE5Qvl6cfDRYDHHe6BjSf1wuxH2SAb6vWtODdzDIqPWjtbL4jmSfb72fQXp6
         2/qUS8v+1x+Tr3PTOWFcj1XjPZN7q0h3zYi6lbKm3QMJNCBzrePsZvAswAPCSfJwO9c/
         LvmA==
X-Gm-Message-State: AGRZ1gIrPt5cok5thmtoOmkdYa/hWLKpLtILTUk+J0zgFb6BVQO6ZFHz
        Tr3/+VBVnyn3dGv+G/gghxA4q/O/0YFiQQ==
X-Google-Smtp-Source: AFSGD/Xft0Bh1FS+YNMdnuupr08W9+oMomADeDE+kC5qr4Ed3qiJ1Wt1OtNdbPotVVNpG6mP2er3wA==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr7347652ljf.96.1542908155708;
        Thu, 22 Nov 2018 09:35:55 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h63-v6sm7623789lji.88.2018.11.22.09.35.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 09:35:54 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id k19-v6so8573324lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:35:54 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr8343445ljj.6.1542908153909;
 Thu, 22 Nov 2018 09:35:53 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
 <CAHk-=wiDLq5CVnTJhFNEEduqYP_VSsQPSNvi=w6a8Y9figuh7g@mail.gmail.com>
 <20181122103231.GA102790@gmail.com> <CAHk-=wjG=hvKnsRByogG_7Pwwi+7UQ1AK52m5bTp9dUHhAOzfw@mail.gmail.com>
 <CALCETrXtXfD9=H_jqz2DowmEdeUBXOxA5zk4xVNmiK0RzJVZxw@mail.gmail.com>
In-Reply-To: <CALCETrXtXfD9=H_jqz2DowmEdeUBXOxA5zk4xVNmiK0RzJVZxw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Nov 2018 09:35:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgox1vM7EiA_Ga7sY0A-piyNQPtmB=HZasOwYXySkaYXQ@mail.gmail.com>
Message-ID: <CAHk-=wgox1vM7EiA_Ga7sY0A-piyNQPtmB=HZasOwYXySkaYXQ@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, pabeni@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 9:26 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> So I think your patch is viable.  Also, with that patch applied,
> put_user_ex() should become worse than worthless

Yes. I hate those special-case _ex variants.

I guess I should just properly forward-port my patch series where the
different steps are separated out (not jumbled up like that patch I
actually posted).

                Linus
