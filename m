Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbeE2Mjd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:39:33 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39652 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933447AbeE2Mj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:39:27 -0400
X-Google-Smtp-Source: ADUXVKJITbWnSpwlkSdrukhuE4YWOJJc4HLW5wASurfKk3D7k7HhbPdDk9Vv4t0viDPJqpE0OH0jZggvHfAwXbygHQk=
MIME-Version: 1.0
In-Reply-To: <20180529222327.29d16eb6@canb.auug.org.au>
References: <20180529210257.26da8de7@canb.auug.org.au> <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
 <20180529222327.29d16eb6@canb.auug.org.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 29 May 2018 14:39:06 +0200
X-Google-Sender-Auth: eFGBR2LEosHAOe8QSWee9Ft9YQk
Message-ID: <CA+7wUsy8V9zyH+-nU_X+tpXnN3VYGctErquqSX3g7kQGZsvupQ@mail.gmail.com>
Subject: Re: linux-next: boot messages from today's linux-next
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On Tue, May 29, 2018 at 2:23 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Mathieu,
>
> On Tue, 29 May 2018 13:56:48 +0200 Mathieu Malaterre <malat@debian.org> wrote:
>>
>> On Tue, May 29, 2018 at 1:02 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> > Hi all,
>> >
>> > My qemu boots of today's powerpc linux-next kernel produced the following
>> > boot message differences:
>> >
>> > -Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
>> > +Max number of cores passed to firmware: u (NR_CPUS = 2048)
>> >
>> > Seemingly caused by commit
>> >
>> >   eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
>>
>> My bad. Patch is pending (thanks Michael!):
>>
>> https://patchwork.ozlabs.org/patch/921948/
>
> Umm, that fixes some other messages, but not this particular one.

Here is what I tried to say:

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 4d62f561f272..72ebe5896c1d 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -379,6 +379,11 @@ static void __init prom_printf(const char *format, ...)
                        }
                        prom_print_dec(vs);
                        break;
+               case 'u':
+                       ++q;
+                       vs = va_arg(args, unsigned long);
+                       prom_print_dec(vs);
+                       break;
                case 'l':
                        ++q;
                        if (*q == 0)


> --
> Cheers,
> Stephen Rothwell
