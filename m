Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbeE2GPY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:15:24 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:31350 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeE2GPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:15:23 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4T6F1GW001271
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AB8JxZpRWkqybUfVy4cEtFXwl1XowG723zn7b+0mCa02E2Obk+HJmIXvsnEpLnc+0rxZMJp5Lv/Y8gWbM77nHV4/QSQ=
MIME-Version: 1.0
In-Reply-To: <20180529061127.GA20005@infradead.org>
References: <20180528163505.15698-1-luc.vanoostenryck@gmail.com> <20180529061127.GA20005@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 29 May 2018 15:14:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_dnO9Enr+Dg11YTux8JAV3K=k4r_5VP3moUCG8s5XHg@mail.gmail.com>
Message-ID: <CAK7LNAT_dnO9Enr+Dg11YTux8JAV3K=k4r_5VP3moUCG8s5XHg@mail.gmail.com>
Subject: Re: [PATCH] riscv: pass machine size to sparse
To: Christoph Hellwig <hch@infradead.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <albert@sifive.com>, Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-29 15:11 GMT+09:00 Christoph Hellwig <hch@infradead.org>:
> On Mon, May 28, 2018 at 06:35:05PM +0200, Luc Van Oostenryck wrote:
>> By default, sparse assumes a 64bit machine when compiled on x86-64
>> and 32bit when compiled on anything else.
>>
>> This can of course create all sort of problems when this doesn't
>> correspond to the target's machine size, like issuing false
>> warnings like: 'shift too big (32) for type unsigned long' or
>> is 64bit while sparse was compiled on a 32bit machine, or worse,
>> to not emit legitimate warnings.
>>
>> Fix this by passing the appropriate -m32/-m64 flag to sparse.
>
> Can we please move this to the common Kbuild code using the
> CONFIG_64BIT syombol?  This really should not need boiler plate in
> every architecture.


I agree.

Luc did so for -mbig/little-endian:
https://patchwork.kernel.org/patch/10433957/

We should do likewise for -m32/64.



-- 
Best Regards
Masahiro Yamada
