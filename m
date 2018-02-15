Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2542822-1518732542-2-8786779950521225538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518732542; b=lOIrU3OOAYA2eEEQX3uvGmfM48sofBK/PfC2qZ7fizOXplQ
    TcF1Ug5jesO4NW9yZnGbjGZqa1c6HBu+Gg+/8VuuXxytEbT21Q9TViR/FmOtNjf2
    jMPTkq5/FxjDi3RSgOnd5kttPrkfkH5Txealwcw7Uxm3+/H45yLwrmsfL+XXQz79
    +2QP4ucJDz5u2L4NZzeJ6Uq4tv5ODAg97sGHDwiJ9IiLTtbKlezg135j3w63I6wb
    AckPWXY35F/PNExSq0AjVggn6ZHiBvMacEzvBKXsmpmsILgKlaac74qDKNVc0h7d
    lUu/QjQrtRjIR8tvhLFqjX45GaxoCsTjjoYQclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518732542; bh=wGPz4ZrCbrlN7vogzzSITwzcw1QdFbp902N+WS
    zp0xk=; b=s219QTmvOC6nqcJl25vrLY8oRVXwWypdExQF2uQnht2lFhDmN7g+Oi
    /p4zyzqWTxEFXOuEtzGiMmc6+8qDD3Hzti6qqT4q2x/qRqGGnHmfQfpXbmazuWUm
    2fqoSYRAmpfKQdvwYVo2geAkl7mgDHWUljGQyGjVei5lBo047rr3Nupdzyz4FGqZ
    0VJPeUjYUR06lFvbbeSHddG2r7SD4JBePGrQc4RIZKEPCE12U0Nzlgsh8PQBncaY
    fO9r4ua88SyIiM0lX9rzLezhB04BMFXA0xaoHbX9wrkgKax75Cmj4wFKfLk19vfD
    zwfHLl9fsgRnM1Fsn3sNCOeOklknXWgA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=sLiCkLya x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bu+Qyej6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=sLiCkLya x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bu+Qyej6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163648AbeBOWIq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 17:08:46 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35393 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163600AbeBOWIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 17:08:42 -0500
X-Google-Smtp-Source: AH8x226Cw+E0AHGM5ssNRB+GEC3+Wlq7MpY+6PM8jOpBgGlgAtbOvx5uNae/SHtUaqdYJPh0IhlMv0INUerfemCI2R4=
MIME-Version: 1.0
In-Reply-To: <CA+55aFz7g4wuwgc7hNFfYf+OqgPax3-F=yz8Xar7iemTin=FEg@mail.gmail.com>
References: <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
 <20180215195209.15299-1-linux@rasmusvillemoes.dk> <CA+55aFzYyWLiWb_O3KFZiJAZPzoopaa2cuj8ByWDi4ERjg0ZHw@mail.gmail.com>
 <CAPcyv4hFn7jXLY43xTVPgzXVjECkpqhuj24mn5XXAyjiJq3Hyg@mail.gmail.com> <CA+55aFz7g4wuwgc7hNFfYf+OqgPax3-F=yz8Xar7iemTin=FEg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Feb 2018 14:08:41 -0800
Message-ID: <CAPcyv4iDDBWD09b5Pm5=D8+EKZQpMfK4zs1dGfptf5Sf8sSdJA@mail.gmail.com>
Subject: Re: [PATCH] linux/nospec.h: allow index argument to have
 const-qualified type
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 2:03 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Feb 15, 2018 at 1:56 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> So I don't mind removing it, but I don't think it is garbage. It's
>> there purely as a notification to the odd kernel developer that wants
>> to pass "insane" index values,
>
> But the thing is, the "index" value isn't even kernel-supplied.
>
> Here's a test:  run a 32-bit kernel, and then do an ioctl() or
> something with a negative fd.
>
> What I think will happen is:
>
>  - the negative fd will be seen as a big 'unsigned int' here:
>
>         fcheck_files(struct files_struct *files, unsigned int fd)
>
> which then does
>
>                 fd = array_index_nospec(fd, fdt->max_fds);
>
> and that existing *STUPID* and *WRONG* WARN_ON() will trigger.
>
> Sure, you can't trigger it on 64-bit kernels because there the
> "unsigned int" will be small compared to LONG_MAX, but..
>
> It is simply is *wrong* to check the "index".  It really fundamentally
> is complete garbage.
>
> Because the whole - and ONLY - *point* of this is that you have an
> untrusted index. So checking it and giving a warning when it's out of
> range is pure garbage.
>
> Really. That warning must go away. Stop arguing for it, it's stupid and wrong.

True, I had been myopically focused on the 64-bit case.

> Checking _size_ is one thing, but honestly, that's questionable too.

Nah, I'm not going to argue for that.
