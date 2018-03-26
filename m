Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeCZB4U (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 21:56:20 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55471 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCZB4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 21:56:18 -0400
X-Google-Smtp-Source: AG47ELucSa3+i8wOtaUAiAntikMQkawlWGodnBaAAbzxpForrw3upRc9o/myUSFQIE7FInwH15LfdA==
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.us>
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
References: <20180325182803.30036-1-avarab@gmail.com>
        <20180325182803.30036-3-avarab@gmail.com>
        <CAPig+cQ6EK=Q00panZECVvWt3pJyS9acC1n4mgogMmk5J4hO8g@mail.gmail.com>
Date: Sun, 25 Mar 2018 18:56:15 -0700
In-Reply-To: <CAPig+cQ6EK=Q00panZECVvWt3pJyS9acC1n4mgogMmk5J4hO8g@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 25 Mar 2018 20:11:24 -0400")
Message-ID: <xmqqlgefeh1c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> A minor point: Are you sure that it's git-format-patch that's being
> careful about arranging Date: to display in the desired order, and not
> git-send-email? Looking at old patches I still have hanging around
> which were created with git-format-patch, I see the Date: headers are
> wildly out of order, presumably because the date is taken from
> Author-Date: and the patches were heavily rebased.

send-email uses the current time as the timestamp it lets MTA to see
(and for a N-patch series, the first patch gets current time minus
N, and later patches get newer timestamps with 1 second increment).

The Date: field in the input file to the command has nothing to
participate in this process; sending a series that has patches that
have been shuffled with "rebase -i" would still give older timestamp
to the earlier message while sending the series out.

That is sufficient for any MUA that is capable of sorting the
messages in the sender's timestamp order; even though there is no
way to force the actual order in which an MTA on the receiving end
sees the messages, it is not necessary and it would not help X-<.
