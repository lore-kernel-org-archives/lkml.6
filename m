Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED37FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9A02184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7Zf2Bpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeLSLOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:14:04 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:45355 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeLSLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:14:04 -0500
Received: by mail-vs1-f53.google.com with SMTP id x28so4359960vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZzmP5CXZYgnMuq7Hi7O92EA22A99yCWsjub4AkC6BY=;
        b=i7Zf2BpnyVkLxnHGfSpMpNYMFdCPusvGdP67GCj5iVU3LFzbK0WF3XM3A1XG6N27W+
         V6+r1Wf0UNdzIyEZODaH+/9aaMUDbArUPkSFLmTKOwifV2D1MU8LhryTP59rGWYjDazo
         OxZ4teVzvciJ2g6lqdxc6Nayaeap5Xd7fE/aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZzmP5CXZYgnMuq7Hi7O92EA22A99yCWsjub4AkC6BY=;
        b=Ft+4aVNI0IgWPobAHzkmCGOk+BBbIUUQNETxxqG4dTWceVRlZxlTkZJih8yebz+6xW
         Kr9QdR88xjiSkpGhemy11BVP3V4TMBJemmFtv4iN4rBm6HcU9HoM5TIEC3C7M5fvJTPc
         51ptWhXTVhRPIBtk1A4OdokzPeQQzxj/ttMn0cJ4Vrj4nER7jzlnzG4teOTwT5JY/US3
         52xnnNTgapZDkR2NfJPKf+bcSvSMMXb3fqLzt6VuaFhS+BwJS+tjLZiQM9QWazPm2pyw
         6C+PHeEYnee1cB1IVHbZV9FGv/as5TXm1K8XcrwCGHxPmrV+vyuGd1AfrheGP8zgUrvw
         n0Lw==
X-Gm-Message-State: AA+aEWanlW8/6hdPqlRuK5GIuN2ZDzhTkFbsSgx5oU1tl3Y1Mj1PvvwC
        LEb+KS8RXJ42FV5KK+rcshVVcSv64d049W3KnJCFfg==
X-Google-Smtp-Source: AFSGD/Wtbxtk9sbneu7mAQ6Vr26JSfpvronwcjXFh+w4aE0G8uUj2LOyyM3UxcDWHi/k7MxsbUIo1wLnaYaWsJEPwkU=
X-Received: by 2002:a67:b245:: with SMTP id s5mr10073771vsh.200.1545218042256;
 Wed, 19 Dec 2018 03:14:02 -0800 (PST)
MIME-Version: 1.0
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
 <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFq6X8vJU=pK1fgirGkD2-GS=LryRP1No8bSgPNLbyvAEg@mail.gmail.com>
 <CAKfTPtCpv0MqF64JGTyR63bqKdAhXzL1fEsNbS6DHsD-jXYpKw@mail.gmail.com>
 <CAPDyKFrSxX-eBsTiEvbrbjVpqkSuBnhxruCgtihH6hSvWSFD1g@mail.gmail.com>
 <CAKfTPtB=TUAz=KpZzJsRUvK8ymiXnTgQ3BxcY0yu9YbJ1BW7QA@mail.gmail.com>
 <CAPDyKFoR7t=K65n0_+4yRqdpRMZ0BbA16cDhmxEvNhm0qEOXNQ@mail.gmail.com> <CAPDyKFpfDF_7ZyhRY-jfapjuQQ=5KpQt7QV2-d_a-qki=omAYA@mail.gmail.com>
In-Reply-To: <CAPDyKFpfDF_7ZyhRY-jfapjuQQ=5KpQt7QV2-d_a-qki=omAYA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 12:13:26 +0100
Message-ID: <CAPDyKFpQ3yVe5_opAEs1SprSD-VhqZREEunpw8HMD+1F=r2C+g@mail.gmail.com>
Subject: Re: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        jani.nikula@linux.intel.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> Hold on. I am wondering if the drm driver could use the existing
> pm_runtime_autosuspend_expiration() function instead. Isn't that
> really that what is needed?

No, it can't. I don't know why I thought that, sorry for the noise.

U
