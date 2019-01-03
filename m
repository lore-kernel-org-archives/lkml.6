Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C65CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECC32073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzTkF8Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfACL3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:29:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39359 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfACL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:29:14 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so42291228itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 03:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTf1ISxz44gFqNGbDi0F6gRg6ajOO3jJUGTWGvjBvq8=;
        b=PzTkF8KkOgbPI7OZBO2lS7ihVq/V2xbkIYQ4Fz+/c70ruaCbTwLMr8O3PpOnhheSIo
         Ouo/mOsQhvBfaI5+AOQ5oAGuM9Drj7xa9FVOqwHpd46FLv55UeyJeshY1M10lbxgjM5Q
         eQXRvv7lUcsi6+EZCx/ZdTtrFB3l0QEogcUxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTf1ISxz44gFqNGbDi0F6gRg6ajOO3jJUGTWGvjBvq8=;
        b=fihFrQjfaPaUJQzpb9kEIcuCbOQ0inNXpBF7gJGOJzUYe2PD3wjYarqwx6PS7QUl9A
         ANaaTONn7Xde6p20YJ4w4B11IwPOXUX3wLgYPMDRwICLbC2xKaF0sh0HxuQASJG/INw2
         QfLkDhi3cac9GMmRtB3KS/D3VmVzm7rkxFeY8uumVJ7gbqdkOlBrZ8+hJ8sIB3ndMClg
         2ROT5hvhIGp6Di5/7nWXsWp4u+w0qFMtgASFrgsFnN5adguxl5rCyw2IlesMdVZOEMAh
         lQrBRKGAG1+a9VUQFU7UDNTMVMwU0t44VR5h2VmjBn/JYoHF0LQBabrTeBZtfl5CuSfA
         1oEQ==
X-Gm-Message-State: AJcUukf69SVze1ktJyBAEZCny28hYsdIXqNOtIHKgXcvRpOLFp1te2Eh
        Q3EsW+3Rtm6MLCoG4w2xy38SiF1yqDHz00CFVveYXg==
X-Google-Smtp-Source: ALg8bN6ze6Ysp3Q6BIwUcJv0STjbC4qRmnSxG+vKlTIkazkrPft5Ch6mtKKxUrCbwt+xHPWc8t8wS6xtku5NKk042gw=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr28296440iti.166.1546514953814;
 Thu, 03 Jan 2019 03:29:13 -0800 (PST)
MIME-Version: 1.0
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org>
 <1546442319-20461-2-git-send-email-firoz.khan@linaro.org> <CAMuHMdXD5PpF0VswotPP=DQUZ6Rcx0jUq1Czo_WFdGAUrkddyw@mail.gmail.com>
In-Reply-To: <CAMuHMdXD5PpF0VswotPP=DQUZ6Rcx0jUq1Czo_WFdGAUrkddyw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 3 Jan 2019 16:59:03 +0530
Message-ID: <CALxhOnhjbJMGEXTaYCw9TN7kMsu_fi67FW-AjHGtntnUbXQ6tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: remove nargs from __SYSCALL
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your feedback.

On Thu, 3 Jan 2019 at 16:15, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> >         while [ $t_nxt -lt $t_nr ]; do
> > -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> > +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
>
> Please keep the space after the comma.

This is intentional as I was facing some compilation issue with
one architecture (If I'm right it is powerpc) when I keep the space
after comma.

Firoz
