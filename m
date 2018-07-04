Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21C0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973052408F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm+I4GIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973052408F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934320AbeGDIr5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:47:57 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46026 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGDIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:47:54 -0400
Received: by mail-vk0-f65.google.com with SMTP id l64-v6so2663463vkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+yrYri1rVJwBjq17HcmsNtutvo5/SBkrCbY1w9Hhk58=;
        b=mm+I4GIV3aaWtnQgz7kXNmyNOtMFtHsXBGjctRg3sgWbBCDLqy5n8lmFWRKrCA9TDR
         hl+CuRyxsXriq+kmU5woJLVfZkYM9eaAu+YoYdT6zsOVmsbcLQ5SLlW8r8NJuS6gzVp/
         r3goWgYHC70FGT8OcwxRR+Hru2/bkutLgt2jI13xEFvCBmg156KRY4xU+xwaPAmc8Hdn
         4Q2ihXgvY+i0okPxg5DjSF3ZHf7ZAi8xy8VcNEce9v7dP0Xrytfe4VESoNMRVcwsLHSR
         UpOC8lOn7exvYaV8/mOltCZeLCHbR+sAK9WRzrQdXYgIEcwQ8P8STYzaOSeSMJxltAtP
         UJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+yrYri1rVJwBjq17HcmsNtutvo5/SBkrCbY1w9Hhk58=;
        b=KCA8OFmDTAKH+GOmHHZf+YWj6Dq6D6G2rj/3IO+/nzO9gdY2rgrpNYSR4Yy1KvfZiH
         WlgoWJvmpsy7iRh/0n+q+YfF2E+bYNnLHchNlF3v961K73Ll0uJ0v990IufcZon9JOU4
         pUOdUAeGih8a6nzxvASm/XLopJZeOsWBU4wohEGcLvi6QN64MCIuGpdSgVZWkUw88LPn
         vztrRBYE0yz7Z9roHT/VoF5ms4T1GpNnbc6uT1q+Ehtyo9KFcJNb5KD+sL1XNFU1477v
         FGRliRTBO68r9eGoS6NDA0QAYP/Pwe2zo+aqPU3Vk9ctS6tR4UpHcUMwMGni0ji0Rdgu
         5dkw==
X-Gm-Message-State: APt69E1lpHxRHdMIb57T3iyX+1iuL1pJYiITZRq8Cy6rkJ4794aJOEwz
        HoaQ1vcGJFtWxwjiT62Ao9rHKgC1ASEvip4Jn30=
X-Google-Smtp-Source: AAOMgpdb6nwCxFXEbCGV6t6KDDVD02mzSBqxDNZn7T9raPQ4tDyL6Ac3Y3fzIY5CifDYaSIqhUmL1j8Kppb80+7Q5LM=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr583256vkd.161.1530694073615;
 Wed, 04 Jul 2018 01:47:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 01:47:52 -0700 (PDT)
In-Reply-To: <CAHCio2jv-xtnNbJ8beokueh-VQ6zZgF1hAFBJKHCNyuOuz2KxA@mail.gmail.com>
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
 <CAHp75VdaEJgYFUX_MkthFPhimVtJStcinm1P4S-iGfJHvSeiyA@mail.gmail.com> <CAHCio2jv-xtnNbJ8beokueh-VQ6zZgF1hAFBJKHCNyuOuz2KxA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 11:47:52 +0300
Message-ID: <CAHp75Ve1JcxyVWUJagO8Jmj32sfBAjZcPKuG-xvYKMs0b_uCqA@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
To:     =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        aarcange@redhat.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 5:25 AM, =E7=A6=B9=E8=88=9F=E9=94=AE <ufo19890607@gm=
ail.com> wrote:
> Hi Andy
> The const char array need to be used by the new func
> mem_cgroup_print_oom_context and some funcs in oom_kill.c in the
> second patch.

Did I understand correctly that the array is added by you in this solely pa=
tch?
Did I understand correctly that it's used only in one module
(oom_kill.c in new version)?

If both are true, just move it to the C file.

If you need a synchronization, a) put a comment, b) create another
enum item (like FOO_BAR_MAX) at the end and use it in the array as a
fixed size,

>
> Thanks
>
>>
>> On Sat, Jun 30, 2018 at 7:38 PM,  <ufo19890607@gmail.com> wrote:
>> > From: yuzhoujian <yuzhoujian@didichuxing.com>
>> >
>> > The current system wide oom report prints information about the victim
>> > and the allocation context and restrictions. It, however, doesn't
>> > provide any information about memory cgroup the victim belongs to. Thi=
s
>> > information can be interesting for container users because they can fi=
nd
>> > the victim's container much more easily.
>> >
>> > I follow the advices of David Rientjes and Michal Hocko, and refactor
>> > part of the oom report. After this patch, users can get the memcg's
>> > path from the oom report and check the certain container more quickly.
>> >
>> > The oom print info after this patch:
>> > oom-kill:constraint=3D<constraint>,nodemask=3D<nodemask>,oom_memcg=3D<=
memcg>,task_memcg=3D<memcg>,task=3D<comm>,pid=3D<pid>,uid=3D<uid>
>>
>>
>> > +static const char * const oom_constraint_text[] =3D {
>> > +       [CONSTRAINT_NONE] =3D "CONSTRAINT_NONE",
>> > +       [CONSTRAINT_CPUSET] =3D "CONSTRAINT_CPUSET",
>> > +       [CONSTRAINT_MEMORY_POLICY] =3D "CONSTRAINT_MEMORY_POLICY",
>> > +       [CONSTRAINT_MEMCG] =3D "CONSTRAINT_MEMCG",
>> > +};
>>
>> I'm not sure why we have this in the header.
>>
>> This produces a lot of noise when W=3D1.
>>
>> In file included from
>> /home/andy/prj/linux-topic-mfld/include/linux/memcontrol.h:31:0,
>>                 from /home/andy/prj/linux-topic-mfld/include/net/sock.h:=
58,
>>                 from /home/andy/prj/linux-topic-mfld/include/linux/tcp.h=
:23,
>>                 from /home/andy/prj/linux-topic-mfld/include/linux/ipv6.=
h:87,
>>                 from /home/andy/prj/linux-topic-mfld/include/net/ipv6.h:=
16,
>>                 from
>> /home/andy/prj/linux-topic-mfld/net/ipv4/netfilter/nf_log_ipv4.c:17:
>> /home/andy/prj/linux-topic-mfld/include/linux/oom.h:32:27: warning:
>> =E2=80=98oom_constraint_text=E2=80=99 defined but not used [-W
>> unused-const-variable=3D]
>> static const char * const oom_constraint_text[] =3D {
>>                           ^~~~~~~~~~~~~~~~~~~
>>  CC [M]  net/ipv4/netfilter/iptable_nat.o
>>
>>
>> If you need (but looking at the code you actually don't if I didn't
>> miss anything) it in several places, just export.
>> Otherwise put it back to memcontrol.c.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko



--=20
With Best Regards,
Andy Shevchenko
