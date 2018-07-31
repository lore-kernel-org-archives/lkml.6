Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39432C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A7B20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I48Pd9ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A7B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbeGaSoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:44:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41376 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbeGaSoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:44:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so17437913wrr.8;
        Tue, 31 Jul 2018 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bzPIsOxixV46MrDLqgR12pdODUsTABHyqtsYk95fGXE=;
        b=I48Pd9ma1JFct8yOq316rSy83SI2kBrwgcZRbUZ3x6z8RcPvJG2C+bg72aYfSEQmuW
         1ZtBtxLs+nAn69l6KjG0y5htuNDW7YNJNHSJiCZKWYBk64j5AU+vnMVAFvuZJn4+rXTk
         PoJSI2IFanKG4c8CloRrj1dLrSFHlDTCgIxFsW6ynnAJJtXY+GsURGTxMJLPxIRVMeTw
         6qMB6Nku7z8+tDFAfS26OcFFaaiKcNJLGCa2UDFbN9r2n8/9wOsCkMAgMQi+1NkmGlGU
         oSb08uE3fR76nZciYvQCi60drxh49/ws11dx65LOP0n/OHI5OxSGWZK6mF/X0KaynhOY
         9ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bzPIsOxixV46MrDLqgR12pdODUsTABHyqtsYk95fGXE=;
        b=czz/xl2g3nofNTP6lFd+JK8wbDC8Pc8S8mTzMWbh+iZ5gLtuGmsqv72qY6CBXLdJpe
         NZI7UcwVgBQAlaUPlY88+BaGXYT9f14atnQGxoCFddT1iYlR/P68Lql5WmAUwAL1/Qka
         3vJ38IeJ6IrcvSfU97yXnCUvfvwqzX++DxuSsImAyQHGURai/PtJAabrqXCYy1uNq0AF
         l67tJ6TXNoPP1YY6xZz8AKapqH2ANucuvUWBZqE2qtgUncylgipj69+ejwub5ON4K/Jl
         m6lqAdbykMa2Q2/6Ja9qzCxKGSyH8I6CyI9gyLy0H7G5sdNvMpE50Nt8fuID47oJzThh
         wnEw==
X-Gm-Message-State: AOUpUlG3i8xyru3suXrfBZHCywdz8+xzxwLuy5TxcQqnnuuk+9viVuRQ
        SlqijLYgCV5RZC3wz8YoxR4=
X-Google-Smtp-Source: AAOMgpfLgQUpE9xQJblW6TovilMrtrc3HnaoBdo0eNoMlRl7fh5ugdGuRIFW8jN9rQz13ABrLEmZmg==
X-Received: by 2002:adf:eb87:: with SMTP id t7-v6mr22647971wrn.123.1533056579789;
        Tue, 31 Jul 2018 10:02:59 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u185-v6sm3645856wmg.25.2018.07.31.10.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 10:02:58 -0700 (PDT)
Date:   Tue, 31 Jul 2018 10:02:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     lkp@intel.com, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, paul.burton@mips.com,
        christophe.leroy@c-s.fr, shorne@gmail.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v2 2/2] kernel.h: Disable -Wreturn-stack-address for
 _THIS_IP_
Message-ID: <20180731170256.GA23359@flashbox>
References: <20180730213412.242849-3-ndesaulniers@google.com>
 <201807311827.UpeCrGPC%fengguang.wu@intel.com>
 <CAKwvOd=rwib91mnXs=PCP460hkCWTE5anNFgvRPBrbagetCbzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=rwib91mnXs=PCP460hkCWTE5anNFgvRPBrbagetCbzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:48:57AM -0700, Nick Desaulniers wrote:
> Does anyone understand this error?  The code looks just fine to me,
> and the source file doesn't conflict with any of the macros I've added
> (certainly not in any way that could cause an indentation error as
> reported here).

Unfortunately, I've been trying to work through it this morning and I
can't understand it either. lock_map_acquire_read's defintion does
include _THIS_IP_ and adding curly braces to the if statement fixes it
but that doesn't explain why it's happening.

Maybe this is a GCC bug/issue?

Cheers,
Nathan

