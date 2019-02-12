Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E262206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPdl+JTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBLAhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:37:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39213 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfBLAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:37:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id f16so1125370wmh.4;
        Mon, 11 Feb 2019 16:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UYvbv4YryySKlDRppCsjYcorfRb6U7/oOzwS5dfq0Qc=;
        b=qPdl+JTk8Toj2frEOQfqrNevt6tq9hgDSFZL1sviqBoN9pdvYKYetHASLW7ClE4uJt
         cTOKGCv5RsOvagu2Wci9XS6iKlKsMSErBcyCzP3wDBPbM3U6F8+ftcQZawcHp504sebV
         LPjj1jNHBrDcPixk7ygX6gkaZi7tgt/r2sK4KpLF9ByJFRKDNsz1xfNdHJeuLdZ9MaFd
         qulltJV7M7yZCQIUlTvHiSNeV6w1o/OXpaYnFshV3GFMKUxjLSHZnSgv+nTKqwW8uRkL
         dxeJSKAZ1EMKQhl+pt5BZhEsvwx/j8hXVvjuDqRBPqLN/n0LVZjOuajB9BVXqf4nHxEJ
         i9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UYvbv4YryySKlDRppCsjYcorfRb6U7/oOzwS5dfq0Qc=;
        b=JZNuuf6tsPSQtf3m5TweCTWiFSrv21S7KTHfvxmz8UFNMX6O98sBU6iePigoBd26MN
         cJkBqeU1SoOMPMlxWbjNBBlILCqjy+8Y3ST2BDPdenF8BY0nAx3lddSj31Ch6SOT4v+O
         lVm+dI9QEpOyq1d+UGWMaLBIJBwArqtjneifQ80vPagZeST24n2bSpFunm6J8feDbRkL
         1sGrMnK7yJJ3AVTdVOyXc7o2O/vnU5S7rBVvGi4Rz2HIahTqYsZBevu6M5mqVm40pNst
         rFdH2OM8Mg3BRpbffaFS/4Gb52UNINTjD/c0K7PSHBxs9WT92ZO4UTrxPNl4UCfjwMyt
         RGEw==
X-Gm-Message-State: AHQUAubNw3IT7wExUQtuTdQdIiHMarr+igUmZHzpIvzplD1y0v0wAV1t
        Kf7eLQhx7opcYZDG5WyOt/RpMv7Y+7I=
X-Google-Smtp-Source: AHgI3IagzJXiPV1FFoqDpoUyz3igG3tVJCjdwtXPdbLLTECiHy4brKnj03aSzFJGxzfyRrGapM3OUw==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr629238wma.90.1549931829496;
        Mon, 11 Feb 2019 16:37:09 -0800 (PST)
Received: from [172.20.11.181] (bba134276.alshamil.net.ae. [217.165.113.164])
        by smtp.gmail.com with ESMTPSA id v6sm25543197wrd.88.2019.02.11.16.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 16:37:08 -0800 (PST)
Subject: Re: [RFC PATCH v4 00/12] hardening: statically allocated protected
 memory
To:     Kees Cook <keescook@chromium.org>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
 <CAGXu5j+n3ky2dOe4F+VyneQsM4VJbGPUw+DO55NkxxPhKzKHag@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <25bf3c63-c54c-f7ea-bec1-996a2c05d997@gmail.com>
Date:   Tue, 12 Feb 2019 02:37:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+n3ky2dOe4F+VyneQsM4VJbGPUw+DO55NkxxPhKzKHag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2019 02:09, Kees Cook wrote:
> On Mon, Feb 11, 2019 at 3:28 PM Igor Stoppa <igor.stoppa@gmail.com> wrote:

[...]

>> Patch-set implementing write-rare memory protection for statically
>> allocated data.
> 
> It seems like this could be expanded in the future to cover dynamic
> memory too (i.e. just a separate base range in the mm).

Indeed. And part of the code refactoring is also geared in that 
direction. I am working on that part, but it was agreed that I would 
first provide this subset of features covering statically allocated 
memory. So I'm sticking to the plan. But this is roughly 1/3 of the 
basic infra I have in mind.

>> Its purpose is to keep write protected the kernel data which is seldom
>> modified, especially if altering it can be exploited during an attack.
>>
>> There is no read overhead, however writing requires special operations that
>> are probably unsuitable for often-changing data.
>> The use is opt-in, by applying the modifier __wr_after_init to a variable
>> declaration.
>>
>> As the name implies, the write protection kicks in only after init() is
>> completed; before that moment, the data is modifiable in the usual way.
>>
>> Current Limitations:
>> * supports only data which is allocated statically, at build time.
>> * supports only x86_64 and arm64;other architectures need to provide own
>>    backend
> 
> It looked like only the memset() needed architecture support. Is there
> a reason for not being able to implement memset() in terms of an
> inefficient put_user() loop instead? That would eliminate the need for
> per-arch support, yes?

So far, yes, however from previous discussion about power arch, I 
understood this implementation would not be so easy to adapt.
Lacking other examples where the extra mapping could be used, I did not 
want to add code without a use case.

Probably both arm and x86 32 bit could do, but I would like to first get 
to the bitter end with memory protection (the other 2 thirds).

Mostly, I hated having just one arch and I also really wanted to have arm64.

But eventually, yes, a generic put_user() loop could do, provided that 
there are other arch where the extra mapping to user space would be a 
good way to limit write access. This last part is what I'm not sure of.

>> - I've added a simple example: the protection of ima_policy_flags
> 
> You'd also looked at SELinux too, yes? What other things could be
> targeted for protection? (It seems we can't yet protect page tables
> themselves with this...)

Yes, I have. See the "1/3" explanation above. I'm also trying to get 
away with as small example as possible, to get the basic infra merged.
SELinux is not going to be a small patch set. I'd rather move to it once 
at least some of the framework is merged. It might be a good use case 
for dynamic allocation, if I do not find something smaller.
But for static write rare, going after IMA was easier, and it is still a 
good target for protection, imho, as flipping this variable should be 
sufficient for turning IMA off.

For the page tables, I have in mind a little bit different approach, 
that I hope to explain better once I get to do the dynamic allocation.

>> - the x86_64 user space address range is double the size of the kernel
>>    address space, so it's possible to randomize the beginning of the
>>    mapping of the kernel address space, but on arm64 they have the same
>>    size, so it's not possible to do the same
> 
> Only the wr_rare section needs mapping, though, yes?

Yup, however, once more, I'm not so keen to do what seems as premature 
optimization, before I have addressed the framework in its entirety, as 
the dynamic allocation will need similar treatment.

>> - I'm not sure if it's correct, since it doesn't seem to be that common in
>>    kernel sources, but instead of using #defines for overriding default
>>    function calls, I'm using "weak" for the default functions.
> 
> The tradition is to use #defines for easier readability, but "weak"
> continues to be a thing. *shrug*

Yes, I wasn't so sure about it, but I kinda liked the fact that, by 
using "weak", the arch header becomes optional, unless one has to 
redefine the struct wr_state.

> This will be a nice addition to protect more of the kernel's static
> data from write-what-where attacks. :)

I hope so :-)

--
thanks, igor
