Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B01C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2565920859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hs0Q3crx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfBTXKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:10:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39723 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBTXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:10:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so2272056pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CEdCyOWbKcLtC5JegEnnCbD6vAdSZWTAOlx9ez5RsEo=;
        b=hs0Q3crx85jAuaboXoAfBCXLlaZ2XgRXSvU7zPEMzwLmjRYTBW/JlOqLERYs0lvntZ
         zJHiv5hTiOK5Tp6N4+rB8OrL0B56riRmjdbCZFkwWIj6PYyqP7i4nFQcCnmt7Vr5gFcm
         wqxl6xzcvXPHQKaYiIf8e6GEYkXQnMhQQPtLr+xX/bBVy+F0hEzSHrsOS3zFjvzvldzc
         +NyexT2IkImQRa9Ccr3bQEQGBN8ZmMkmJ6OorjtzdO5S1DAA7f0GVdG/JJ1a5DQs5P0H
         HVGjZV9ZqTnLexJzt7mc0hHGZq6dxD8JwBp7dezbTQdPsrTc0naUTZ75tFtQswJI0sLY
         c4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CEdCyOWbKcLtC5JegEnnCbD6vAdSZWTAOlx9ez5RsEo=;
        b=KIbkg+p7pqwOGPySHgMQy0hjJb936zjW7jYsLy0PvHXGOu99uvUCvLxKloqC8HIc0N
         sq5w2VTmzBiB3HwCu2H/R3eP37++Kf1sb3a0eizQXKkZb6aVNiRJA/GihRcE9kGgvrBO
         K2zD1vTCvg8YkXvxmhZYjU4Rn/VXR7yXADVNMvUQOLEbpwOu0o+Lf6dhKfEVtKzQgCmN
         /yoDR82LGlk5qmnxOpVBcnJl/kpWPmiD3Z1WxbgRn8meCcbEzYUDO2CO0FsPT9l4I+FW
         UY6pxfQ+Mg+iIWqEbdxzYQeP9EYyTfzJzo74YiT1zOu4hyBqxfZYPDu5NrKcc7ZdAsYm
         8mDQ==
X-Gm-Message-State: AHQUAuY7SiXH4c7uZboYe//MiiICaL2cLF/xmCXHDCkK3AwhjgIV1DOb
        PyxWrhPdkuGqXL4UcvdnKPqXSQ==
X-Google-Smtp-Source: AHgI3IYUuhb0X1Nn4sk1iCXf/q3fN0Di5NSbh9/zQS1q5a+hsa8jzyTW1bvxMSrPazQnTB/bNDVAow==
X-Received: by 2002:a63:5362:: with SMTP id t34mr34738216pgl.81.1550704245143;
        Wed, 20 Feb 2019 15:10:45 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w128sm27919858pfw.79.2019.02.20.15.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 15:10:44 -0800 (PST)
Date:   Wed, 20 Feb 2019 15:10:44 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 15:10:06 PST (-0800)
Subject:     Re: [PATCH 4/6] lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
In-Reply-To: <20190220142048.GA20929@yury-thinkpad>
CC:     andriy.shevchenko@linux.intel.com, yury.norov@gmail.com,
        akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        dmitry.torokhov@gmail.com, keescook@chromium.org,
        willy@infradead.org, mpe@ellerman.id.au, linux@rasmusvillemoes.dk,
        penguin-kernel@I-love.SAKURA.ne.jp, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     yury.norov@gmail.com
Message-ID: <mhng-e872dce6-2abe-467b-b1c1-82a59d4c93e2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 06:20:48 PST (-0800), yury.norov@gmail.com wrote:
> On Wed, Feb 20, 2019 at 03:52:36PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 20, 2019 at 03:51:01PM +0200, Andy Shevchenko wrote:
>> > On Wed, Feb 20, 2019 at 11:37:03AM +0300, Yury Norov wrote:
>> > > test_bitmap_parselist currently uses get_cycles which is not
>> > > implemented on some platforms, so use ktime_get() instead.
>> >
>> > This sounds like a fix that should go first in the series.
>>
>> Ah, okay, it's already first for test module.
>> Perhaps Fixes tag and actually one or more examples of such architectures?
>
> Hi Andy, thanks for your time on it.
>
> Only arm, arm64, openrisc, riscv and sparc64 #define get_cycles.
> So IIUC, others take stub from include/asm-generic/timex.h.

Should we (RISC-V) be doing something else?  It seems odd to be in such a 
minority here, but we do have a ISA-mandated timer so the get_cycles() 
implementation is super easy.

> sparc32, xtensa, m68k, um, and in some cases x86, mips and nios2
> provide zero-stubs explicitly.
>
> Yury
>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
