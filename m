Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2758C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CFD2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyQsL6B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CFD2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeJWRhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:37:40 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40615 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeJWRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:37:39 -0400
Received: by mail-wr1-f50.google.com with SMTP id d2-v6so806510wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yt2j6LWad1Sg+G/57ZYIDcsEbPBV7gN9fV1gSiO8x+o=;
        b=FyQsL6B/NHtcdbz/oB78Slsd3qLuw/fqFCPKUHgptAFwIZbSPKahsQyN4+MV7topfT
         AmU0XIHQVGfu4/PgoaScVqS5ApSpieN1poPezTWvQAohQv567wcOcvZArr1FaLjL4r2Q
         A9/hz2XS+iYajlo7N6bUCAbg1krXpullKW8nv1KJ71lCnzpxhR70N2amsMJiGn4IDI+d
         VRu441YLnQMm+A9F4WBVEzjS+ne/upAN2eqKx7QOZHLiouhH5H825P5nAqHdxdJyVEd1
         CzzCjGf5ZhMJ04a8Ij+EObed+6Ee4zFbK25O7kZbuTS63HAw0+5Vg/JLDiBqF6kf83gx
         X2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yt2j6LWad1Sg+G/57ZYIDcsEbPBV7gN9fV1gSiO8x+o=;
        b=piT8MGUlNAtrviT+PQMG4Ht5mK3ft6EVgLzGQc5qFvB85yCNeRv8BP+GT0ngXHQ8em
         1Zs1Ql5npa3G7K3tqa2xPKnWfhwYEz0KwsSBsN5UJSwpLaEzZgUt+/LWW8c66OmBFUAS
         2qObZhUpxRNAdM0pVhCMuT9hBYA+2IJtfrjtq6K6v8zJCWl9WFSSeU6EvBKZUtdbl8q3
         7FeGzthlP1qmHYlzXHjd/wg6iheJ9wNx9RTleJ74XDEuaB9KNXKmFkchT1p0TDe4tz8V
         5mPzRcchumVgbnjl1BsHvwCJ96aCunpdOAUkgxML3gSpHTGzbYogCvB0o3vhzRXXHqyK
         UILA==
X-Gm-Message-State: AGRZ1gLOOJjmDH3rNiDSyqHNbgzNAyJV+rCylzHS6ArR9SDpnlItzKlE
        Z1AdjqW+wu0DS3PWDAhWA/s=
X-Google-Smtp-Source: AJdET5ebjB66IID9pHH8nWItrorfdjlJYzumvisjVqaoQLjY7hhSsU8h5KYHOEplgHBsLxZSU+sqmw==
X-Received: by 2002:adf:d14a:: with SMTP id b10-v6mr16140579wri.17.1540286106712;
        Tue, 23 Oct 2018 02:15:06 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r2-v6sm439335wrq.1.2018.10.23.02.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 02:15:06 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:15:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181023091503.GA24437@gmail.com>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I've got a few options:
> 
>  - just don't do it
> 
>  - acking the pull request before it's validated and finalized.
> 
>  - starting the reply when doing the pull, leaving the email open in a
> separate window, going on to the next pull request, and then when
> build tests are done and I'll start the next one, finish off the old
> pending email.
> 
> and obviously that first option is the easiest one. I'm not sure what
> Greg did, and during the later rc's it probably doesn't matter,
> because there likely simply aren't any overlapping operations.
> 
> Because yes, the second option likely works fine in most cases, but my
> pull might not actually be final *if* something goes bad (where  bad
> might be just "oops, my tests showed a semantic conflict, I'll need to
> fix up my merge" to "I'm going to have to look more closely at that
> warning" to "uhhuh, I'm going to just undo the pull entirely because
> it ended up being broken").
> 
> The third option would work reliably, and not have the "oh, my pull is
> only tentatively done" issue. It just adds an annoying back-and-forth
> switch to my workflow.

There's a fourth option I'm using: I use 'zero inbox' mail reading, 
last-to-first, and with that I can 'delay' a reply to a pull request or 
patch simply by marking the mail unread. Then when I push out tested 
trees and patches I go and process the tail of the mbox, a couple of 
entries typically. (For patches I don't even have to do anything because 
the notification is automatic and I mark the patch read when I see the 
tip-bot notification myself.)

It's still a separate workflow step but easier to manage than postponed 
emails or separate email windows, which are inevitably going to get lost 
in browser mishaps every couple of weeks, and which are not high-profile 
enough in the primary workflow either.

Might not be a practical method with the amount of mail you are getting 
though ...

> So I'm mainly pinging people I've already pulled to see how much people 
> actually _care_. Yes, the ack is nice, but do people care enough that I 
> should try to make that workflow change? Traditionally, you can see 
> that I've pulled from just seeing the end result when it actually hits 
> the public tree (which is yet another step removed from the steps above 
> - I do build tests between every pull, but I generally tend to push out 
> the end result in batches, usually a couple of times a day).
> 
> Comments?

No strong feelings here: occasionally 1 out of 40 pull requests perhaps, 
if you don't do a same-day pull or for some reason you are delaying the 
pull request (you need to time to think about it, or it's just randomly 
sorted differently from other pull requests, etc.) then I just don't know 
*why* you didn't pull: are you just thinking about it, or a random delay 
because some other tree is causing trouble and you are bisecting, or did 
it did it get lost because my email got marked spam?

I'll wait 2-3 days in such cases because when there's something genuinely 
wrong with a pull request I definitely don't want to draw your attention 
to it but figure it out myself and offer a v2 pull request ... ;-)

If you started sending Acks explicitly there would be more certainty in 
these cases.

But it's not a big factor, I'd say the efficiency of your workflow (which 
is a single thread) should be the primary concern here.

Thanks,

	Ingo
