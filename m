Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770CCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A09221874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNwyxTEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfADGO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:14:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44377 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfADGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:14:26 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so28790402iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 22:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwUAtZgw6D0Px0XPgR5mtdpPcEh8C/PJRFiqNBAkl4A=;
        b=TNwyxTEvJ/ajyBOx1EAfgCEutyIv9rSle9BHLhLq51vy+dH5yfMcxM/10LKw2KlgkO
         Mo9zG7z2TCHcQyD/z0KxYZV5q93fClosmEdBZ9ZHign3DcQsA8cbEptu1PZkS9hSjSFk
         +Hnxz0L6h8rNJUApoa7TmlqMbaks2jKrFWVVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwUAtZgw6D0Px0XPgR5mtdpPcEh8C/PJRFiqNBAkl4A=;
        b=aSNlfileckhagxblEPb2GWeEt1OE+akwbtn8qbYDPRmzkE9rV7qEuc13NYC2dSN8Tq
         lyM1wIzFI+hlZWv/EAbrcKrPodKzjH55Sm4bDdiFWA1Tlu3RQCbvG9MPdgwOEGitEhV7
         Cme27vCNCyyxcPcw+DeRgANy+D99o/ZePTxFYM4mvA5Tt6CtqhJdyiJKlYCGtSzDTfm7
         s/6dQgJsbIfSWBWVr6QxdtK/zO7SO8l4q/drVvoC5Hax2ObBjMeIdkIVlaMJEzpAUz5b
         UEGZE4o7YQtPVxs0pHHBXObqaVhutH2ukzj4QTqTAgn1lYz1jQ4AAFx1TKz47m72fxwI
         Le2g==
X-Gm-Message-State: AJcUukeknhDo9of24DGxzdiWom9uH0JI10bfvO/FNHpR6Wg1iHOTRrU6
        TW7zc8bqUKI3tY5GlMyQHqTKSYEBtMdMTsT3mUvLgQ==
X-Google-Smtp-Source: ALg8bN6rrV7yca8YNfgI0XrKZ4OX1vbvWcBCshyu3jJWAjJmg6Py7qE9TcutzfFnLAfvPurjNZwbpBAjhnv0MSCvOUY=
X-Received: by 2002:a6b:4106:: with SMTP id n6mr35084764ioa.171.1546582464820;
 Thu, 03 Jan 2019 22:14:24 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
 <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com> <CAMo8Bf+EJ+AaxfWGUcWMxsE=kpYD=-whAb0CxvdGYg+eK4bWpw@mail.gmail.com>
In-Reply-To: <CAMo8Bf+EJ+AaxfWGUcWMxsE=kpYD=-whAb0CxvdGYg+eK4bWpw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 4 Jan 2019 11:44:13 +0530
Message-ID: <CALxhOnhVKRC0faiQTNNeUP3rYtK7aUg1Sr758ScokrBnE55iHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Fri, 4 Jan 2019 at 11:25, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Thu, Jan 3, 2019 at 9:17 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Fri, 4 Jan 2019 at 08:28, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > This was intentional as I was trying compile other one architecture with the
> > previous implementation, it was giving the error. So I modified without space
> > after comma.
>
> I have tested that presence or absence of space does not affect the build
> for xtensa, and normally we put space after a comma, so I've mentioned that.
>
> Since this script is anyway removed in the next patch of the series it doesn't
> really matter whether the spaces are present or not.

Yes, you are right, there is no effect in xtensa but if I'm right
there is a problem
in powerpc architecture (not remembering exactly which arch) with this space
after comma.

BTW, the script from all architecture will be removed and keep it in
scripts directory
is our plan. So to satisfy powerpc (again I'm not sure which arch) I
just did this
change.

Thanks for your feedback.

Firoz
