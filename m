Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F157BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B484C2192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NaguH4gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392925AbeLVX2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:28:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35903 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeLVX2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:28:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so6315600lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 15:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/R1ouawAlcu48wS/MnacDmr0NAhSb7obzXcvQnE2ks=;
        b=NaguH4gf/pmfYQRrtsGEKmqNOgwFgRSBFJ50D5PRbRVSurKyKNA46a00qYScxq+rI+
         WlRWqoOn8VGWXsKA+TJ2cy+TcaMaKNFtNxFoZc1Kvd4L6Mur0VvJ8YibXxstD8t6BRd9
         myGnnZvBjuzVlkF6u/h3LTsyJYgzX2oeMFXDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/R1ouawAlcu48wS/MnacDmr0NAhSb7obzXcvQnE2ks=;
        b=UIlJk2CGf1xLqL2aNvLnMvMWMz57IpCwcTkk/oSCLbolkcDdBj7WRtESHw2qvTi8aF
         cZD3uIcNKRUveVIAdwkYLKqBGWrdokVO4yySkvnx6geVTSQdtMyF4SbhVJpvBv84HtC7
         KRgeLsHrggiTzsi37/fTVuqiFkLGjQHVuoR+5GnZzGDewVX3H9eMA3DM7QO1JH4iZmmT
         aQ7QWPQ5Vp+xFByN7zul4ukPee+cAN+SXCy89hePM7uApDh2qWYyiEAVHgdHvod44g0b
         5w80dcgT6jqsbIG9DfJ6ykuHb4r2IBHkPycZgZRCrPvP1kyDYoYSkrqalZ+KFeOOPL7B
         f8PA==
X-Gm-Message-State: AA+aEWa+l9WHNnEuQUlW/R/EUnmqterW7/nit+sIJ9OHu2A4e7UbyiRy
        2sKJjuuvCBcXQxS/pWN1uM1Yj43GjDw=
X-Google-Smtp-Source: AFSGD/W/ROw0v8fMAt/07c0Z5a9KJBzDHQZJAsyqogaPLGWMAhu175uWQCJh8fUnG+h+6WWLYcBqrQ==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr4276131lfe.45.1545521320910;
        Sat, 22 Dec 2018 15:28:40 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 185-v6sm2939231ljj.49.2018.12.22.15.28.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 15:28:39 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id k15-v6so7816264ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 15:28:39 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr5008878lji.133.1545521319137;
 Sat, 22 Dec 2018 15:28:39 -0800 (PST)
MIME-Version: 1.0
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
 <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
 <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
 <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com>
 <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com> <CAPP7u0UhPyC=eewx4dYu+AU5tK_URE8_5PW9cNkK6Ppp7vkqHg@mail.gmail.com>
In-Reply-To: <CAPP7u0UhPyC=eewx4dYu+AU5tK_URE8_5PW9cNkK6Ppp7vkqHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Dec 2018 15:28:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8Qrh4nvFbWttz6zPMeRKO2Twv57vZfGaQ6odsjYFEnQ@mail.gmail.com>
Message-ID: <CAHk-=wg8Qrh4nvFbWttz6zPMeRKO2Twv57vZfGaQ6odsjYFEnQ@mail.gmail.com>
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     christian.brauner@canonical.com
Cc:     nix.or.die@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        ellierevves@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, seth.forshee@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 3:07 PM Christian Brauner
<christian.brauner@canonical.com> wrote:
>
> However, for this case should I resend the revert?

Since I was pointed at the original email thread, I just picked it up
from there directly. It still applied cleanly, nothing had changed in
that area.

                Linus
