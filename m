Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D3DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C45820827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQJq3kfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfAHNhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:37:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37656 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfAHNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:37:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so4255510edb.4;
        Tue, 08 Jan 2019 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nXKYaCNiwgzlBrCj/v1vQjps+Q5gGfbpQOOfB1h0CI=;
        b=fQJq3kfazkRaVcWp/jPyOlyKRy5/ek8ymQOV+bF2CWzmEjQUp053C+Rgi/qmTgxPb7
         2AiGxr0nOB+Osg6yaSWO3EoPyW8btVIJDxvZFk211tKdiHLhXICxYKURjEUDjgR7c3BE
         7Pp4d7Xkb5SUpz066jZZ2OK6w4qtdfNP1XPUF6fdNqJaFMdtIPVyBBJnj6IhiQy0AA0J
         LgUa75e0kK/DymYavwYIg7nKGj40aqv0rcaDgdYAQ4yzXboZqTFPtvglQgYIV330GHm3
         h8ksU4gM3pO1YNzJtUYRdWDMnVwaJFqz2iTO6DL8UfDPpefn0sVNG2l24PFVvS8EM4NK
         ChUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nXKYaCNiwgzlBrCj/v1vQjps+Q5gGfbpQOOfB1h0CI=;
        b=P6Sv7506gqAha1fKnq9TD5jJpd5vnO5HjnBNSKoPJvCTQN9iWDQBG2I4W+p/uy1tAq
         gkmLQAVJeyC6K5+rCpE/ZtxL5AIZofYMuV9i+OzoZS3bFn+PdU4VMz+mKkEbJMvrbP7h
         aXWULmBSiU11TIKYTZpiiSPwsZbUbJbQfiEIT0wTuCiZRvl17kVLooUTzlPLDTZQFTm7
         OiUmCPrFIklCcL3ZI9Jbj6AbLMvaQ/GK84mjZ5uOskIRpLrZ+GExnWhJzi/gfyr8fBwL
         mM02D9TD3IVAoe6aW+v1owbngmf7O3H+wsel83wap1dq+D8XhJJirm71/bl8yTRTdxs3
         hq7Q==
X-Gm-Message-State: AJcUukeFLQQPSa41apkiGDs6HMnoFzHMsGdBcdpwlYnUeMdDBBpEwSYk
        mtZX8kUCkdRRPgqmDzvSiqIS+K4M0swRRm9zI+c=
X-Google-Smtp-Source: ALg8bN6X8ZcOXLEatM5qF1v6ohRVupo0MHYrFK/Rc+HQE/howUNszts5xyEWsKGJSadb3HAUYegy2sl528E8HtLYcS4=
X-Received: by 2002:a50:a517:: with SMTP id y23mr2140352edb.219.1546954663585;
 Tue, 08 Jan 2019 05:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20190108032657.8331-1-deepa.kernel@gmail.com>
In-Reply-To: <20190108032657.8331-1-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Jan 2019 08:37:07 -0500
Message-ID: <CAF=yD-JuXHnp-5TvPSq87PDvHD1hkrUEWHQ9Uxwhbsd08vszHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] net: y2038-safe socket timestamps
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        David Howells <dhowells@redhat.com>, fenghua.yu@intel.com,
        isdn@linux-pingi.de,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, Ralf Baechle <ralf@linux-mips.org>,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux <sparclinux@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, ubraun@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:29 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> The series introduces new socket timestamps that are
> y2038 safe.
>
> The time data types used for the existing socket timestamp
> options: SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING
> are not y2038 safe. The series introduces SO_TIMESTAMP_NEW,
> SO_TIMESTAMPNS_NEW and SO_TIMESTAMPING_NEW to replace these.
> These new timestamps can be used on all architectures.
>
> The alternative considered was to extend the sys_setsockopt()
> by using the flags. We did not receive any strong opinions about
> either of the approaches. Hence, this was chosen, as glibc folks
> preferred this.
>
> The series does not deal with updating the internal kernel socket
> calls like rxrpc to make them y2038 safe. This will be dealt
> with separately.
>
> Note that the timestamps behavior already does not match the
> man page specific behavior:
> SIOCGSTAMP
>     This ioctl should only be used if the socket option SO_TIMESTAMP
>         is not set on the socket. Otherwise, it returns the timestamp of
>         the last packet that was received while SO_TIMESTAMP was not set,
>         or it fails if no such packet has been received,
>         (i.e., ioctl(2) returns -1 with errno set to ENOENT).
>
> The recommendation is to update the man page to remove the above statement.
>
> The overview of the series is as below:
> 1. Delete asm specific socket.h when possible.
> 2. Support SO/SCM_TIMESTAMP* options only in userspace.
> 3. Rename current SO/SCM_TIMESTAMP* to SO/SCM_TIMESTAMP*_OLD.
> 3. Alter socket options so that SOCK_RCVTSTAMPNS does
>    not rely on SOCK_RCVTSTAMP.
> 4. Introduce y2038 safe types for socket timestamp.
> 5. Introduce new y2038 safe socket options SO/SCM_TIMESTAMP*_NEW.
>
> Changes since v2:
> * Removed extra functions to reduce diff churn as per code review

Thanks, Deepa. This set looks great to me.

One issue, it does not apply cleanly to current davem-net-next/master
for me. A conflict on patch 7. It does apply cleanly on davem-net
master. Please rebase and also send with [PATCH net-next].

Perhaps also run the selftests in
tools/testing/selftests/networking/timestamping/txtimestamp.sh, just
to be sure.

Since you have a to resend anyway, a few minor nits inline, as well.
