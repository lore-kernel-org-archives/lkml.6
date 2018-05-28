Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-280420-1527500036-2-12776462449009131355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527500036; b=K4ajHX8vAXEZaZjfrsbWXBxmdpzax3MmR9rTY9Sop75Pd2PsO6
    KJI8Hlin34+pBiIT7ryk4pOAN4y24EZizVTFMPaviEbycFv2+xLFZvxoycdSrebE
    qEbk9Vo3P/NPwAZyx4cfLKZdXmHwBhjvtmJjB42zNCqXhSQh3l+xyfM8lR43HIkr
    owb4nmeLRAm+UhBH6San5HnS7IqgmU9EthTTj+aNsIR1KRpcOuBXjfIHGRoOrahc
    uEgd7nAtCQd2rjweH3deJ+eO1ehBeFc22/d7Ee97oMeA4uY2DbzZbeDby5cLPA2n
    A4lrbWU/Iqd+m4mC57BfBJFLlPhrrQ8gScAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527500036; bh=JyGQ/gX81HhosIhuinL+19U8uiHben8uBr3AtD1ZlT
    g=; b=P+XjSE+zuJlp1iZP9Kw8p5AZJ1fT90VMw5pEW94B4YoN7irDsaR3oDL12L
    kKL24PYnoObshrmwcfKFRK2/IEkFRHMKtJoJn/21+2CiplUzhsfptW8Su5Iko4/k
    +mq9Cl1vIqTYZiieMVvA70dofZRoOrHQTeeJgITMDFz06UhhwR4urzzNL9blo5DU
    V62QDiDVfstrlMp82OcbQGDcXUmvvuU7MzaxP9DfosH2vm+3QigR0dusoRFc2Rpq
    pXiyg82OPojEIRMJ3FJ2C7SXbxT2nb6ja2GoaMuaFpX1SwDuVLcKT+S8uwkmRZFz
    tyvq5NzCaeiN6YOSbSB1R3nYdZ1w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=qCgQ2oX8
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=P+fbcTF5;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=qCgQ2oX8
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=P+fbcTF5;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKdwxNJuuJHa5EDpbXOBNr7rsFF+vbgtMXkBZgo1fMio0/ABiFeVhBymUUE4G9Ccc/PdpjKaQSyNPFzRR4lCmm1AAwuhotY/y7H4IubOaN9avkTQaXof
    NsDr56Hgm8eNyxCzKX5/dKL6Dr4z0h9cYDqyLtE3D3Akvq1uA0BRrvVHpwtrdHFeS6NVjTWGZ4s92u32EL6A/L7Jv0JYM9GJtTnVrEIiZF9Ou/MxtP/VsNZi
    bAkl0pSgGbsvRo0Mhpoc7Q==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=8r6i9kuyV-oA:10 a=VUJBJC2UJ8kA:10 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=faUCR2kPiTTa34ozXUkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeE1Jdz (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 05:33:55 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38408 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbeE1Jdy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 May 2018 05:33:54 -0400
X-Google-Smtp-Source: ADUXVKLYBPQ3i5+SOzEMR4v2UaRXCv8HhmxN/pBjZk6rQKAdHzXplfGnLnPRZ+jADf7XIU4wpTh6RfD8+UXNd0MPG4g=
MIME-Version: 1.0
In-Reply-To: <CAG48ez2N8tjyjGbdh+927uf2A_Xtsie=+DL+GZbvBniiO8jNHw@mail.gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com> <CAG48ez2N8tjyjGbdh+927uf2A_Xtsie=+DL+GZbvBniiO8jNHw@mail.gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 28 May 2018 11:33:33 +0200
Message-ID: <CAJHCu1+3jcJWSyPE8DsFfaR-NNtG5P=H31cKeDuagx_w1u0urA@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
To: Jann Horn <jannh@google.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-28 11:06 GMT+02:00 Jann Horn <jannh@google.com>:
> On Sat, May 26, 2018 at 4:50 PM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> Prevent a task from opening, in "write" mode, any /proc/*/mem
>> file that operates on the task's mm.
>> /proc/*/mem is mainly a debugging means and, as such, it shouldn't
>> be used by the inspected process itself.
>> Current implementation always allow a task to access its own
>> /proc/*/mem file.
>> A process can use it to overwrite read-only memory, making
>> pointless the use of security_file_mprotect() or other ways to
>> enforce RO memory.
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> ---
>>  fs/proc/base.c       | 25 ++++++++++++++++++-------
>>  fs/proc/internal.h   |  3 ++-
>>  fs/proc/task_mmu.c   |  4 ++--
>>  fs/proc/task_nommu.c |  2 +-
>>  4 files changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 1a76d75..01ecfec 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -762,8 +762,9 @@ static int proc_single_open(struct inode *inode, struct file *filp)
>>         .release        = single_release,
>>  };
>>
>> -
>> -struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
>> +struct mm_struct *proc_mem_open(struct inode *inode,
>> +                               unsigned int mode,
>> +                               fmode_t f_mode)
>>  {
>>         struct task_struct *task = get_proc_task(inode);
>>         struct mm_struct *mm = ERR_PTR(-ESRCH);
>> @@ -773,10 +774,20 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
>>                 put_task_struct(task);
>>
>>                 if (!IS_ERR_OR_NULL(mm)) {
>> -                       /* ensure this mm_struct can't be freed */
>> -                       mmgrab(mm);
>> -                       /* but do not pin its memory */
>> -                       mmput(mm);
>> +                       /*
>> +                        * Prevent this interface from being used as a mean
>> +                        * to bypass memory restrictions, including those
>> +                        * imposed by LSMs.
>> +                        */
>> +                       if (mm == current->mm &&
>> +                           f_mode & FMODE_WRITE)
>> +                               mm = ERR_PTR(-EACCES);
>> +                       else {
>> +                               /* ensure this mm_struct can't be freed */
>> +                               mmgrab(mm);
>> +                               /* but do not pin its memory */
>> +                               mmput(mm);
>> +                       }
>>                 }
>>         }
>
> I don't have an opinion on the overall patch, but this part looks
> buggy: In the error path, you set `mm` to an error pointer, but you
> still own the reference that mm_access() took on the old `mm`. The
> error path needs to call `mmput(mm)`.

You are absolutely right,

Thank you,

Salvatore
