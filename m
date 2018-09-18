Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0EAECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7A620867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g48EEozK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7A620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeIRMxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:53:25 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46528 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeIRMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:53:24 -0400
Received: by mail-yb1-f194.google.com with SMTP id y20-v6so383326ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5RrqvCWFMFgx8mXMJteJ/KvOrMdCerf7N8tPVlMdox4=;
        b=g48EEozKhW41YE++EjzbpV8wUZkJEP6oXnFu1/ex/rrirS8SDYrr/QPdXdyXYcQdSX
         lUuqJrmL8LFHGl2aY21mAuWRjcnTblVJNv0iBjeHduwVZSOyylV6rY2DxjSUlvPoxvoz
         Hl41GrMIESr50zxv6YzyAisys6QO5xZnvqSLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5RrqvCWFMFgx8mXMJteJ/KvOrMdCerf7N8tPVlMdox4=;
        b=ejd8ykc2XT/bcC8cHV/A6pexE4RPvvz5NVDU+nKiHUNQIMnvSU5cfszhS4t/jFZ/hE
         CaVW1XVOLELvGhfTlFEQgKdZVWYJHEao9/SO5V8t2eUiW82QVJbaKpxDfigDpRJhJbsu
         rLy51FDLUpUKDsI8BZ6zGKVQlpfiT3uVzLsUtqMdZhjvWixWWc+0YqSbsfoheT4Ktk0C
         mn0t9EBDDnHgDacmZFwVvTmdmTwcRUgyggDM2g0KRwtkXnm9AQyArgKpUFuiFmSn8uG5
         MdrnDlkB/TVWqmB/fAwO4XTU+345ghXVdxCMKAvu51KJhqufQWm4EMt4lvbV/9hwQyN1
         3JMw==
X-Gm-Message-State: APzg51CGcWIGwi95QhMRc1o7Me6easDpoBdA4x1tQ1h6B/oUeDbvu9q0
        wdVJFUCOJq86HXNpimi8fURjSqYQgH8glpmCoGHWcw==
X-Google-Smtp-Source: ANB0Vdb9brawrSa4jka4sva9iBIRcM4Za3qkcNPW2wsKbCGyQ6v5+puyTVtgU1+lAaqE7p6I2DkgSbP3s9tymfpdLf4=
X-Received: by 2002:a25:8206:: with SMTP id q6-v6mr7069605ybk.166.1537255326936;
 Tue, 18 Sep 2018 00:22:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 00:22:06
 -0700 (PDT)
In-Reply-To: <mvmftzoq9d3.fsf@linux-m68k.org>
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-4-git-send-email-firoz.khan@linaro.org> <mvmftzoq9d3.fsf@linux-m68k.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 12:52:06 +0530
Message-ID: <CALxhOnjPL_eB+EdqqO=HVu5uT6d2atAtW_bfMbrEi-B93-XBKw@mail.gmail.com>
Subject: Re: [PATCH 3/4] m68k: Added system call table generation support
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On 9 August 2018 at 13:06, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Aug 09 2018, Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
>> +       $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>
> mkdir -p is a no-op if the directory exits.

Thanks for your reply :)
Sorry for the delayed response :(

Yes, mkdir -p is a no-op if the directory exits. As I mentioned in the
cover letter,
I leverage x86/arm/s390 architecture implementation to come up with a generic
solution. For this, I took x86 implementation as reference.

- Firoz

>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
