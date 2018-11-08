Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3382CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02A420825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fBqeo1Tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02A420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeKICdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:33:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44694 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKICds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:33:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so9789429plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IcXWo4Ru8Po2n0qcDZDRzwCHw21xpgGQ6HLWe7ZXU8s=;
        b=fBqeo1TwPBxPRMe8MZ9QnKq8HPLbCBTkJpFNe1GfG+tgLdHj3JuEq1QT2DAg0eGG5z
         EY1Tz2NhKboqZcX8BoyXbx5hepSR3i3+MsSwh/sghjxos5uW3qhhzwMSK5dgOxZdgcWG
         izTxv/YqRsTznULOv/IK2ESe1f26sIIzmBOZ9KmXL4U1r19IJrGueH64n/IM9Ug/7Q15
         AwUAf9dhxdgvEjp+MUvZHPxs9zwyeSwVjjZRpOsCJLrmLt8OFi/aQPAmmgNbKA6KPy2n
         jACAnrKd5KSaj2pWCQDZ0XPw6O8Hl9Mhi2ruNjMS8cy3F5Y6VeLyeTe53iE4HwIISHDd
         7M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IcXWo4Ru8Po2n0qcDZDRzwCHw21xpgGQ6HLWe7ZXU8s=;
        b=YFknaKChAl5fh7sL3Mztyp+pKsKu/0/StWgioFWg27JY+gcQCBaMRqiTwZTXxgfuLS
         mVzw0KvGMQX07oN2RdNXam5y90kPl1o49Hiit+x0HdosVWK7Zx37/kXQHyvjsueRJDVj
         iF5oS63gLva2rqFpPP4491Ot2Vj1OE4hZVrLqtcBST88/X/ciTIYD6iGlfL9ol+/o/Je
         QNPW5AlGBAzse7LZekIJSkDw23Q80l/8SvI3ALut45ci8PMgQHT7YoMBLeUNm3aeAmOS
         WLHd1UeGqSbV33Hjwxw3WokESHWuZDS4mGERq45HxqJ0H1ZxNRucQ2I5NtyqkbwZW2WV
         uvCg==
X-Gm-Message-State: AGRZ1gJ7e+tMjXSc+AlQEnZjAQGJmcaiGUkMoUSPWOfvaaAtGIz/cE6+
        YT0j7HlS0Ae5sEMrcDFTCPBu3g==
X-Google-Smtp-Source: AJdET5fcm7ZpwDm1e19hsStaS1X/NjR3IKQ3ZemaROE6NwBitEIdbzdpV79XvGF9UZ42z0W91jwncA==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4-v6mr5155730plv.121.1541696245237;
        Thu, 08 Nov 2018 08:57:25 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l23-v6sm1691597pfj.179.2018.11.08.08.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:57:24 -0800 (PST)
Date:   Thu, 08 Nov 2018 08:57:24 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 08:31:33 PST (-0800)
Subject:     Re: [PATCH] riscv: add asm/unistd.h UAPI header
In-Reply-To: <CAEn-LTqCT-u0_QNdOSf3bLKYa5S2vz4T0X5yKmnS1AE4pDYOkg@mail.gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcin.juszkiewicz@linaro.org, linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-dc92b5a0-ee9f-4e63-a99e-34e77058c77a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2018 02:38:22 PST (-0800), david.abdurachmanov@gmail.com wrote:
> On Thu, Nov 8, 2018 at 3:10 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 07 Nov 2018 13:09:39 PST (-0800), Arnd Bergmann wrote:
>> > On Wed, Nov 7, 2018 at 7:30 PM David Abdurachmanov
>> > <david.abdurachmanov@gmail.com> wrote:
>> >> On Wed, Nov 7, 2018 at 1:08 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>> >> > On Mon, 05 Nov 2018 12:56:15 PST (-0800), Arnd Bergmann wrote:
>> >
>> >> > The target is still the next glibc release (Feb 1st) for a stable RV32I ABI.
>> >> > That's progressing well, with one last blocking issue related to some of our
>> >> > floating-point emulation routines before we can submit the port.  This should
>> >> > give us ample time to line up the ABIs correctly so everything works.
>> >> >
>> >> > So I think the correct answer here is to drop __ARCH_WANT_STAT64 from RISC-V.
>> >> >
>> >>
>> >> Then if you agree I could do and send v2:
>> >>
>> >> +#ifdef __LP64__
>> >> +#define __ARCH_WANT_NEW_STAT
>> >> +#endif /* __LP64__ */
>> >
>> > Looks good to me.
>>
>> This is a bit pedantic, but I'm not sure what the right answer is here:
>> "-march=rv64gc -mabi=ilp32d" will not define __LP64__, but will define
>> "__riscv_xlen == 64".  I actually don't know enough about how an rv64gc/ilp32d
>> ABI would work to answer this: would we have "long long" all over our syscalls?
>>
>> Probably not worth worrying about for now, as we'll have to go audit all of
>> these if we ever end up with an ilp32 ABI.  So just go for it and we'll throw
>> this on the pile to deal with later :)
>
> GCC will not allow "-march=rv64gc -mabi=ilp32d":
>
>     cc1: error: ABI requires -march=rv32
>
> I see that arch/riscv/include/uapi/asm/elf.h already use __riscv_xlen so to be
> consistent I will use it too (but I like __LP64__ more as it is well
> known macro).
>
> Looking at other UAPI headers I see that include/uapi/linux/rseq.h is using
> __LP64__ macro. This header is installed on riscv.

Yes, it's not currently supported and there are no concrete plans to support 
it.  Like Arnd mentioned, it's a big headache.  It was really more of a 
question about how this might work than a concrete review, I'm happy with the 
patch as it was suggested.
