Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36573206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrLY43ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36573206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeK2Fc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:32:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33072 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725761AbeK2Fc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:32:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so9876523pgu.0;
        Wed, 28 Nov 2018 10:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XtrritqyCgXvd/Oac0XlhV9ZTEWanBaIrFkfpwFUgoI=;
        b=hrLY43aeQQctAtGXs6mvsCbS1JaUdjCeCQKH9Jd4/kyn3F2By200bXeF+JzmVXfB+9
         OAsPOy/AkaCVaPb8fBYZX8qyr6crHsSIBtjEAxdbzGtOe+vYaZQ9KD1cO8CLDW31d1sS
         AwrYr9s1NK3XswCkKQ8eyIk231QfBFzzAh/QqE88UiKkl4x/PB7YWJPCtDs48JDpZf9N
         2l75Aysh89DDhew7js8hV4q/Sd4eqqxXSyeErCes86pB7hK+ttTdmhLdUNPsnadQj6ES
         qtONysdhpb5sjrdnC80ugXTFeZqOyZbeGQclLTgnziseJs/fZPSUsW5jABZEcsn5zFTX
         XzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XtrritqyCgXvd/Oac0XlhV9ZTEWanBaIrFkfpwFUgoI=;
        b=VHfW+Cho5AFXEEGF1DEEQ+w/xlv3npiRKLYXx6vx2vJPq6JuARZa3IQpc1o17GOWDN
         7LzXX5zBtwAAOViOw8swRMCxGlGOLj/r1fUR9LL9Oguwv20xmB8ARh+bLFZ6CuSEA9QT
         wA50XmB3iWieqxtrNt/rB3QDPr+H4QH6yCTLplMxieO3CGrklqjYwPI6KSy+fbr6MEkg
         KmarCjYQstkuhasBDUl+Po0UTFYu1cPgI+zGrBmB5TaRl99Nrrf16y5fRuppyMRHeIyd
         CioTA533gKHTc0Hkk6T6eEEQiQavq62ytR01wKaqEoRNbdGl0fyxUrQTnrMMAb+Q1kFa
         IPug==
X-Gm-Message-State: AGRZ1gLnEDRvofWmANjtBn4/F6dA4C2XLipcZL2NRj7OlnS7QF10/wWx
        0er1nJyoAv0vN87VdlziUds=
X-Google-Smtp-Source: AJdET5cxLrEPX5yKWJ5TLS8PAm3NG73T+mF0FtJhUvU3AVAfODcjXXAo7JAzYe8q28Vwn8DmmXM0OQ==
X-Received: by 2002:a62:1bd7:: with SMTP id b206mr38415056pfb.213.1543429794690;
        Wed, 28 Nov 2018 10:29:54 -0800 (PST)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id b5sm16446863pfc.150.2018.11.28.10.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:29:53 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: =?utf-8?Q?Re=3A_=5BPATCH_0/2=5D_Don=E2=80=99t_leave_executable_TL?=
 =?utf-8?Q?B_entries_to_freed_pages?=
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181128095734.GA23467@arm.com>
Date:   Wed, 28 Nov 2018 10:29:52 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, jeyu@kernel.org,
        netdev@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, kristen@linux.intel.com,
        dave.hansen@intel.com, deneen.t.dock@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB747B26-5C1A-4417-9DE9-8C356AB1C593@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <CDB8B7C1-FD55-44AD-9B71-B3A750BF5489@gmail.com>
 <449E6648-5599-476D-8136-EE570101F930@gmail.com>
 <20181128095734.GA23467@arm.com>
To:     Will Deacon <will.deacon@arm.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 28, 2018, at 1:57 AM, Will Deacon <will.deacon@arm.com> wrote:
>=20
> On Tue, Nov 27, 2018 at 05:21:08PM -0800, Nadav Amit wrote:
>>> On Nov 27, 2018, at 5:06 PM, Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>>=20
>>>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe =
<rick.p.edgecombe@intel.com> wrote:
>>>>=20
>>>> Sometimes when memory is freed via the module subsystem, an =
executable
>>>> permissioned TLB entry can remain to a freed page. If the page is =
re-used to
>>>> back an address that will receive data from userspace, it can =
result in user
>>>> data being mapped as executable in the kernel. The root of this =
behavior is
>>>> vfree lazily flushing the TLB, but not lazily freeing the =
underlying pages.=20
>>>>=20
>>>> There are sort of three categories of this which show up across =
modules, bpf,
>>>> kprobes and ftrace:
>>>>=20
>>>> 1. When executable memory is touched and then immediatly freed
>>>>=20
>>>> This shows up in a couple error conditions in the module loader and =
BPF JIT
>>>> compiler.
>>>=20
>>> Interesting!
>>>=20
>>> Note that this may cause conflict with "x86: avoid W^X being broken =
during
>>> modules loading=E2=80=9D, which I recently submitted.
>>=20
>> I actually have not looked on the vmalloc() code too much recent, but =
it
>> seems =E2=80=A6 strange:
>>=20
>>  void vm_unmap_aliases(void)
>>  {      =20
>>=20
>>  ...
>>  	mutex_lock(&vmap_purge_lock);
>>  	purge_fragmented_blocks_allcpus();
>>  	if (!__purge_vmap_area_lazy(start, end) && flush)
>>  		flush_tlb_kernel_range(start, end);
>>  	mutex_unlock(&vmap_purge_lock);
>>  }
>>=20
>> Since __purge_vmap_area_lazy() releases the memory, it seems there is =
a time
>> window between the release of the region and the TLB flush, in which =
the
>> area can be allocated for another purpose. This can result in a
>> (theoretical) correctness issue. No?
>=20
> If __purge_vmap_area_lazy() returns false, then it hasn't freed the =
memory,
> so we only invalidate the TLB if 'flush' is true in that case. If
> __purge_vmap_area_lazy() returns true instead, then it takes care of =
the TLB
> invalidation before the freeing.

Right. Sorry for my misunderstanding.

Thanks,
Nadav