> On Tue, Jul 31, 2018 at 3:27 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Nick,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v4.18-rc7 next-20180727]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Nick-Desaulniers/compiler-clang-h-Add-CLANG_VERSION-and-__diag-macros/20180731-161932
> > config: x86_64-fedora-25 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/net//wireless/intel/iwlwifi/iwl-trans.c: In function 'iwl_trans_send_cmd':
> > >> drivers/net//wireless/intel/iwlwifi/iwl-trans.c:137:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
> >      if (!(cmd->flags & CMD_ASYNC))
> >      ^~
> >    drivers/net//wireless/intel/iwlwifi/iwl-trans.c:138:1: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
> >       lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
> >     ^ ~
> >
> > vim +/if +137 drivers/net//wireless/intel/iwlwifi/iwl-trans.c
> >
> > 92fe8343 Emmanuel Grumbach 2015-12-01  116
> > 92fe8343 Emmanuel Grumbach 2015-12-01  117  int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
> > 92fe8343 Emmanuel Grumbach 2015-12-01  118  {
> > 92fe8343 Emmanuel Grumbach 2015-12-01  119      int ret;
> > 92fe8343 Emmanuel Grumbach 2015-12-01  120
> > 92fe8343 Emmanuel Grumbach 2015-12-01  121      if (unlikely(!(cmd->flags & CMD_SEND_IN_RFKILL) &&
> > 326477e4 Johannes Berg     2017-04-25  122                   test_bit(STATUS_RFKILL_OPMODE, &trans->status)))
> > 92fe8343 Emmanuel Grumbach 2015-12-01  123              return -ERFKILL;
> > 92fe8343 Emmanuel Grumbach 2015-12-01  124
> > 92fe8343 Emmanuel Grumbach 2015-12-01  125      if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
> > 92fe8343 Emmanuel Grumbach 2015-12-01  126              return -EIO;
> > 92fe8343 Emmanuel Grumbach 2015-12-01  127
> > 92fe8343 Emmanuel Grumbach 2015-12-01  128      if (unlikely(trans->state != IWL_TRANS_FW_ALIVE)) {
> > 92fe8343 Emmanuel Grumbach 2015-12-01  129              IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
> > 92fe8343 Emmanuel Grumbach 2015-12-01  130              return -EIO;
> > 92fe8343 Emmanuel Grumbach 2015-12-01  131      }
> > 92fe8343 Emmanuel Grumbach 2015-12-01  132
> > 92fe8343 Emmanuel Grumbach 2015-12-01  133      if (WARN_ON((cmd->flags & CMD_WANT_ASYNC_CALLBACK) &&
> > 92fe8343 Emmanuel Grumbach 2015-12-01  134                  !(cmd->flags & CMD_ASYNC)))
> > 92fe8343 Emmanuel Grumbach 2015-12-01  135              return -EINVAL;
> > 92fe8343 Emmanuel Grumbach 2015-12-01  136
> > 92fe8343 Emmanuel Grumbach 2015-12-01 @137      if (!(cmd->flags & CMD_ASYNC))
> > 92fe8343 Emmanuel Grumbach 2015-12-01  138              lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
> > 92fe8343 Emmanuel Grumbach 2015-12-01  139
> > 5b88792c Sara Sharon       2016-08-15  140      if (trans->wide_cmd_header && !iwl_cmd_groupid(cmd->id))
> > 5b88792c Sara Sharon       2016-08-15  141              cmd->id = DEF_ID(cmd->id);
> > 5b88792c Sara Sharon       2016-08-15  142
> > 92fe8343 Emmanuel Grumbach 2015-12-01  143      ret = trans->ops->send_cmd(trans, cmd);
> > 92fe8343 Emmanuel Grumbach 2015-12-01  144
> > 92fe8343 Emmanuel Grumbach 2015-12-01  145      if (!(cmd->flags & CMD_ASYNC))
> > 92fe8343 Emmanuel Grumbach 2015-12-01  146              lock_map_release(&trans->sync_cmd_lockdep_map);
> > 92fe8343 Emmanuel Grumbach 2015-12-01  147
> > 0ec971fd Johannes Berg     2017-04-10  148      if (WARN_ON((cmd->flags & CMD_WANT_SKB) && !ret && !cmd->resp_pkt))
> > 0ec971fd Johannes Berg     2017-04-10  149              return -EIO;
> > 0ec971fd Johannes Berg     2017-04-10  150
> > 92fe8343 Emmanuel Grumbach 2015-12-01  151      return ret;
> > 92fe8343 Emmanuel Grumbach 2015-12-01  152  }
> > 92fe8343 Emmanuel Grumbach 2015-12-01  153  IWL_EXPORT_SYMBOL(iwl_trans_send_cmd);
> > 39bdb17e Sharon Dvir       2015-10-15  154
> >
> > :::::: The code at line 137 was first introduced by commit
> > :::::: 92fe83430b899b786c837e5b716a328220d47ae5 iwlwifi: uninline iwl_trans_send_cmd
> >
> > :::::: TO: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > :::::: CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
