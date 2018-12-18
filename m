Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87300C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442E321873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugXYonj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeLRToB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:44:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43042 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeLRToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:44:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so8267262pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5KpjPgUHX+RxhsBvBsdScbhtSLPb9ZzjMgkOlOcy5A=;
        b=ugXYonj3lGNzo3fHCjSPE9Bzj1KIa/jjcq/Bo0NSDr7mWAzFykHuZZBDKn40QnKlsD
         PB/jTH9S/fP56EIQVXccfgWXN8NqglU6Qx2HnL2mk1D8ImpZk6StrATlIfDeb/7oQumD
         op44r8edWm1JaeEchcqn2+uf9IwuZZuJRNHoVK5yin54XCrYKvBgqyyOESVKHSyktN2+
         ZAyBJA8EOVSUBBC0HZVJXEwkzU5MCSuGlzMhjs+xhT4S2azQuidPVzNN74o57/CC8EpK
         D9DNCA3nY0nzuddD/pBHg6DD+7iWTFA/sHBUpzSG9+98TTgEE5b1LI2aWA7oz/exShdo
         39Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5KpjPgUHX+RxhsBvBsdScbhtSLPb9ZzjMgkOlOcy5A=;
        b=DDxXEXWaKVdiZfoPwwg0OCaiy5V0E2ftgim/iQRDFcqDAxEeSaVUCMkXiIMChdMoM/
         MDplRkV4RvsKvJSkZnFr4adNx51ZA2HhJ/pR4o8X9eGZXN2BqXeSXyVtMv4dTIH6wB5H
         RmqjjIVau3zh+7THOuLSTbcgix6cBqrvOiexyEgP6zikpwos04xnSnvbbSK163E+gcah
         b8O+b8O8vPTwix8NhCfFD7REnLCom1J8NRxLMqOAhg6hx+etT0uNdzh6Bc2t+vnpTfso
         YmZndtKL15HeegEej5Ah6+Ac1RaCjObLIZDEChJuY7G5stP9S0Ha/BqQMwgaz701KuVD
         13Ew==
X-Gm-Message-State: AA+aEWacPzl/cQPVHukraOhJ4umagP9oGk2ialcSoltAhqmWRvqnoJ6l
        gCyUs9stqGA65Ye0km60NmDPx1yjJrX4bm//xX/1JA==
X-Google-Smtp-Source: AFSGD/U03CTuUDilZSep8CQ7qPeyiP5gSpZaqT9dluQX3xCnzrrBLUmdZ0Cxqg4Yklw8IGa2qevEBTQT6ErfyNcX7pY=
X-Received: by 2002:a63:e156:: with SMTP id h22mr16976992pgk.255.1545162240518;
 Tue, 18 Dec 2018 11:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20181025193601.11746-1-natechancellor@gmail.com>
 <CAKwvOdm2r8bfXQCBiUjnQNnCs8ETxzYQHK4ZjMrfLyRvw77zAQ@mail.gmail.com>
 <154513398652.1108.7150969916024071452@skylake-alporthouse-com> <20181218190143.GA7036@flashbox>
In-Reply-To: <20181218190143.GA7036@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Dec 2018 11:43:49 -0800
Message-ID: <CAKwvOdmVoLECad49ggj2gBWLUneRXDAksBUVxXTsCoqJyseyiA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Disable -Wuninitialized for intel_breadcrumbs.o
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:01 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Tue, Dec 18, 2018 at 11:53:06AM +0000, Chris Wilson wrote:
> > The other false-positive clang-6 gave was for local_clock_us().
> > Presumably that one is fixed?
>
> With this patch, I can build i915 using defconfig and allyesconfig
> without any warnings with tip-of-tree Clang.

Also, please let us know about any other bugs found via testing with
Clang: https://github.com/ClangBuiltLinux/linux/issues

We're happy to take a look!
-- 
Thanks,
~Nick Desaulniers
