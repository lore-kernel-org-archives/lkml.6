Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF10C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC420841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsW0XZGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CC420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeGaSaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:30:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44474 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeGaSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:30:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so7413132pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0WOo3R3YBIqyGQEAcbJ7mGnnTgMAUrFkzZIsK+f730=;
        b=rsW0XZGX7UJ+r+0Uvjxdc6P7DK+s0JGuFibI6wVkRUoLZTMBBsjKG1PJmgKer0nhEE
         6C4M0tO5eVcRoGEPIpVK5wKxoQz0zWqSFkTBTy7g16nDSwwgpeI/q+DtmT8iCQqrSZx0
         iEPAnrCDiPP0wb3XNrNrfkdasaiB6IvXj0F44aAnrGNi83Uea0F3V2w+4ITLAYKS1eiV
         08gEZI1CCIgF9FSV8KJeHfiHOF5dI0eihhTL5J0OGzpw9SJjaxbt1jDIKR3Ggw56VUM/
         0uOccVVc1ZmMioKBQ92dxSdSsOhzkos+tDYMYBysMgvV8d2BR3xYrdFC3MflWBhs4Hqn
         mJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0WOo3R3YBIqyGQEAcbJ7mGnnTgMAUrFkzZIsK+f730=;
        b=VjXoJIUazb8ugh2HQRkxg3oYrYlcWGSoEZsLI4RHd2exg3lyyj8P0xkW7PGmhQg2WG
         o6XEJRllF8dPyXFggCLtoLmOSjK+pF7JyCDC+R4/d6iFfkfgpuHnmVCH8UDgh1qksTrl
         iTWVRnPN7o+Or8a5KM88NubLV8lZtl9/bBgOflk22l0QPvySX7sDe202MXE3b+GiJZ+m
         cwSUvdU4FfLRM5bVfUGJjPIzZUnjatTbEPJ4R6OV52XH5sHOvyaRhMTgZZKDr36JlbSd
         OAFGbr88tS//l03/tlwLHZUYP6ojYogUZrwmK8uZcF7yRoACX0t8Y0sBQOh+RkAm+W/i
         7euw==
X-Gm-Message-State: AOUpUlEGDjD/IdG3UZEF5PYqOStulHOLSTa2ZSMmwSkwYQ05sghxCqG8
        emt7iVLTI/3vs5x6onxLyrDdcaATkK1YJN1SQPSudg==
X-Google-Smtp-Source: AAOMgpdP9mxVk3W5FXDXvCb2yVFqQ3nSGnlzp5IvgcFTIa0qNGeyhZtpwezCi/04FzeQxdvFPm4Ec0EaeQgQ11LIqpA=
X-Received: by 2002:a17:902:708b:: with SMTP id z11-v6mr20830038plk.262.1533055748726;
 Tue, 31 Jul 2018 09:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180730213412.242849-3-ndesaulniers@google.com> <201807311827.UpeCrGPC%fengguang.wu@intel.com>
