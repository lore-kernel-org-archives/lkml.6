Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DECBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF4620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbJW4MY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF4620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeLEQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:04:06 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39180 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:04:06 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so20953540itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luGuuDpBNul2rXU3SgVzNCBD1onQVRr9+C2I354pqwE=;
        b=qbJW4MY9BEGGSVHQN3k2hlhUzpmvbnzrAEopia0MH0u2noOwEuO2QQLHbhVOogLgXg
         Omnut5WUAu1IAbVSBp0VzmUJzo7tRVMNHZUpdNloqNZ1agCPy5DeT/uYf2/BEYAO170n
         I/fs4qp41kk3ffetPJ8Ta+mDAcixMgjDt3n3sAJE6EQ+9WntpyvOf9nnc9Jl95xLqfhd
         qGNKW2z+eaxDKyhRfEcyWLH+6RA8T/OLw6YfdrjPNOXkFxACYh+cIxTJ8Agw2D42XYCP
         kg0HsT+g+v824PGp4ejKAUER0eLoE4iJynZtDlJnreNRKD0Uoh9E8Hi5ETpws1xitVRG
         32Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luGuuDpBNul2rXU3SgVzNCBD1onQVRr9+C2I354pqwE=;
        b=sEpnkk0cj0qI/61/I3zeFMt13A4SBJWYVJNMfSqOmpqbgO3yVi3SKX8KHzR3iegxZm
         kwCBltVyjB/VUdE9UilNgWJMUUMnZnDhJtGMwQ5LdW72zRTvmueLecR7T8DYkHZUENT3
         KmoKU1HEhK5JAB70y5hGz6DPX2Ocjq+Dpnx46iR8NaToOGFDEjjseg1npAOnLgYUfirJ
         EbjJIRzBwMPHDheB70/6WQPBcuywVtYEl6y97CUfyKL4iJJOYUf+GkcZfGDZ5uHxVWE9
         9kxRTF74CjcN/kSO5EFfU06ekMvpE8tjxJ7ZPejTz1oJj68URDaqBKm51Cx9Qtxt3XaZ
         ZuHA==
X-Gm-Message-State: AA+aEWYxhe2yo2tYvUrA+EdjQCGP6p3qs4nOxLrtqyvOz7lMJWhquKFL
        6LV00VuFBfc4tNi1d3HobwPjFzFRLUvhcXcYTw5Ldg==
X-Google-Smtp-Source: AFSGD/VC9WbThhVkOPwYcKGfI0NAzePw/dNt3kexiST+IkutyMgRjUURc4+5KLp45UFfXHG4voYHkPMfLPqRCEltQMM=
X-Received: by 2002:a24:94c9:: with SMTP id j192mr16668160ite.125.1544025844946;
 Wed, 05 Dec 2018 08:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20181204103649.950154335@linuxfoundation.org> <716b46ef-03da-9656-92fd-3823f31f5ce6@linaro.org>
 <20181205065851.GA16346@kroah.com> <e38e63a3-c898-61e8-2140-73e9f05aec33@linaro.org>
In-Reply-To: <e38e63a3-c898-61e8-2140-73e9f05aec33@linaro.org>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Wed, 5 Dec 2018 08:03:27 -0800
Message-ID: <CAK6E8=eq_cMn_44Ldhc+djJhhEp0a4wH+6zuUVwvQB+feasV8w@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
To:     rafael.tinoco@linaro.org
Cc:     gregkh@linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, ben.hutchings@codethink.co.uk,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@roeck-us.net, Nandita Dukkipati <nanditad@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 4:08 AM Rafael David Tinoco
<rafael.tinoco@linaro.org> wrote:
>
> On 12/5/18 4:58 AM, Greg Kroah-Hartman wrote:
> > On Tue, Dec 04, 2018 at 07:09:46PM -0200, Rafael David Tinoco wrote:
> >> On 12/4/18 8:48 AM, Greg Kroah-Hartman wrote:
> >>> This is the start of the stable review cycle for the 4.19.7 release.
> >>> There are 139 patches in this series, all will be posted as a response
> >>> to this one.  If anyone has any issues with these being applied, please
> >>> let me know.
> >>>
> >>> Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> >>> Anything received after that time might be too late.
> >>>
> >>> The whole patch series can be found in one patch at:
> >>>     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.7-rc1.gz
> >>> or in the git tree and branch at:
> >>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> >>> and the diffstat can be found below.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> During functional tests for this v4.19 release, we faced a PANIC,
> >> described bellow, but unlikely related to this specific v4.19 version.
> >>
> >> First a WARN() at tcp_output.c:
> >>
> >> tcp_send_loss_probe():
> >> ...
> >>      /* Retransmit last segment. */
> >>      if (WARN_ON(!skb))
> >>              goto rearm_timer;
> >> ...
> >>
> >> [  173.557528] WARNING: CPU: 1 PID: 0 at
> >> /srv/oe/build/tmp-rpb-glibc/work-shared/juno/kernel-source/net/ipv4/tcp_output.c:2485
> >> tcp_send_loss_probe+0x164/0x1e8
> >> [  173.571425] Modules linked in: crc32_ce crct10dif_ce fuse
> >> [  173.576804] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.7-rc1 #1
> >> [  173.583014] Hardware name: ARM Juno development board (r2) (DT)
> >
> > So only this one machine saw this failure?
> >
> > If you can reproduce it again, bisection would be great to do if
> > possible.
>
> Yes, the only machine... I'm afraid this issue is intermittent and
> depends on TCP Tail Loss and a specific race causing the NULL
> dereference, so bisection would be tricky since it has happened
> independently of the functional test that was running. I have also
> copied authors for the Tail Loss code to check if they got any clues
> even without KASAN data.
There cause is an inconsistency of packet accounting: TCP
retransmission queue is empty but tp->packets_out is not zero. We will
send a fix soon. Thanks.

>
> Thank you,
> -
> Rafael D. Tinoco
>
