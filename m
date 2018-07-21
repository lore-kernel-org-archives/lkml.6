Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18589ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE35720857
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYSYwRy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE35720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeGUA4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:56:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36663 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeGUA4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:56:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so4649556pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcKGziW8YkjooBq6zXHJVo8o609Dj3pikTUeIzQGTVY=;
        b=fYSYwRy/p6fdT6LCXIrwdaHuIvLQaLPff49Txhkr4NsIdR5PT1dAeCfz6ONcCYn8hX
         FfURoA4Asgqo9Fl8C5O+QmQSU6WzeOF8xQfEgk1aWv6rqajFjSMJ89gphY1jKFefVsbj
         aOe4VZtFscl2gqxK1wxwR+YrurjB5LL5WLuhcZma6kdBvTLhe90af/zJYxdHZO5PLTtI
         nTsBeigI70u6I+BbidkxPuVc91gA4zsVmYFoOlR8IjZUN8efg0U0cScEedWxsurqn4Vz
         cvBypCUEgSR1+EJ+Yc5hgc4z3eoHf5DQaIrgEtbu3op0TIpdwkHhxiHTruXsoFCk8hZw
         5k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcKGziW8YkjooBq6zXHJVo8o609Dj3pikTUeIzQGTVY=;
        b=p2Kc1VXo+luVwLDnuRW2szsh1L7daiiwLE9ozyd22xFKQVFYD1swFBxxCkYIK3u0Gg
         JnI926m61Fhr2/w3z0tg7LDynyA7bXF/ieGuUg78KV0McR+jS2teMYQaxC5AN/idAX+m
         UG3f5QY30EdFrT6pcEPvhHOCbPS4Y5vgR/8fxVKIT0thJCeHyRTB2T98xPPIoldQ+DL/
         Dc0BxulyDUKzU0+bdH5DKaRAqYdHJ/FptoUtCA22IEIBCVPQePtOpb2ycOCWzVKCgjS6
         +5VS+8ERdb/JxnCK0hU1SKnlDN2Fwx76P+XES4eI5+OaZUalp8546owdhQEysWJKxODm
         msTw==
X-Gm-Message-State: AOUpUlHhz1o0yJTGI7kysPHgELm9EzYMOmAhfkm2/YHvulAXSZ+3DhDl
        yDTMiQVzjqkI5pWSouj0Dp+qd9qfmAG9+gry1gd6Xw==
X-Google-Smtp-Source: AAOMgpccqOeAOhfzsmZQh0hy4/0GZYsnzCPB+vGxzp2MWvLK8ayt39DEtYKyVmzkfpL5H+Fi4I+w6X/9i+QV2oW6UeE=
X-Received: by 2002:a63:d916:: with SMTP id r22-v6mr3758392pgg.381.1532131578690;
 Fri, 20 Jul 2018 17:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180720223642.126080-1-ndesaulniers@google.com> <201807210738.RRpvc56w%fengguang.wu@intel.com>
In-Reply-To: <201807210738.RRpvc56w%fengguang.wu@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 20 Jul 2018 17:06:07 -0700
Message-ID: <CAKwvOdnrwW-CaVKR-iJTDfwVGRj4xE=5MaUMyvjqsEw-7yPiZw@mail.gmail.com>
Subject: Re: [4.4 STABLE BACKPORT] x86: paravirt: make native_save_fl extern inline
To:     lkp@intel.com
Cc:     kbuild-all@01.org, Greg KH <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jgross@suse.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 5:04 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/x86/core]
> [cannot apply to v4.18-rc5 next-20180720]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Nick-Desaulniers/x86-paravirt-make-native_save_fl-extern-inline/20180721-073112
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    arch/x86/kernel/irqflags.S: Assembler messages:
> >> arch/x86/kernel/irqflags.S:22: Error: bad register name `%_ASM_ARG1'
>
> vim +22 arch/x86/kernel/irqflags.S
>
>     16
>     17  /*
>     18   * void native_restore_fl(unsigned long flags)
>     19   * %eax/%rdi: flags
>     20   */
>     21  ENTRY(native_restore_fl)
>   > 22          push %_ASM_ARG1
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

oops, probably should not have cc'ed vger.kernel.org for a patch meant
for stable.

-- 
Thanks,
~Nick Desaulniers
