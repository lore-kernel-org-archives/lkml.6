Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9213C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F86020874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogTKtZF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F86020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937485AbeFSIwr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:52:47 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35690 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937229AbeFSIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:52:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so10601388plt.2;
        Tue, 19 Jun 2018 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtazQiwLSgkFa69iCUvG49Km/B3ufAdAvUNZHxblZTg=;
        b=ogTKtZF0fTIN1awwZubRrEQ8QhtERyol9ZKaIyGc8ScPdYtToSaAC5eGSqt0MuADP3
         q84B1OTM7dxKANj1fHZyl5mZoqU3CFbCSW4lUxhFUQJHw5eu7/jE4VxUKmpmhqNR+LfE
         7WWgvwu6+16JLtidGAtRzj2DKhBwOijL5ull3hzNu4qGP7kmXGbyxjPR78/U0XKWvu/q
         vsOmIkndm1ZxrJQneldqSm1D70g3VHGbqO92uXKmk7eovjrHIlYjaJKrDJGCHU72e5g7
         faLAUtdIVJs1/3kp0XPP5s6Ey+FyrkTOaqZTlZvdPzciB6VbuODBJYHy/CLFQdhwsXVW
         CGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtazQiwLSgkFa69iCUvG49Km/B3ufAdAvUNZHxblZTg=;
        b=caVdZlidbuGKFd2J1VM8JlNsHADtFvQMRtMWqWdi8dDD3gBNJZWsCBpe1mK65v9QRo
         7uGPc8eTZJLD327P2HhIUh+lna14O66XdIiQ36RVQOcFAZwqrskIEgjOrFlmAAjLQzwC
         SVJ4um6KRkJaptGZD1amTNaYLJ99AxZEiBNterLN4cDZGxAgR39ba/RlLbl8U28nRmNX
         IR+3yduHyxUObr9Oppui99u/kXA0n/mipPVqsahkE1vrMr7wKxPeZh1eBdLs/k3q/kNp
         aHEg/fydZbv50DLw0ihRWueBKxZHpGHZGN4y0zjnraGEGF1y+zXyYRatuC1JJdVdvESg
         FL8A==
X-Gm-Message-State: APt69E3b9E7ICzaiynh96wrWYtGVeCRJ7yjobv64dBDvP0g6pxw/qUrL
        YYoQUgG7aW8oq7kQT4vrRQU=
X-Google-Smtp-Source: ADUXVKLYIFimQmF+H/oS98+oo/TGGK2YYS6iRoiJIa9qQASDLdQWTwq0QbNwRWshPSC4BT0P+i0ULw==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10-v6mr17843070plp.333.1529398361273;
        Tue, 19 Jun 2018 01:52:41 -0700 (PDT)
Received: from 350D (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.googlemail.com with ESMTPSA id l71-v6sm25500965pge.8.2018.06.19.01.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 01:52:40 -0700 (PDT)
Message-ID: <09b7cc16ee5275d4ef3dffb11942e3f2ba44aedd.camel@gmail.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From:   Balbir Singh <bsingharora@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Date:   Tue, 19 Jun 2018 18:52:29 +1000
In-Reply-To: <CALCETrWCEjuM56J8dqXPR==MevJTYKan5dnAMFJaXzFMYr8Q_A@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
         <1528815820.8271.16.camel@2b52.sc.intel.com>
         <814fc15e80908d8630ff665be690ccbe6e69be88.camel@gmail.com>
         <1528988176.13101.15.camel@2b52.sc.intel.com>
         <2b77abb17dfaf58b7c23fac9d8603482e1887337.camel@gmail.com>
         <CALCETrWCEjuM56J8dqXPR==MevJTYKan5dnAMFJaXzFMYr8Q_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 14:44 -0700, Andy Lutomirski wrote:
> On Sat, Jun 16, 2018 at 8:16 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > 
> > On Thu, 2018-06-14 at 07:56 -0700, Yu-cheng Yu wrote:
> > > On Thu, 2018-06-14 at 11:07 +1000, Balbir Singh wrote:
> > > > On Tue, 2018-06-12 at 08:03 -0700, Yu-cheng Yu wrote:
> > > > > On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> > > > > > 
> > > > > > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > > > > > This series introduces CET - Shadow stack
> > > > > > > 
> > > > > > > At the high level, shadow stack is:
> > > > > > > 
> > > > > > >       Allocated from a task's address space with vm_flags VM_SHSTK;
> > > > > > >       Its PTEs must be read-only and dirty;
> > > > > > >       Fixed sized, but the default size can be changed by sys admin.
> > > > > > > 
> > > > > > > For a forked child, the shadow stack is duplicated when the next
> > > > > > > shadow stack access takes place.
> > > > > > > 
> > > > > > > For a pthread child, a new shadow stack is allocated.
> > > > > > > 
> > > > > > > The signal handler uses the same shadow stack as the main program.
> > > > > > > 
> > > > > > 
> > > > > > Even with sigaltstack()?
> > > > > > 
> > > > > 
> > > > > Yes.
> > > > 
> > > > I am not convinced that it would work, as we switch stacks, oveflow might
> > > > be an issue. I also forgot to bring up setcontext(2), I presume those
> > > > will get new shadow stacks
> > > 
> > > Do you mean signal stack/sigaltstack overflow or swapcontext in a signal
> > > handler?
> > > 
> > 
> > I meant any combination of that. If there is a user space threads implementation that uses sigaltstack for switching threads
> > 
> 
> Anyone who does that is nuts.  The whole point of user space threads
> is speed, and signals are very slow.  For userspace threads to work,
> we need an API to allocate new shadow stacks, and we need to use the
> extremely awkwardly defined RSTORSSP stuff to switch.  (I assume this
> is possible on an ISA level.  The docs are bad, and the mnemonics for
> the relevant instructions are nonsensical.)

The whole point was to ensure we don't break applications/code that work
today. I think as long as there is a shadow stack allocated corresponding
to the user space stack and we can Restore SSP as we switch things should be
fine.

Balbir Singh.

