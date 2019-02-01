Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE9121872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5MWFUM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfBAS7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:59:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37993 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfBAS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:59:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so6288299ede.5;
        Fri, 01 Feb 2019 10:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSEu1aCba5uk1gA70su1TjmCc/dFMJPWWL5j5GOtVxE=;
        b=i5MWFUM7ZV7XaohoSx+0nXra35AX4aWM58zDKctroetbvog8ZBWfNWNZhLseO4fWa/
         bFxNPRw2g7ZCOskS7OT8A195HY+j9izfR6NNb+yU/Gyp7nEyrANJVYT+h5MaztBkpASR
         Fy3i2zNQQiBgmmav57B13QjpBQSsaP0nZ9xP5WxdbFXW2VtsXafL4fMbo2KNFte6WXCq
         j8Qc35JoJx5MVJ7sqgAeNzR+/pzkbmY4CdygX7VHNSI+kWuCxvxcxMgU90z+PhtBQVrk
         jqPPPVcfkUH0sfQFDD6hPXvF8KkTxGKt+Ug5anpq5nB0gn17AeVu2A7ueuhhdu039i1I
         JduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSEu1aCba5uk1gA70su1TjmCc/dFMJPWWL5j5GOtVxE=;
        b=KUvOHPMcGDz9mOoXDJhyPGqlw9oBBhVz8e0acdpTdTj2NViKlDpmNrPkpKK+fM2wB6
         /s9gMZPQdiz6OxOEKE63j2auNW5NgNwT9hnlZLa7Sf4TwwmWt4w2N/IZeWEHyqvFirqX
         WSirl+K0Tq6fu9PQ3/inp18f+9PUER5dWCywLczYJkywRpABvmoT98KLUS1OFPykkhz0
         dH01DHFpVoDptgzSeLqxUAWGFlqoRwPe1fzy9XrepHrlwAW7xopNyjCliRiWSrbzIGdo
         VBJaCDlad4ArJndigjGYaO8qjy/Xb1z/4wrOiU3AFJ20IaGlT0626qeYRwZK82MQN3HY
         UHwg==
X-Gm-Message-State: AJcUukdaZZrrdwU9red5oujqCI8hIFFlzizQETmUjXxc1AL9rmcbmrdK
        WGgcQvS9E6LHIgWqAakoi8oNw50hwdiBIRv4I2Kwuw==
X-Google-Smtp-Source: ALg8bN4Un8+aKk/5AFQ0YuvvUlttsNZxZJglN9lTeaygjeoKsA/7C/2ZzGeJyBuV/cFDU+NFyJnvwyGoT1YD3c48wdw=
X-Received: by 2002:a17:906:4d1a:: with SMTP id r26mr36104055eju.32.1549047578139;
 Fri, 01 Feb 2019 10:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20190201154356.15536-1-deepa.kernel@gmail.com>
