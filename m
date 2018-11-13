Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17196C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EA620896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EA620896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeKNIDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:03:45 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51001 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:03:44 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42vhTc0k5bz1r2nj;
        Tue, 13 Nov 2018 23:03:32 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42vhTb739dz1qrn8;
        Tue, 13 Nov 2018 23:03:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id P3ZIq1MMviU3; Tue, 13 Nov 2018 23:03:31 +0100 (CET)
X-Auth-Info: 87Qw1n2M1OTgDxe6XOh1hsy92xkkzaKo+MjTfTIGy3cCvaqzZY9IWVLrUKyOD30i
Received: from igel.home (ppp-188-174-148-99.dynamic.mnet-online.de [188.174.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 13 Nov 2018 23:03:30 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 7CABF2C1F08; Tue, 13 Nov 2018 23:03:29 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     alexander.kapshuk@gmail.com, sky@genki.is,
        yamada.masahiro@socionext.com,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scripts/setlocalversion: Improve -dirty check with git-status --no-optional-locks
References: <20181110.085826.230851261@genki.is>
        <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is>
        <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
        <20181111.174140.002789201@genki.is>
        <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
        <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
        <20181113000938.GA16783@google.com>
        <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
        <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
        <20181113190335.GA50985@google.com>
X-Yow:  Yow!  Now we can become alcoholics!
Date:   Tue, 13 Nov 2018 23:03:29 +0100
In-Reply-To: <20181113190335.GA50985@google.com> (Brian Norris's message of
        "Tue, 13 Nov 2018 11:03:36 -0800")
Message-ID: <878t1w7hzi.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 13 2018, Brian Norris <briannorris@chromium.org> wrote:

> +		} | grep -qv '^\(.. \)\?scripts/package'; then

\? is a GNU extension, so if you want to stay portable you need to
switch to ERE.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
