Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA8BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671902190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Gx8ZSqaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391471AbfBMKh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:37:59 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33088 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbfBMKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:37:59 -0500
Received: by mail-ed1-f47.google.com with SMTP id a2so1515354edi.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP18OxAsyDG9thqLI7xRdP1nD8wNi/YDU03X91JyCyg=;
        b=Gx8ZSqaTFK3JZOzzXaGnGRk5RU2l6JeEguvwOF4E2JWAFC17aApB/P/EXHcNe40fnb
         OXeLQp850GfeVAkAoGu3MAKkI9vCJRZi00kL50CIfdZdF5yGc5KQTno5G51n/ZrdRFnX
         fZBfQo4uUfAf8Bs0/fehOOD3iuoqtb4T897+c7btrHn6+mQk5nvba/AKM5fMVEVbR52W
         yhdKYCQGxfFGpfou9XLtP/SC/cJYwmmUVkd4n+a+X5Y1lcNolyZBTj5jUen3YpG618B/
         lX2DED6YVR9zn7OxZtlMhMt6dtV7hSyc+J900JvRi6phVgdGiw/1vcKrxF/6AlY4q4Es
         8VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP18OxAsyDG9thqLI7xRdP1nD8wNi/YDU03X91JyCyg=;
        b=HMgQKvogw8dOW2c+fSWsCP+4DC74O+SEGRejIj20VsucGfAR+aSPT4eDk8XY0GYOS2
         9U29NwKIBcZd9k/Qyv+ZiIGwq4EvbLTaHoEoZYPfNBP5VJg67mpDoqpWXBMFuPQDB6O7
         b2WQXS0GmZBF3PBpGP5ZBbDR7/yzkXb1IxtRmtBb/pA1+keCzRI/XhMJt/5gwuAGyNlZ
         bDfWWGa7RtLTZ93qkTvdhLKc6IYa75nPJS71ZckvA9kxwqy6+8A/bQFXDzia0meliusU
         9xPIN4SGAt32u9df5n5TSg+rWNysR/V90KaGXnA4tEzMsNl9v9Kq9VweWvIqiYOH+jSS
         CKSw==
X-Gm-Message-State: AHQUAuZpiL2/oJ9S796csX58GOqIga2SoM/RhgZiF3PqoXirCZ709lug
        Yi2CPu4rOS3G49zECq0dl1b9wVv4YHktpQ+C8NU=
X-Google-Smtp-Source: AHgI3IbbTxIQ0fFHJzfqbGEX8KQmkn+KZxxWEPg0/jZkHmsF0HpbpiyUAdB6I4Pe3daQRkbMK/19duCiFsHeeZ3Zgyw=
X-Received: by 2002:a50:a4ce:: with SMTP id x14mr6757518edb.229.1550054277496;
 Wed, 13 Feb 2019 02:37:57 -0800 (PST)
MIME-Version: 1.0
References: <CAK1hOcN8_0MNEFfoHg0sAuu09SPhXHvXfXkeHONtoFXOArjumg@mail.gmail.com>
 <20190213040539.GA8524@lenoir>
In-Reply-To: <20190213040539.GA8524@lenoir>
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Wed, 13 Feb 2019 11:37:45 +0100
Message-ID: <CAK1hOcNETR+J6nYqidQKyybHmbHgiPvrm604vK=rLqRVOd6XTg@mail.gmail.com>
Subject: Re: preempt.h: some SOFTIRQ_OFFSET should be SOFTIRQ_MASK?
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 5:05 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> On Tue, Feb 05, 2019 at 07:34:31PM +0100, Denys Vlasenko wrote:
> > SOFTIRQ is a counter.
> > Why here:
> >
> > #define in_serving_softirq()    (softirq_count() & SOFTIRQ_OFFSET)
> > #define in_task()               (!(preempt_count() & \
> >                                    (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
> >
> > we check only lowest bit?
>
> So we have SOFTIRQ_OFFSET that is used when serving softirqs.
> And we have SOFTIRQ_DISABLE_OFFSET that is used when we disable
> softirqs.
>
> I think the choice is right on both tests above, or am I missing something?

From my reading of the following:

 * We put the hardirq and softirq counter into the preemption
 * counter. The bitmask has the following meaning:
 * - bits 0-7 are the preemption count (max preemption depth: 256)
 * - bits 8-15 are the softirq count (max # of softirqs: 256)
 * The hardirq count could in theory be the same as the number of
 * interrupts in the system, but we run all interrupt handlers with
 * interrupts disabled, so we cannot have nesting interrupts. Though
 * there are a few palaeontologic drivers which reenable interrupts in
 * the handler, so we need more than one bit here.
 *         PREEMPT_MASK:        0x000000ff
 *         SOFTIRQ_MASK:        0x0000ff00
 *         HARDIRQ_MASK:        0x000f0000
 *             NMI_MASK:        0x00100000
 * PREEMPT_NEED_RESCHED:        0x80000000
 */
#define PREEMPT_BITS    8
#define SOFTIRQ_BITS    8
#define HARDIRQ_BITS    4
#define NMI_BITS        1

it seems that 8-bit SOFTIRQ_MASK contains depth count of nested softirqs.
Therefore, to test whether we are in softirq, you need:

define in_serving_softirq()    (softirq_count() & SOFTIRQ_MASK)

But existing code uses SOFTIRQ_OFFSET, not SOFTIRQ_MASK, for the mask.
This means that if nest count is e.g. 2, in_serving_softirq() will return
"false".
