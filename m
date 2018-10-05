Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D8DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6316D2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qgK7T18l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6316D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeJEX1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:27:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40740 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeJEX1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:27:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so7081862plv.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ylALM1i0/5QJ4UtpmaS85u5cgqJgzR+0WMDfZjeoQak=;
        b=qgK7T18lH+BiZJCwaW5fLt2Sax6iXXOZzvbpCqgMmmTfQkHmXPpT7PR1LPfrRugQUn
         OWu1GIfay8S5a/95gKD+KlVIwUuU7rgMymrU/QnyZXJnkQcs+JkV40aAiB7oGlCs8YvO
         d7eB606Z5KxFghHK1YzJfl7A3SKTkrMUkr4A4gX/xgki3YWNKVGBnRO47ApaZ2FkUEAr
         1C/LboX2DwGAuowU+H9SlyMtXl+9SLGSH2OGAMD/W8tI4uWFn9GIWYEtTLzahI/cHEjb
         24V0O2K4p8WV2dFPGopjZeg19DGHFzqAvicf1IbrrU2xgEzDy+2ACcqMvh8/eQG4JqI5
         ghMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ylALM1i0/5QJ4UtpmaS85u5cgqJgzR+0WMDfZjeoQak=;
        b=TZDxZuBUq0utEvpxBpdSkZJGoVvuOVS0p4Vm52j6xQo+opeWT2tVHvZG8MIMARue+w
         ZzLs2bUbjlfLjsNQrUUMH0vb5NvPl7w6LMYkISXsUYaf+bKxYO1v3eW0shLgftMYIXGa
         y0buPVHAKWdIEOhzDkbLV5u8MH6Ic6F/1l9w0mVIvLFg3lkSX6r3jcV5VOxxjOf6XRQt
         /1zJv9OiQXralmO3igjb8RK9jUHVcO4BJjyF3vr3d+m0B0lLTdf3E46Er2oIYXgE3xrB
         a3x0oVsOk4z/tmym4ELVmZ3NeBSWwaX6MOIIsgtobZRMPkVbG4IAxDqOh/wIaZeU71b4
         O8fA==
X-Gm-Message-State: ABuFfoh+6NRbJvyNSMOWRKqHFL+v8/v3XT3lpGEx6XlVRpnKW+RM/ZWh
        C+uZ/z2Z5CM3S8gPMUxSR1W8eg==
X-Google-Smtp-Source: ACcGV63D2URhe1qL0SvTDQV0Xw8kug7LpBoF/0pJq164+V+4CtbLr3fIexHG3QA8ppsBOLyqlxFZGQ==
X-Received: by 2002:a17:902:421:: with SMTP id 30-v6mr6187502ple.184.1538756887742;
        Fri, 05 Oct 2018 09:28:07 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02c:cbf4:5532:1d8f:efe5:8aa? ([2600:1010:b02c:cbf4:5532:1d8f:efe5:8aa])
        by smtp.gmail.com with ESMTPSA id d24-v6sm8488462pgv.23.2018.10.05.09.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:28:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v4 3/9] x86/cet/ibt: Add IBT legacy code bitmap allocation function
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <fc2f98ab46240c0498bdf4d7458b4373c1f02bf8.camel@intel.com>
Date:   Fri, 5 Oct 2018 09:28:05 -0700
Cc:     Eugene Syromiatnikov <esyr@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BF3AE8F-CC2A-4160-9FF6-FEA171A76371@amacapital.net>
References: <20180921150553.21016-1-yu-cheng.yu@intel.com> <20180921150553.21016-4-yu-cheng.yu@intel.com> <20181003195702.GF32759@asgard.redhat.com> <fc2f98ab46240c0498bdf4d7458b4373c1f02bf8.camel@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 5, 2018, at 9:13 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>=20
>> On Wed, 2018-10-03 at 21:57 +0200, Eugene Syromiatnikov wrote:
>>> On Fri, Sep 21, 2018 at 08:05:47AM -0700, Yu-cheng Yu wrote:
>>> Indirect branch tracking provides an optional legacy code bitmap
>>> that indicates locations of non-IBT compatible code.  When set,
>>> each bit in the bitmap represents a page in the linear address is
>>> legacy code.
>>>=20
>>> We allocate the bitmap only when the application requests it.
>>> Most applications do not need the bitmap.
>>>=20
>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>> ---
>>> arch/x86/kernel/cet.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 45 insertions(+)
>>>=20
>>> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
>>> index 6adfe795d692..a65d9745af08 100644
>>> --- a/arch/x86/kernel/cet.c
>>> +++ b/arch/x86/kernel/cet.c
>>> @@ -314,3 +314,48 @@ void cet_disable_ibt(void)
>>>    wrmsrl(MSR_IA32_U_CET, r);
>>>    current->thread.cet.ibt_enabled =3D 0;
>>> }
>>> +
>>> +int cet_setup_ibt_bitmap(void)
>>> +{
>>> +    u64 r;
>>> +    unsigned long bitmap;
>>> +    unsigned long size;
>>> +
>>> +    if (!cpu_feature_enabled(X86_FEATURE_IBT))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    if (!current->thread.cet.ibt_bitmap_addr) {
>>> +        /*
>>> +         * Calculate size and put in thread header.
>>> +         * may_expand_vm() needs this information.
>>> +         */
>>> +        size =3D TASK_SIZE / PAGE_SIZE / BITS_PER_BYTE;
>>=20
>> TASK_SIZE_MAX is likely needed here, as an application can easily switch
>> between long an 32-bit protected mode.  And then the case of a CPU that
>> doesn't support 5LPT.
>=20
> If we had calculated bitmap size from TASK_SIZE_MAX, all 32-bit apps would=
 have
> failed the allocation for bitmap size > TASK_SIZE.  Please see values belo=
w,
> which is printed from the current code.
>=20
> Yu-cheng
>=20
>=20
> x64:
> TASK_SIZE_MAX    =3D 0000 7fff ffff f000
> TASK_SIZE    =3D 0000 7fff ffff f000
> bitmap size    =3D 0000 0000 ffff ffff
>=20
> x32:
> TASK_SIZE_MAX    =3D 0000 7fff ffff f000
> TASK_SIZE    =3D 0000 0000 ffff e000
> bitmap size    =3D 0000 0000 0001 ffff
>=20

I haven=E2=80=99t followed all the details here, but I have a general policy=
 of objecting to any new use of TASK_SIZE. If you really really need to depe=
nd on 32-bitness in new code, please figure out what exactly you mean by =E2=
=80=9C32-bit=E2=80=9D and use an explicit check.

Some day I would love to delete TASK_SIZE.=
