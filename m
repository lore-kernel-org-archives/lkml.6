Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366B920831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366B920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbeKTCuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:50:17 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54106 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbeKTCuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:50:17 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gOmNF-0003to-14; Mon, 19 Nov 2018 09:26:09 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gOmNC-0001BG-SL; Mon, 19 Nov 2018 09:26:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        rdunlap@infradead.org, christian@brauner.io,
        open list <linux-kernel@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>, jannh@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, timmurray@google.com,
        Kees Cook <keescook@chromium.org>, jengelh@inai.de,
        Andrei Vagin <avagin@gmail.com>
References: <20181118111751.6142-1-christian@brauner.io>
        <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
        <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
        <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
        <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
        <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org>
        <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
        <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
        <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
        <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
        <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
        <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
        <CAJwJo6aXQUtciO7kPSENoajV6JUqUGJxCh_0yPf5D8GfbLegzA@mail.gmail.com>
Date:   Mon, 19 Nov 2018 10:26:00 -0600
In-Reply-To: <CAJwJo6aXQUtciO7kPSENoajV6JUqUGJxCh_0yPf5D8GfbLegzA@mail.gmail.com>
        (Dmitry Safonov's message of "Mon, 19 Nov 2018 16:13:30 +0000")
Message-ID: <875zwt2fvr.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gOmNC-0001BG-SL;;;mid=<875zwt2fvr.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/eyLRLeC/f35jz/EU5CEoWdYiiMT2Fhk8=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: allow killing processes via file descriptors (Larger pids)
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Safonov <0x7f454c46@gmail.com> writes:
>
> So, I just wanted to gently remind about procfs with netlink socket[1].
> It seems to me that whenever you receive() pid information, you
> can request some uniq 64(?) bit number and kill the process using it.
> Whenever uniqueness of 64-bit number to handle pids will be a question
> the netlink message might be painlessly extended to 128 or whatever.

No.

I have seen this requested twice in this thread now, and despite
understanding where everyone is coming from I do not believe it will
be wise to implement larger pids.

The problem is that we then have to make these larger pids live in
the pid namespace, make struct pid larger to hold them and update
CRIU to save and restore them.

All for a very small handful of processes that use this extended API.

Eric
