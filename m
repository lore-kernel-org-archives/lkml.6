Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40538C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029A6208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcbzwwLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbeL0Us0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:48:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35697 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeL0UsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:48:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so21464935qtc.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fi4v9QVEbJBS29NLpBWanHSYjhSWP0ozXzu1zdb62tQ=;
        b=KcbzwwLv+0zx+u7ng/1EDextMWxtGE21w1KymZIOnpkKV322b65mq/p9lrrFbjZZue
         JCaQQp73rwA1sERGbN3CZup2QCkg4asac2gV2Blgew+lwc17t+UHfhCKJyZUVvzrAxY2
         +l1cUR28LyWNr++cD7P4u4AgsLRP6Hx4sawGyYbQUlQRiNXuZKxLDDDlMAxDJ477MeAk
         tZ3/Dtw6N72isIUrrhbDRozstK5hIq1xT2on2VJ8/1NqeqPo7FEB44ECxmsO7jXHAy0r
         wDp4hg2emgyXaQxrKreO9W6LfyIiWeMZS8zSEHPmCO4BAgkU6wFetLvKpW0mHmz/HjDu
         0iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fi4v9QVEbJBS29NLpBWanHSYjhSWP0ozXzu1zdb62tQ=;
        b=XGTSJGJgRbAk+I+QQoCY+fs/WuR0CY9fRmqrkGqHbtvAbsZM4Wl5VW4+exNZhGpfnF
         5Dj/SIfD76aKq1gALduok5aBMI4RcM+gPFCMYF8FelagNPOSHC6dLE7WfB2Xja+Ee4WF
         BS9wIaBiQt7r6rwl4z4oxja17Jb5bPwxQ4Y2WB90xl2kjkPUYp7sY3xRdtoNPIO7d53A
         2jhPnUx0BTmsQJcZtiE5qmgZEcmhTi8kr8Kd6Iw/ykajDPv9HhDJS0bwp+ja4evYyPSb
         e9oLbEpGK5tjFgxzVFOQRZnMlq8GrbByzWzxZJ3ruGlUUXBY+rRn19uGDDTD+9QFhncH
         eruQ==
X-Gm-Message-State: AA+aEWZ0hb6qc7oSYJZWzAHntEuXw6WwMx+3ruKBBI3zvfTGyP3P3lrU
        UIRqMDWPhxIQO0sgs6cAucCjf0SZMpEIwnLLfIU=
X-Google-Smtp-Source: AFSGD/VqAPX0VXaUA49Mwqx0exh7PvIBqs/kkMjMy7lEFPL9JyXNbqkxK4CmnWihb2jipD1wtGHr5+6cwhNYNQUqaeU=
X-Received: by 2002:ac8:728f:: with SMTP id v15mr23042461qto.260.1545943705005;
 Thu, 27 Dec 2018 12:48:25 -0800 (PST)
MIME-Version: 1.0
References: <d1a036ae6ecc7614d969e841ee2e9d2f@memeware.net>
In-Reply-To: <d1a036ae6ecc7614d969e841ee2e9d2f@memeware.net>
Reply-To: BonOnlines@gmail.com
From:   Bon Onlines <bononlines@gmail.com>
Date:   Thu, 27 Dec 2018 21:48:11 +0100
Message-ID: <CANV0cTm1PfB61hg-zcxDqdwCKOLSoX0evkwWmv0fHGxgxsf4iQ@mail.gmail.com>
Subject: Re: Why is no one discussing this anymore?
To:     vsnsdualce@memeware.net
Cc:     Raul Miller <rauldmiller@gmail.com>, visionsofalice@redchan.it,
        OpenBSD general usage list <misc@openbsd.org>,
        linux-kernel@vger.kernel.org, freebsd-women@freebsd.org,
        freebsd-chat@freebsd.org, owner-misc@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are you aware we are in the end of year holidays? I recommend you to
not call others as an idiot, as the only idiot here are you ;)

On Thu, Dec 27, 2018 at 9:31 PM <vsnsdualce@memeware.net> wrote:
>
> Why is no one discussing this anymore.
>
> It's like you just accepted the "NU UH U WRONG" proclamation from
> programmers.
>
> Are you idiots aware that programmers DO NOT KNOW THE LAW simply by
> virtue of being "smarts"?
>
> Are you idiots aware that I am a lawyer, I have studied the law, and I
> do know more than the programmers on this issue (note: I'm also a
> programmer too... but for something useful... like games :) )
>
> Are you idiots aware that Eben Moglen (drafter of the GPLv3 (not 2,
> Linux is under 2)) has NOT made good on his pledge to publish a report
> on how I'm wrong and let me "correct" him where he got it wrong.
>
> Why do you think that is? That in 2 months nothing.
>
> It's because, as a relative who's worked in the field for many decades
> said: he's full of shit.
>
> Anything he publishes would just undermine the stance he's taken.
>
> The license IS recindable at the will of the 1000s of grantors. Any one
> of them could shake the tree.
> _______________________________________________
> freebsd-chat@freebsd.org mailing list
> https://lists.freebsd.org/mailman/listinfo/freebsd-chat
> To unsubscribe, send any mail to "freebsd-chat-unsubscribe@freebsd.org"
