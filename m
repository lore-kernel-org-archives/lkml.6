Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeCOS7g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:59:36 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:38961 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeCOS7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:59:34 -0400
X-Google-Smtp-Source: AG47ELtCPcfkIsvx9v4I9ObLXLkTOwV8fT2pXzQ/Z4udP9qiJQRg2Z+0fgFu7fCR2pI1yQWfFr0UNQ==
Date: Thu, 15 Mar 2018 14:59:32 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] kbuild: move include/config/ksym/* to
 include/ksym/*
In-Reply-To: <CAK7LNATS2CyFVXoN5CrqeVcNBYA09aCmyz3Bm5BZo4VJEvxONQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1803151450260.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com> <1521045861-22418-7-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1803141437030.28583@knanqh.ubzr>
 <CAK7LNATS2CyFVXoN5CrqeVcNBYA09aCmyz3Bm5BZo4VJEvxONQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Masahiro Yamada wrote:

> 2018-03-15 3:47 GMT+09:00 Nicolas Pitre <nicolas.pitre@linaro.org>:
> > On Thu, 15 Mar 2018, Masahiro Yamada wrote:
> >
> >> The idea of using fixdep was inspired by Kconfig, but autoksyms
> >> is unrelated to Kconfig.  So, I want to get those touched files
> >> out of include/config/.  The directory include/ksym/ is removed
> >> by "make clean".  We do not need to keep it for external module
> >> building.
> >
> > It could be argued that include/config/ is not strictly containing
> > configuration data either and is slightly misleading.
> 
> But, slightly related to configuration, IMHO.
> At least they carry timestamps that are updated
> when kernel configuration is changed.

Yes. But for the sake of argument, the ksym timestamps are updated only 
when configuration is changed too. Fundamentally they're both about 
dependencies, hence my naming suggestion of deps/config/ and deps/ksym/ 
so not to clutter the top include directory too much.

> The difference between include/config/ and include/ksym/ is that
> files under include/config/ are necessary for building
> external modules (so should be cleaned away by mrproper)
> whereas include/ksym/ is unnecessary for external modules
> since vmlinux and in-kernel modules do not depend on
> external modules.

Agreed. 

> I wonder if trimming symbols makes sense for external modules.

Probably not.


Nicolas
