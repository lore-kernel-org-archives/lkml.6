Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F03ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072CD204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hv6U7hn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072CD204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeIRMVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:21:40 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46225 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIRMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:21:40 -0400
Received: by mail-yb1-f196.google.com with SMTP id y20-v6so355727ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Ms/YbFKnS4bxMhBs4PIsFP8hZqQhBYkgx9GUHIEixA=;
        b=hv6U7hn0kWoWblvgFRg/gONjU385qwpG7W3jVklAXCV87I4KtLzodC4+z/tZvu8zAO
         1oFtBsURKYGRbmAITmXsi+6KQDxp0AVV1+KrA8DleRYOljBf1muJRGSW337epkj0RGv9
         Ihm0eEDrqitRRQWUq5ZeWb68TM9CREO4k1X2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Ms/YbFKnS4bxMhBs4PIsFP8hZqQhBYkgx9GUHIEixA=;
        b=Ug5PL7LfmgDwF2LyHFViVLJAJFyBMF86oY//EaI3b89ySJ/zSjVrQb6B6GUedr1duS
         aNAfyzyjTVbyqZCaHqtoyT4s8riva+MYqaE6jA6WLK9GvH0h6YUHclkh6MFZPp42yzZg
         F1klPGfI7mjajKJ5r46aOUxfg+x2j07nmn62TygXt+NYg3PIh3xMxXnPeGGnYm6Ud84J
         RZeYP2qlHJVEnbnd+lCyk/B9SS+bPlC1iXFEHE6eo1poS4CS8fQsl9qA9sMHHBFc8EBn
         ErVuCCt10MK4v+4az2qTLzrHgSQ/fJkonwWrk99g9MdVChzp2szxtKlQPfGz6vBbN9Pj
         +blw==
X-Gm-Message-State: APzg51Cnb1uwYoawG/vOOqy5S3SJQ6GeXMjJkbPuzsRfUykThdfor1K+
        AUrXBu72Y7vQ/h7+fpHpodBgMG4hGbuWN+XWbwKaqg==
X-Google-Smtp-Source: ANB0VdZbwVOB8Vqq6Osqa2C++ggyff7V5zR/q0m5vpbC3tPyMj50W3vLyTsegMz277yPpYBAsM7tMFEnp4SoGroQnJo=
X-Received: by 2002:a25:9702:: with SMTP id d2-v6mr12442006ybo.77.1537253428599;
 Mon, 17 Sep 2018 23:50:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 23:50:28
 -0700 (PDT)
In-Reply-To: <80094eae-05b8-a96f-b631-cc3b81e0e425@xilinx.com>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-3-git-send-email-firoz.khan@linaro.org> <80094eae-05b8-a96f-b631-cc3b81e0e425@xilinx.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 12:20:28 +0530
Message-ID: <CALxhOnjxc0kQYDEkkOvRCS99dMMpV9jQJNP4yLhtNr3VO3KJVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] microblaze: Added system call table generation support
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

On 9 August 2018 at 12:35, Michal Simek <michal.simek@xilinx.com> wrote:
> On 9.8.2018 07:27, Firoz Khan wrote:
>> The system call tables are in different format in all
>> architecture and it will be difficult to manually add or
>> modify the system calls in the respective files. To make
>> it easy by keeping a script and which'll generate the
>> header file and syscall table file so this change will
>> unify them across all architectures.
>>
>> The system call table generation script is added in
>> syscalls directory which contain the script to generate
>> both uapi header file system call table generation file
>> and syscall.tbl file which'll be the input for the scripts.
>>
>> syscall.tbl contains the list of available system calls
>> along with system call number and corresponding entry point.
>> Add a new system call in this architecture will be possible
>> by adding new entry in the syscall.tbl file.
>>
>> Adding a new table entry consisting of:
>>         - System call number.
>>         - ABI.
>>         - System call name.
>>         - Entry point name.
>>
>> syscallhdr.sh and syscalltbl.sh will generate uapi header-
>> unistd.h and syscall_table.h files respectively. File
>> syscall_table.h is included by syscall.S - the real system
>> call table. Both .sh files will parse the content syscall.tbl
>> to generate the header and table files.
>>
>> ARM, s390 and x86 architecuture does have the similar support.
>> I leverage their implementation to come up with a generic
>> solution. And this is the ground work for y2038 issue. We need
>> to change 52 system call implementation and this work will
>> reduce the effort by simply modify 52 entries in syscall.tbl.
>>
>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>> ---
>>  arch/microblaze/kernel/syscalls/Makefile      |  37 +++
>>  arch/microblaze/kernel/syscalls/syscall.tbl   | 404 ++++++++++++++++++++++++++
>>  arch/microblaze/kernel/syscalls/syscallhdr.sh |  33 +++
>>  arch/microblaze/kernel/syscalls/syscalltbl.sh |  28 ++
>>  4 files changed, 502 insertions(+)
>>  create mode 100644 arch/microblaze/kernel/syscalls/Makefile
>>  create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
>>  create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
>
> it is interesting that arm and x86 scripts and they are "almost" the
> same. Is there any plan to put these script to generic location instead
> of keeping the same copy in architecture?

