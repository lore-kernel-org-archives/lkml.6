Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F75C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 02:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231E4214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 02:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mzZy8OfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231E4214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeIWIja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 04:39:30 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:39376 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeIWIja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 04:39:30 -0400
Received: by mail-yb1-f177.google.com with SMTP id c4-v6so7012394ybl.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 19:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y/Uuk2QZZQ7liiT7pBx6R3/zGxZA503uXFQpdHVURpE=;
        b=mzZy8OfPScaoJwwbVNp7O+1IzVNMGYZXhoilfqPvjN0ZKqfke49UDSyxhTp1sLbIYf
         S/LWz/TXZvYPbVbzImgCHyjFHtt8dgpkxFKySADdKCOgF6dWYRWnuPLD0pys7PVAn+Dd
         ddZdq+e9xEAiuez+EzPWLrqc6HheUWYzfDzks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y/Uuk2QZZQ7liiT7pBx6R3/zGxZA503uXFQpdHVURpE=;
        b=MgM57KkqM0oBnLP5jUW14owViOoRX0KDPSe7ZIH2vNVi5NQnADnGJ9V5lf2QUW9B/S
         aEj4sDmjHGVsCg1Bdf+hcOngQNIhVaqksT8NZCevXqHTtjo11j5+s5TBtk+Tun+PWDLL
         fuLhsSdWkM4SqtJNMlDJs/2bG5IMB7s5ILjzu3CFoDdbgxNxBEjevOC6Sg5e5OdDg1bB
         wnjpkNG6xSWdNzIRpJs+2uGbUPAxkJ2mPYFQT0scLA76E7tD6FIP3KWwGc5tkRF+JdmS
         wgwgfFOJOE25a0Ursp+JR8vCy77locT9t8d7BNEC7y7g47SyPxB+vnq+fWX3/hFx8Xb4
         RE8A==
X-Gm-Message-State: ABuFfoj0qyVBQYh9pkR5RIF7Ysj4SWxoOiQIeWBjGPxMejGRlETbF49q
        ibPjGiS38RgydYPQQSlxd7ycwD0E1OI=
X-Google-Smtp-Source: ACcGV61qm5iBu8nTgaH90wSzzgImbz8FFeVSHcwee3W5GiKlJhTCTt6AUey/dRT8d46KOLia16BP6A==
X-Received: by 2002:a25:ad45:: with SMTP id l5-v6mr1925176ybe.161.1537670621200;
        Sat, 22 Sep 2018 19:43:41 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id o84-v6sm230165ywd.82.2018.09.22.19.43.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 19:43:38 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id y12-v6so3785765ybj.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 19:43:37 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr1965378ybh.209.1537670617592;
 Sat, 22 Sep 2018 19:43:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sat, 22 Sep 2018 19:43:36
 -0700 (PDT)
In-Reply-To: <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com> <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 22 Sep 2018 19:43:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
Message-ID: <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 9:38 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/21/2018 8:02 PM, Kees Cook wrote:
>> On Fri, Sep 21, 2018 at 4:59 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> v4: Finer granularity in the patches and other
>>>     cleanups suggested by Kees Cook.
>>>     Removed dead code created by the removal of SELinux
>>>     credential blob poisoning.
>> Thanks for the splitting, this really does make it easier to review
>> (at least for me). I think this looks really good, though obviously
>> I'd like to refactor it slightly on top of my series. :)
>
> Whichever goes on top is fine with me. What's one
> more patch set merge, after all?
>
>> One additional thought I had was about the blobs allocations: some are
>> separate kmem caches, and some are kmalloc. I'm thinking it might make
>> sense to use separate kmem caches for two reasons:
>
> I had seriously considered doing that. I can't see any reason
> not to. It's something that could be done at any time, and with
> all the other things that had to change it just didn't get in.

Yup; that is an easy future change. Not needed now!

>
>> - they're going to always be the same size and are regularly
>> allocated/freed, so it may offer a performance benefit.
>>
>> - they're explicitly not supposed to be exposed to userspace, so
>> hardened usercopy would protect them if they were not kmalloc()ed.
>>
>> I'm excited about getting this landed!
>
> Soon. Real soon. I hope. I would very much like for
> someone from the SELinux camp to chime in, especially on
> the selinux_is_enabled() removal.

Agreed.

> On a somewhat related note, I will be out for the first three
> weeks of October, returning just in time for the Linux Security
> Summit in Edinburgh. My connectivity will be severely limited.
> I don't expect to accomplish anything while I'm out.

If you're okay with it, I can help with changes while you're out -- I
want to try to rebase it on my tree and see how it looks anyway. :)

-Kees

-- 
Kees Cook
Pixel Security
