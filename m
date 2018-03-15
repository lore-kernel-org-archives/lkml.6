Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeCOSuI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:50:08 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35311 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeCOSuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:50:04 -0400
X-Google-Smtp-Source: AG47ELuVWQrp7BL693Pv9AUs2HoqEvrwRJ/8pvASr9Q9mzTVB8KFsecF7bc9RR0gU7Y+jowyIOF8PA==
Date: Thu, 15 Mar 2018 14:50:02 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] kbuild: link vmlinux just once for
 CONFIG_TRIM_UNUSED_KSYMS
In-Reply-To: <CAK7LNATANL6Lfa6=05g9fCfj0ZLNHu_XnPEfurrOBQ8YXqUc4w@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1803151434270.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com> <1521045861-22418-8-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1803141448330.28583@knanqh.ubzr>
 <CAK7LNATANL6Lfa6=05g9fCfj0ZLNHu_XnPEfurrOBQ8YXqUc4w@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Masahiro Yamada wrote:

> I am not familiar with Make internal, but
> I can test it with simple code.
> 
> 
> [Test Makefile]
> A: B
>         cp B A
>         echo $?
> 
> B: C
>         cp C B
>         touch A
> 
> [Result]
> $ rm -rf A B C
> $ touch C
> $ make
> cp C B
> touch A
> cp B A
> echo B
> B
> 
> 
> In the recipe of 'B', 'A' is touched,
> so the dependency 'A: B' has already been met
> before the recipe of 'A' is executed,
> but Make does not notice that fact,
> then tries to update 'A'.
> 
> 
> The situation is the same.
> vmlinux has been updated in the recursed sub-make,
> but it is not noticed.

OK, I agree.


Nicolas
