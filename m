Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeCMGQJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:16:09 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:39977 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeCMGQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:16:07 -0400
X-Google-Smtp-Source: AG47ELvME66uSjJJenPvX8meqaUB68wKj8VXaiuGRH6us9t0aZxF8Xvt9AP6Mrm08VeEq8TqOOW4Zg==
Date: Tue, 13 Mar 2018 07:16:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, malat@debian.org,
        dave.hansen@intel.com, yang.s@alibaba-inc.com, linux@roeck-us.net,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/2] kbuild: Don't mess with the .cache.mk when root
Message-ID: <20180313061603.jsgiumet23uqi6hl@gmail.com>
References: <20180313061109.72629-1-dianders@chromium.org>
 <20180313061109.72629-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313061109.72629-3-dianders@chromium.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Douglas Anderson <dianders@chromium.org> wrote:

> +# Don't create Makefile caches if running as root since they can't be deleted
> +# easily; in the real world we might be root when doing "sudo make install"
> +ifeq ($(shell id -u),0)
> +export KBUILD_NOCACHE := 1
> +endif

Please don't do this - many prominent kernel developers build their kernels as 
root - this makes the build slower for them, and also bifurcates testing.

Thanks,

	Ingo
