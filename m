Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4FB7AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01065208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpjUwJug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01065208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeFLST7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:19:59 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43803 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbeFLST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:19:58 -0400
Received: by mail-vk0-f66.google.com with SMTP id d74-v6so14692494vke.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=si6MOoP6RDPuWCv2+Q6EgDn/kXN6Bcwd2/cgCDa/2Ng=;
        b=hpjUwJugAH1JQFG95b/Jzyv7wLFeVZDE9bgqqLMGgzG0EHqhJA8vgQfQVR1aLPkN+p
         XdpvGNLGcAKHJ314eOF7MpfSfcDrl9h7DjwYUs1W2KKSk6ee6jkOZSiiYleJyF3hkMhc
         0M8lpmTWU/JN5YAIms/BKsnx58M58+br2ImXtG66HIoZex37L7Zjef4GNi5znD73Hrzy
         imu6BzW+VrfztuO0t9ugJ5fkKQs/Lm+D++u0EXAvugElG+mIQLYUDhMxuvHBMqHZBf+6
         ST357hEboVyt7DpxciYC7xcnK9UaJbcODVtbjFHq643PBV1S16gUh+p0wn3Y6+tMrKd2
         NT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=si6MOoP6RDPuWCv2+Q6EgDn/kXN6Bcwd2/cgCDa/2Ng=;
        b=iN2s8yl//ce8ETi3x9Ad0VBwGFDEgS/7kLVjk3QZdaj9+nhzpnHhUglYl1tgdhmRqP
         rqNErE9bvRx1XKz5P9E0t/jXGrtDiCpLtLkSQhIyG1NAK+zvb/PaXy8nYny6UQARUrBD
         ciVnufSvmkRaKkZhTqeA2hyLBXQNvpxFoobmfL9PlVKvSxjNJmNUTpTBo+Y1AQ1dPRXQ
         bx9whE9yNM3cc+2W+usfqQOmHtLdNcVkFLky/yyzeEA9qx5VzlK/nAx5DmjdkSnmRjha
         HtLZf1t0JZTYJ0YZAlxPiVB+uQsv+39/C8RUgeSx8jPaBWhkhvKW1YHoA77F0WZRXAFW
         rETw==
X-Gm-Message-State: APt69E0w8XdF+tbAtpff5iPihK/rUaDXU9Y1e9QCIMs6Lj4+qlIA9y9w
        tQMHk7sR2pPgsFLxdPQN9ma3KzQJFvA0tP+ReMQ=
X-Google-Smtp-Source: ADUXVKK6n5k/ew/rEU605A1cV8eeQeOGqX16Pw7B9rYRCItW34lzlz89EdZU2F+dtU1yLrE33m/l0eLoHDtwtidHtz0=
X-Received: by 2002:a1f:5244:: with SMTP id g65-v6mr1031230vkb.28.1528827597988;
 Tue, 12 Jun 2018 11:19:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9f:3c04:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 11:19:57
 -0700 (PDT)
In-Reply-To: <mhng-92398134-2db9-4a35-b432-0ab444418e1b@palmer-si-x1c4>
References: <20180612030006.h7a4mag76aqqifod@ltop.local> <mhng-92398134-2db9-4a35-b432-0ab444418e1b@palmer-si-x1c4>
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Tue, 12 Jun 2018 20:19:57 +0200
Message-ID: <CAMHZB6E3Jcvni=nsxvOB-+g8sDGCvEV2G2q2+3XrJJy7f__-eg@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Albert Ou <albert@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:12 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Mon, 11 Jun 2018 20:00:08 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
>> On Mon, Jun 11, 2018 at 12:01:37PM -0700, Palmer Dabbelt wrote:
>>>
>>> OK, I'll try and figure out what's going on.  We've had a handful of
>>> headaches trying to get things like '.align 2; .align 2' to actually
>>> produce
>>> no NOPs for the second alignment directive, which is surprisingly
>>> complicated due to the aggressive linker relaxation we do.
>>
>>
>> OK. I imagine indeed but note that no linker is involved here so,
>> if the problem is still present, it must already be in the assembler.
>
>
> Ah, OK -- in that case then it's just not a bug.  In RISC-V land we handle
> alignment as part of relaxation in the linker, so if you're looking at the
> output of the assembler then you'll always see a bunch of NOPs for every
> alignment directive.  If you 'objdump -dr' you should be able to see the
> relocations that get emitted, there should be a R_RISCV_ALIGN that points to
> the run of NOPs.

Ah OK. Indeed I see the R_RISCV_ALIGN.
Thanks for the explanation.

-- Luc
