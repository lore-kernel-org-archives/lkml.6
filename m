Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VDNsIPtIGVuPTAAAmS7hNA
	; Thu, 07 Jun 2018 15:07:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6C109608BF; Thu,  7 Jun 2018 15:07:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q+ttrOKF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F2A166074D;
	Thu,  7 Jun 2018 15:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2A166074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936077AbeFGPHG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:07:06 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35046 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935887AbeFGPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:07:04 -0400
Received: by mail-it0-f44.google.com with SMTP id a3-v6so13088316itd.0;
        Thu, 07 Jun 2018 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYTGoc7nhJ89GP/6tSzeuSfobCsTBBXkV5rQ2gH5iPE=;
        b=Q+ttrOKF2nNeCbvLPv5R9T6xHvm4QIEew/R2Hdaf8OrNJ3y63fN4BmRD+CIfzsLzeJ
         jx9ATCQAEFYPjUQAJhh6/VXfIihl1r3mpXis5SfWGMg6BIiSyfS12GRHBN5/WgKnjPck
         ZtOOKq37IVK49shFzpRgB5xe+Nh7731mEbors=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYTGoc7nhJ89GP/6tSzeuSfobCsTBBXkV5rQ2gH5iPE=;
        b=rwcW/gV3wDggzzbrXpT6tooJ6LohKHdTaYY7FpeLG8/cOPc3OT1byiEvmOkaRn3unt
         f1vMRyTUKmdcC6evPKzMj92/qHAd9X4oBNLS0NcEEP5UGIUQf5u/RajgbeXUtNtSZRpQ
         VpDlBm4MsbPNi+CAXkpsA2yWcteoEsN8D6xi0zLWn4fdaqzsPhSsHz7JcemFRQ33OA1+
         5SI+aSXfHZNzQrJa7ifq+f28r8hx0tkhAkUtHYSWAIg1KrWUwJ3b9INH03NxwLp2DnyX
         4tlzW1COUldxpeJ/iSnFjAfa1J7L9VhPd2nZXjqeMYcO6tTE52Uqy1nacTD3KF0NleCI
         K/+A==
X-Gm-Message-State: APt69E0CwRa1FCVTE9zZ/w10ORIUiKI6rvnswI1OmNmeLJNnn7FQzMkB
        g0tbv5CDecRfffWT8waQ+WwtclcMepib+HikFoY=
X-Google-Smtp-Source: ADUXVKJJU1+R9ggq61/6WLaDwxb7O0/HK81eLErqp7wX25UebhA+ZCPK/JTb7jp8lttsayg8M0AgezHDW/JWcmwgSRA=
X-Received: by 2002:a24:6b14:: with SMTP id v20-v6mr2254594itc.100.1528384023176;
 Thu, 07 Jun 2018 08:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180530183826.GI7063@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
 <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com>
 <20180606190710.GY3593@linux.vnet.ibm.com> <CA+55aFwZTAp3wZYGSJR1kPkc=QhPNMdEEPttsM4REcWPPDH9Bw@mail.gmail.com>
 <20180607094314.GF3593@linux.vnet.ibm.com>
In-Reply-To: <20180607094314.GF3593@linux.vnet.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Jun 2018 08:06:51 -0700
Message-ID: <CA+55aFzs0ueN22WaKs_R6=T4HHY9j0MtpoFA8eh=t=PN7grCnA@mail.gmail.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Roman Pen <roman.penyaev@profitbricks.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 2:41 AM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> We are considering adding unmarked accesses, for example, accesses
> protected by locks.  One possible litmus test (not yet supported!)
> might look like this:

Fair enough - you do want to have the distinction between "marked" and
"unmarked".

And it does make sense, although at that point I think you do hit the
"what can a compiler do" issue more. Right now, I think the things you
check are all pretty much "compiler can't do a lot of movement".

But I suspect that the markings you do have are going to be fairly
limited. Things like "READ_ONCE()" vs "smp_read_acquire()" are still
fairly simple from a compiler standpoint, at least when it comes to
control flow - they have "side effects". So I guess that's the only
real difference there - a regular read doesn't have side effects, so
it could be moved up past a conditional, and/or duplicated for each
use. That sounds much more complex to the checker than the existing
things it supports, no?

               Linus
