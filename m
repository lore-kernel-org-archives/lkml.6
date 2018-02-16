Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3785732-1518770962-2-15035688713832007568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518770961; b=F1iH+TsIBlfn6CkTXMb1zVyLVQ+mYfpfdz/8iAHRnMXcp6S
    Ldec9azY7uQ4jEBNWaeTwkwFrkidJSmE7KzWIoWQtV77UM9Ax8vxzepsWGCzGp05
    UwrZS2NA6eWbL3wz0Y8ftsJ+QjevYO+6M0AAU2kfBg5kHCsvMT+Lcq2sU7bwFfUu
    sIbLOIuSIbexVz/8zeVTNJ473TesoqOX49ljrWLkNPkmTAO6JD4oN76AUSyzuGDA
    zfgjOFVzeUcVXnEbCOT2RbUon5d6/ZCxH58FRjeT9h6eUyD9j2yNa6GLVkxNFIuM
    Vl0hBuPhTH/JC4JytpHOzx3dHc8JeaDJZrgxGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518770961; bh=c
    O+BwVeNJHcC6YfqFmdHVhjcflzH/8au9uOACG8bans=; b=Ni/scmKcvM3+K4DD2
    BA6gxJf2fEDy9hWMvgJoOfU4GcRrUyHLOcWuC0zzTHkr+6QaM17FhPeXZNIL0IQ5
    z/IAJlI76SC3BuwykGvaGDv49bTMlb9/kef0BL9hORGOpAxFLFcB2N+QGAHZhXWH
    w9IlqjOBTqQTWKtKmqt69MVGelgF9DVgZ4Xl/RyPN+qDIzBhVOqYhb47ZhgawE8p
    bvXI0cv/JDclZhdg+YYzlqpPFZTFYcwKdKu7sdUZ/W29Nw3GtWfup4s1rLd5BOEv
    MgTt6Y+HMec4h424dmwPwuzEFLRoDOOABsG/vE0OGj2/uUcc4C/Qno5oa8rapFd0
    LMCWg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=sYZv9qQh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ciiXiBpR;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=sYZv9qQh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ciiXiBpR;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225gzVcgXS/rxBCNWIr+pJZ14VHXI+JOu+mKKpI3kbQpu0kvG5kBW3zFfNIs4o6nq8t8X8A+X9GJ3wpAHM0iVoc=
MIME-Version: 1.0
In-Reply-To: <20180216084715.14969-1-maco@android.com>
References: <20180216084715.14969-1-maco@android.com>
From: Martijn Coenen <maco@android.com>
Date: Fri, 16 Feb 2018 09:49:12 +0100
Message-ID: <CAB0TPYEV0OOcntsh920c-4oiQxw41+znvJ0=por7Z6TTg_Engw@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: synchronize_rcu() when using POLLFREE.
To: Greg KH <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>,
 Todd Kjos <tkjos@google.com>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Eric Biggers <ebiggers@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Martijn Coenen <maco@google.com>, Martijn Coenen <maco@android.com>,
 Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

This is for 4.14 LTS and 4.16.

Thanks,
Martijn

On Fri, Feb 16, 2018 at 9:47 AM, Martijn Coenen <maco@android.com> wrote:
> To prevent races with ep_remove_waitqueue() removing the
> waitqueue at the same time.
>
> Reported-by: syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/android/binder.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 15e3d3c2260d..359220f87e1d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4376,6 +4376,15 @@ static int binder_thread_release(struct binder_proc *proc,
>
>         binder_inner_proc_unlock(thread->proc);
>
> +       /*
> +        * This is needed to avoid races between wake_up_poll() above and
> +        * and ep_remove_waitqueue() called for other reasons (eg the epoll file
> +        * descriptor being closed); ep_remove_waitqueue() holds an RCU read
> +        * lock, so we can be sure it's done after calling synchronize_rcu().
> +        */
> +       if (thread->looper & BINDER_LOOPER_STATE_POLL)
> +               synchronize_rcu();
> +
>         if (send_reply)
>                 binder_send_failed_reply(send_reply, BR_DEAD_REPLY);
>         binder_release_work(proc, &thread->todo);
> --
> 2.16.1.291.g4437f3f132-goog
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
