Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D42CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C37E222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4nWs+tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfBLS1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:27:04 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39873 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBLS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:27:04 -0500
Received: by mail-ua1-f68.google.com with SMTP id s15so808689uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUTN2kVgPr9Rtx3niaarjV1+OXsIe+jmKVNS7ZlRBbk=;
        b=k4nWs+tDNGy0ynHcSKhJ+yAvoxk4/6erIg4nXcXkJQmK+UDcuJ9ZTwwN36K9Xr0uaB
         oauBPEPeyWrsMPyZozjMHqxHjJ2/V0Td51Iqq7boFOHaDkQClRVwmQmbdm065mUFsOtJ
         2cPSfBQT8ibSF/TOK923MTXQoVBguBQGJ1fo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUTN2kVgPr9Rtx3niaarjV1+OXsIe+jmKVNS7ZlRBbk=;
        b=SpqZQXjKFZwgJ1/JN58t+uATjeJnKzRiBY1yUKB6U09ZZbIEf2KceCYwIN2EPQFbnh
         H3FfWc5mUKbQyt3Xrzk+o46i6c/EpQcZwsYjfg3GvuXKlrYGQc/2YQNEFlFohiSZTdT4
         ch+BqkEwA2rujVgZjb094odB1lBcvQpkIw9LWV1TA39v2O8ZqVxXHbR+bioAqYhb15L6
         wjzoKlY2W46Co+AZA64Cea1nogN8vfwoAZuaL0EQFbuNEGT6ul0w4zDZxq5NgkMZddD+
         J+0uBOXuO+1Npa9GMkyMkarh7gcKuYUHhBm/JPhuTAQSjhj0l1mwLaGALh+CZOhPDE5r
         r0ow==
X-Gm-Message-State: AHQUAuZSAtKVsv+sJaZbpJLliJx53Uvds/OrCP1SZ3y3VOrQrjWUlERW
        NhDtGjR1g+AH3My5UU3d8qgqtRjOGhg=
X-Google-Smtp-Source: AHgI3IZRQZnrQ8lh5piQJQI59DCrww/jjiOjWoy58rIybeo6kM2M2OseAPFZzsFb8DNN1QXfk+Xacw==
X-Received: by 2002:ab0:148e:: with SMTP id d14mr2008593uae.23.1549996023344;
        Tue, 12 Feb 2019 10:27:03 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id u188sm2791860vke.33.2019.02.12.10.27.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 10:27:02 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id i64so2200145vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:27:02 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr2071837vsd.222.1549996021985;
 Tue, 12 Feb 2019 10:27:01 -0800 (PST)
MIME-Version: 1.0
References: <201902120021.x1C0LeYB051392@www262.sakura.ne.jp>
 <CAGXu5jJ86XosW71111EaaSKcVwzw+UYvi4j619KwoBn=DNwrNw@mail.gmail.com> <201902120059.x1C0xEbp071744@www262.sakura.ne.jp>
In-Reply-To: <201902120059.x1C0xEbp071744@www262.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 10:26:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKH83LJxd=yHs3kAfnjVxX9wphpivwaKnqvByJHwoi4XQ@mail.gmail.com>
Message-ID: <CAGXu5jKH83LJxd=yHs3kAfnjVxX9wphpivwaKnqvByJHwoi4XQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: Ignore "security=" when "lsm=" is specified
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:59 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Kees Cook wrote:
> > On Mon, Feb 11, 2019 at 4:21 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > Kees Cook wrote:
> > > > To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> > > > used on the command line, and report that it is happening.
> > >
> > > To maintain the existing behavior of CONFIG_DEFAULT_SECURITY, I also suggest this change.
> > > This saves e.g. Ubuntu users who are using only AppArmor from explicitly specifying
> > > security=apparmor when they don't want to enable other LSM_FLAG_LEGACY_MAJOR modules.
> >
> > No, this completely disables the purpose of lsm=
> >
> > I don't understand the use-case you're concerned about?
>
> The purpose of lsm= remains.
>
> I worry that distro users who don't explicitly specify security= parameter
> suddenly find TOMOYO messages because TOMOYO is no longer exclusive.

What's wrong with that? TOMOYO will start, see there is no policy, and
not do anything else.

> There are two ways for avoiding it. One is to explicitly specify security=
> parameter. The other is to remove tomoyo from CONFIG_LSM. This change adds
> the third way; preserve current security= behavior until they start explicitly
> specifying lsm= parameter.

"security=" has been deprecated due to the many many threads about how
it won't work moving forward. Leaving the CONFIG settings confuses the
situation and needlessly drags out the transition for no real gain.

But yes, if someone selects a "legacy major" LSM, the others
(including TOMOYO) will be disabled, which matches the old behavior.
Also, yes, removing it from CONFIG_LSM works; this is up to the distro
to decide.

-- 
Kees Cook
