Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB67ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A1D208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF7YoktT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A1D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbeGPKii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36844 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeGPKih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id u7-v6so26799749lji.3;
        Mon, 16 Jul 2018 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U526Z76lr9q3SDgXDC8SMe3lWlKehMMlXJd4nvJ+2/k=;
        b=DF7YoktTZcQl8qwRSO+w3BRIIa9PuDiIrl9DPmslufHzeUohAk9+tU73HlQVOPPwOs
         6E+zE773ZXaeHlLKwcZrGfRY9FSoFjW2mee47Xkxae7anFryHdTjsMjft3dboGYpYu0t
         Js/cAe46YGPXk103KJVZ8xLwq3CWmZ7fXYnXcsPbtDzkGEoLp6GrfnNyi+smizRHdTNB
         +MYK/qkJ21YfegrDCFP9/+hdZeHNH3BX7ugpfz3tagTud9M4W9jj1Ro05fXZwjPzsdhp
         I4omv6vDUS2dZ0KwlInqzzOzVR5uUptox7OVMGHBUCJwJyU4E+lfAQAqcLMyyM0oMJcs
         QMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=U526Z76lr9q3SDgXDC8SMe3lWlKehMMlXJd4nvJ+2/k=;
        b=HrDgeOl0D0j0Yh7ApNuq0fCi0JFawsDWU117RUYCuW7n11jiIibi5z6iguXpr2Q7cd
         /AXEb5qXntjlqAgIdaHEjI7T76neAdHxwDnc6vROxWuvKdhNUyT7Qm0KS2+EM1g7Te4Z
         rPY+4pgYVKcAeK7NgEU7RX76TFskjJ3PNQYmqfRaSvyGQECyb243m9/sFTyZT1b1WR1K
         Cro2sKAAjaoutwgum5gLk0a0d2WVr9ggVEpnbxDJ/BuDOSZeaHMUtF9KaAXzDfyIVUse
         zYZ4+DQar/LjLeVFLA/EHlXjDbF0SSkiis+pakT2MVGEm+XRz7tBlnYPkKULaGgVOENF
         8DFw==
X-Gm-Message-State: AOUpUlHwIP+G7ZrC11oH1Dfvb+iQCVwd1/wnYRIEws0TOAkPnXARLlOU
        /HHL8dTk3Tg6dkq9VNxZ9YHdtJ0FMeCKhyjl0jU=
X-Google-Smtp-Source: AAOMgpemEchVcQpNCI674nzPG/ZgjomJdjxuvd0fbmWRzDocgqF2J9yF/EkMQrUXJSIUWk7fSc2f8gFm4i3kjaKT3Yg=
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr9974943lje.129.1531735914601;
 Mon, 16 Jul 2018 03:11:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:11:53
 -0700 (PDT)
In-Reply-To: <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
References: <20180713133204.3123939-1-arnd@arndb.de> <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Jul 2018 12:11:53 +0200
X-Google-Sender-Auth: udznkbPeJx1MWMhzbbO98cnmKSo
Message-ID: <CAK8P3a2xu4KGVM1BvTjtXKHfXpBQ2PMynAPybW4cRt7FB8ktwg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] y2038: globally rename compat_time to old_time32
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 5:54 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> Right now we only have compat syscalls and native syscalls.
> Until we transition all the architectures to use the new syscalls,
> wouldn't it be the same sort of confusion as exists today?
> These structures today are still used by compat entry points.
> I'm trying to understand why such a cleanup would make sense today
> rather than at the end of the transition.

I don't think it makes a big difference whether we change it now or later,
but if Christoph feels that it addresses his concern about the compat_
namespace being reused during the transition, doing it earlier would
enable us to finish the remaining syscalls.

We are running a little late with the remaining syscalls for 4.19 as we
now have an rc5. At this point we probably won't have time to finish
the discussion about all of clock_adjtime, getrusage/waitid and getitimer(),
but I'd really like to get utimensat, futex, sched_rr_get_interval,
recvmmsg, sys_io_getevents, rt_sigtimedwait, ppoll and pselect6
done for 4.19 so we can finalize the ABI for 4.20 along with doing
the actual conversion.

      Arnd
