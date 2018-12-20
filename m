Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A36C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA4C218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B7v/zhuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeLTUkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:40:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39348 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLTUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:40:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so3346423qtl.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6JsmajvHgjh5zKiNZPfPF+qgRMpvJ7baDvQkLUr1SRk=;
        b=B7v/zhuK/o4Zjwe2RNO/FwJugvOj7+uuUa6Hpb0Q43PxVwVT5+QfyUKcKc+pn1cS3A
         MCa84yX/v7dUTJgp90EQQvNZJw7+lvlc0+ElvGi0Xi+ncWpWcSTcFnaeTI7z1keU8p9b
         AQqWbJApqrvM2zYddZ1PuLtxxX9bHX6QajXHzWRxFhBLUPwwanCWme6x+ID+C8WRIopQ
         m+JVF8RxBLY9DKLJ0RfCpiMmOEKGCzVdEBFn9vac3HSnuaCS1U/PKazsUh2l+EqJd7LV
         oI0XOT/xhpEwQFLHCkehF98rnPjzqDLf7IUlFFqfSnJlGkxM0Az6o0sNgyBW2CzqCEZ3
         JStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6JsmajvHgjh5zKiNZPfPF+qgRMpvJ7baDvQkLUr1SRk=;
        b=TRkQeLbJ5ce8SUtkwlNlMlMUQMhHo+KKyVNWgMiWuC+MyICTpacNWRgpXArXNuMb1Z
         9rxfWSHr6HYH5FWRbHjS2T4BGgGKneqoamf33WfYHzHByIGQLLKeJu2RQ9/zEdwmgtiW
         UWgWRGUQ1N0MHetznb9AD6SzTilB+waGWlxbYQU8U+p9QrcD7VJCdcX95L2dO9Ete+L8
         a4Ky97iT1u3CQUx9GZue1dCzT/eoI88+eATZP5zG3mQrMzv80UQaAW+2WrJHR88IRe1f
         K4QJ799INISNr6MvUySX4bV+t2Lr2kxOKfK7oqygQO+2j0GDxGmlUH+NZyVl9Tsvsmdo
         n3Cg==
X-Gm-Message-State: AA+aEWaqMCsW8klMgsfPcu00eK60AZnJ6c1NbC2vRvLPTRliIu35Rq4n
        jxGJF7+ZPhx2rtN0uhbUB/22XJhyt7c=
X-Google-Smtp-Source: AFSGD/W2JH67Zmi7abUFE/wkZ6GQgPzv2VuNw3FoUKOIPfOWCKBaPozFhlwGQTeHz/Rh4Xw1VjrjsA==
X-Received: by 2002:a0c:b0db:: with SMTP id p27mr6514652qvc.73.1545338434545;
        Thu, 20 Dec 2018 12:40:34 -0800 (PST)
Received: from localhost ([2601:182:c980:96c:8dd:4488:90b1:59d1])
        by smtp.gmail.com with ESMTPSA id r47sm4479171qtc.77.2018.12.20.12.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 12:40:33 -0800 (PST)
Date:   Thu, 20 Dec 2018 12:40:33 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:39:09 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Make BSS section as the last section in vmlinux.lds.S
In-Reply-To: <CAAhSdy1danjgviJ2WGGEANQXFkzZzXUdCj+04dZ4eLjcVOt14A@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-d6686972-69e1-4355-8b30-e03893e24db6@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 01:36:45 PST (-0800), anup@brainfault.org wrote:
> On Mon, Nov 26, 2018 at 11:42 AM Anup Patel <anup@brainfault.org> wrote:
>>
>> The objcopy only emits loadable sections when creating flat kernel
>> Image. To have minimal possible size of flat kernel Image, we should
>> have all non-loadable sections after loadable sections.
>>
>> Currently, execption table section (loadable section) is after BSS
>> section (non-loadable section) in the RISC-V vmlinux.lds.S. This
>> is not optimal for having minimal flat kernel Image size hence this
>> patch makes BSS section as the last section in RISC-V vmlinux.lds.S.
>>
>> In addition, we make BSS section aligned to 16byte instead of PAGE
>> aligned which further reduces flat kernel Image size by few KBs.
>>
>> The flat kernel Image size of Linux-4.20-rc4 using GCC 8.2.0 is
>> 8819980 bytes with current RISC-V vmlinux.lds.S and it reduces to
>> 7991740 bytes with this patch applied using GCC 8.2.0. In summary,
>> this patch reduces Linux-4.20-rc4 flat kernel Image size by 809 KB.
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>> ---
>>  arch/riscv/kernel/vmlinux.lds.S | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>> index 65df1dfdc303..cc99eed44931 100644
>> --- a/arch/riscv/kernel/vmlinux.lds.S
>> +++ b/arch/riscv/kernel/vmlinux.lds.S
>> @@ -74,8 +74,6 @@ SECTIONS
>>                 *(.sbss*)
>>         }
>>
>> -       BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
>> -
>>         EXCEPTION_TABLE(0x10)
>>         NOTES
>>
>> @@ -83,6 +81,8 @@ SECTIONS
>>                 *(.rel.dyn*)
>>         }
>>
>> +       BSS_SECTION(0x10, 0x10, 0x10)
>> +
>>         _end = .;
>>
>>         STABS_DEBUG
>> --
>> 2.17.1
>>
>
> Hi All,
>
> Any comment on this patch?

Sorry, I haven't had a chance to look at it yet.  Aside from the macro issue 
mentioned by Nick it seems OK.
