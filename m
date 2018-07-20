Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DACECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5A220833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eH8m9KgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5A220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbeGTQLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:11:38 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39176 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbeGTQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:11:38 -0400
Received: by mail-it0-f66.google.com with SMTP id g141-v6so12698727ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=tbPZlFQX0aNzoXp4cVlFlxRlvFUyR/LVZokBfq6Cbmo=;
        b=eH8m9KgNlN0vqmIXRyUyHYD0Rqyk3GQfF41xmK+Ym2qRdDsa9S0kP5icwvgDAQvCHt
         vkqgdlUnEm+cKmaXD4s6V0gs9eiwvOLx8OWfIFt+qdP0wctbcqyrT3X4wFdLfd8AhR4X
         XQGmM91Veym6DlglkiBzxG90Rs8pZzKs8l9jO1DssRs47VtlwAW5/koY+89+AhTuUi8D
         qmCCdf9RYO1b0sCFY3+TQwc6vh2awTXCxFg8N9XOJ/A/ZzzfEBdIoXqERnC/zypd+LpN
         JMNlB06FVkwEnWghb75g6OxILZSrdNQgmBP9b/yFR0XERGA5MucUgi64OsiHFAoCMGnP
         tVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tbPZlFQX0aNzoXp4cVlFlxRlvFUyR/LVZokBfq6Cbmo=;
        b=S4qrhxe3B1NCRvdcdGy5Xpu48uYJo48W/TRQ3GGjLndp4+pcarRc04qtkK5INf7OIO
         45aYrmn64CSg+t1mbi3z6AwVT0Iq0CmwRCW7R9Jw/Jaj+fHyxnuqecICBa5b9T3td55x
         emz4wj4VVy2Q2KhVvYr7ip29vcrIUINGoCQQnTHdvgDluX3umsLVDCWEeciMScgf/RmM
         bC9XFtnRgv6W631w01T8xl9J9GD+3iw0tWnNLkc3e2SKyf4oCqprRAOvl86SJc9lTG7G
         56R5UQJ0/R649BVx3d3FYSoTv/DYU3atn+lCJ1ph9CQ5uROm6bd9Z+DHRIsFjoMEHt7X
         KjJw==
X-Gm-Message-State: AOUpUlHEhLAFnXfnLQDHEms+G/GXgeXHyWAmbdrVKrUb9at9kzXzMUaC
        vADGEyTouGkDVZUEez8VYm/iUg==
X-Google-Smtp-Source: AAOMgpeuOsnFTV8vX7PWNZoryc6AtlPzCjNnOUeCou2vsqAObO5KYJbFgTGgRg1iThWiSfNjD0igwg==
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr1855595iti.135.1532100170973;
        Fri, 20 Jul 2018 08:22:50 -0700 (PDT)
Received: from localhost ([2604:2d80:4413:8125:f9a8:268f:dca5:76cc])
        by smtp.googlemail.com with ESMTPSA id u125-v6sm2927329ita.4.2018.07.20.08.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:22:50 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Signed-off-by missing for commits in the amlogic tree
Organization: BayLibre
References: <20180716080014.75c9016b@canb.auug.org.au>
        <7h4lgvm3go.fsf@baylibre.com>
        <CAOesGMghENGioK2o_dZKGPJYT01yoP9Fks1k-i1SUXZFENu3Lg@mail.gmail.com>
Date:   Fri, 20 Jul 2018 10:22:49 -0500
In-Reply-To: <CAOesGMghENGioK2o_dZKGPJYT01yoP9Fks1k-i1SUXZFENu3Lg@mail.gmail.com>
        (Olof Johansson's message of "Thu, 19 Jul 2018 14:57:19 -0700")
Message-ID: <7hh8ku53ue.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@lixom.net> writes:

> On Thu, Jul 19, 2018 at 12:26 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>
>>> Commits
>>>
>>>   3f1ad8c53b29 ("ARM64: dts: meson: enable the saradc node in meson-gx-p23x-q20x.dtsi")
>>>   4dabd157d48e ("ARM64: dts: meson-gx-p23x-q20x: move the wifi node to each board's .dts")
>>>
>>> are missing a Signed-off-by from their committer.
>>
>> Oops.  I missed these.
>>
>> Olof, these were just merged by you in my PR[1].  How do you want me to
>> handle this?
>>
>> I could respin the PR, or just send another with them reverted then
>> re-applied with signoff?
>>
>> Or, since these branches don't need to be static (yet), I suppose you
>> could just edit the commits and add my signoff.
>>
>> I'm OK with any of the above, let me know your preferene.
>
> Hi,
>
> Fresh pull requests is probably easiest for all. I'll drop the one I brought in.
>

Ack, I'll resend.  Thanks.

Kevin
