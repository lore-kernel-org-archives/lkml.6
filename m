Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52991C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2922251A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBML4S+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2922251A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbeKNEGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:06:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33176 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732227AbeKNEGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:06:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id v68-v6so6461998pfk.0;
        Tue, 13 Nov 2018 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hMmS1nZS3LXt+WsRx1ONzsmAETiXZKuLi7jcwbuIYLI=;
        b=eBML4S+ekMrRsPHuYROhWihBN3yGCz/36qKQZdjajR/6TPTfX28Yzt6rP+1JJWvZQY
         7mVC1xH7cR/J8A0bLuO37qVCID2q5xQA4Iw48k+FdA+ezUFZCBqmQ1uBHmI5n3KXpRNJ
         2PD2UO6gfVb61N8DF244wtTEui7iXzepYZiYs7+8dfN+wNROhHfLTr1At3s44za94YMM
         TjTI9oDqUpclxhSVwaeXjTlbTs0pGNgjEwDL0/F4pCa4Agt06KWHPyxLlQTaw7KVtHK5
         IuYAXRNjsMI7qFjLaeWIQBhMtqi9XCpEhgp0sKTwEKHHcv8/GrmAoM6dbollq6OOaicK
         mFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hMmS1nZS3LXt+WsRx1ONzsmAETiXZKuLi7jcwbuIYLI=;
        b=YaQIq7w20nabQNp1MrHi9VHjI/XkyvqIuFUp5bq6adtAQSU5SDFba8bZLajjX0O5EM
         d1HSRNfXq0NZJtQf/cQfB6LLTT4U31/M7dairxXzgfOw2lLqpsc/e6JLlJwJVD3P9T9q
         aSLR6z+hZd1Lgsx/FqygHCWcb3klsriB42Jia9sirpcP6RnWbg1lyMVIan0gVIqTaQrT
         xeKx7UeknKhXO//Gt4U1NgT2cboymBttkyRXQZ/yz9ObfcW47nbgZ64N8biMiL/BHcWy
         QAzatjyMj97thVJTzsWgne+TKkiv8FLs129Sm3hHKru0a6LZlpy83klszuRbe/8Yi+gc
         txrw==
X-Gm-Message-State: AGRZ1gIDp6BSw2BX0PoDCTK+GryXKRObMNVwE1KCPwiimtsGIgRd/dxE
        VqSipAk74aktRAQgE9uSINk=
X-Google-Smtp-Source: AJdET5fY7NRN4RwW1nd1TJuAAdgWkqoAX2b0SMFS9R7TkjUsYJq12qavsVjq9znH3P/h2bRYI4a4gg==
X-Received: by 2002:a62:65c3:: with SMTP id z186-v6mr6281147pfb.206.1542132424077;
        Tue, 13 Nov 2018 10:07:04 -0800 (PST)
Received: from [10.2.51.78] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id p9-v6sm15337649pfa.22.2018.11.13.10.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:07:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
Date:   Tue, 13 Nov 2018 10:06:59 -0800
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E01BD14F-734B-4142-B2E6-50E7A974AEF6@gmail.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
 <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski
Sent: November 13, 2018 at 5:47:16 PM GMT
> To: Nadav Amit <nadav.amit@gmail.com>
> Cc: Igor Stoppa <igor.stoppa@gmail.com>, Kees Cook =
<keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Mimi =
Zohar <zohar@linux.vnet.ibm.com>, Matthew Wilcox <willy@infradead.org>, =
Dave Chinner <david@fromorbit.com>, James Morris <jmorris@namei.org>, =
Michal Hocko <mhocko@kernel.org>, Kernel Hardening =
<kernel-hardening@lists.openwall.com>, linux-integrity =
<linux-integrity@vger.kernel.org>, LSM List =
<linux-security-module@vger.kernel.org>, Igor Stoppa =
<igor.stoppa@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>, =
Jonathan Corbet <corbet@lwn.net>, Laura Abbott <labbott@redhat.com>, =
Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport =
<rppt@linux.vnet.ibm.com>, open list:DOCUMENTATION =
<linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas =
Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH 10/17] prmem: documentation
>=20
>=20
> On Tue, Nov 13, 2018 at 9:43 AM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>> From: Andy Lutomirski
>> Sent: November 13, 2018 at 5:16:09 PM GMT
>>> To: Igor Stoppa <igor.stoppa@gmail.com>
>>> Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra =
<peterz@infradead.org>, Nadav Amit <nadav.amit@gmail.com>, Mimi Zohar =
<zohar@linux.vnet.ibm.com>, Matthew Wilcox <willy@infradead.org>, Dave =
Chinner <david@fromorbit.com>, James Morris <jmorris@namei.org>, Michal =
Hocko <mhocko@kernel.org>, Kernel Hardening =
<kernel-hardening@lists.openwall.com>, linux-integrity =
<linux-integrity@vger.kernel.org>, LSM List =
<linux-security-module@vger.kernel.org>, Igor Stoppa =
<igor.stoppa@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>, =
Jonathan Corbet <corbet@lwn.net>, Laura Abbott <labbott@redhat.com>, =
Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport =
<rppt@linux.vnet.ibm.com>, open list:DOCUMENTATION =
<linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas =
Gleixner <tglx@linutronix.de>
>>> Subject: Re: [PATCH 10/17] prmem: documentation
>>>=20
>>>=20
>>> On Tue, Nov 13, 2018 at 6:25 AM Igor Stoppa <igor.stoppa@gmail.com> =
wrote:
>>>> Hello,
>>>> I've been studying v4 of the patch-set [1] that Nadav has been =
working on.
>>>> Incidentally, I think it would be useful to cc also the
>>>> security/hardening ml.
>>>> The patch-set seems to be close to final, so I am resuming this =
discussion.
>>>>=20
>>>> On 30/10/2018 19:06, Andy Lutomirski wrote:
>>>>=20
>>>>> I support the addition of a rare-write mechanism to the upstream =
kernel.  And I think that there is only one sane way to implement it: =
using an mm_struct. That mm_struct, just like any sane mm_struct, should =
only differ from init_mm in that it has extra mappings in the *user* =
region.
>>>>=20
>>>> After reading the code, I see what you meant.
>>>> I think I can work with it.
>>>>=20
>>>> But I have a couple of questions wrt the use of this mechanism, in =
the
>>>> context of write rare.
>>>>=20
>>>>=20
>>>> 1) mm_struct.
>>>>=20
>>>> Iiuc, the purpose of the patchset is mostly (only?) to patch kernel =
code
>>>> (live patch?), which seems to happen sequentially and in a =
relatively
>>>> standardized way, like replacing the NOPs specifically placed in =
the
>>>> functions that need patching.
>>>>=20
>>>> This is a bit different from the more generic write-rare case, =
applied
>>>> to data.
>>>>=20
>>>> As example, I have in mind a system where both IMA and SELinux are =
in use.
>>>>=20
>>>> In this system, a file is accessed for the first time.
>>>>=20
>>>> That would trigger 2 things:
>>>> - evaluation of the SELinux rules and probably update of the AVC =
cache
>>>> - IMA measurement and update of the measurements
>>>>=20
>>>> Both of them could be write protected, meaning that they would both =
have
>>>> to be modified through the write rare mechanism.
>>>>=20
>>>> While the events, for 1 specific file, would be sequential, it's =
not
>>>> difficult to imagine that multiple files could be accessed at the =
same time.
>>>>=20
>>>> If the update of the data structures in both IMA and SELinux must =
use
>>>> the same mm_struct, that would have to be somehow regulated and it =
would
>>>> introduce an unnecessary (imho) dependency.
>>>>=20
>>>> How about having one mm_struct for each writer (core or thread)?
>>>=20
>>> I don't think that helps anything.  I think the mm_struct used for
>>> prmem (or rare_write or whatever you want to call it) should be
>>> entirely abstracted away by an appropriate API, so neither SELinux =
nor
>>> IMA need to be aware that there's an mm_struct involved.  It's also
>>> entirely possible that some architectures won't even use an =
mm_struct
>>> behind the scenes -- x86, for example, could have avoided it if =
there
>>> were a kernel equivalent of PKRU.  Sadly, there isn't.
>>>=20
>>>> 2) Iiuc, the purpose of the 2 pages being remapped is that the =
target of
>>>> the patch might spill across the page boundary, however if I deal =
with
>>>> the modification of generic data, I shouldn't (shouldn't I?) assume =
that
>>>> the data will not span across multiple pages.
>>>=20
>>> The reason for the particular architecture of text_poke() is to =
avoid
>>> memory allocation to get it working.  i think that prmem/rare_write
>>> should have each rare-writable kernel address map to a unique user
>>> address, possibly just by offsetting everything by a constant.  For
>>> rare_write, you don't actually need it to work as such until fairly
>>> late in boot, since the rare_writable data will just be writable =
early
>>> on.
>>>=20
>>>> If the data spans across multiple pages, in unknown amount, I =
suppose
>>>> that I should not keep interrupts disabled for an unknown time, as =
it
>>>> would hurt preemption.
>>>>=20
>>>> What I thought, in my initial patch-set, was to iterate over each =
page
>>>> that must be written to, in a loop, re-enabling interrupts =
in-between
>>>> iterations, to give pending interrupts a chance to be served.
>>>>=20
>>>> This would mean that the data being written to would not be =
consistent,
>>>> but it's a problem that would have to be addressed anyways, since =
it can
>>>> be still read by other cores, while the write is ongoing.
>>>=20
>>> This probably makes sense, except that enabling and disabling
>>> interrupts means you also need to restore the original mm_struct =
(most
>>> likely), which is slow.  I don't think there's a generic way to =
check
>>> whether in interrupt is pending without turning interrupts on.
>>=20
>> I guess that enabling IRQs might break some hidden assumptions in the =
code,
>> but is there a fundamental reason that IRQs need to be disabled? =
use_mm()
>> got them enabled, although it is only suitable for kernel threads.
>=20
> For general rare-writish stuff, I don't think we want IRQs running
> with them mapped anywhere for write.  For AVC and IMA, I'm less sure.

Oh.. Of course. It is sort of a measure to prevent a single =
malicious/faulty
write from corrupting the sensitive memory. Doing so limits the code =
that
can compromise the security by a write to the protected data-structures
(rephrasing for myself).

I think I should add it as a comment in your patch.=
