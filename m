Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E7CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9278C208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vaTUCA7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9278C208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeGLMpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:45:32 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51489 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeGLMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:45:31 -0400
Received: by mail-it0-f66.google.com with SMTP id h2-v6so4765947itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LovpyTSMV7uavf9sBeFYcwHb0AY+wi6kG+hGX8EnHw=;
        b=vaTUCA7/IVpy/VQwg9yWtM2nr0VxoNB1B/X0p1Up48R5JDM6NieM19+FmqJpNSy7D6
         KRBYJYefxxPonUqtrqfWSSjq75Wr5x6L3NptTlzvLnVcWkV6Y+cK21sAu6EiYcTBSs5G
         ZALp/YMC6YwvamcC7D4GMIA/R6PpMaXtyei4hdvSwJIlTt0QALquYiwXa8FfV7xxzyK4
         e3hS2/xvMAF20FXmRF//H0iyHSfXgLJ44F9lbUhR4GeclDE/H6Nq1RcvbgftNvJc0xr7
         FrqPUSIO5aC9hrzB6RRf1RCAFlIX4MY/+rUo9a7IPB9J0a71E2m9TMfmz8NGwqYz+1DH
         Q+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LovpyTSMV7uavf9sBeFYcwHb0AY+wi6kG+hGX8EnHw=;
        b=knlfWCwJ9GPjPpG8YuguCZz/DXnlmpe9tBg9px+cO8UtX/e4vwzJ6n3CzyJEqXxfQu
         iuKjCcqz8HzZ5wAd75xfKeQ2Zu57BoNN6ZrBc9wWyIm7kiTzjTgI9jjmD5ODBYUVHppm
         tfykFFipYl0+3Con6HmMCEg1Ot5d2i8UrjbbYS2Gwg5PfqcBASOFa5hDu2oEO65qcfLM
         5gi2Um0yJpPkweun/0KnueeDjbKM158TO/MAGACGTnkyOaNYBQNn91V1jXdktuSuVAH1
         0Xcqe5reV/OpSmJzQsojCjecbsgLiHU8vhl1sUd8DnRFYTxawMjjuJWRxI1i42sxED9a
         YTXw==
X-Gm-Message-State: AOUpUlF/weVuFRAqj8ou5fsNpjW3b00FS+z0YonyHeBuJwQZ394bZAs4
        g10Vaur8v0OQPGYBlRzIhr30P0PYBUQVrQ0lWGwcfg==
X-Google-Smtp-Source: AAOMgpd9ZqzxhMHzbvtZnuMvhQAffQg8WwaTBfBSz/YzMI8ox2jLMgh8Bdkz70USmbD7Wuj3/ryMlsog1xUcuj1aLtk=
X-Received: by 2002:a02:c4c6:: with SMTP id h6-v6mr1327806jaj.26.1531398968251;
 Thu, 12 Jul 2018 05:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180712003625.2551-1-jmaxwell37@gmail.com> <f65200d8942d4eca92f854e63d2d5286@AcuMS.aculab.com>
In-Reply-To: <f65200d8942d4eca92f854e63d2d5286@AcuMS.aculab.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 12 Jul 2018 05:35:56 -0700
Message-ID: <CANn89iLJ+LHK2oMAwWiifg1pa=t2JBi7N6794ixe4aSB_vvuJA@mail.gmail.com>
Subject: Re: [net-next, 1/3] tcp: convert icsk_user_timeout from jiffies to msecs
To:     David Laight <David.Laight@aculab.com>
Cc:     jmaxwell37@gmail.com, David Miller <davem@davemloft.net>,
        Neal Cardwell <ncardwell@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jmaxwell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:57 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jon Maxwell Sent: 12 July 2018 01:36
> ...
> > - (s32)(tcp_time_stamp(tp) - start_ts) >
> > - jiffies_to_msecs(icsk->icsk_user_timeout))
> > + (s32)(tcp_time_stamp(tp) - start_ts) > icsk->icsk_user_timeout)
>
> That has never been tested properly.
> icsk_user_timeout is u32 so the comparison is unsigned and the (s32) cast
> has no effect.
>

The existing code had this ' bug' already.

Please do not blame this patch, and send a patch if you believe there
is an issue ?

In my opinion, the (s32) here is a reminder for the reader of the
width of the expression,
more than anything, since there is no chance the result can be negative.
