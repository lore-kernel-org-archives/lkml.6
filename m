Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EEDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95AA2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsSUCizI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95AA2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeJBMaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:30:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55508 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJBMaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:30:16 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so1931703itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 22:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+nDHKrmNSHhPYBaGOTxPFgrA9l9EnEJUxs1jCR0TQ+o=;
        b=ZsSUCizIQ6wejPCkBsN3IAWzpfltvEVzJB9VyNeMffaw2RIeeRns/y/vNTautgy5em
         PlUnvAkD8qSFB0faKPk+vXn8t9dzpxJlQz0Ngjg8S7RDZZNJn4G6LV8PT0PqODR5XFzH
         dOSj5MoRW5uRhzZuIiTW5EuiikXkshVGAWQVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+nDHKrmNSHhPYBaGOTxPFgrA9l9EnEJUxs1jCR0TQ+o=;
        b=rbOorr+fvtE44p0UVwbzFTMj/0SxcZqrRN+xOP6bzKrhdfuOoB/MimK4Kg4AiJ4Ofm
         a75s1ue/5tWSfWA8TUkBAAy1ApM3CfA/Jz5n3cypv6wdr/7MwQ/aIsAGrmGmXfxLPhce
         T7YYl2Hh7lfCWi4qpUOZrvUumQ1ENeIQ2NLrS3KUTqieuVfB4jasCAjy+j+2OGN1lbkq
         KWQadNBlqtPYfPZfiQbN3MEBXTl4m775PmrkU9Ls27iNGK3Rp68eeFoRJiSgHy8MwOfK
         Mim4beadJYu4zQAttADeaeq0ufycHl5SjTljAnlAtWSRFl6Et0wrsQdlzarRUDt39HhD
         p5Fg==
X-Gm-Message-State: ABuFfojZZtp9N6GF8Ib9HCxfYGcpncO3DFuixw7ginh0V65pmkVp0sHQ
        HNvRkBKhkuwJW7p6qZ7RkBhZkWGOb+NqqrU6gqGolQ==
X-Google-Smtp-Source: ACcGV62yfdgCVmnaJEHmtdwZ75UKtiST2+VeaelDyasEBRkF3jB/fOfjM9nJ3XWpL/iK8CF5+eQnWdj+Sxg4VrSwRv4=
X-Received: by 2002:a24:e48e:: with SMTP id o136-v6mr859331ith.58.1538459329210;
 Mon, 01 Oct 2018 22:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 22:48:48 -0700 (PDT)
In-Reply-To: <20181001202538.GB4958@osiris>
References: <20180930164950.3841-1-ard.biesheuvel@linaro.org> <20181001202538.GB4958@osiris>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 07:48:48 +0200
Message-ID: <CAKv+Gu-T6YLb3gAhNtBmY1SbNovuzKFxJ1A7R0R=CygndvzGYQ@mail.gmail.com>
Subject: Re: [PATCH] s390: vmlinux.lds: move JUMP_TABLE_DATA into output section
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 October 2018 at 22:25, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> On Sun, Sep 30, 2018 at 06:49:50PM +0200, Ard Biesheuvel wrote:
>> Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
>> region") moved the __jump_table input section into the __ro_after_init
>> output section, but inadvertently put the macro in the wrong place in
>> the s390 linker script. Let's fix that.
>>
>> Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Jessica Yu <jeyu@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/s390/kernel/vmlinux.lds.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>
> I don't think this is very obvious, but this fixes current build breakage
> in linux-next and I assume Thomas should pick this up.
>

Indeed.

Thomas, Ingo,

Could you please take this fix for the jump lable changes queued in
-next, and the other one I sent out yesterday [0], through core/core
in tip.git as before?

Thanks,
Ard.

[0] https://lore.kernel.org/lkml/20181001081324.11553-1-ard.biesheuvel@linaro.org/
