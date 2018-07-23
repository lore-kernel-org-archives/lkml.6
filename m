Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1E7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC71E20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmsiUda3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC71E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbeGWRFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:05:31 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33664 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388144AbeGWRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:05:31 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15-v6so1145615qtp.0;
        Mon, 23 Jul 2018 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pqO9y8dZQMOxOkMmCJPLZtk2KXhDz5IvCuJAv/SHdnA=;
        b=PmsiUda30yfyYw3AJ8FZ4JbEIShBQeUJ4Fp5xomSzruLcpQUvQ2NAU4ybz3ughPMHM
         X2sot8d0JLk0YAeo+9t3kXSzncFLErFyzaGCw6Zo1ldd6ko6DiN3r7k9uic4dCadnR1f
         Ctn2rhoguxfORTBDiWuh8D+c/pznuYOVl+nj+7Z9Y2suHxuG8SzG6avAnqJ84Gr4hU6a
         DtEcXnY7UzV3oK/K+KdACG2dzI6rJkrU0nxSStsEhHOrrH9gqNzXiODHn03vZ8RSumlO
         eH4Y0k8FjyVQ/WAIIXoAhVtnX5pL+U7a11gb7XhOiuqbRDRrKRfvl1qdQ9pJod8xepcC
         B54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pqO9y8dZQMOxOkMmCJPLZtk2KXhDz5IvCuJAv/SHdnA=;
        b=pzfb3gHfabN5G3B9einTIKnnHAGynlz7Vc76KKQspL5oaAS0qynzLc5Jkl15sIc8NT
         RzqU4G4ppslAXcELtiEqBSq7BhfbJP3sdd/YDkrwlv23HTLd2JzsEJS42oIfWnE8lNMe
         jE00DjT1loKdf+P8pMLI8UUyGiKZPxhw7ozBYL6nAu1rJVjpQN3Q3ujXZEhVkBVjzeTl
         HIML/7JcAWQPWrt1UuzrF98idQpvfe1TheUt4fz4FgWflvK9GNthLsQT7rdOi3364mLW
         90pXX5bgJbcQW1kTQxwlh6HMqHujpW+JYR00ba5OyuXDMh1TBxnRBAW2O4I4YFFDeNSt
         V/JQ==
X-Gm-Message-State: AOUpUlFKsZK6jxDhhRuUTCnSD40BpTO6MOC0hUytoe9dYPWAf/zwVDwS
        1Klbqg1O2787+bH20TpX4zTw0VWecmtYlupjsDRQfg==
X-Google-Smtp-Source: AAOMgpdjnuoungeKXw9kcIZlTwaX144UFXDbppSdjnIdhA2nrIBHrfiC+ycgcv8xm0stVwe8P4spRd4GpCBYdKmlEms=
X-Received: by 2002:ac8:274a:: with SMTP id h10-v6mr12907871qth.187.1532361817087;
 Mon, 23 Jul 2018 09:03:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 09:03:36
 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1807210154100.8506@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
 <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com>
 <alpine.LRH.2.21.1807051254050.21817@math.ut.ee> <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
 <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com>
 <alpine.LRH.2.21.1807161948380.27791@math.ut.ee> <alpine.LRH.2.21.1807162200180.27791@math.ut.ee>
 <alpine.LRH.2.21.1807202339490.8506@math.ut.ee> <alpine.LRH.2.21.1807210154100.8506@math.ut.ee>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Jul 2018 18:03:36 +0200
X-Google-Sender-Auth: qmF2GgjL6VF7hJP1S6CMTgr29rI
Message-ID: <CAK8P3a19pCbn5Ns0jVqGTiSmGj4AOgjWL0CQtAA-sYRqY4Gvjw@mail.gmail.com>
Subject: Re: bisected: 4.18-rc* regression: x86-32 troubles (with timers?)
To:     Meelis Roos <mroos@linux.ee>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 1:01 AM, Meelis Roos <mroos@linux.ee> wrote:
> Added netdev and Daniel Borkmann - please see
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1724795.html
> for the original report. It seems to be about BPF instead.
>
> Meanwhile I have found more machines with the trouble. Still no clear
> mark in the config - some x86-32 machines that have
> CONFIG_BPF=y
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_JIT_ALWAYS_ON=y
> are working fine.
>
>> The new bisect seems to have also led me to a strange commit. This time
>> I tried to be careful and tested most on two reboots before classifying
>> as good.
>>
>> However, f4e3ec0d573e was suspicious - it failed to autoload e1000 but
>> had no other errors. On both boots with this kernel, modprobe e1000 and
>> ifup -a made the system work so I assumed it was good, while it might
>> not have been. Will try bisecting with f4e3ec0d573e marked bad.
>
> Now this seems more relevant:
>
> mroos@rx100s2:~/linux$ nice git bisect good
> 24dea04767e6e5175f4750770281b0c17ac6a2fb is the first bad commit
> commit 24dea04767e6e5175f4750770281b0c17ac6a2fb
> Author: Daniel Borkmann <daniel@iogearbox.net>
> Date:   Fri May 4 01:08:23 2018 +0200
>
>     bpf, x32: remove ld_abs/ld_ind
>
>     Since LD_ABS/LD_IND instructions are now removed from the core and
>     reimplemented through a combination of inlined BPF instructions and
>     a slow-path helper, we can get rid of the complexity from x32 JIT.

This does seem much more likely than the previous bisection, given
that you ended up in an x86-32 specific commit (the subject says x32,
but that is a mistake). I also checked that systemd indeed does
call into bpf in a number of places, possibly for the journald socket.

OTOH, it's still hard to tell how that commit can have ended up
corrupting the clock read function in systemd. To cross-check,
could you try reverting that commit on the latest kernel and see
if it still works?

       Arnd