In-Reply-To: <201807311827.UpeCrGPC%fengguang.wu@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Jul 2018 09:48:57 -0700
Message-ID: <CAKwvOd=rwib91mnXs=PCP460hkCWTE5anNFgvRPBrbagetCbzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
To:     lkp@intel.com
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone understand this error?  The code looks just fine to me,
and the source file doesn't conflict with any of the macros I've added
(certainly not in any way that could cause an indentation error as
reported here).
On Tue, Jul 31, 2018 at 3:27 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.18-rc7 next-20180727]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Nick-Desaulniers/compiler-clang-h-Add-CLANG_VERSION-and-__diag-macros/20180731-161932
> config: x86_64-fedora-25 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All warnings (new ones prefixed by >>):
>
>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c: In function 'iwl_trans_send_cmd':
> >> drivers/net//wireless/intel/iwlwifi/iwl-trans.c:137:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
>      if (!(cmd->flags & CMD_ASYNC))
>      ^~
>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c:138:1: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
>       lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
>     ^ ~
>
> vim +/if +137 drivers/net//wireless/intel/iwlwifi/iwl-trans.c
>
> 92fe8343 Emmanuel Grumbach 2015-12-01  116
> 92fe8343 Emmanuel Grumbach 2015-12-01  117  int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
> 92fe8343 Emmanuel Grumbach 2015-12-01  118  {
> 92fe8343 Emmanuel Grumbach 2015-12-01  119      int ret;
> 92fe8343 Emmanuel Grumbach 2015-12-01  120
> 92fe8343 Emmanuel Grumbach 2015-12-01  121      if (unlikely(!(cmd->flags & CMD_SEND_IN_RFKILL) &&
> 326477e4 Johannes Berg     2017-04-25  122                   test_bit(STATUS_RFKILL_OPMODE, &trans->status)))
> 92fe8343 Emmanuel Grumbach 2015-12-01  123              return -ERFKILL;
> 92fe8343 Emmanuel Grumbach 2015-12-01  124
> 92fe8343 Emmanuel Grumbach 2015-12-01  125      if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
> 92fe8343 Emmanuel Grumbach 2015-12-01  126              return -EIO;
> 92fe8343 Emmanuel Grumbach 2015-12-01  127
> 92fe8343 Emmanuel Grumbach 2015-12-01  128      if (unlikely(trans->state != IWL_TRANS_FW_ALIVE)) {
> 92fe8343 Emmanuel Grumbach 2015-12-01  129              IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
> 92fe8343 Emmanuel Grumbach 2015-12-01  130              return -EIO;
> 92fe8343 Emmanuel Grumbach 2015-12-01  131      }
> 92fe8343 Emmanuel Grumbach 2015-12-01  132
> 92fe8343 Emmanuel Grumbach 2015-12-01  133      if (WARN_ON((cmd->flags & CMD_WANT_ASYNC_CALLBACK) &&
> 92fe8343 Emmanuel Grumbach 2015-12-01  134                  !(cmd->flags & CMD_ASYNC)))
> 92fe8343 Emmanuel Grumbach 2015-12-01  135              return -EINVAL;
> 92fe8343 Emmanuel Grumbach 2015-12-01  136
> 92fe8343 Emmanuel Grumbach 2015-12-01 @137      if (!(cmd->flags & CMD_ASYNC))
> 92fe8343 Emmanuel Grumbach 2015-12-01  138              lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
> 92fe8343 Emmanuel Grumbach 2015-12-01  139
> 5b88792c Sara Sharon       2016-08-15  140      if (trans->wide_cmd_header && !iwl_cmd_groupid(cmd->id))
> 5b88792c Sara Sharon       2016-08-15  141              cmd->id = DEF_ID(cmd->id);
> 5b88792c Sara Sharon       2016-08-15  142
> 92fe8343 Emmanuel Grumbach 2015-12-01  143      ret = trans->ops->send_cmd(trans, cmd);
> 92fe8343 Emmanuel Grumbach 2015-12-01  144
> 92fe8343 Emmanuel Grumbach 2015-12-01  145      if (!(cmd->flags & CMD_ASYNC))
> 92fe8343 Emmanuel Grumbach 2015-12-01  146              lock_map_release(&trans->sync_cmd_lockdep_map);
> 92fe8343 Emmanuel Grumbach 2015-12-01  147
> 0ec971fd Johannes Berg     2017-04-10  148      if (WARN_ON((cmd->flags & CMD_WANT_SKB) && !ret && !cmd->resp_pkt))
> 0ec971fd Johannes Berg     2017-04-10  149              return -EIO;
> 0ec971fd Johannes Berg     2017-04-10  150
> 92fe8343 Emmanuel Grumbach 2015-12-01  151      return ret;
> 92fe8343 Emmanuel Grumbach 2015-12-01  152  }
> 92fe8343 Emmanuel Grumbach 2015-12-01  153  IWL_EXPORT_SYMBOL(iwl_trans_send_cmd);
> 39bdb17e Sharon Dvir       2015-10-15  154
>
> :::::: The code at line 137 was first introduced by commit
> :::::: 92fe83430b899b786c837e5b716a328220d47ae5 iwlwifi: uninline iwl_trans_send_cmd
>
> :::::: TO: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> :::::: CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Thanks,
~Nick Desaulniers
