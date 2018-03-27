Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeC0Qwb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:52:31 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38548 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeC0QwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:52:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2RGq6Lx013374
X-Nifty-SrcIP: [209.85.217.169]
X-Google-Smtp-Source: AIpwx490c2U0BxFPmcsC+ZdcEdo9nbdew2vS+8XyW9EdShKivBYpmU5FIABaCTeo9XjA8xGj0zeGwkEMLnnRXIdzysU=
MIME-Version: 1.0
In-Reply-To: <87a8da66-c610-9b61-d0f8-b5bc7faf2dd7@siemens.com>
References: <c6e11bd4-3d22-f8aa-c905-d06b16b1f5e2@siemens.com>
 <CAAqcGH=fFv=Fh43mbi19_A-c551adVV5OSJ-53HF09ev2u-E1g@mail.gmail.com> <87a8da66-c610-9b61-d0f8-b5bc7faf2dd7@siemens.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 28 Mar 2018 01:51:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATxW=5URYDu1Uj7BxwrE83HA0kb5GiqeEd3QMJ2RWQtnw@mail.gmail.com>
Message-ID: <CAK7LNATxW=5URYDu1Uj7BxwrE83HA0kb5GiqeEd3QMJ2RWQtnw@mail.gmail.com>
Subject: Re: [PATCH] builddeb: Fix header package regarding dtc source links
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Riku Voipio <riku.voipio@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-22 16:49 GMT+09:00 Jan Kiszka <jan.kiszka@siemens.com>:
> On 2018-03-22 15:45, Riku Voipio wrote:
>> On 21 March 2018 at 07:15, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> Since d5d332d3f7e8, a couple of links in scripts/dtc/include-prefixes
>>> are additionally required in order to build device trees with the header
>>> package.
>>
>> A bit odd usecase IMHO, but:
>
> The use case is not completely odd (I hope): Jailhouse hypervisor. We
> build it as out-of-tree module so far, and we both need dtc for the
> driver module as well as the guest device trees.
>


I do not think this use case is odd.

Some drivers embed DTB for overlay, for example,
https://patchwork.kernel.org/patch/10159055/

So, building external modules may require
ability to build DT as well.


Applied to linux-kbuild/fixes.  Thanks!


-- 
Best Regards
Masahiro Yamada
