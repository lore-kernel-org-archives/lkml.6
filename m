Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C50C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA63208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LTEe+mQi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bawUSZWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA63208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGaSnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:43:41 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40354 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732212AbeGaSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:43:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id z143-v6so6047394ywa.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p/AqqoLFA5OOxno2bAquEYYNyheGJAR9BUzscAZ3aqQ=;
        b=LTEe+mQiCefZ6PPKlPaTrW9hK3foVe4Zkmc1L2dL3t55JrEBoAsR8tHNVRml3DKI8f
         I8u3nB9qsDu0iL56tPOkHxH7cjufWfj04MjioIcBfFnYVx0nyOpgFxJesbgCuUypk5QL
         12nbgqd9cHkXwcowez1VV4FmF28ZH0rhNO5P18yziKk+6gkjPGSxv2UI4+ZUDv/9F4of
         eR69gifEoIKgPXTVaLPdZ8JkKvg5QxoARj246pT2wfDKI9lXL2LwB5NTwznVQMB2QH6c
         29jvnhV5EMJ5DfzCF0cT5ZJfwGRL2ABbGv5e1hnnce44ZD+ZY/okMJ1mqhGfXEYxnTZA
         Ca1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p/AqqoLFA5OOxno2bAquEYYNyheGJAR9BUzscAZ3aqQ=;
        b=bawUSZWRnQtfCh2smcY846V1vR2HdIBp1PjWF1YfoHN5vLRimOahfS6LKi5b9DvjvJ
         I7Cn+msB//E9+PkgfdM6Kd1/goSU/T5E39gHHvj+XyPiPhB3gZ3F22+WYcZn2o4fpSrp
         pQknf8+4U79gBEAcugzJCsIJDVCSsDNGQ8qxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=p/AqqoLFA5OOxno2bAquEYYNyheGJAR9BUzscAZ3aqQ=;
        b=dCU6uMxHA6Cx15OYdY00Wou1bldVcbvMHK7O9XOXpHhgFjtj5DM2Upu5Gl/mTTpwtt
         ZbMTkV1BEAKY7j8pjR/wHtRYDYHIUabQglsRWlMjx3cKTqIMEfjelyts/MPsOn/GLSqT
         XLQHzVRE6zShdKmAi6DyajLU7CJ2GOd9fmp20emYPqDFaWrfVxAnMPiT7WUEXgz0Qqwe
         JjYu0+f31EhG+fQHdrT3nje6961wNTyaxm9/0/wM2ec0J4uB024v+MtcsrFLi+B0eBmz
         TFkeeILE9+Wob38G+tNyEDoxDIf3d6O67FCpO9Y34p9djENWbUJTDxvwQGxpUK5hobL9
         bYzg==
X-Gm-Message-State: AOUpUlGJanKiJ0sokCPcAkK8TBkN1wmAZohCWnml4stfh7bqOvAdZ1oU
        srWcMwvMpEsFT0DW0UeS3spPwrz4O8Jx2eg42G+W9w==
X-Google-Smtp-Source: AAOMgpd46LHAm+lScOGK61uHtSxBtvtbCzYp7t0sh3TT4Tlkh+WWLZubSmH6ODa4N4GTj0hszTB3CSiyjftWq34Bdu4=
X-Received: by 2002:a81:8742:: with SMTP id x63-v6mr11418646ywf.129.1533056547793;
 Tue, 31 Jul 2018 10:02:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 10:02:26
 -0700 (PDT)
In-Reply-To: <CAKwvOd=rwib91mnXs=PCP460hkCWTE5anNFgvRPBrbagetCbzw@mail.gmail.com>
References: <20180730213412.242849-3-ndesaulniers@google.com>
 <201807311827.UpeCrGPC%fengguang.wu@intel.com> <CAKwvOd=rwib91mnXs=PCP460hkCWTE5anNFgvRPBrbagetCbzw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 31 Jul 2018 10:02:26 -0700
X-Google-Sender-Auth: KnMd1eECOgxOcWuwZqh5ctsNjuU
Message-ID: <CAGXu5jJFdbcmSMZi-uz0QySJ5c6uqUKEazztDfCWDeQOMF-T-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, paul.burton@mips.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stafford Horne <shorne@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>, NeilBrown <neilb@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        sandipan@linux.vnet.ibm.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Lawrence <paullawrence@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>, ghackmann@android.com,
        "# 3.4.x" <stable@vger.kernel.org>,
        Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>, Andrew Vagin <avagin@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:48 AM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Does anyone understand this error?  The code looks just fine to me,
> and the source file doesn't conflict with any of the macros I've added
> (certainly not in any way that could cause an indentation error as
> reported here).

It does _use_ the macro, but yeah, I'm stumped...

> On Tue, Jul 31, 2018 at 3:27 AM kbuild test robot <lkp@intel.com> wrote:
>>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c: In function 'iwl_trans_send_cmd':
>> >> drivers/net//wireless/intel/iwlwifi/iwl-trans.c:137:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>>      if (!(cmd->flags & CMD_ASYNC))
>>      ^~
>>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c:138:1: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
>>       lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
>>     ^ ~
>>
>> vim +/if +137 drivers/net//wireless/intel/iwlwifi/iwl-trans.c
>>
>> 92fe8343 Emmanuel Grumbach 2015-12-01 @137      if (!(cmd->flags & CMD_ASYNC))
>> 92fe8343 Emmanuel Grumbach 2015-12-01  138              lock_map_acquire_read(&trans->sync_cmd_lockdep_map);

#define lock_map_acquire_read(l)
lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)

#define lock_acquire_shared_recursive(l, s, t, n, i)
lock_acquire(l, s, t, 2, 1, n, i)

The config doesn't have CONFIG_LOCKDEP, so it's not:

extern void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
                         int trylock, int read, int check,
                         struct lockdep_map *nest_lock, unsigned long ip);

but rather:

# define lock_acquire(l, s, t, r, c, n, i)      do { } while (0)

If you build with the same gcc and config, does it reproduce for you?

-Kees

-- 
Kees Cook
Pixel Security
