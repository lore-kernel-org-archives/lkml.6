Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12A2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A290221871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545141123;
	bh=WqWLrpE8VoNzWAHb/VyKZRbfjGVdFK31ehgBqercEAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dfv/swiUWOWIoGVmuEt20s9Jq4O7mNfarWI8ZAIFYHBln7Co0axj8tpHfzFLZfm/5
	 fDte5LO4D/BPXZ4R67tFW26kbqALLDup0xQAx//fsx8JZ6VWmsFu8ZdGRj6N14QmQO
	 Ur4KKzzi39kBjDgG0b0OhBIoswWrijWP5hnHESOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeLRNwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:52:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51490 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeLRNv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:51:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2685413wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=piICW2MK9zNucBsn8z1v8+n7fIciN3iNTbfVbDAomXY=;
        b=VvZ7KpvyvkMFZx+DXgjyRXxZPHYxYcnsTftu2BLtqZgc23F5DS8Fk+CP8W7a5fKejA
         jWdrtr9RntnZ2EE8UzDKc6tnneNq6V8VpBgnZwtiB5OdCM+HR97K7N+PtLUcCCtMgib0
         1nNzGXunoHmQqGTb+EHJWtkpCjDgMF8SAxlPM89zf1lria4q2DsbSWNt9p6j60gyX0Jw
         dV5Lk/x1DpqsG+AAHXOcxAdOf2K/Dg0jUtOJ3f8cGehI8d315Y44o7hFNTWiZf2mHbEa
         i8ZtJISOixK8cA37ZVhta4sUQ2t3812Wk2dovmlSGF9oi+mxZTbrR+yZn8uPF7wyIA5k
         7A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=piICW2MK9zNucBsn8z1v8+n7fIciN3iNTbfVbDAomXY=;
        b=hCioRlg98XZeiL3hyRpmcyUah/JJGPb2b05mDlfI1xMOL+3cN2Pxv+A+nHodfvMFa9
         a4MneCtbAQJAFG8M4q1kR3XFsRyZ1pz5LDj8EFkHJ6ImRvfLrjUC9ivjNCbW8lxz6Pip
         /ef+xXW85cB49Ek6wbcF7eeYzgDcKaNSYV5cNhmoD/db8DFnb0C4hMy6vERbvxAlWq1N
         OyPLgP8E4j9QyvJqZ3oBaO1EyAI31ZHkDVTBII8/IbVJOzbGexe1floXvX84sHOKRNNc
         7sVivGCJf2m0lF7BH+qGjJYEfSytf78DN8MCoc6Flnat+H7cE12QozZaCTcPBHFgqoiG
         N1dQ==
X-Gm-Message-State: AA+aEWZ4tksC8h/2pQ1cGC7wBvei1l/o+GXZ54hEff1OXlsAONet1a9D
        P9vqo6iVhIsw/CRhTQ7cPUo=
X-Google-Smtp-Source: AFSGD/Wkz0WnrphJpuLMYJvewl+z94d4IkqjTN1rjRH5e2FDQZm/enwLEefOswR7+y24ZzyEL/mtcw==
X-Received: by 2002:a1c:3905:: with SMTP id g5mr3238844wma.30.1545141116224;
        Tue, 18 Dec 2018 05:51:56 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w6sm2122977wme.46.2018.12.18.05.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:51:55 -0800 (PST)
Date:   Tue, 18 Dec 2018 14:51:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        yang.shi@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        sergey.senozhatsky.work@gmail.com, dima@arista.com, bp@alien8.de
Subject: Re: [PATCH v2] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181218135153.GA101957@gmail.com>
References: <1544738377-3848-1-git-send-email-longman@redhat.com>
 <20181217181712.GA5114@gmail.com>
 <CAHk-=wjhqBYmzOyg7LPjvZhoXr3Tr+k9+caG2ScdCtZeO6oJcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhqBYmzOyg7LPjvZhoXr3Tr+k9+caG2ScdCtZeO6oJcQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Dec 17, 2018 at 10:17 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > We should rename printk() to syslog() or so, and rename early_printk() to
> > printk(), and be done with this.
> 
> No.
> 
> As already pointed out, the syslog part isn't the issue. The printing
> part is the issue.

Indeed - I fired a shot fired in the wrong direction ...

> So thinking that early_printk is any better is just puting your head in 
> the sand.

... at my own feet. ;-) Apologies to the syslog folks!

early_printk should still in principle be more robust: it tries to use as 
little (no) locking as possible, and definitely tries to do no 
allocations. It doesn't use syslog, nor any console locking, nor any 
regular console drivers.

Which results in usability trade-offs: trashed screen output, mangled 
lines. It's a superior debug facility when debugging particularly hairy 
low level code - which most of the kernel isn't where it turns into an 
inferior debugging method.

I thing a good solution would be PeterZ's force_early_printk boot knob, 
for those low level folks who absolutely want to rely on printk always 
working in some fashion.

( I think it might even be possible to add a non-locked feature to 
  early-printk that actually adds the messages to the syslog ring-buffer 
  - without any notification/wakeup/serialization features. 'dmesg' is 
  handy and its lack is the primary usability disadvantage of 
  earlyprintk. )

Thanks,

	Ingo