Having a single script is always our plan for long run. But I have to keep a
separate versions for the start so each architecture can be handled  in one
series. Which would make easier to merge in the initial version.

we could probably add it to scripts/*.sh first, but that requires more
coordination between the architectures.

>
> fileguard name contains hardcoded macro prefix where in arm there is
> uapi detection. The same should be done architecture and sholdn't matter
> if you define macro with or without value.

Yes. As I told in my cover letter, I leverage x86/arm/s390 architecture
implementation to come up with a generic solution. For the fileguard,
I took x86 implementation as reference.

>
>>  create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
>>
>> diff --git a/arch/microblaze/kernel/syscalls/Makefile b/arch/microblaze/kernel/syscalls/Makefile
>> new file mode 100644
>> index 0000000..7624044
>> --- /dev/null
>> +++ b/arch/microblaze/kernel/syscalls/Makefile
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +out := arch/$(SRCARCH)/include/generated/asm
>> +uapi := arch/$(SRCARCH)/include/generated/uapi/asm
>> +
>> +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
>> +       $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>> +
>> +syscall := $(srctree)/$(src)/syscall.tbl
>> +
>> +syshdr := $(srctree)/$(src)/syscallhdr.sh
>> +systbl := $(srctree)/$(src)/syscalltbl.sh
>> +
>> +quiet_cmd_syshdr = SYSHDR  $@
>> +      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'  \
>> +                '$(syshdr_abi_$(basetarget))'          \
>> +                '$(syshdr_pfx_$(basetarget))'          \
>> +                '$(syshdr_offset_$(basetarget))'
>> +
>> +quiet_cmd_systbl = SYSTBL  $@
>> +      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'  \
>> +                '$(systbl_abi_$(basetarget))'
>> +
>> +$(uapi)/unistd_32.h: $(syscall) $(syshdr)
>> +     $(call if_changed,syshdr)
>> +
>> +$(out)/syscall_table.h: $(syscall) $(systbl)
>> +     $(call if_changed,systbl)
>> +
>> +uapisyshdr-y                 += unistd_32.h
>> +syshdr-y                     += syscall_table.h
>> +
>> +targets      += $(uapisyshdr-y) $(syshdr-y)
>> +
>> +PHONY += all
>> +all: $(addprefix $(uapi)/,$(uapisyshdr-y))
>> +all: $(addprefix $(out)/,$(syshdr-y))
>> +     @:
>> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
>> new file mode 100644
>> index 0000000..219d940
>> --- /dev/null
>> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
>> @@ -0,0 +1,404 @@
>> +#
>> +# Linux system call numbers and entry vectors
>> +#
>> +# The format is:
>> +# <number> <abi> <name> <entry point>
>> +#
>> +# The abi is always common for this file.
>> +#
>> +0       common  restart_syscall                 sys_restart_syscall
>> +1       common  exit                            sys_exit
>> +2       common  fork                            sys_fork
>> +3       common  read                            sys_read
>
> Arm(and partially s390) are using tabs for indentation. Any reason not
> to use it here too?
Sorry for this. My editor has a different setting for tab indentation.
I'll fix this
one while post the next patch series.

FYI, I have a list of this need to improve, those I'll correct in the
next version
of the patch series.

- Firoz
