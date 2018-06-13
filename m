Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 910C1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4646820020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITDJMiJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4646820020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935711AbeFMNsX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:48:23 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51999 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935279AbeFMNsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:48:21 -0400
Received: by mail-it0-f65.google.com with SMTP id n7-v6so3791359itn.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zCYwNuo7xCNhSP9gJNM/UqERWvQ2IYMq+5+MRErbM3Q=;
        b=ITDJMiJV3lBRKOCeZhxKy6jRGHwM1M6v+j9YxEew6wHg3ulYfXfZQ6nWs8onXojiRh
         96wH9rHmrKnVISAVHenPWooGiQPHjacfd1Lpcl/2W9pxUV1i8xMA4XVtWkUfgjKOvPnq
         mxN6J5fR++tifJJf1BiHE8POURz7xQplcm+Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zCYwNuo7xCNhSP9gJNM/UqERWvQ2IYMq+5+MRErbM3Q=;
        b=D8DYMKXwUWzROpftzJCYSTpCwYvAoZ8Tk6P7GO1RlVld8etS1TgcFcR0iSEzJcxJQw
         AphO2fLFLm6HiQ13lt1GZjSKtN+6jKyCHntDYA5xkeTHu6P+symExvxDjL5mb9u6y5nc
         aQjmWVXQ6cu7oZW9aBOG8dBlY9X1XgFL6nZJvpLEdqitHxb9eqzhWc76hwATbrAruh8c
         XBwOoi89dS6g+nV9l1htazXS3LE+yX2kNgJ+qrr/r7bU6PX/HHaA6GcT5yGmoqTulTKO
         P1OvJnkQc1QwW0GT+OXaafpsXbG40fw76ZLS377eKRtyyY4QoJ8z3OSVukw0IHOeKHSR
         Oknw==
X-Gm-Message-State: APt69E370cHu2OB7o92HtlZ+0GEgclyDwSMYIPuUOBGI08kvsnmFrcAw
        Ffg8sXc+WogOBVRywewBuW3FyRdFRIIKxT2XA20=
X-Google-Smtp-Source: ADUXVKKWM/FEIKb4TLlXYLkj1ThRtBITubz2IFyFhASOHgo4BPbGbXN/ImvyUsXu+6umQeILHiGn47BVQK/JDFlIn7w=
X-Received: by 2002:a02:89a3:: with SMTP id p32-v6mr386767jaj.10.1528897700937;
 Wed, 13 Jun 2018 06:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180612083449.100099222@infradead.org> <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
 <20180612171420.GU12217@hirez.programming.kicks-ass.net> <20180613143247.1b749c83@endymion>
 <CAHpGcMKj1MNyc0XJuKxf727jtNhiKpL3AuR_+pRZipWXG+V08w@mail.gmail.com>
In-Reply-To: <CAHpGcMKj1MNyc0XJuKxf727jtNhiKpL3AuR_+pRZipWXG+V08w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 06:48:09 -0700
Message-ID: <CA+55aFy40OkMArs_q3K-SWJhdxTYyqWAwMbkBRRTN=f0ex45Rg@mail.gmail.com>
Subject: Re: Quilt vs gmail (Was: [PATCH 0/3] sched/swait: Convert to full
 exclusive mode)
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 6:27 AM Andreas Gr=C3=BCnbacher
<andreas.gruenbacher@gmail.com> wrote:
>
> All of that may be correct, but those headers apparently do break
> email based patch reviewing on Thunderbird and Gmail now, and that's
> not very likely to change.

I do want to point out that at least for me, it's not a very big
annoyance. It would be sad if people who actually_use_ quilt lose a
feature they use for this.

I've seen it twice in the last few months, so it's not  like it's all
that noticeable. It's a bit annoying when it happens, but it's not a
show-stopper.

Either I don't interact with a lot of quilt users, or (quite likely)
people don't always use quilt itself to then send the patches (the
same way I don't use git send-email to send patches even though I
obviously use git).

                  Linus
