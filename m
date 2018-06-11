Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5D056C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258E20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KSJ2KWYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0258E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeFKTXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:23:44 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:40610 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753786AbeFKTXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:23:42 -0400
Received: by mail-io0-f170.google.com with SMTP id g22-v6so25214075iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xv0QdDFSjAkzumKAi/eOVYfr665fgxAHah20iogNl1E=;
        b=KSJ2KWYc1i4a8SAUmUs8+Sf4VVGBMZS6Ae+oA/aN+myKhtXUcaxdrd5kL3anMz59gM
         EqkA96ZjMc65JUZrDd/xTarpC0n3VsLvMBNYaskf/hwRNMJuOI5qnZKK/eaDm5U1Ezhs
         9nWfi9JcVWvVjjxqNhoK0+HOrpoEgGjXos8tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xv0QdDFSjAkzumKAi/eOVYfr665fgxAHah20iogNl1E=;
        b=PzOgHbZwvZCbJTt1UVasgk6gfqYQBYsP8kSUHncuO2nodYFUh5x03+sZdvWb0fJFzU
         g4ljIW+uds/sn6gtIOygiJshvQy8yNIsyUxciRR8xIyK3tseUMoNG1GaQ2l/TuoGiF+k
         3eVsu39nbOw15swYmcMALAUlOh6IVOz0vB1VTcSr/tNKHEG3gcydz6GC4LgWCJ4ikzyM
         HCBkMZ1qV4c7TUZaDbEfsV2j1cHEA+UzFYGqirOuviieiM77go4tUCrVpuk32TTcAej+
         m4XgcofbecYpoxdbdXEqkW4doeY0srUdwJOs4HaWI3rgSUybhUfhsHu5oPS44CtwCJ9P
         x3Gw==
X-Gm-Message-State: APt69E2yOJwMlQ3uKR2WYQYF12RKo+fi9Fl6wPqmHLTQ/XQ3vrYsKRsG
        sTLNYwO6tCYJC0zTA35CGSK5NEXrAvzZnwXsTO3Tsg==
X-Google-Smtp-Source: ADUXVKIeN3K7BbvvkNcZz0CDuxe6yiVlDH9l2tnInqmtzmkuhVL1Zp/hpHfx9Xa9s69wOvGYq6T25ABfTaqm8fdD1U0=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr509804iog.238.1528745021408;
 Mon, 11 Jun 2018 12:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com> <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net> <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
 <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com> <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com>
 <20180608060223.GB24107@lst.de> <1c8b3938-6656-5d5a-f65d-dfd2e55d989e@amd.com>
 <CAEJqkggkZynDvV8XxkFfy89x-DX5xDTyubUJ3oXBO6eUjBWBKw@mail.gmail.com> <20180611071501.GA1015@lst.de>
In-Reply-To: <20180611071501.GA1015@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 12:23:30 -0700
Message-ID: <CA+55aFyjSsb75N=sdhK7t3YDRx=7R0GB=jbdRtn8aCEv9zf4Vg@mail.gmail.com>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gabriel C <nix.or.die@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, jmvalin@mozilla.com,
        Dave Airlie <airlied@linux.ie>, Felix.Kuehling@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Joerg Roedel <jroedel@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> For now I'd say revert this commit for 4.17/4.18-rc and I'll look into
> addressing these issues properly.

Ok, reverted in my tree, and marked for stable (for 4.17). Thanks,

                     Linus
