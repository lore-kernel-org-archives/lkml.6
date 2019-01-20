Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D0C676ED
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1812087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyHfZysI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfATPg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:36:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42469 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfATPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:36:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so13733695lfh.9;
        Sun, 20 Jan 2019 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDgpqnXHJfr4H3bP/aLy0HSEuvslPYVgPLXpqDwvslM=;
        b=YyHfZysI27SRNLmIFWNsZds8UPfVaYTTbiW45cwopF5Z6qjQ9zavAIgZd78WAIB5MV
         R4rgzBkztMamv9t9oJTfYsUNARu0KspTxh5mEnVKUTU4FpFm4UwvHOA4ZCEGesKac1IG
         OoB40bHJ902V33IfLNFpGsrH9lJITU2n6YGEVpE6Je+0CYeN1CkKpfDfgB2vNm7/G5yg
         Y9gfZHo8QnIsxF4Cs09vs1MbGvvWREbdiFVoXGD1jPOwUpfzOXIht6r0u4rnwuIpk9oF
         ltlLvbHhz1GaA6sOkCl9v3CE5dZ2Lh1BhEn1pGD92j/m1qB1d44hPwTRzryCOvXFS4+V
         wKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDgpqnXHJfr4H3bP/aLy0HSEuvslPYVgPLXpqDwvslM=;
        b=DXD8uz8oDmwH9X5J0IEp4ZTnoneCJkRw12ISPp4i8lDMGk4M7MQ+qOxgnQxSl/KbWq
         YHIatYq1SLk+u2h+wvBEXZQwJL02fXLcGH+dsUIb8o2AKc2vo3rb1ofjoWTqBkPQCllo
         UWRozqC0wqvW+GCP8JUmmvw3XJ3DaIalGVp2kPjDkk+hAJxq8GfVW6F7tJT9SUWqSTiI
         0IHzu5c30oo1juRomDcE4+V7k+fI8wHoQwVW7MS2MK1X+cJJ4fq/Z66zxGh5FZ7W9T8p
         oQjmjVViCCIhWkmfsvTNUBip/7XB58s0dHJscMV85fdpk+AeE8ydQZDa+qRB4bXQPaHH
         IGeA==
X-Gm-Message-State: AJcUukcyDRQWRmq96VKlhiFUmdwGuxh7lbdH9uTQ1bRUPkBmY9ik028y
        FEodJUntRF/ARAylu6Tp4gG1STUSKB8QUamhudg=
X-Google-Smtp-Source: ALg8bN4yK13fSumhwLoEz8ZqO2StF0haEY63sHfVsbS3B60KDYMgszZtFmbr4h8PCkjQUvn9Q2tbXScMRWW/+NMQip0=
X-Received: by 2002:a19:db54:: with SMTP id s81mr17514067lfg.102.1547998585298;
 Sun, 20 Jan 2019 07:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20190102205715.14054-1-mst@redhat.com> <20190102205715.14054-2-mst@redhat.com>
 <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
 <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
 <20190109094959-mutt-send-email-mst@kernel.org> <CANiq72npFGsoHmBQUSNRLohDmMBNQFka8AcmhMz--QU1v2Aorg@mail.gmail.com>
 <20190120094237-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190120094237-mutt-send-email-mst@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 20 Jan 2019 16:36:14 +0100
Message-ID: <CANiq72nrX0WKaG1j8mP4eptLvv6dX7J2tBRz5erGKN4OwMiJZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org,
        Eric Christopher <echristo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 3:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> No not yet. Sorry! Pls send this one in, barrier_data will likely miss
> the next merge window.

No worries! Done.

Cheers,
Miguel
