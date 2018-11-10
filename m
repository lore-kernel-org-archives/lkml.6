Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06145C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4930420892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4930420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=genki.is
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeKKF5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 00:57:03 -0500
Received: from genki.is ([104.200.25.21]:43330 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725761AbeKKF5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 00:57:03 -0500
Received: by genki.is (OpenSMTPD) with ESMTP id c04140a1;
        Sat, 10 Nov 2018 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=genki.is; h=date
        :message-id:mime-version:content-transfer-encoding:content-type
        :from:subject:to:cc:in-reply-to:references; s=dkim; bh=oYr3Mi8ot
        7Rhh2djUfPkW95DG9c=; b=UroW0Sv2CusivINK6kbE98jI63+A02TzNW8VR4bY2
        uEEG8vUlBqjmiri/PFkcch7qfpfKa7oty6H5OzwnFZSvoAMrLE2ZCYqPbriucfgc
        zqNtj9KihGiloqG5h9f9d16erDs9RHvTuDJQrVX14BF9ePYGvrRsCXSWoF7L1ACg
        m22njzDWeUbRSf9N5QGf9yXL7/INsxriBHUTTUZtVDlxPf6er+rFAI3FDPfa5GiK
        8BBO43iPSc+mJIlNB3I9FgyfjzPvKBBCnrH5HD+BdSpHE6KgRHpMIQGAEK951QSD
        FRWDM59lFwEoxRilSURp/qJWNqDxl1skTwWLatCvBUb+g==
Received: by genki.is (OpenSMTPD) with ESMTPSA id 72b3af66 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 10 Nov 2018 20:10:51 +0000 (UTC)
Date:   Sat, 10 Nov 2018 12:10:51 -0800
Message-ID: <20181110.201050.925673938@genki.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
From:   Genki Sky <sky@genki.is>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christian Kujau <lists@nerdbynature.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m24lcpjjss.fsf@linux-m68k.org>
References: <20181107022156.GA254567@google.com>
        <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
        <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
        <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
        <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
        <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
        <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
        <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
        <20181109183436.GA45531@google.com> <20181110.085826.230851261@genki.is>
        <m24lcpjjss.fsf@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sat, 10 Nov 2018 11:42:11 +0100, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Nov 10 2018, Genki Sky <sky@genki.is> wrote:
> > On Fri, 9 Nov 2018 10:34:37 -0800, Brian Norris <briannorris@chromium.org> wrote:
> >> +		git_status="$(git --no-optional-locks status -uno --porcelain 2>/dev/null)"
> >> +		if [ $? -eq 0 ]; then
> >> +			if echo "$git_status" | grep -qv '^.. scripts/package'; then
> >
> > Shouldn't this be:
> >
> > 	if printf '%s' "$git_status" | grep -qv '^.. scripts/package'; then
> >
> > I.e., use printf not echo? Because of echo introducing a newline.
>
> The input to grep should be a text file, thus should end with a newline.

Ah okay, thanks. I guess GNU grep was being lenient. Well then, I
think the line at least needs to be changed to:

	if [ -n "$git_status" ] && echo "$git_status" | grep -qv '^.. scripts/package'; then

I'm just trying to say that in the proposed patch, if git doesn't
print anything, the echo adds a newline that wasn't there before. This
causes the grep -qv to exit with status 0 (because there's at least
one line that doesn't contain '^.. scripts/package'). Meaning it will
print dirty.
