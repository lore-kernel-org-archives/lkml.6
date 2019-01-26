Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51713C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1A0218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyekXCV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfAZH5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 02:57:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45056 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAZH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 02:57:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so9082796edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 23:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1gG+vECuEBj91or9sy2L2olqgqZyRyHNB0EkLQJObj4=;
        b=RyekXCV8BkvSyiuFwnySyJRGNxYZbKW+K/FQ4xQ6fF4y4C5SjiwJUUGyLtSdwzF2sC
         aVPyjNIJxeBW9nR+dmabhQKENL3qQ/sd53RMQXkuuL69jcj9Xm2lpIJglIa/nRX3+Xb1
         +LPUfQABszo8aF1cUwYzEj9b70oc7aqEseoLZ3ZE2suNuk5c59SJnNj9Mc0Lxb1CfPt7
         S10jXnQ5frgItGU5iy/ly6nVpCQWM/xyHObfNa//ZqfDDubfeU4R6VKJ2nPVwixEdHjn
         DnuJszcfsYy9rL0XrbJLvkbqDTzvZQY9P4f8q3Anpoqst8Ib9E46D8TNCamRBXfFIVqQ
         rvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1gG+vECuEBj91or9sy2L2olqgqZyRyHNB0EkLQJObj4=;
        b=qLzOE8HEqc48gUnWWCto3RUHA5mswu0Vxq0deq6PMVj2OHJzoRa6RVVbll9qYNVTNC
         vgWupAiXpNs9CqALBYYkCI4GZY0T8JnEauQ9m1yba7E2lM9NLEc+B1pkEX4E7UG3AyPe
         FG62XkAKCYQRTzhPQyeouq3SXWwArzbIFqLNni2IANf75LkGsiL70erkmpsQ+vhj67mQ
         cmJCyam90RaZcs0hknhckATTjixaveEdoqyyg58/NdfdduLzC2pToQW6RanbhPAzMmWJ
         mIl3UXk34jMXyXEuatBKAfA5nr7N7P798PX0YXiKdmO0+tnaT9UBNniWQH8/h60sSMJb
         eV5w==
X-Gm-Message-State: AJcUuke3b/v0lBTBFnZ6NgaCTLgYSR3VgJQWVRq3s/Wnix75ec8Jd3Ov
        Sglooly6Tj8yzQpnJlJNIAM=
X-Google-Smtp-Source: ALg8bN4TiWhJgc8xLgQ6zEQNRewSFLkGfgayzNDVx9xeqTjS9Ug1DgqObZsnVeBY7/diIXybWsDu3g==
X-Received: by 2002:aa7:c605:: with SMTP id h5mr13875063edq.9.1548489472124;
        Fri, 25 Jan 2019 23:57:52 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id k20sm12059994eda.71.2019.01.25.23.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 23:57:51 -0800 (PST)
Date:   Sat, 26 Jan 2019 00:57:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2] drm/i915: Disable -Wuninitialized
Message-ID: <20190126075749.GA30117@archlinux-ryzen>
References: <20190126071122.24557-1-natechancellor@gmail.com>
 <CAKwvOdmA6075WEPaKkL9d1wUQmboU9CxhbNT1oiVk8_Onjh5Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmA6075WEPaKkL9d1wUQmboU9CxhbNT1oiVk8_Onjh5Rg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:34:19PM -0800, Nick Desaulniers wrote:
> On Fri, Jan 25, 2019 at 11:13 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > This warning is disabled by default in scripts/Makefile.extrawarn when
> > W= is not provided but this Makefile adds -Wall after this warning is
> > disabled so it shows up in the build when it shouldn't:
> >
> > In file included from drivers/gpu/drm/i915/intel_breadcrumbs.c:895:
> > drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c:350:34: error:
> > variable 'wq' is uninitialized when used within its own initialization
> > [-Werror,-Wuninitialized]
> >         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> >                                         ^~
> > ./include/linux/wait.h:74:63: note: expanded from macro
> > 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
> >         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> >                                ~~~~                                  ^~~~
> > ./include/linux/wait.h:72:33: note: expanded from macro
> > '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
> >         ({ init_waitqueue_head(&name); name; })
> >                                        ^~~~
> > 1 error generated.
> >
> > Explicitly disable the warning like commit 46e2068081e9 ("drm/i915:
> > Disable some extra clang warnings").
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/220
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Reviewed-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> 
> probably could give Chris Wilson the suggested by tag.
> https://lore.kernel.org/lkml/154513398652.1108.7150969916024071452@skylake-alporthouse-com/
> 

Ugh you're right, completely slipped my mind.

Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>

> > ---
> >
> > v1 -> v2:
> >
> > * Rather than disable the warning for the problematic folder, disable it
> >   for the entire folder like Matthias's commit.
> 
> Thanks for following up with a v2.

Thank you for the review!
Nathan

> 
> -- 
> Thanks,
> ~Nick Desaulniers
