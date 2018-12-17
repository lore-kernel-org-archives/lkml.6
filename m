Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8278CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527A62145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbeLQNAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:00:17 -0500
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:41466 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeLQNAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:00:16 -0500
Received: from av1.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id wBHCxL05031742;
        Mon, 17 Dec 2018 12:59:23 GMT
X-AuditID: 8b5b9d4d-8f5ff7000000235c-fc-5c179da8b528
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id 23.FB.09052.8AD971C5; Mon, 17 Dec 2018 14:59:21 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wBHCxJsv024045;
        Mon, 17 Dec 2018 14:59:19 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 17 Dec 2018 14:59:19 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Make BSS section as the last section in
 vmlinux.lds.S
Organization: FORTH
In-Reply-To: <CAAhSdy1danjgviJ2WGGEANQXFkzZzXUdCj+04dZ4eLjcVOt14A@mail.gmail.com>
References: <20181126060802.19314-1-anup@brainfault.org>
 <CAAhSdy1danjgviJ2WGGEANQXFkzZzXUdCj+04dZ4eLjcVOt14A@mail.gmail.com>
Message-ID: <587bbe80f25203e6122dfcc0eadba50b@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsXSHc2orLtyrniMQdsiVouWD+9YLbb+nsVu
        sWjFdxaL0xMWMVlc3jWHzWLb5xY2i80TFrA6sHtM/X2GxeNwxxd2j80rtDw2L6n3uNR8nd3j
        8yY5j/YD3UwB7FFcNimpOZllqUX6dglcGXc3nGMt6Bes2PtsIUsDYy9vFyMnh4SAiURbewNr
        FyMXh5DAEUaJ+XM3s0M4hxgl5syaxAhRZSoxe28nmM0rIChxcuYTFhCbWcBCYuqV/YwQtrxE
        89bZzCA2i4CqRP+8lWwgNpuApsT8SwfB6kUEVCSePz0HVT+VSaL1gm0XIweHsECIxMM1YGF+
        AWGJT3cvsoKEOQUCJe5u1QQJCwnUS/ze8Y0V4gIXiamLHkNdpiLx4fcDdhBbVEBZ4sWJ6awT
        GIVmITl0FpJDZyE5dAEj8ypGgcQyY73M5GK9tPyikgy99KJNjODImOu7g/HcAvtDjAIcjEo8
        vJr7xWKEWBPLiitzgcHCwawkwttrCRTiTUmsrEotyo8vKs1JLT7EKM3BoiTOe/hFeJCQQHpi
        SWp2ampBahFMlomDU6qBMZ6Jz05C29xv8xqvZ//0rfk/e/RNn5KT9GrGZ/GPF87cFs6TiBS7
        ZRZa9NDkUMW5xd1TUs5Lsz0tzNQROVX75eXhJnsry8Wpv00jlU8eEDoWuiirl4PLeVLRsqnL
        nz2YGdkvtOnBudiPu45MPTLxvFzX/qUXOnfFtKko85U7b67bZ7/Rt1PjoxJLcUaioRZzUXEi
        AGJkZLCIAgAA
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Mon, 17 Dec 2018 12:59:23 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av1.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Mon, 17 Dec 2018 12:59:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2018-12-17 11:36, Anup Patel έγραψε:
> On Mon, Nov 26, 2018 at 11:42 AM Anup Patel <anup@brainfault.org> 
> wrote:
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
>> diff --git a/arch/riscv/kernel/vmlinux.lds.S 
>> b/arch/riscv/kernel/vmlinux.lds.S
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
> 
> Regards,
> Anup
> 

Just a note on coding style, you should be using a macro instead of 0x10 
so that those who read the code can understand what it is and also a few 
comments since searching through the commit logs to understand why you 
used it isn't optimal.

Regards,
Nick

