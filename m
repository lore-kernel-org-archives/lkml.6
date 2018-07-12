Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143B9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5152124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="czPDKisl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5152124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbeGLUpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:45:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40503 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732514AbeGLUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:45:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so22958488wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JygkbmooFKfegUWCG6EF1gVAfl2/zwi1DvSEwe8uKEE=;
        b=czPDKislMKLhZrFT9QYHtruAQyOZ+raCvSeb7kj01eol1WyhuqajiZlzfrtjBA8pSw
         1/6wUhGvLqZK0yf1P2Sb8CvK3ZjnPV2N+8HkhohZua834f27e6KRADl9GTEhoadJRSK7
         NYmilZc1r3iGTkBRn84r+UhemwEgMKOky7Xws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JygkbmooFKfegUWCG6EF1gVAfl2/zwi1DvSEwe8uKEE=;
        b=UC3IID69caYLPR/UeYRQdTEPGO/OqGM+YfOucimjL6xT15IhZDczP5Cc7CgmZNIkwQ
         D6b/N4BCMKMr1iW9tIJ9i6eqBCnzN9IkwgIb/sKINwKQm/Iu73NL8fzs/0Dw9fe+n36G
         Dx057HfLQBUDTqb4oemPGGdsxGVK6gTRHOs4S1Y61pT6lNvxRNs74D9y/7EcMO9T7awU
         vyNDKfSfXUyzd3vJVSXIdTkka6odIeT2Z//MjU6/09OAnkHZJKpo8frS1Dnrhhj2I5iU
         mk3WYG5I1W5TykCuMVXUgb0FaFlck2PPX9EbXuY8+seUlLXG9hv315TvKBgbB91JJGyT
         Vfbw==
X-Gm-Message-State: AOUpUlG1ch/NjWntHy8yfU5+TN9Uk9vDq/kY8bzLkMw+7suEQyomvQ+/
        pt32/pzzyWTvlvRgIt6UtlriLINBWQusXOgvOxHoZw==
X-Google-Smtp-Source: AAOMgpcsLQ6Y9GhhN/UdNkEfQQ+MDrmu79Yefnv/KFltY6dITZrxx3WZaRGI861TxdY6Cqg1Uk8wpFA+JbUvkS5hQYI=
X-Received: by 2002:a5d:4b50:: with SMTP id w16-v6mr2809344wrs.87.1531427656698;
 Thu, 12 Jul 2018 13:34:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 13:34:15
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1807122222360.1597@nanos.tec.linutronix.de>
References: <1531426641-20076-1-git-send-email-john.stultz@linaro.org> <alpine.DEB.2.21.1807122222360.1597@nanos.tec.linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 12 Jul 2018 13:34:15 -0700
Message-ID: <CALAqxLUxihWMj0xR=qg=A2eycYYHCXbr3y2JxLUJyBznrso5bw@mail.gmail.com>
Subject: Re: [GIT PULL][PATCH 0/2] Few timekeeping items for 4.19
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 12 Jul 2018, John Stultz wrote:
>
>>   I had a few other items in my stack here, but you've already
>> queued them in -tip, so here's what I have left.
>
> Did I miss you replying on them that you picked them up? Normally when I
> see that you or Daniel picked something up I happily move the mails to the
> done folder unless I see something horrible.

No, that's my fault. I'll try to be better about making that clear so
you don't duplicate work. You're just much faster then I am :)

>> Let me know if you have any objections or feedback for change.
>
> One small request for the next pull request. Please write a short summary,
> optionally in a tag, then pulling the tag adds it to the merge commit message.
> But plain in the pull request mail is fine as well.

Sure, I'll try to take a swing at this next time, I've not done much
with git tags (other then trying to do a signature tag long ago when I
still had a valid gpg key :)

thanks
-john
