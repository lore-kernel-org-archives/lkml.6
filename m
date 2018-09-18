Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC23C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9429F214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNcAFNVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9429F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeIRRrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:47:53 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34625 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbeIRRrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:47:52 -0400
Received: by mail-yw1-f67.google.com with SMTP id y134-v6so671506ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oojYhBLBUuSv9+HnDBLox3Yi8H1bXUnifpxXZNqN/9c=;
        b=cNcAFNVoq/SNbhlWMk4grfPasBGRXROV30aEBpIiaZ7kM789uJQT+WqLgMZONhbOT0
         EvXWV4WaNhecwDZhwWgweUoFFThzGIKpN+CjCGAQGXSHP3Rx8QHliBuoDX3eI+iGO7P0
         IbF4aFEzpHvs+92xxDwXmiZzuPW8W2oUvI/BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oojYhBLBUuSv9+HnDBLox3Yi8H1bXUnifpxXZNqN/9c=;
        b=coUa9Rqyx9rDfHo+ZJiCMLLrroNY7UBNm6X1UDjXpwQ6MQsx0nIEfXaOZK913UVLEE
         nxZN6pMCXO2xFFjKrnIdbIM/c77/uM9houQzJyN1PbFrgMQtBQl3CB6HmaAJin4AIfkl
         I0hD+cfIz9iWhjLdNVdOGNrafD6A2BhxlMEKiSq49CiOpDpSkcmKbf8+ZpS2VRgo9aZA
         nQ8NjtRHBXWtjhRID7PV+sWP6+Rci7HadxQdUqHWp4r0Z2Qvr892AeJynoewqqjcObST
         n6QXLsoTc1zHybitKxFhrasIr9nJbdPwZ38dUJ7spwNiWCL9zXYHyNFDdRywbo7S/JQL
         c2jw==
X-Gm-Message-State: APzg51Dsqf5Gv5oQVK89Ddt30Cgj0ClY8GXcgU0qLuBXMPLTcfXQffqb
        52AtlZ/DJ2nYlRzXzKnc03m+HLuC7LG/4ZZh+r66xA==
X-Google-Smtp-Source: ANB0VdaprcCtLp03D+Rw3uqqIkuKsky0ZG1jcSLhToFxjsegWn3Rz8cetVwS32aKIChrmuQ3YCbPP0mwVGZCf/eNd+M=
X-Received: by 2002:a81:1b82:: with SMTP id b124-v6mr12486389ywb.381.1537272932724;
 Tue, 18 Sep 2018 05:15:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 05:15:32
 -0700 (PDT)
In-Reply-To: <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 17:45:32 +0530
Message-ID: <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 September 2018 at 15:31, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> ---
>>  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
>>  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 ++++++++++++++++++++++++++++
>>  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 +++++++++++++++++++++++++++
>>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++
>
> I think you should only need a single .tbl  input file here.

Yes, we can do that way also.As I mentioned, it will add
more complexity in the script.

 The script has to be smart enough to parse the
.tbl if we add more thing in the .tble file. It need more
logic in the scripts. This is not common. So if you keep
separate .tbl we can avoid this.

ABI flag is serving *nothing* in all other architecture including
SPARC.

But as I told in the cover letter, I followed x86/arm/
s390 architecture's system table generation implementation.
They are keeping ABI flag. In our case we can delete this
flag completely from all architectures.

Most of the architecture these 32/64 similarity is absent.
So it would be better keep separate files to maintain a
generic script across all architecture.

>
>
>> +
>> +systbl_abi_syscall_table_32 := 32
>> +$(out)/syscall_table_32.h: $(syscall32) $(systbl)
>> +       $(call if_changed,systbl)
>> +
>> +systbl_abi_syscall_table_64 := 64
>> +$(out)/syscall_table_64.h: $(syscall64) $(systbl)
>> +       $(call if_changed,systbl)
>> +
>> +systbl_abi_syscall_table_c32 := c32
>> +$(out)/syscall_table_c32.h: $(syscall32) $(systbl)
>> +       $(call if_changed,systbl)
>
> And here you need a fourth output file for the SPU table on ppc64.

Hmm. Let me have a look where things went wrong.

>
>> +383     common  statx                           sys_statx
>> +384     common  pkey_alloc                      sys_pkey_alloc
>> +385     common  pkey_free                       sys_pkey_free
>> +386     common  pkey_mprotect                   sys_pkey_mprotect
>
> This also misses rseq and io_pgetevents.

As I mentioned in the cover letter:
"I started working system call table generation on 4.17-rc1. I used
marcin's script - https://github.com/hrw/syscalls-table to generate
the syscall.tbl file. And this will be the input to the system call
table generation script. But there are couple system call got add
in the latest rc release. If run Marcin's script on latest release,
It will generate a new syscall.tbl. But I still use the old file -
syscall.tbl and once all review got over I'll update syscall.tbl
alone w.r.to the tip of the kernel. The impact of this thing, few
of the system call won't work."

Hopefully, the next version does have this change. Thanks!

- Firoz
