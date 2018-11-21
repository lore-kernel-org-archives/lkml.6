Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D449C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4717D21731
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="tBSaAqqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4717D21731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbeKVEvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:51:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46358 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732947AbeKVEvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:51:24 -0500
Received: by mail-io1-f65.google.com with SMTP id m1-v6so4719960ioc.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GmIGIP5BMNNQIU9SWNX7PqO+dvzqp1ZHFbw42p5PecE=;
        b=tBSaAqqX2CJoq08gjXFyy0rSOkk4HVt+BHen25kTBbaaGlg/G51ZwPFnv8JVwQ9Do0
         a50+Ld9jEYgBHtFTP0AdfyKEfxeHLeGhadsxMbxzR+VcbGTHAodsjqY6HTHK8dH/ncGf
         K839hVu/p/U88Lvp9EPY4avocC5zIoxNzV/UznyuNoJsRt5YhQiK9zRgI1fOw19RgB94
         1YJK/Hr2HAZkqra5C0Cb0DUTqOsDEccY9RnWgj1dgkhXgQk2/nm0mSq2U1r6NYsIoUNI
         46VYZHvz64DZHutqpwB23WHPcWCJOWhRvRO8gEHXzUit80167MkupGu2mGK63KgY+cAm
         LqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GmIGIP5BMNNQIU9SWNX7PqO+dvzqp1ZHFbw42p5PecE=;
        b=K3mnK12K1uC02fWAIRwOfGqsDXexW9fo7Q8muzuFT01mn5JM5GVOPdXe9o4jHk8rSn
         xBmoJL55AsScq1aYSOfGc+dN9F5ydmxs6saWN/mvR2C9+h0Dq67vq/uLK7HRTUuwRj+1
         4JjA0oPo7tZ35EOJYG2gGFwWCKTm1r/2gGzund8VKzvfANBX/TwuL3QXLBdwwT9FJ1Ay
         T/LMlK2gNhf225BzO3K/oQH8l7Ed5+ZcNZNOfS2kCjTDld5y6xXpywC8D7p/A4wU33Op
         0vLEIcTF4fQHYuRne4iXmR8TVdithnKHYF3I8d93MrzLKYoRhMOxJmtXVLEx8Cbt/E5G
         aYYw==
X-Gm-Message-State: AA+aEWaHbj8ghqZe9mMZp0zobQYRtunkaniHpQ6GX6zMWSdPOwd8X7r2
        8AUGfSAgVtoVaUr+boj9BQd8xA==
X-Google-Smtp-Source: AFSGD/UPRYnitpcH6b5hqb9s1xNfYVbQJgUW7ZyCZpur77D9ucZuaVh/On2qHQtvdjbvqMW7M07Duw==
X-Received: by 2002:a6b:c402:: with SMTP id y2mr6080745ioa.77.1542824159250;
        Wed, 21 Nov 2018 10:15:59 -0800 (PST)
Received: from ?IPv6:2600:100e:b040:b126:ec78:48dd:44e2:e165? ([2600:100e:b040:b126:ec78:48dd:44e2:e165])
        by smtp.gmail.com with ESMTPSA id c187-v6sm608844itc.2.2018.11.21.10.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 10:15:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com>
Date:   Wed, 21 Nov 2018 11:15:56 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BB9DE07-E0AE-43E2-99F1-E4AA774CD462@amacapital.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com> <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com> <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com> <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com> <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com> <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com> <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com> <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com> <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com> <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com> <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com> <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com> <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2018, at 9:34 AM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
>=20
> Hi,
>=20
>>> On 13/11/2018 20:36, Andy Lutomirski wrote:
>>> On Tue, Nov 13, 2018 at 10:33 AM Igor Stoppa <igor.stoppa@huawei.com> wr=
ote:
>>>=20
>>> I forgot one sentence :-(
>>>=20
>>>>> On 13/11/2018 20:31, Igor Stoppa wrote:
>>>>> On 13/11/2018 19:47, Andy Lutomirski wrote:
>>>>>=20
>>>>> For general rare-writish stuff, I don't think we want IRQs running
>>>>> with them mapped anywhere for write.  For AVC and IMA, I'm less sure.
>>>>=20
>>>> Why would these be less sensitive?
>>>>=20
>>>> But I see a big difference between my initial implementation and this o=
ne.
>>>>=20
>>>> In my case, by using a shared mapping, visible to all cores, freezing
>>>> the core that is performing the write would have exposed the writable
>>>> mapping to a potential attack run from another core.
>>>>=20
>>>> If the mapping is private to the core performing the write, even if it
>>>> is frozen, it's much harder to figure out what it had mapped and where,=

>>>> from another core.
>>>>=20
>>>> To access that mapping, the attack should be performed from the ISR, I
>>>> think.
>>>=20
>>> Unless the secondary mapping is also available to other cores, through
>>> the shared mm_struct ?
>> I don't think this matters much.  The other cores will only be able to
>> use that mapping when they're doing a rare write.
>=20
>=20
> I'm still mulling over this.
> There might be other reasons for replicating the mm_struct.
>=20
> If I understand correctly how the text patching works, it happens sequenti=
ally, because of the text_mutex used by arch_jump_label_transform
>=20
> Which might be fine for this specific case, but I think I shouldn't introd=
uce a global mutex, when it comes to data.
> Most likely, if two or more cores want to perform a write rare operation, t=
here is no correlation between them, they could proceed in parallel. And if t=
here really is, then the user of the API should introduce own locking, for t=
hat specific case.

Text patching uses the same VA for different physical addresses, so it need a=
 mutex to avoid conflicts. I think that, for rare writes, you should just ma=
p each rare-writable address at a *different* VA.  You=E2=80=99ll still need=
 a mutex (mmap_sem) to synchronize allocation and freeing of rare-writable r=
anges, but that shouldn=E2=80=99t have much contention.

>=20
> A bit unrelated question, related to text patching: I see that each patchi=
ng operation is validated, but wouldn't it be more robust to first validate =
 all of then, and only after they are all found to be compliant, to proceed w=
ith the actual modifications?
>=20
> And about the actual implementation of the write rare for the statically a=
llocated variables, is it expected that I use Nadav's function?
> Or that I refactor the code?

I would either refactor it or create a new function to handle the write. The=
 main thing that Nadav is adding that I think you=E2=80=99ll want to use is t=
he infrastructure for temporarily switching mms from a non-kernel-thread con=
text.

>=20
> The name, referring to text would definitely not be ok for data.
> And I would have to also generalize it, to deal with larger amounts of dat=
a.
>=20
> I would find it easier, as first cut, to replicate its behavior and refact=
or only later, once it has stabilized and possibly Nadav's patches have been=
 acked.
>=20

Sounds reasonable. You=E2=80=99ll still want Nadav=E2=80=99s code for settin=
g up the mm in the first place, though.

> --
> igor
