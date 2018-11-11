Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D127321104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=genki.is header.i=@genki.is header.b="t35V/Cuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D127321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=genki.is
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeKLDav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:30:51 -0500
Received: from genki.is ([104.200.25.21]:43348 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbeKLDau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:30:50 -0500
Received: by genki.is (OpenSMTPD) with ESMTP id a751a57d;
        Sun, 11 Nov 2018 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=genki.is; h=date
        :message-id:mime-version:content-transfer-encoding:content-type
        :from:subject:to:cc:in-reply-to:references; s=dkim; bh=dgnBQf6qs
        x/E5md9I1XwCrwdU3A=; b=t35V/Cufr6EZHxCSGFrAtBJoyOmIamwC7O877hZr9
        +iG1N6JlCxfl05Jvy7HLhMLD8JDyshrx2NZAvBLA8cOgk6chueKk7ERMeA8QL/+T
        W3lTgZxMNGSUuOz7yIdwoVv7hTEWyOvIm3ofAghLXS493pf4ZZll68XvKWFYwobw
        NwlrnOmBcInyCWdr0DL7tpHBnE2IpW1QJNsC6+A9YRy7Te2bMeCqj94Vvh4e6xX0
        rBqWLJCWrL13h6UAgSglXoWbPi+3UguMbMe7yd0RQSpq7agAuPF7xmGhfkjsMXO2
        k+RdGLsnGJGb96FE0w2adxuTedz1anSdENaVBTL5OPzYw==
Received: by genki.is (OpenSMTPD) with ESMTPSA id 15aabc5c (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 11 Nov 2018 17:41:40 +0000 (UTC)
Date:   Sun, 11 Nov 2018 09:41:40 -0800
Message-ID: <20181111.174140.002789201@genki.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
From:   Genki Sky <sky@genki.is>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     schwab@linux-m68k.org, briannorris@chromium.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        dianders@chromium.org, Guenter Roeck <linux@roeck-us.net>,
        lists@nerdbynature.de, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
References: <20181107022156.GA254567@google.com>
        <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
        <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
        <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
        <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
        <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
        <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
        <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
        <20181109183436.GA45531@google.com> <20181110.085826.230851261@genki.is>
        <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is>
        <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Sun, 11 Nov 2018 16:48:38 +0200, Alexander Kapshuk <alexander.kapshuk@gmail.com> wrote:
> Piping the output of the git command to grep and using the return status
> of grep as the test condition within the if block, would be sufficient
> to determine whether or not '-dirty' should be printed.
>
> Sample run:
> % if git --no-optional-locks \
>         status -uno --porcelain \
>         2>/dev/null |
>         grep -qv '^.. scripts/package'
> then
>         printf '%s' -dirty
> fi

I don't think this works well for us. We need to check whether
--no-optional-locks is available before using the output to determine
whether the tree is dirty or not. If it's not available, we have to
fall back on diff-index. Let me know if I'm misreading you.
