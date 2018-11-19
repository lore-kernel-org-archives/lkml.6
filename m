Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB839213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qy1q0UBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB839213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390410AbeKTEBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:01:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45189 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389785AbeKTEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:01:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so10310275plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=H5owF+wMf79EVakKmOx7q+3qQUQfzmV0sdtOMq5KHco=;
        b=Qy1q0UBgrto8oC1sUXTq1sEixAFaT3JVdkkLf3wT5ngnkF0/nZEz0Stx0phskKD135
         vrHRJIyyc1TDeE+4WwFzTFCdYCz0eNjlT6S3ZLsHinu6LPPpJLRAT/Naz/uk0GA+qLLW
         EM/lsXwHGrWw+JcmREivEP5OylK7SVULEz+b/fmEqPLK+/u8iyVrocrTL4NOQZrTG+vu
         LuWwsdkpITdY4qO29SGyuFmpjdGQPJn98oVyhA6xcxufU4URMerimvGsobISOJVmQrMf
         P8Xmy94k0VjpAMBowKAFawpFq+ELUivOTu4CVeNKY0w85bmrBwvxZZcWWEo37QpbpFB/
         0SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=H5owF+wMf79EVakKmOx7q+3qQUQfzmV0sdtOMq5KHco=;
        b=T/tWSxEbw+nREn6H1UC0UFxMpej4qJ7LXGDnAbj65DG0Dj0lucphjAQ/fSA5JQQ9cX
         6qaXRzqV1uTxHbi9X4ALZIoblPuVJvyJNoV7sP3Khuq6iW5+T/Ri5Lf+I0rpSOKDZGdG
         cvTCRZL44Nift4GSVnFdmzOkcZSsu/FMpQRIwQUI6t9jGwHp/6idE5s5yCgAGA12sDR+
         fVC/oPFW0Gf+pjqCS7A+q4RQM/DmSamJa/uCFX9xKr+jwGjvzYvIR+Wh3OERVIyz5oxN
         JhhIQU9OcyhG8k0pOheLWTt9P5OaPifoYBuZ3NiXqCNPPwt9fF9+fu2dETN3ge1o0MfS
         qBFw==
X-Gm-Message-State: AA+aEWbRyC5bxBhdH0yi8GQxKo0O9LIWiWwiu2earGoFMALpvONIzCPd
        q3JrROkoYP/6nbrbc5a2hWf60lan60g=
X-Google-Smtp-Source: AFSGD/V4iNdu82z3NfQh85ggl1zqJFIrcRFH1/n4wLwvtkzT/WBY0iO7DPwAenx5lYq9ny5WQRy3lA==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr6890679plt.144.1542648993894;
        Mon, 19 Nov 2018 09:36:33 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d8-v6sm48404462pfj.106.2018.11.19.09.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:36:32 -0800 (PST)
Date:   Mon, 19 Nov 2018 09:36:32 -0800 (PST)
X-Google-Original-Date: Mon, 19 Nov 2018 09:18:07 PST (-0800)
Subject:     Re: [PATCH] riscv: fix warning in arch/riscv/include/asm/module.h
In-Reply-To: <CAOesGMjzOkPNv7v_uMMsCw=20NuebPvkLBS5b5eaS9Z6=p1qKg@mail.gmail.com>
CC:     david.abdurachmanov@gmail.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Olof Johansson <olof@lixom.net>
Message-ID: <mhng-37d3ed08-3bb9-420e-bb62-3bd555d141dd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 19:09:36 PST (-0800), Olof Johansson wrote:
> On Thu, Nov 8, 2018 at 11:32 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Thu, 08 Nov 2018 11:07:00 PST (-0800), david.abdurachmanov@gmail.com wrote:
>> > Fixes warning: 'struct module' declared inside parameter list will not be
>> > visible outside of this definition or declaration
>> >
>> > Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
>> > ---
>> >  arch/riscv/include/asm/module.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
>> > index 349df33808c4..cd2af4b013e3 100644
>> > --- a/arch/riscv/include/asm/module.h
>> > +++ b/arch/riscv/include/asm/module.h
>> > @@ -8,6 +8,7 @@
>> >
>> >  #define MODULE_ARCH_VERMAGIC    "riscv"
>> >
>> > +struct module;
>> >  u64 module_emit_got_entry(struct module *mod, u64 val);
>> >  u64 module_emit_plt_entry(struct module *mod, u64 val);
>>
>> Works for me.  Looks like arm64 might have exactly the same issue.  I'll roll
>> it up into the next RC.
>
> Looks like it's still here in -next. So, patch:
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> (and it'd be great to pickup together with the 32-bit build fix).

Sorry, I must have managed to screw something up here and drop both of these 
from my fixes list.  Not sure how they managed to make it into -next without 
being in the list, but it's been on my TODO list to fix up my workflow scripts 
for a while anyway...
