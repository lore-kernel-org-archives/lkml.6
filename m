Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 34TnGCvUHVt6RQAAmS7hNA
	; Mon, 11 Jun 2018 01:45:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0BCAD60791; Mon, 11 Jun 2018 01:45:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQqCC1m6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5A734605A5;
	Mon, 11 Jun 2018 01:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A734605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeFKBpn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 21:45:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38206 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753699AbeFKBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 21:45:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id b14-v6so11394164pls.5;
        Sun, 10 Jun 2018 18:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mHtrwlWv67ahQDfFnwBTq0iPHNJzG97Tk4KlzmVfdbo=;
        b=DQqCC1m6j4Sbge7HC/Zq09CX3MWYTOw5pyzoqVBCYS7vnQCARqOqkDBgM+tydvzufW
         cZcdTqf+ZiKW94KPacjW9agco6BcM4pSJButz/2+yoPP4+TcbBYOF3JK/iUtxBDf7RJA
         5/HgCcQp97ZvTOcv9vaS5+AMFk2CMeC+fyLxySuRqd+DoMkwFykzhgwBhQo3HqpZKxSM
         C7UOncSUqgNBD9KEmahRLgoNeo4/sg+Wv/Ah0m7liCHxkbE7gWbJJw6rl0XArPO98QhU
         tbsaTDH6ME5PSLh7KLCcslSFmPwe8iVWSVGv88QjGEVYftnlc2uLSVNugziVV9K+dZyO
         0hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mHtrwlWv67ahQDfFnwBTq0iPHNJzG97Tk4KlzmVfdbo=;
        b=QJ3Ee3/CAWwGw94rcW5JdYdVx0ojKDtD68YLKBCdXdkKAT8GKKxcswEyGpnU6MJA/D
         psewwC9Ahzkoh4JcWA8ZK6g6I+nBN7XX5+JqNCfgUCq0kbuad6V6ZHvITb43dYItzZ/C
         FJOFQvof8a7SVPpAbpY+f8+7/JX/cbNrmUM3ZRqxFaXP7TLqrhI0r12MAlnLH2PBQXcu
         B+xmrkNiQEBSmr/lzNWnoBN6YKaDyZ0YizDHc+H0gulpIbr6ibxg/SFe723tukA8ctt4
         2rOhJTy2OikWooaI8l50mSW+yQ/1ykvlLSsKOqKIWCaggmank5dlEqYLcInZSxVeA7++
         X1uA==
X-Gm-Message-State: APt69E2RTEj3K6ykGcdnisUcQBwuhUhflzG019rfuVnm2+UB3ySIi5SV
        i4WHyfCQkvWG32SCefH6GxOSjOsbtuEp3QzTYcs=
X-Google-Smtp-Source: ADUXVKKtZHszTLh/c3Ivd2RPeDKXLyt76e9kHKP52EDm9WDaLjNEK9x8oQeSREGg10PTiu1UzDRfC/X57rRLIvNbyGo=
X-Received: by 2002:a17:902:206:: with SMTP id 6-v6mr16239276plc.294.1528681541262;
 Sun, 10 Jun 2018 18:45:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:14e5:0:0:0:0 with HTTP; Sun, 10 Jun 2018 18:45:40
 -0700 (PDT)
In-Reply-To: <22a505e0f094352b9cb883935fae9f494fb2cb0b.camel@kernel.crashing.org>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com> <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com> <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
 <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
 <3187b544-e265-dfd9-e0e3-e2a742c190d5@gmail.com> <22a505e0f094352b9cb883935fae9f494fb2cb0b.camel@kernel.crashing.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Mon, 11 Jun 2018 13:45:40 +1200
Message-ID: <CAOmrzkLGWgY44puwim7bJPpkpE5cmyMEf3S+fHHMJYU6FC-tCw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I'm glad Finn is caring enough to keep this 20 year old bike shed in
good repair, but this may be overdoing it a little indeed. My bad.

A comment on the V1 PMU entry everyone should be OK with, I hope.

Cheers,

  Michael



On Mon, Jun 11, 2018 at 12:05 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2018-06-10 at 21:12 +1200, Michael Schmitz wrote:
>> Hi Geert,
>
> Top posting, sorry ...
>
> We are painting that bike shed with way too many coats..
>
> We can keep the existing definitions, stick a comment on them stating
> "obsolete" and use new number if/when needed.
>
> Ben.
>
>
>> Am 10.06.2018 um 20:29 schrieb Geert Uytterhoeven:
>> > Hi Finn,
>> >
>> > On Sat, Jun 9, 2018 at 2:20 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>> > > > > > Is this enum used by any user space code? If so, perhaps rather
>> > > > > > leave the PMU_68K_V1 in there to avoid upsetting that?
>> > > > >
>> > > > > It also changes the value of PMU_68K_V2, which is an ABI break.
>> > > >
>> > > > Yes, that's what I worry about - but do we know of any users of that
>> > > > particular interface?
>> > >
>> > > There is no ABI issue AFAIK. The value of pmu_kind is visible to userland
>> > > only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k. This patch
>> > > series will make these UAPIs available on m68k, and for that reason I've
>> > > chosen the value PMU_UNKNOWN for pmu_kind.
>> >
>> > While /dev/pmu and /proc/pmu/* may not exist on m68k, definitions in
>> > include/uapi/linux/pmu.h are part of the ABI, and cannot be changed or removed,
>> > unless we are 100% sure there are no users.
>> >
>> > If I would write a program interfacing with /dev/pmu and /proc/pmu/*, and
>> > needing to check the PMU type, it would have a switch() statement with
>> > all existing values defined in <linux/pmu.h>. So that would become broken
>> > by your change.
>> >
>> > Hence the enum is append-only.
>>
>> The PMU type from pmu.h was never exposed to user space on m68k via
>> /proc/pmu/*, and /dev/pmu is used for ioctls to the PMU driver on
>> powerpc only (the 68k PMU driver doesn't have ioctl support). No way
>> that I can see for user space to make use of the PMU type definition
>> from pmu.h, so I suppose we can be sure there are no users.
>>
>> The m68k PMU types cannot be said to be exposed on powerpc either (which
>> has ioctl support to interrogate the PMU type), as these only return
>> values up to PMU_KEYLARGO_BASED.
>>
>> Applications like pbbuttonsd or pmud don't use the kernel PMU type at
>> all, but go straight to the PMU via the ADB bus to interrogate the
>> hardware type, so won't be affected either.
>>
>> Is there any other way besides procfs and ioctl for user space to
>> interrogate the PMU type that I'm missing here?
>>
>> (I understand that breaking the ABI should not be done as a rule, but
>> this may be a case where we can successfully argue the definitions were
>> never in use, so the rules may be bent a little).
