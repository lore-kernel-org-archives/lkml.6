Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBCC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB0420850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="awB4kvAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB0420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLDCeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 21:34:10 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33274 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeLDCeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 21:34:09 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so10062406itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 18:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JA8NQS7kBF80EfTLnAWmTQ2L3BuyNMfHSw52z/MkAB4=;
        b=awB4kvAij7ygEeuJnxQUjvrIDm8cwl3JCbmwPgJ95Ajr/PKMwX1lJYXXQ+SV+s8jHm
         ygwxEDDUgRyFY7SqG2s/lExjNCV08nCtYW44Q+iLwO1is3zasP7uTkSF1AHLlstev6fn
         gOFapleHAhTYoSmiUNXmasxRHxM1GMD7hfIFbFMZUJhs3Fp8L80r79X7ywztWHU7aJSd
         WtaYNPmSIiYlGZieJ6O7+ObsdBn4RGz3HAzt+P4sog8nQARUEgI12nJ9f/l85yp+ecWK
         P0h5CSD33IVwL2JsDyAZB8djP2u8e3rUbx2tdt653DmWPOvaqjnJIV0EVviT47OOZTLa
         l8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JA8NQS7kBF80EfTLnAWmTQ2L3BuyNMfHSw52z/MkAB4=;
        b=aiz0NQzQBsjTqzjSqhpIbvkkHnUt5pDtRVbp5CNK1x70MsPo7N2Ma2qla1Zo6StPMw
         7oTs/x0CuDlp5yWiUAo2SL3zS/EJY14F9zyrTK2KxfYSyh5M3tx8issaHLc4/Mrwh5Jm
         xIaXrK/IuwZ5M8ckLvLvbt4lL4RmEOMJNLqSZ6Ks1ArbI+ep88Y+500rXeVeGXP5qdhJ
         7ch/wXk28KaG4njDOld68Uyg4rSFKdh9rKD/YrmtS7/dvXoibIQpEoPqXaHXhhJ4dash
         zskU/Ulkb0lYVCv+fX7zId2t5FpEzS93/tu3Wmk9+0j8s1P/9UyA3PeUGig55NbNMKKA
         NWZw==
X-Gm-Message-State: AA+aEWaGd5DhkhpX062W0JFVEVxuVC2ZE2ZPKK9BvtgzCIXS53eRXt23
        /nj9L2mmY5HV0OBCRf1WEOflog==
X-Google-Smtp-Source: AFSGD/V5q3zZrmpayXtTqoj0BUL6MtcxNb44zyeuTGHszkPKfavVSDzHvfa6W6E3JMA0dmm+I48RhQ==
X-Received: by 2002:a24:570a:: with SMTP id u10mr10509691ita.11.1543890847965;
        Mon, 03 Dec 2018 18:34:07 -0800 (PST)
Received: from cisco (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id c102sm5032251itd.38.2018.12.03.18.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 18:34:07 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:34:05 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v9 2/4] seccomp: switch system call argument type to void
 *
Message-ID: <20181204023405.GH3504@cisco>
References: <20181203032827.27978-3-tycho@tycho.ws>
 <201812041031.7kJxvTuh%fengguang.wu@intel.com>
 <20181204021726.GG3504@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204021726.GG3504@cisco>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 07:17:26PM -0700, Tycho Andersen wrote:
> On Tue, Dec 04, 2018 at 10:07:38AM +0800, kbuild test robot wrote:
> > Hi Tycho,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on v4.20-rc5 next-20181203]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Tycho-Andersen/seccomp-hoist-struct-seccomp_data-recalculation-higher/20181204-013450
> > config: i386-randconfig-x005-201848 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from kernel/seccomp.c:28:0:
> > >> include/linux/syscalls.h:239:18: error: conflicting types for 'sys_seccomp'
> >      asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
> >                      ^
> >    include/linux/syscalls.h:225:2: note: in expansion of macro '__SYSCALL_DEFINEx'
> >      __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> >      ^~~~~~~~~~~~~~~~~
> >    include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
> >     #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
> >                                        ^~~~~~~~~~~~~~~
> >    kernel/seccomp.c:946:1: note: in expansion of macro 'SYSCALL_DEFINE3'
> >     SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
> >     ^~~~~~~~~~~~~~~
> >    In file included from kernel/seccomp.c:28:0:
> >    include/linux/syscalls.h:881:17: note: previous declaration of 'sys_seccomp' was here
> >     asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
> >                     ^~~~~~~~~~~
> 
> Huh, I have no idea why I don't see this, but even with the attached
> config it still doesn't cause a problem for me. Anyway, I'll fix it up
> and do some more investigating...

Oh, because it's "make ARCH=i386". Whoosh :)

Anyway, it's fixed for v10.

Tycho
