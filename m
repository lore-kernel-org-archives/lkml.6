Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF3FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2532620844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tz1fYdTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2532620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbeGaUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:40:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46769 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbeGaUki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:40:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so7559687ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpHcqNaN5pHfT/bJjWP0xHK7kxdSYEPGBJT4HyqS9TY=;
        b=tz1fYdTw/1efGYkUCYC88qKM+G4adAPpfORb9lWGba5/wCrT/zuGcEKSkQcLcA6DNJ
         2XUzjyLxC8yOcHS0QLa5aDamlpC5iSeJrdAcmBUD0WSPjlOuIsrUR0KRLY+C3oWztV2O
         crGtIiUNICHyrp4RW6LvWuSf7JLU+Sdjm7Cq5xH/Sp6gJRYaXNKAad8FS3dyp3dqzPH1
         D8Bo36nmkGz672MOuCmMD/8QIQ285omm4RMjIm2WolmwynVQ2+A80BJRSTiQubta88Q5
         iBWvlGbt78SZ4Ow+Tbii308TAqw19DY6scEhvqmNtc4n18QPJ+Iua1vGS14rxIHCkyGJ
         m1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpHcqNaN5pHfT/bJjWP0xHK7kxdSYEPGBJT4HyqS9TY=;
        b=H5UEKMRr5mc5uZIA6Y+AKAdYfJO4fbElbqHwTDW2fY8n+4l2Qoi23E2klRZve8/Pd0
         P2+GOb9beSYryf6368wwd3fdfHSCr30EvyjQBDbyOAKnyzUDz6GoDBK+XgtlPQW6t14f
         Bhhx81kz8bOMJV9ApWftM7RyXC5TdwlxUe3LAAd+B64gIYcRJe83rTyXV7GVbG7JjnFS
         DYmY9E8ftKR8FyjD6VnbThyaIsEs4ePyTV/V2NDZszYh4AQ/Hh+JWqCcbSWMkHFlvudH
         vDJD7MQA+yrhpqQpqdXZt9pw4KXGI0r9lNpnwi7+GSOPEForrcGVQ3eCjulJ8po+5jQf
         ZaIA==
X-Gm-Message-State: AOUpUlGomCuQ/cMcjwcu7VJYBKae5GUCk9YqtbdeY+HkwDlUCjoBiuqX
        xVvShUH6/ywf2rfjV/yXYh0sqTFlKJC6LsQpSO+hyw==
X-Google-Smtp-Source: AAOMgpfHxbAUanFHxpcHsd1nNDPVRtBbvVxbgFs//sfGwKqZkpFIH9kqaKwo4vD/HHsQvofdKsWLkFEBciiQbRP8dkw=
X-Received: by 2002:a17:902:b08a:: with SMTP id p10-v6mr21348264plr.217.1533063537584;
 Tue, 31 Jul 2018 11:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180730213412.242849-3-ndesaulniers@google.com>
 <201807311827.UpeCrGPC%fengguang.wu@intel.com> <CAKwvOd=rwib91mnXs=PCP460hkCWTE5anNFgvRPBrbagetCbzw@mail.gmail.com>
 <CAGXu5jJFdbcmSMZi-uz0QySJ5c6uqUKEazztDfCWDeQOMF-T-Q@mail.gmail.com>
In-Reply-To: <CAGXu5jJFdbcmSMZi-uz0QySJ5c6uqUKEazztDfCWDeQOMF-T-Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Jul 2018 11:58:46 -0700
Message-ID: <CAKwvOdneN9xG5iegvfnn9XUm_-qUHxx--7k3j-UthwvsXmZOjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
To:     Kees Cook <keescook@chromium.org>
Cc:     lkp@intel.com, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, paul.burton@mips.com,
        christophe.leroy@c-s.fr, shorne@gmail.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, rdunlap@infradead.org,
        bp@suse.de, neilb@suse.com, LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, dwmw@amazon.co.uk,
        sandipan@linux.vnet.ibm.com, linux@rasmusvillemoes.dk,
        Paul Lawrence <paullawrence@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>, ghackmann@android.com,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>, avagin@openvz.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:02 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jul 31, 2018 at 9:48 AM, Nick Desaulniers
> > On Tue, Jul 31, 2018 at 3:27 AM kbuild test robot <lkp@intel.com> wrote:
> >>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c: In function 'iwl_trans_send_cmd':
> >> >> drivers/net//wireless/intel/iwlwifi/iwl-trans.c:137:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
> >>      if (!(cmd->flags & CMD_ASYNC))
> >>      ^~
> >>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c:138:1: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
> >>       lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
> >>     ^ ~
> >>
> >> vim +/if +137 drivers/net//wireless/intel/iwlwifi/iwl-trans.c
> >>
> >> 92fe8343 Emmanuel Grumbach 2015-12-01 @137      if (!(cmd->flags & CMD_ASYNC))
> >> 92fe8343 Emmanuel Grumbach 2015-12-01  138              lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
>
> #define lock_map_acquire_read(l)
> lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
>
> #define lock_acquire_shared_recursive(l, s, t, n, i)
> lock_acquire(l, s, t, 2, 1, n, i)
>
> The config doesn't have CONFIG_LOCKDEP, so it's not:
>
> extern void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>                          int trylock, int read, int check,
>                          struct lockdep_map *nest_lock, unsigned long ip);
>
> but rather:
>
> # define lock_acquire(l, s, t, r, c, n, i)      do { } while (0)

This is tricky, if I preprocess that translation unit with the exact
flags used during compilation, I get:

```
 if (!(cmd->flags & CMD_ASYNC))

#pragma GCC diagnostic push

#pragma GCC diagnostic pop
 do { } while (0);
```

Which is not enough to trigger -Wmisleading-indentation alone.  It is
curious that if we add braces to that if statement (as Nathan notes in
a sibling post) or removing the pop (not shippable) seems to fix the
warning.

-- 
Thanks,
~Nick Desaulniers
