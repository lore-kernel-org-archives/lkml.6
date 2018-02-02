Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeBBUTH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:19:07 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42804 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBBUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:18:58 -0500
X-Google-Smtp-Source: AH8x2273fo53jGHz08dmVoIHRhiw+QbnNylXN461Qq29+DrPVoKY6p0PJeL9pW/0HqrN1ZSJ5/yGeUEJuavEunMI0qA=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1802021336090.1842@knanqh.ubzr>
References: <20180202161550.2106846-1-arnd@arndb.de> <20180202162104.2300532-7-arnd@arndb.de>
 <nycvar.YSQ.7.76.1802021336090.1842@knanqh.ubzr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 21:18:57 +0100
X-Google-Sender-Auth: f-W3u7BI4KOkpkp4vzW0syl53GQ
Message-ID: <CAK8P3a3dgFjXP3wub+J5-_67MS2Mm_twktD=cyoY2pPro+AWzQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] Kbuild: lto: pass -m32/-m64 to to LDFINAL
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 7:41 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 2 Feb 2018, Arnd Bergmann wrote:
>
>> Building randconfig kernels with a biarch compiler fails with LTO
>> when the final link uses a different target architecture compared
>> to the earlier compilation stages.
>>
>> Setting -m32 or -m64 in ${LDFINAL} solves this problem, though my
>> feeling is that there is a better way to do this. There might also
>> be other from KBUILD_CFLAGS that we may need in LDFINAL.
>
> On ARM I had the same problem as it requires explicit arch flags. I
> therefore used this patch:

> -exec $CC $ARGS
> +case "${KBUILD_VERBOSE}" in
> +*1*)
> +       set -x
> +       ;;
> +esac
> +
> +exec $CC $KBUILD_CFLAGS $ARGS

Ah, right, that's much simpler. I'll put that in my test tree now and
will see if it works on x86.

Do you have a git tree with other changes for LTO on ARM? I'd
like to try that as well.

       Arnd
