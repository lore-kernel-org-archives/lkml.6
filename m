Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609FBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211582089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4fFja1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211582089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbeKPJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbeKPJw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:52:26 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B20D821582;
        Thu, 15 Nov 2018 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542325346;
        bh=DJdl/aQE4Bb/td9fW8l9il6SHzBdgc524KJz+5OfLjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C4fFja1LhkSSRe1Gu3IaVRk15/5kmfYaeTTJcV9qYRxr+Px/Ouslgku4EpTM3tZaS
         umE0/JcWtOrxAyFrMRG8KNqKv987y4nZGzghv7uCrZnpcayp7h0M9+u4bur8TK3KFd
         m73/27VD9VhNsCiDpf4gn7IJr5t3ZYtVvWpJJZ+k=
Received: by mail-qk1-f170.google.com with SMTP id q1so34701451qkf.13;
        Thu, 15 Nov 2018 15:42:26 -0800 (PST)
X-Gm-Message-State: AGRZ1gJ5JFstD9Vn22lg39duLm7NnvEq2jKdt5dshYBTXWxj0R5KvA2P
        YEO9a5t6MPO2qFsgs0AKjbsm/7Xt65HVZOd3HQ==
X-Google-Smtp-Source: AJdET5da5E++auAxj7b1VvpHHbud5Xcj1a8vH+KtvrV0yaCksCCLV1Jbzm0c2x/ZiWQesMXJhNl/12HnvqprdWib/2s=
X-Received: by 2002:aed:29a5:: with SMTP id o34mr7794386qtd.257.1542325345848;
 Thu, 15 Nov 2018 15:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20180418222905.10414-1-robh@kernel.org> <e7a2f4ca-40c2-05ef-097c-2cecd31fb731@gmail.com>
 <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com> <CAKON4OxwAmmPv2+CEtT+eO3Uu8duCKD8OqyWj8+w2Y5SZ4bfOQ@mail.gmail.com>
In-Reply-To: <CAKON4OxwAmmPv2+CEtT+eO3Uu8duCKD8OqyWj8+w2Y5SZ4bfOQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 15 Nov 2018 17:42:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJd7F7=yyW5X0P4W0N+0UDA8MLPDGvbBBK+VqMKqajC7Q@mail.gmail.com>
Message-ID: <CAL_JsqJd7F7=yyW5X0P4W0N+0UDA8MLPDGvbBBK+VqMKqajC7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To:     jonsmirl@gmail.com
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        devicetree-spec@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 1:39 PM jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>
> On Fri, Apr 20, 2018 at 9:36 PM Rob Herring <robh@kernel.org> wrote:
> > I share the concern as I doubt most kernel developers don't know
> > jsonschema. But then the alternative is us defining and writing our
> > own thing which is C like 'cause that's what kernel developers
> > understand. My hope is to simplify and restrict things enough that it
> > writing a binding doc is straightforward without being jsonschema
> > experts. That was the intent of this patch without going into all the
> > details behind it.
>
> When schemas were first discussed long, long ago the idea was to have
> a n arbitrator who controls the schema (like Grant/Rob) so there is no
> need for general schema design knowledge in random kernel developers.
>
> First a developer should try and build their device tree using the
> existing schema. Then only if they find that impossible to do so
> should they propose schema changes. The schema arbitrator would then
> look at those changes and work them into the existing schemas as
> needed. Doing this via an arbitrator will ensure consistency in the
> overall schema design while eliminating redundancy with slight
> variations (like we have now).
>
> Another side effect of schemas is that as they evolve and enforce
> commonality among driver implementation it will become possible to
> turn those in-common pieces into driver libraries.

If we replace 'schemas' everywhere above with 'bindings', then this
pretty much describes the status quo today. Most device specific
bindings are a collection of standard bindings. Occasionally, we have
new common bindings. All the bindings get reviewed by me. The only
real change here is submitters have to have some level of
understanding of json-schema instead of just English (for writing free
form text). I think it will continue to largely be following existing
examples of other bindings.

Rob
