Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E248C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E873D2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland-com.20150623.gappssmtp.com header.i=@herbertland-com.20150623.gappssmtp.com header.b="u5dPS3WU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfBOCsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:48:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42262 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfBOCsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:48:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id y140so4891901qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpbJjRBGH59c4Ahc97sbV5w5+jdyJon5GyhFWxCzjJk=;
        b=u5dPS3WUyH7GXxfcsxnPtNeolWqezGTGJMp1YL1JDERUBNRlbd6BOshwyLxV4jkjF1
         Pkny5camY1aDb4XLNsmH7DZ8T5diZ6TsRumc4KEeWC4svlBs+OOJHHBp3jAav7Nf0TiH
         Es9oodWVuN+RE3N3bo/hjIk2A0NM2AW2RVg6FgZdulhUuB6czIlIiqWpRazvziRhkHNv
         CpURqz0anRrs+qiw9X23WXYtqpDvGo8S2YCOA445Do4M99dvovdiNWBXFFYMosyk2uli
         tBWCVonSaEfwg8iPQzDXO19yXWGFO44mCqvwqsam2md35ynkQz5b8lZR39UeIT/fYpy8
         smYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpbJjRBGH59c4Ahc97sbV5w5+jdyJon5GyhFWxCzjJk=;
        b=HzoJC1zuMEio5Af3IgoTzFTV0QwPfQXH+CdmRloZVXzJ1uphbOzwk1+0u3mRIWtN9j
         P0tQztblnm+0fFyBu1Et6dgXEf9dYCAZBK/oQaBnWabVgdVfbgXsgnA0X1jOVcDT82H6
         q7w42RPjZvRK+MsGmJsxVwYUAuS567RqKYG7+7pahNXj0iJwZTblU7+pvZkNkr1PEKKu
         6+ys53w91rqdo0LqAK1qeN46HTwn1ihbHTsIHlp11LgQo9RRCYHREBSpoS3MYWKxpAN/
         dDFBw5PHTgSNKSllT2FmH/E9bzNX+z9dJ6JMltRwPrsYTkrHVWeFj/Je8LS7t/fNwEY4
         ggUQ==
X-Gm-Message-State: AHQUAuaM18zUGg6wRmGgiMxWolTE7/gKEl1+iZApZWpYNEeGF6BtvdGs
        7sQpQhYaZam13rTtKb8CUmPXDIeCrZ+7A7t84WneJg==
X-Google-Smtp-Source: AHgI3IalxCH6h9h2B3lAlicVhdQu2OO9U4xyiJHwFKdao6uVChyTvVj/nhUwPujBVb708urZqT0CXYbrDyCCH/Yeh6Y=
X-Received: by 2002:a37:5bc1:: with SMTP id p184mr5435629qkb.121.1550198897523;
 Thu, 14 Feb 2019 18:48:17 -0800 (PST)
MIME-Version: 1.0
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
 <20180912053642.GA2912@nautica> <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica> <20181031025657.GA17861@nautica>
 <20190215010029.GA10899@nautica> <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica>
In-Reply-To: <20190215015705.GA17974@nautica>
From:   Tom Herbert <tom@herbertland.com>
Date:   Thu, 14 Feb 2019 18:48:06 -0800
Message-ID: <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     David Miller <davem@davemloft.net>, doronrk@fb.com,
        Tom Herbert <tom@quantonium.net>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 5:57 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Tom Herbert wrote on Thu, Feb 14, 2019:
> > > The best alternative I see is adding a proper helper to get
> > > "kcm_rx_msg(skb)->offset" from bpf and document it so users aren't as
> > > lost as I have been; I'm not quite sure how/where to add such a helper
> > > though as I've barely looked at the bpf code until now, but should we go
> > > for that?
> >
> > I'd rather not complicate the bpf code for this. Can we just always do
> > an pskb_pull after skb_clone?
>
> Which skb_clone are you thinking of?
> If you're referring to the one in strparser, that was my very first
> approach here[1], but Dordon shot it down saying that this is not an
> strparser bug but a kcm bug since there are ways for users to properly
> get the offset and use it -- and the ktls code does it right.
>
> Frankly, my opinion still is that it'd be better in strparser because
> there also is some bad use in bpf sockmap (they never look at the offset
> either, while kcm uses it for rcv but not for parse), but looking at it
> from an optimal performance point of view I agree the user can make
> better decision than strparser so I understand where he comes from.
>
>
> This second patch[2] (the current thread) now does an extra clone if
> there is an offset, but the problem really isn't in the clone but the
> pull itself that can fail and return NULL when there is memory pressure.
> For some reason I hadn't been able to reproduce that behaviour with
> strparser doing the pull, but I assume it would also be possible to hit
> in extreme situations, I'm not sure...
>
This option looks the best to me, at least as a way to fix the issue
without requiring a change to the API. If the pull fails, doesn't that
just mean that the parser fails? Is there some behavior with this
patch that is not being handled gracefully?

Thanks,
Tom

> So anyway, we basically have three choices that I can see:
>  - push harder on strparser and go back to my first patch ; it's simple
> and makes using strparser easier/safer but has a small overhead for
> ktls, which uses the current strparser implementation correctly.
> I hadn't been able to get this to fail with KASAN last time I tried but
> I assume it should still be possible somehow.
>
>  - the current patch, that I could only get to fail with KASAN, but does
> complexify kcm a bit; this also does not fix bpf sockmap at all.
> Would still require to fix the hang, so make strparser retry a few times
> if strp->cb.parse_msg failed maybe? Or at least get the error back to
> userspace somehow.
>
>  - my last suggestion to document the kcm behaviour, and if possible add
> a bpf helper to make proper usage easier ; this will make kcm harder to
> use on end users but it's better than not being documented and seeing
> random unappropriate lengths being parsed.
>
>
>
> [1] first strparser patch
> http://lkml.kernel.org/r/1534855906-22870-1-git-send-email-asmadeus@codewreck.org
> [2] current thread's patch
> http://lkml.kernel.org/r/1536657703-27577-1-git-send-email-asmadeus@codewreck.org
>
>
> Thanks,
> --
> Dominique
