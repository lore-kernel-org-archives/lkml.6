Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F2C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1042820664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0hFEEPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1042820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeJ2Pox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:44:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39409 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeJ2Pox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:44:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id a28-v6so3653594ljd.6;
        Sun, 28 Oct 2018 23:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w0zpsbP2pmfLkcLFbzVHp7c61UeSFwG62SaU0PqJigg=;
        b=S0hFEEPTY0fYdQU07u3GbN+d33waf+FyOGLwlgIHG42dMjGeRWRcIAmqpsL9dA/O/j
         XsHe9VxiIiEi+c0Rutj4WdqbJJLrYWOzPNJk2+JARMA3mKVZh714V9hvYYgA58rj8qqK
         lUHlUkp8fqXVKNf/JlO2tIONnLRrk5SYiUn5jSZJysc0LRw9YfUp9+gozaPfb8KnolzW
         dT5xT9XQMNDwoNpt92pvAC50N7K//3Mz8zmfJgYsoDpNwPxxs2ySL4gy6WTLl273+3tV
         d9f5oVrTXJBWo+H8JFizi2qfy6DELXVEWbuRCps6VrGuzd4c+NNJ+SLNENtc649jmJhK
         5jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w0zpsbP2pmfLkcLFbzVHp7c61UeSFwG62SaU0PqJigg=;
        b=Pj1WLb+8avZ2cfKp0jT2hQkfVzUK75+LtL3n8zUGlc7rQAMxDhQ8CWa2dYTEENpATY
         zW5mC2J6Uny9dKVFBE0ah/X+OOacbOR4BWQs8I6LYgI1aBhO5idDVBgyoxUXiK+4NSqN
         aD7+nkGnqHHAc/mBzupQK44uVlIOVpHIPR1mvpmajzoX6qKyZEpMQaB+ohxazu/BFXVM
         Vhiy9x823xsOsW00LlbLNXZ4AjxwNoUt69JUPMuhVt5J2TQVvNvaOio3uzyNEQ6MS5EF
         srHWYAcmxHWPbn6wHt5pWwCCwuOZgPvAMQBzJWiSUhOaPYdpIGtqWBOOwDRUxsOVt4iR
         uZlw==
X-Gm-Message-State: AGRZ1gJjK7trUppzdPV+PuoOzPCSFh9clMPX7y186wUyi+BmgtqJaQGu
        shLIYa0WIHCkwlQxeyM+zO+DQsc0iHBm6I1ib1hfafvEOU0=
X-Google-Smtp-Source: AJdET5dv4yfEtpSka2dLg2ERSb7tGYa5gwUSCerp0dmJmFOrXUIIme6sNsNCQZ9PPXG6LRE4awt7Va/fEVu2iNBKhLg=
X-Received: by 2002:a2e:809a:: with SMTP id i26-v6mr6741969ljg.100.1540796251439;
 Sun, 28 Oct 2018 23:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCc3hrq6E-Ff1oiYUOSDA08PMrqnu80XQtaD5adcUQvV8w@mail.gmail.com>
 <20181029012058.GK19305@dastard>
In-Reply-To: <20181029012058.GK19305@dastard>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Mon, 29 Oct 2018 09:57:20 +0300
Message-ID: <CAE5jQCeT4hONkK8cmkMoReoW-HqVLqnYN6c3YrxDjwNAf=nfEA@mail.gmail.com>
Subject: Re: XFS: Hang and dmesg flood on mounting invalid FS image
To:     david@fromorbit.com
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How did the corruption occur?

It is a fuzzed image. Most probably, it was artificially "patched" by
fuzzer. Or do you mean "what particular bytes were changed"?

Best regards
Anatoly
=D0=BF=D0=BD, 29 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 4:32, Dave Chinner=
 <david@fromorbit.com>:
>
> On Sun, Oct 28, 2018 at 08:50:46PM +0300, Anatoly Trosinenko wrote:
> > Hello,
> >
> > When mounting a broken XFS image, the kernel hangs and floods dmesg
> > with stack traces.
>
> How did the corruption occur?
>
> $ sudo xfs_logprint -d /dev/vdc
> xfs_logprint:
>     data device: 0xfd20
>     log device: 0xfd20 daddr: 131112 length: 6840
>
>      0 HEADER Cycle 1 tail 1:000000 len    512 ops 1
> [00000 - 00000] Cycle 0xffffffff New Cycle 0x00000001
>      2 HEADER Cycle 1 tail 1:000002 len    512 ops 5
>      4 HEADER Cycle 1 tail -2147483647:000002 len    512 ops 1
>                            ^^^^^^^^^^^^
>      6 HEADER Cycle 0 tail 1:000000 len      0 ops 0
> [00000 - 00006] Cycle 0x00000001 New Cycle 0x00000000
>      7 HEADER Cycle 0 tail 1:000000 len      0 ops 0
>
> Ok, so from this the head of the log is block 4, and it has a
> corrupt tail pointer it points to:
>
>
> $ sudo xfs_logprint -D -s 4 /dev/vdc |head -10
> xfs_logprint:
>     data device: 0xfd20
>     log device: 0xfd20 daddr: 131112 length: 6840
>
> BLKNO: 4
>  0 bebaedfe  1000000  2000000    20000  1000000  3610000  1000080  200000=
0
>                                                  ^^^^^^^       ^   ^
>                                                  wrong       wrong wrong
>
>  8 2f27bae6  2000000  1000000 dabdbab0        0        0        0        =
0
> 10        0        0        0        0        0        0        0        =
0
> 18        0        0        0        0        0        0        0        =
0
> 20        0        0        0        0        0        0        0        =
0
>
> They decode as:
>
> cycle: 1        version: 2              lsn: 1,24835    tail_lsn: 2147483=
649,2
>
> So the tail LSN points to an invalid log cycle and the previous
> block. IOWs, the block number in the tail indicates the whole log is
> valid and needs to be scanned. but the cycle is not valid.
>
> And that's the problem. Neither the head or tail blocks are
> validated before they are used. CRC checking of the head and tail
> blocks comes later....
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
