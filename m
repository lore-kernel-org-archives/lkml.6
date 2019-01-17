Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16096C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3407205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfAQNjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:39:17 -0500
Received: from ozlabs.org ([203.11.71.1]:43047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfAQNjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:39:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gQCj3VYrz9sBn;
        Fri, 18 Jan 2019 00:39:13 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module build
In-Reply-To: <CAK7LNAQKuW8f7BgX8q-Eqa480o6Ch_mZsHyY52h96kifnYepHg@mail.gmail.com>
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNAQKuW8f7BgX8q-Eqa480o6Ch_mZsHyY52h96kifnYepHg@mail.gmail.com>
Date:   Fri, 18 Jan 2019 00:39:13 +1100
Message-ID: <87imyn4d4u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> On Tue, Jan 15, 2019 at 5:07 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
>> caused kernel panic on PowerPC if an external module is used with
>> CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
>> for the external module build.
>>
>> Commit e07db28eea38 ("kbuild: fix single target build for external
>> module") turned it into a build error because the 'prepare' target is
>> now executed but the 'prepare0' target is missing for the external
>> module build.
>>
>> External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
>> also broken in the same way.
>>
>> Move 'PHONY += prepare0' to the common place. Make is fine with missing
>> rule for phony targets.
>>
>> I minimize the change so it can be easily backported to 4.20.x
>>
>> To fix v4.20 for external modules of PowerPC, please backport
>> e07db28eea38 ("kbuild: fix single target build for external module"),
>> and then this commit.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
>> Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
>> Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
>> Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
>> Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
>> Cc: linux-stable <stable@vger.kernel.org> # v4.20
>> Reported-by: Samuel Holland <samuel@sholland.org>
>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>
> Applied to linux-kbuild/fixes.

Thanks.

cheers
