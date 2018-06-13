Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1BBC1C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02AB208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tru6OT4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02AB208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935625AbeFMN1e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:27:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35119 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935487AbeFMN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:27:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so5472900wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9tq5wtaX3UHWBbmao67YZ2afVTFv8LABu7R+AtCWGlE=;
        b=tru6OT4rH2nonxMubnv+WorBUsPVLjfUKC0IrPcfBL2mT2COvojmFPSlGtu6QX8XRO
         PSKDjDH+XEMCL3S8lAurY6LBiuS0lGi1mtLv/Yi4L9XuAq0O+M4tk5MlJJQfYcSMPMJA
         OiM0utT5t70Essv1OSScq4ek0P/Xp3DBCXv+izp3Niuf6dPnhfAqLQH/D0YioMFYDvZp
         YByhlyEStIbhjih+dzMnH+WPepZpp0OWY1wQyx++b7d+jhJw2ZUs0Qd96c3jJsyvlPWh
         fAvFezUr1dxtbi5VSfi6hI9ykVtqfhc+3l7lvRQjVbjwybMrlYHLXS6C6xxkU5PUBJM2
         YOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9tq5wtaX3UHWBbmao67YZ2afVTFv8LABu7R+AtCWGlE=;
        b=gLdTmjikIQ9CDJk+GPYmg+zcMxZKglbGur25pifpjguQtJOKp/yS/3ybPfe8UCAxWR
         Ca5qCHu6NkGOd2RBEhNTgXJpMeFtT+geBlAtnMT9tFytBXOrIz3JqtCsi+TTZAIx7SQ0
         LqA8vlJaTA0oaANfC3rwMKx5hjxOdB6SawZh4bXvMJjfpyC4wJFFitwg8PxranC4sed1
         fes+Rhs/FG99qaD22ljf4VlNfTxYRcdzSO+UYw245xNLccRWzZrSPEIirvZoffW7zGI9
         ogn8Ys7rwlpFizCEOpjhIACpfWwb0JeRnnN7e/0GL5+kQbD/E7ddyOMOYB+BdyZUrvsy
         QL3A==
X-Gm-Message-State: APt69E0yl/pCnuEziE74rpBwG+rYCLED5oJ4FnLlSOBneJKogTTccIGo
        J8+0kBKm5Xpgjc5sCZ7ri0nMdGdKFFBvTQMTy10=
X-Google-Smtp-Source: ADUXVKJXnjdFvaRPNxCbrvFVQ7U/QaeR2yXDllv9lsXZ/ryZUVQZ5T8d26oooBJfNTE3KRjHuIGpLVFtHab4QDziUQY=
X-Received: by 2002:a1c:3710:: with SMTP id e16-v6mr3663685wma.58.1528896451861;
 Wed, 13 Jun 2018 06:27:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e241:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 06:27:31
 -0700 (PDT)
In-Reply-To: <20180613143247.1b749c83@endymion>
References: <20180612083449.100099222@infradead.org> <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
 <20180612171420.GU12217@hirez.programming.kicks-ass.net> <20180613143247.1b749c83@endymion>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 13 Jun 2018 15:27:31 +0200
Message-ID: <CAHpGcMKj1MNyc0XJuKxf727jtNhiKpL3AuR_+pRZipWXG+V08w@mail.gmail.com>
Subject: Re: Quilt vs gmail (Was: [PATCH 0/3] sched/swait: Convert to full
 exclusive mode)
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,

2018-06-13 14:32 GMT+02:00 Jean Delvare <jdelvare@suse.de>:
> Hi Peter, Linus, Andreas,
>
> On Tue, 12 Jun 2018 19:14:20 +0200, Peter Zijlstra wrote:
>> On Tue, Jun 12, 2018 at 09:47:34AM -0700, Linus Torvalds wrote:
>>
>> > I do note how quilt emails are really hard to read, because that:
>> >
>> >     Content-Disposition: inline
>> >
>> > makes gmail think it's flowed.
>> >
>> > Which works horribly badly for patches, surprise surprise.
>> >
>> > So I really wish quilt wouldn't do that. It does smell like a gmail
>> > bug, but at the same time, why would you use "Content-Disposition:
>> > inline" when you don't have an actual multi-part email? So I do blame
>> > quilt too for sending nonsensical headers.
>> >
>> > (Yes, yes, I see the "It is permissible to use Content-Disposition on
>> > the main body" in the RFC. But the RFC also makes it clear that it
>> > actually matters for how things are presented, so saying "ok, I'll do
>> > flowed" seems equally insane and equally technically RFC-compliant)
>>
>> Quilt people, anything that can be done about that?
>
> The purpose of the Content-Disposition header is to let quilt store the
> original patch file name, so that the recipient can save the email as a
> patch file having the exact same name as the sender was using, to make
> communication between developers easier. This is the reason why the
> header is being added despite the email not being multi-part. As Linus
> found out already, RFC 2183 allows that. The RFC also explicitly allows
> the use of a filename parameter for inline parts (see section 2.3.)
>
> Using "attachment" instead of "inline" would presumably force the user
> to save the patch to a file before being able to read it, or, at least,
> to take additional actions in the MUA to convince it to display the
> contents inline regardless of what the Content-Disposition header
> says. This is clearly not desirable.
>
> We could try specifying the filename directly, without the "inline"
> keyword, however that would no longer comply with the RFC
> ("disposition-parm" is optional, but "disposition-type" is mandatory)
> and I am afraid that some MUA implementations would either default to
> disposition-type "attachment" in this case, or ignore the header
> altogether.
>
> I'm not sure I understand what "flowed" means in this context. If you
> mean that gmail breaks the formatting of the patch, I would say that
> gmail is infringing the RFC, which clearly stipulates at the beginning
> that the Content-Disposition header field is only about telling the MUA
> which parts should be displayed immediately and which parts should not,
> and not about presentation issues.
>
> Considering that "inline" is the default for a non-multi-part message,
> any MUA which changes its behavior in the presence of
> "Content-Disposition: inline" is bugged in my opinion.

All of that may be correct, but those headers apparently do break
email based patch reviewing on Thunderbird and Gmail now, and that's
not very likely to change. If we continue with our current practice,
we'll end up frustrating users. On top of that, i we make this an
optional feature, quilt users may think that using that option is a
good idea when they will actually break their recipients' workflows.
As Thomas Gleixner wrote in the other thread, most recipients will
already have a way to deal with messages from other sources that don't
include patch filenames, so let's just get rid of Content-Disposition
headers in quilt for good.

Andreas
