Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB2ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D6A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L56Gg3eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D6A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeIRMn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:43:56 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33348 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeIRMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:43:56 -0400
Received: by mail-yb1-f195.google.com with SMTP id y9-v6so400305ybh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CyG2R4kIO4rz4uiHVcpWB9aR+nzsKsX+i17WJnH7g3g=;
        b=L56Gg3eSAXIOu4UsDS7r2JKy8o0zv/iMGwdcbh2U88O/PSAVP1MsTc/nSrZFApVCRO
         QNoSzD/WY7il0ee/k+fFMeK0+r3FSj+6xfp/RHg7RfCIU08wteuF6cRTYpPZkfjKsmYH
         pbufx3JvcRkiAukkOO05RHqyMFbgWNaaTg/Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CyG2R4kIO4rz4uiHVcpWB9aR+nzsKsX+i17WJnH7g3g=;
        b=g2g8Z+XJUTC9PGMXpE1Zgl6Bpxpq3/gIDtafV2FwgbLlvxD2+Mk2IGPAOo4h8uaOl7
         RXJLZ7JoBxFKaeLSZxcJ6Jbi4tiEsT8BaFtDMX7wX0tBaBEeUSbHGI4GJz/WeBMWquoy
         b/t79qntA/RfnfOgMJ5bflRBVWEAgYKCKJ7/SYh/DDYLnzDOpuDOqExhItYgB+62LN/X
         6fTZ9xyuT5DLTjNpInMffZymG38eoBTO92JydWFi8Ub7H7n6XJ8Ed3KCA9ymOvW1B8Ox
         5TqsjPHw4lgiBoUF3O+kaoT7Q2CnM3rmdu0so7PuANKqUwSJeGZpJ/HjG+Iioruzo8Ta
         nlYw==
X-Gm-Message-State: APzg51Bfpv9n/sLPB9iQiep5Yl5tbtqkgl0fM3pHCsMPxcpvSqlgazwW
        JRt/6gXx60orDGJwOed28tARGbH48v4o/fp0PwTDzw==
X-Google-Smtp-Source: ANB0VdbLXpMHeXQsxfyYUH2uMnop/dqA5/AHTc898YOIbPCERO5mL3vGuHHpTzXg7B10nZxvoqaaDq1U5wEN35awHWw=
X-Received: by 2002:a25:cbc8:: with SMTP id b191-v6mr12224510ybg.223.1537254760378;
 Tue, 18 Sep 2018 00:12:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 00:12:39
 -0700 (PDT)
In-Reply-To: <27544098-abc8-db2e-5625-179d13fa63df@xilinx.com>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-4-git-send-email-firoz.khan@linaro.org> <27544098-abc8-db2e-5625-179d13fa63df@xilinx.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 12:42:39 +0530
Message-ID: <CALxhOngGqB2hY1MaEpTZvpgKTP9rwqbnMpgRKT9NQuZ4CXOcew@mail.gmail.com>
Subject: Re: [PATCH 3/3] microblaze: uapi header and system call table file generation
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 August 2018 at 12:42, Michal Simek <michal.simek@xilinx.com> wrote:
> On 9.8.2018 07:27, Firoz Khan wrote:
>> System call table generation script must be run to generate
>> unistd_32.h and syscall_table.h files. This patch will have
>> changes which will invokes the script.
>>
>> This patch will generate unistd_32.h and syscall_table.h
>> files by the syscall table generation script invoked by
>> arch/microblaze/Makefile and the generated files against the
>> removed files will be identical.
>>
>> The generated uapi header file will be included in
>> uapi/asm/unistd.h and generated system call table support
>> file will be included by microblaze/kernel/syscall.S file.
>>
>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>> ---
>>  arch/microblaze/Makefile                  |   3 +
>>  arch/microblaze/include/asm/Kbuild        |   2 +
>>  arch/microblaze/include/uapi/asm/Kbuild   |   2 +
>>  arch/microblaze/include/uapi/asm/unistd.h | 409 +-----------------------------
>>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
>>  5 files changed, 12 insertions(+), 810 deletions(-)
>>
>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
>> index d269dd4b..6121a2b 100644
>> --- a/arch/microblaze/Makefile
>> +++ b/arch/microblaze/Makefile
>> @@ -81,6 +81,9 @@ all: linux.bin
>>  archclean:
>>       $(Q)$(MAKE) $(clean)=$(boot)
>>
>> +archheaders:
>> +     $(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
>> +
>>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
>>       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>>
>> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
>> index fe6a6c6..99225ab 100644
>> --- a/arch/microblaze/include/asm/Kbuild
>> +++ b/arch/microblaze/include/asm/Kbuild
>> @@ -30,3 +30,5 @@ generic-y += trace_clock.h
>>  generic-y += vga.h
>>  generic-y += word-at-a-time.h
>>  generic-y += xor.h
>> +
>> +generated-y += syscall_table.h
>> \ No newline at end of file
>
> This doesn't look right.

You mean I have to keep something like this?
 generic-y += xor.h
-
-generated-y += syscall_table.h
\ No newline at end of file
+generic-y += syscall_table.h
\ No newline at end of file

>
>
>> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
>> index 2c6a6bf..8fe26a3 100644
>> --- a/arch/microblaze/include/uapi/asm/Kbuild
>> +++ b/arch/microblaze/include/uapi/asm/Kbuild
>> @@ -28,3 +28,5 @@ generic-y += termbits.h
>>  generic-y += termios.h
>>  generic-y += types.h
>>  generic-y += ucontext.h
>> +
>> +generated-y += unistd_32.h
>> \ No newline at end of file
>
> ditto.

and like this?

 generic-y += ucontext.h
-
-generated-y += unistd_32.h
\ No newline at end of file
+generic-y += unistd_32.h
\ No newline at end of file

- Firoz
