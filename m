Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2020284-1526362974-2-7186867230355671540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526362974; b=HjD9WrcEheMt5jfnXTND5QcVF/d8HFrEUufGkOcjwWnzX9TreO
    Nzod7XJs3ou61DksVu+Gs96I53xUGMEo4Wozd2dW1kO1iThjdVPyXLBxuxTCAZSO
    ElqGYUz/sNGERGR9FNe24gWSCS9IZyRkjlvVmUX5Pl37Y7YtVHBvsmoCwjAbJnaH
    YRYcHtDCEV3RSc/F9riVQXFjnYWHNA2XaReQigaqNK/D8XbVAwg2rhA56NUN6eIh
    1RydNIgC8ZQswlT02ARaCEEKjJ84d46YTqDs3zNgG9Pw5wInMj3Rd6DWPO6p1stF
    dG+NuXRuZkVUvr9U6ciiL+FSEikxT3YKzFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526362974; bh=QtuZf9Trf8sIY9pNuGkWJDQGmx/xDT9SXMg0OLNE5B
    I=; b=Rb+h9LHV4dZszu0bQVwaT6FXXx0UT7V6Ww3j3x049WKJtxlohvkLRy2emX
    zdrEqbNuJcgBExFtongZ/hYq/fKGo4c/EfIpwcTiaO9BcLmlpHO2ERZxHLELRUVp
    mpYJp5sGQxbjR+G6MyvWe7hCizzIE0ZU7e+wDJuoUTjvz5YbKIydw7CLprs7As2u
    7alesTjP/oS2HXL+hL0dQ7gZcTWrCh8h7NVK9xpABUImppi3xGVbdZLP4KWwkUTd
    HeYIywEaApaYSnNa2GTXinTBcGMYEFZBwZgyPAlZq1+GP68gVzJ9+wLv1G6OQ+Ke
    SFQEhBN4vQkn6vX5cpkzuKIc+VDA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=f3ELQhp8 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=OCir2X4R;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=f3ELQhp8 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=OCir2X4R;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE2VL+sFyLS5K58WZANeN7lPhd6HLSzAsEm7zGQvHzNn3AYqFCIgGqP/VdhoLnw26uilM+fpF5KUn96sWoLZVFYg8QDtFEs+O9+x4RRPqOSKbWzqYzab
    +zCdmLD5wYUfEZdaB7jaY1+Cv2GwbbvF7CKMnykfKkIyrvxbh9Uera0swH7NJyB5nT2qSWvFFzxwzyOXRjL9F1042bofbOK3Mw+OL8YuO7a13R4gmVxRX+Ub
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=r3nPLSDzUwAA:10 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=gu6fZOg2AAAA:8
    a=JrOH7jGdX0cHPOtQ2lUA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeEOFmw (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 01:42:52 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35547 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeEOFmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 01:42:51 -0400
X-Google-Smtp-Source: AB8JxZrA6XB8zH5ncD+CUukLxB8fL18TTzmATmIqpADSnZSHTuFRNDjdf4Nar7YjKLJTj75MS8lNsUveSiPUGmPm95E=
MIME-Version: 1.0
In-Reply-To: <1526326267-22501-3-git-send-email-longman@redhat.com>
References: <1526326267-22501-1-git-send-email-longman@redhat.com> <1526326267-22501-3-git-send-email-longman@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 May 2018 08:42:50 +0300
Message-ID: <CAOQ4uxiL+x0Q8jgUZFOmrM5yndE0sDRRTSci2B-y5Y-r+QMCxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 10:31 PM, Waiman Long <longman@redhat.com> wrote:
> The percpu_rwsem_release() is called when the ownership of the embedded
> rwsem is to be transferred to another task. The new owner, however, may
> take a while to get the ownership of the lock via percpu_rwsem_acquire().
> During that period, the rwsem is now marked as writer-owned with no
> optimistic spinning.
>

Waiman,

Thanks for the fix. I will test it soon.

For this commit message I suggest that you add parts of the reproducer
found here:
https://marc.info/?l=linux-fsdevel&m=152622016219975&w=2

Thanks,
Amir.

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/percpu-rwsem.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index b1f37a8..dd37102 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -131,16 +131,16 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
>                                         bool read, unsigned long ip)
>  {
>         lock_release(&sem->rw_sem.dep_map, 1, ip);
> -#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>         if (!read)
> -               sem->rw_sem.owner = NULL;
> -#endif
> +               rwsem_set_writer_owned_nospin(&sem->rw_sem);
>  }
>
>  static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
>                                         bool read, unsigned long ip)
>  {
>         lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
> +       if (!read)
> +               rwsem_set_writer_owned(&sem->rw_sem, current);
>  }
>
>  #endif
> --
> 1.8.3.1
>
