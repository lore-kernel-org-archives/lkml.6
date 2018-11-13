Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0408BC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF919208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePaxK7nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF919208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeKNDnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:43:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42735 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731698AbeKNDnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:43:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so1944992pfr.9;
        Tue, 13 Nov 2018 09:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4QcUNisc8g+TFMgz1BrOTxAaBCtkW80mZflJIfTqkW8=;
        b=ePaxK7nxZxKGAcIvUGHG8Jq7L9CJ7ZTLMMF/grKSpvCmUell4NhO5/E047U5ls6BV2
         pjtVRU3WnSepvGF2XwCKDBG0gQv9sR5Ht6SHPCS8tYfXMR92mywDpY49fIz6bOAueXXL
         Jfk6Z1rN4A+B00RZQdQFIjRrZH9ShGFujHzpvmxcF1tHONecphR8uJyZ2Ha6AjH7ooW0
         yYjykOqneW/N9Sd6R233oJK8b5zTa12BJ9EKNKcHyRwyR92cBAjuFwWRShnfzV9KX7uK
         EUI+gCSdL2KK491gEOARSVI5KFgVryT07rjXp9/eRS+Bix37JgKYuqIfcEvc2IcnMObw
         UydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4QcUNisc8g+TFMgz1BrOTxAaBCtkW80mZflJIfTqkW8=;
        b=XA4bJLVOyxFJkVaWhhV1TVxnyPfr0xK/c6lVrEkUKx+dfCSpGwB3K8tXZmomt+0EMO
         adxmVos39rDpov8cxxihlHaKDZSb7BQ0afN/uAEmuH8L3X0+v+rxM6LXLcTL+rkW18Iv
         D7Bs+Gv1iD4C7BLQUSlAB4yENlDnNeraDW4nL+gkVu7Bc/ODN7fLQ0BxsyaShCIGfZbJ
         AG1R5Mvjhtyu0XQcDTqVriFxuG8Y3nooX3fCTbmKVmAXpC+8vqp5+JO7OY0VD/ZdKI9f
         ngxmOPcFZ0RaP9KhR/owCbtS7YfkC4odvJMG/rRVJV7hqbXV+q47VqIPpYOmVD0ob2uh
         O/NQ==
X-Gm-Message-State: AGRZ1gK8tmye+1RG21GbqWfw2adyEtapc1CEen7PwyWCSzomr/efDCvu
        Hk0lnjOBkS5V7WcGR/k8hIw=
X-Google-Smtp-Source: AJdET5eQ4uu2oFUR6TFTZP/kCj3No/NYvFZB18n1ulQF7+eOt5RPB4rSFLl5qVBlPOYuPCaezxVEQg==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr5440503pgm.354.1542131038331;
        Tue, 13 Nov 2018 09:43:58 -0800 (PST)
Received: from [10.2.51.78] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id p62-v6sm22054290pfp.111.2018.11.13.09.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:43:57 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
Date:   Tue, 13 Nov 2018 09:43:53 -0800
Cc:     Kees Cook <keescook@chromium.org>,
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
Message-Id: <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
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
To:     Andy Lutomirski <luto@amacapital.net>,
        Igor Stoppa <igor.stoppa@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski
Sent: November 13, 2018 at 5:16:09 PM GMT
> To: Igor Stoppa <igor.stoppa@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra =
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
> Subject: Re: [PATCH 10/17] prmem: documentation
>=20
>=20
> On Tue, Nov 13, 2018 at 6:25 AM Igor Stoppa <igor.stoppa@gmail.com> =
wrote:
>> Hello,
>> I've been studying v4 of the patch-set [1] that Nadav has been =
working on.
>> Incidentally, I think it would be useful to cc also the
>> security/hardening ml.
>> The patch-set seems to be close to final, so I am resuming this =
discussion.
>>=20
>> On 30/10/2018 19:06, Andy Lutomirski wrote:
>>=20
>>> I support the addition of a rare-write mechanism to the upstream =
kernel.  And I think that there is only one sane way to implement it: =
using an mm_struct. That mm_struct, just like any sane mm_struct, should =
only differ from init_mm in that it has extra mappings in the *user* =
region.
>>=20
>> After reading the code, I see what you meant.
>> I think I can work with it.
>>=20
>> But I have a couple of questions wrt the use of this mechanism, in =
the
>> context of write rare.
>>=20
>>=20
>> 1) mm_struct.
>>=20
>> Iiuc, the purpose of the patchset is mostly (only?) to patch kernel =
code
>> (live patch?), which seems to happen sequentially and in a relatively
>> standardized way, like replacing the NOPs specifically placed in the
>> functions that need patching.
>>=20
>> This is a bit different from the more generic write-rare case, =
applied
>> to data.
>>=20
>> As example, I have in mind a system where both IMA and SELinux are in =
use.
>>=20
>> In this system, a file is accessed for the first time.
>>=20
>> That would trigger 2 things:
>> - evaluation of the SELinux rules and probably update of the AVC =
cache
>> - IMA measurement and update of the measurements
>>=20
>> Both of them could be write protected, meaning that they would both =
have
>> to be modified through the write rare mechanism.
>>=20
>> While the events, for 1 specific file, would be sequential, it's not
>> difficult to imagine that multiple files could be accessed at the =
same time.
>>=20
>> If the update of the data structures in both IMA and SELinux must use
>> the same mm_struct, that would have to be somehow regulated and it =
would
>> introduce an unnecessary (imho) dependency.
>>=20
>> How about having one mm_struct for each writer (core or thread)?
>=20
> I don't think that helps anything.  I think the mm_struct used for
> prmem (or rare_write or whatever you want to call it) should be
> entirely abstracted away by an appropriate API, so neither SELinux nor
> IMA need to be aware that there's an mm_struct involved.  It's also
> entirely possible that some architectures won't even use an mm_struct
> behind the scenes -- x86, for example, could have avoided it if there
> were a kernel equivalent of PKRU.  Sadly, there isn't.
>=20
>> 2) Iiuc, the purpose of the 2 pages being remapped is that the target =
of
>> the patch might spill across the page boundary, however if I deal =
with
>> the modification of generic data, I shouldn't (shouldn't I?) assume =
that
>> the data will not span across multiple pages.
>=20
> The reason for the particular architecture of text_poke() is to avoid
> memory allocation to get it working.  i think that prmem/rare_write
> should have each rare-writable kernel address map to a unique user
> address, possibly just by offsetting everything by a constant.  For
> rare_write, you don't actually need it to work as such until fairly
> late in boot, since the rare_writable data will just be writable early
> on.
>=20
>> If the data spans across multiple pages, in unknown amount, I suppose
>> that I should not keep interrupts disabled for an unknown time, as it
>> would hurt preemption.
>>=20
>> What I thought, in my initial patch-set, was to iterate over each =
page
>> that must be written to, in a loop, re-enabling interrupts in-between
>> iterations, to give pending interrupts a chance to be served.
>>=20
>> This would mean that the data being written to would not be =
consistent,
>> but it's a problem that would have to be addressed anyways, since it =
can
>> be still read by other cores, while the write is ongoing.
>=20
> This probably makes sense, except that enabling and disabling
> interrupts means you also need to restore the original mm_struct (most
> likely), which is slow.  I don't think there's a generic way to check
> whether in interrupt is pending without turning interrupts on.

I guess that enabling IRQs might break some hidden assumptions in the =
code,
but is there a fundamental reason that IRQs need to be disabled? =
use_mm()
got them enabled, although it is only suitable for kernel threads.

