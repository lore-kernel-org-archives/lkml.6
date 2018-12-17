Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4BAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF21020874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6nFE8bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeLQWWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:22:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40785 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeLQWWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:22:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so12432664lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 14:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uXUeSCb6wymPCJz5JF6Rf4E7j2stig7Asxv3H/CpxI=;
        b=T6nFE8buAdeX0mJEej9rLMShxxsxjsL1x3K0R6Dgs1koSubgOxBWJtdLjYq6KCc/Qv
         GxJ6v6qUJCSPeZzIjfcBaKwn0kpQ8E6MtPuBaJ1nybw/2Pw2156gUgEtJXH/y7Aylq/T
         tl/3wbxVznouPXdtreNv0s1uMKoAk2cO3RRmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uXUeSCb6wymPCJz5JF6Rf4E7j2stig7Asxv3H/CpxI=;
        b=pT4ByBjmcwWOsHqVbPJubWEPFFBxzz61fqmyj340tiQBwbUp+HSdPVNDgELJmtXSEH
         6hBxDq5Lo1FoC9uhJ4kQ9+IJXqMOL2Q4hqkfAixzkPBOYx676GGsuXs/YpWiezZVvL5O
         Q6BxuuNhliGCmIDYDCOg20rLCqKNb/PJwhakOgPx2qkBPYXyrFFeZqSH4DlBH1d5jgTb
         DBT88Z6ekNMCQz3ry4gKXz1qQOdh3N9l3VYQCgALtxMkPzh6ruDzQjyE4EQkUTliaQVU
         9UGqnKLM1upVpcD8PopZbWpyitR7rION7j/PN0PYPQe/mSyI+VkE2pCaxCJtZFDGuz+y
         dd5A==
X-Gm-Message-State: AA+aEWbNx8YnIZMnZ+18Ms+kGwfDMnRq1+8IjH/jdmPZJCv3Fm1UTukQ
        yw74a44cPzFq/ESKfaCmpDIcaeM7SB574laYaaDNhg==
X-Google-Smtp-Source: AFSGD/VFNXrQZcnR/MhuUqZgiO3sn/GNB87fTkLvFPxmJQOoNqZ9vhF1Oqg60b0Jc9UlW3QO4eyxev1JTqFJE1/9QPE=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr8571077ljc.97.1545085319541;
 Mon, 17 Dec 2018 14:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20181217153652.20056-1-jank@cadence.com> <20181217153652.20056-3-jank@cadence.com>
 <CAMpxmJXrjyK3m4JwgkxwkHjSj-ugb7UzwNrYcBwYjWwj+JBNxw@mail.gmail.com>
In-Reply-To: <CAMpxmJXrjyK3m4JwgkxwkHjSj-ugb7UzwNrYcBwYjWwj+JBNxw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Dec 2018 23:21:47 +0100
Message-ID: <CACRpkdYq5Eg2DrwdED-yTZ4kMoCxew+0rdU-b4zuinOf7BEr6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Jan Kotas <jank@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 4:51 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> The driver looks good but is there any particular reason not to use
> regmap for register IO?

I thought we only use regmap for MMIO when the register range is
shared (as in a system controller) so that some registers are for this,
some register or even bits in a register for some other driver, so they
need the spinlock in the regmap to protect the register range.

It is also nice for shadowing/caching of register contents I guess,
wat does this driver get from regmap MMIO?

Yours,
Linus Walleij
