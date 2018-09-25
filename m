Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C96C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1D92089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jxdYnne/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1D92089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeIZAGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:06:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36103 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIZAGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:06:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so4338279pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=s56OFK1djYzC05lrSnn6/0rMMF5lKJIW0wKOcRDOk9I=;
        b=jxdYnne/Rg9jpmaEWBUZtAQHHChY1m6mepOobRiYVW9FP4NNIU4mm8V69itye4CVpc
         4xsAXlnd40v49OB6l058RXs2cUs51cNvsQtdcYwPdqT0Obdslq71LmvFUs2L4ykUuIlI
         AlAZbtyNojbh0HR+a7qcYO2uwFVqV9HHsWsZoWHSKYCj8RXZxR1iR1MiIYqo+ZNtnQwJ
         cjXjE1Bt0nwr/jG3pl+FZJTAuLPDtDMbWBvDV5hyupLWbArdGj48wB7c/Fuan+zD8FRH
         6L8gC68XrdvIJPaRKyTLpwiueHgZIYyuVbTOE1gt9A0H12hQKKqb6OZE2ATD0KEA/5ed
         PSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=s56OFK1djYzC05lrSnn6/0rMMF5lKJIW0wKOcRDOk9I=;
        b=WZ2G87iqIHxcnEC8AesZbKD8PEb8B+7iIcJTfT8ZYSMdh6NQhfacErC6tdZQlusZSK
         V+j0gdL2zPrHOzr1+R9Qxs0iK+34Qdwy4h6O3r8Wz9kyybHRTS7k6WjPLmdQ88mjMexr
         UO9Rb8IKtpLGc5QQSk/JySnlKNCSEnGRqacRDafReGtA4owibVdvtljRIZX6C8clph4U
         qNqpMZiILgiFnB0IOxajUi0wSHz11AyDi8LRJ0KhkahOxAzz3qJ17qXR9u84LgcahiLs
         gcAbNWzsTHkC153aoZzpg9OlAh5GG+TXNt6WGLKhtYIwaTvdzcd7j36pjbXJ7O0AiIkf
         IdYQ==
X-Gm-Message-State: ABuFfoh4fMG0WZMhmEtTW+DRf6ktjUzw9B3Z3LXEhwjGVPSbjx+nh9o4
        fkt15p/tCZHUisiAmIx9BUSDc2ZbgaM=
X-Google-Smtp-Source: ACcGV62+ghjlXeE2MA7S8p9oMlJNg67J0X6t0vpyDKDlvChihAWYI9IDD3jGTTYqjpJkCiSUgEan6w==
X-Received: by 2002:a17:902:d881:: with SMTP id b1-v6mr2253098plz.191.1537898243741;
        Tue, 25 Sep 2018 10:57:23 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t128-v6sm7784311pfc.90.2018.09.25.10.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:57:22 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:57:22 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Sep 2018 10:56:09 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv/bitops: Remove smp_mb__{before,after}_clear_bit()
In-Reply-To: <20180925174906.GA4372@andrea>
CC:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     andrea.parri@amarulasolutions.com
Message-ID: <mhng-011ba62c-cdf5-4a9b-9d4e-b1a7909d5d43@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 10:49:06 PDT (-0700), andrea.parri@amarulasolutions.com wrote:
> On Tue, Sep 25, 2018 at 10:19:24AM -0700, Palmer Dabbelt wrote:
>> On Tue, 25 Sep 2018 05:12:24 PDT (-0700), andrea.parri@amarulasolutions.com wrote:
>> > The barriers are unused; remove their definition.
>> >
>> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
>> > Cc: Palmer Dabbelt <palmer@sifive.com>
>> > Cc: Albert Ou <aou@eecs.berkeley.edu>
>> > Cc: <linux-riscv@lists.infradead.org>
>> > ---
>> >  arch/riscv/include/asm/bitops.h | 5 -----
>> >  1 file changed, 5 deletions(-)
>> >
>> > diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
>> > index f30daf26f08f4..01db98dfd0435 100644
>> > --- a/arch/riscv/include/asm/bitops.h
>> > +++ b/arch/riscv/include/asm/bitops.h
>> > @@ -23,11 +23,6 @@
>> >  #include <asm/barrier.h>
>> >  #include <asm/bitsperlong.h>
>> >
>> > -#ifndef smp_mb__before_clear_bit
>> > -#define smp_mb__before_clear_bit()  smp_mb()
>> > -#define smp_mb__after_clear_bit()   smp_mb()
>> > -#endif /* smp_mb__before_clear_bit */
>> > -
>> >  #include <asm-generic/bitops/__ffs.h>
>> >  #include <asm-generic/bitops/ffz.h>
>> >  #include <asm-generic/bitops/fls.h>
>>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> Thank you.
>
>
>>
>> Do you want me to take this via the RISC-V tree?  I only ended up with patch
>> 1/2 in my inbox, and I probably shouldn't take both.
>
> I expected this to go via the RISC-V tree and 2/2 via the H8/300 tree,
> but really no preference from me as long as they get upstreamed. ;-)

Works for me.  I'll take this one.