In-Reply-To: <20190201154356.15536-1-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 1 Feb 2019 10:59:01 -0800
Message-ID: <CAF=yD-KRtNqR5k7muxuVoL1A08-EC8Bdy5NVdCaEO2UWMK4n9A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/12] net: y2038-safe socket timestamps
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 7:47 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
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
> The overview of the socket timestamp series is as below:
> 1. Delete asm specific socket.h when possible.
> 2. Support SO/SCM_TIMESTAMP* options only in userspace.
> 3. Rename current SO/SCM_TIMESTAMP* to SO/SCM_TIMESTAMP*_OLD.
> 3. Alter socket options so that SOCK_RCVTSTAMPNS does
>    not rely on SOCK_RCVTSTAMP.
> 4. Introduce y2038 safe types for socket timestamp.
> 5. Introduce new y2038 safe socket options SO/SCM_TIMESTAMP*_NEW.
> 6. Intorduce new y2038 safe socket timeout options.
>
> Changes since v3:
> * Rebased onto net-next and fixups as per review comments
> * Merged the socket timeout series
> * Integrated Arnd's patch to simplify compat handling of timeout syscalls
>
> Changes since v2:
> * Removed extra functions to reduce diff churn as per code review
>
> Changes since v1:
> * Dropped the change to disentangle sock flags
> * Renamed sock_timeval to __kernel_sock_timeval
> * Updated a few comments
> * Added documentation changes
>
> Arnd Bergmann (1):
>   socket: move compat timeout handling into sock.c
>
> Deepa Dinamani (11):
>   selftests: add missing include unistd
>   arch: Use asm-generic/socket.h when possible
>   sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
>   arch: sparc: Override struct __kernel_old_timeval
>   socket: Use old_timeval types for socket timestamps
>   socket: Add struct __kernel_sock_timeval
>   socket: Add SO_TIMESTAMP[NS]_NEW
>   socket: Add SO_TIMESTAMPING_NEW
>   socket: Update timestamping Documentation
>   socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
>   sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
>
>  Documentation/networking/timestamping.txt     |  43 ++++-
>  arch/alpha/include/uapi/asm/socket.h          |  47 ++++--
>  arch/ia64/include/uapi/asm/Kbuild             |   1 +
>  arch/ia64/include/uapi/asm/socket.h           | 122 --------------
>  arch/mips/include/uapi/asm/socket.h           |  47 ++++--
>  arch/parisc/include/uapi/asm/socket.h         |  46 ++++--
>  arch/powerpc/include/uapi/asm/socket.h        |   4 +-
>  arch/s390/include/uapi/asm/Kbuild             |   1 +
>  arch/s390/include/uapi/asm/socket.h           | 119 --------------
>  arch/sparc/include/uapi/asm/posix_types.h     |  10 ++
>  arch/sparc/include/uapi/asm/socket.h          |  49 ++++--
>  arch/x86/include/uapi/asm/Kbuild              |   1 +
>  arch/x86/include/uapi/asm/socket.h            |   1 -
>  arch/xtensa/include/asm/Kbuild                |   1 +
>  arch/xtensa/include/uapi/asm/Kbuild           |   1 +
>  arch/xtensa/include/uapi/asm/socket.h         | 124 --------------
>  drivers/isdn/mISDN/socket.c                   |   2 +-
>  fs/dlm/lowcomms.c                             |   4 +-
>  include/linux/skbuff.h                        |  24 ++-
>  include/linux/socket.h                        |   8 +
>  include/net/sock.h                            |   1 +
>  include/uapi/asm-generic/socket.h             |  48 ++++--
>  include/uapi/linux/errqueue.h                 |   4 +
>  include/uapi/linux/time.h                     |   7 +
>  net/bluetooth/hci_sock.c                      |   4 +-
>  net/compat.c                                  |  78 +--------
>  net/core/scm.c                                |  27 ++++
>  net/core/sock.c                               | 151 +++++++++++++-----
>  net/ipv4/tcp.c                                |  61 ++++---
>  net/rds/af_rds.c                              |  10 +-
>  net/rds/recv.c                                |  18 ++-
>  net/rxrpc/local_object.c                      |   2 +-
>  net/smc/af_smc.c                              |   3 +-
>  net/socket.c                                  |  50 ++++--
>  net/vmw_vsock/af_vsock.c                      |   4 +-
>  .../networking/timestamping/rxtimestamp.c     |   1 +
>  36 files changed, 541 insertions(+), 583 deletions(-)
>  delete mode 100644 arch/ia64/include/uapi/asm/socket.h
>  delete mode 100644 arch/s390/include/uapi/asm/socket.h
>  delete mode 100644 arch/x86/include/uapi/asm/socket.h
>  delete mode 100644 arch/xtensa/include/uapi/asm/socket.h
>
> --
> 2.17.1
>

For the series:

Acked-by: Willem de Bruijn <willemb@google.com>
