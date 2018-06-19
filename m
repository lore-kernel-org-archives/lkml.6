Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA556C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61199205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAMFrWHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61199205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937696AbeFSOQG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:16:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38923 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937559AbeFSOQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:16:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so11038500plt.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s/vulpBI71f4u7Y+Rh9ojoULWVwNFK05ZfboatkSWEE=;
        b=GAMFrWHaUkBjI28JAHZOUDoTRLmZBW9RcnmI/Wvrqc772G30kH5R6qRb8D4bsqH6QS
         ZM/eeYYIungycsKzY3lbWdtMTT1DqafTHJaF1C+jRXocYm18DyzeIRnkBDJFnZ+Kz1Cm
         AY4w7PFh//b7k41voUkDISsoypHSP5SLOUXPnXEdkXzyeJBYWpUg2/Wvk8tiO11fgRIB
         ijiYHw6JG0s8F1obKz45r77fO7XsQw6qbCtMWITd5muhUBfSntMcY++C2o6vFo5QT+cy
         9COko93ZqxPfOT3YAUIgkBBxixxut6f1atif7yfFj9m8YEsOR8jCiFFUDf/S7+c+jSC9
         kJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s/vulpBI71f4u7Y+Rh9ojoULWVwNFK05ZfboatkSWEE=;
        b=Yzwba2EBx9wA2LQHfx0xlRc5JzYTExONUcaNQ+yR82MLFRBOHVC8INDjjSpVXFi3ie
         EFPXHlK+Oj1sWi3xn6zNAX9JazItIb4Q4PelqQYmqJu2WQyiNRBF03/1UzElEIV6cUHL
         9n4CUZPKvSgVtdnV4sm/1FjnaZScfKfDkKYBT3ifcWObhCLFD2pdYwJEQVlOoVDTotfU
         8K3BXbOA46DdhMv+HVELNZTKN+qntQikk6/66Lcnuxhj1mTs8Htywbpd5XgF3UkKMEq2
         M4beZnnVPqmAtzuPe922BgxpPvONVmUH3p91orY/oDBoXDvGGzSuwW70QbP+tg3ws9lM
         98JQ==
X-Gm-Message-State: APt69E0ObbZJY9icqleQCPHV55jeOTKfgAB8PcSmL+sxtQAx83Gg8zfm
        pGLRcn4pmTiMA//SqskxrY6DuEdJ+aaNYqzHKlQUOA==
X-Google-Smtp-Source: ADUXVKLryj1ZqjtW0XjmH6g8vS3fad7Ix48/uEluqXkAkerRBO2bSTU852/1VgGlWnr80BVCYAQ8jQnaKo77HHXAls0=
X-Received: by 2002:a17:902:5a4c:: with SMTP id f12-v6mr19353572plm.85.1529417764069;
 Tue, 19 Jun 2018 07:16:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 07:15:42
 -0700 (PDT)
In-Reply-To: <9d0092e6-142a-7168-7b3c-084faa9268d5@i-love.sakura.ne.jp>
References: <001a113ed5540f411c0568cc8418@google.com> <a274f8ff-989a-ccb8-3cc1-78fbdec0604a@I-love.SAKURA.ne.jp>
 <CACT4Y+ZJTHfFOcbReD_nOYxvxaYcD2Sa=VToZL0RWYw1TemrPA@mail.gmail.com> <9d0092e6-142a-7168-7b3c-084faa9268d5@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Jun 2018 16:15:42 +0200
Message-ID: <CACT4Y+b=7Kt5iVj+jMcWwfFGmYQ5D0SpF_iaBK+pjMJLUfKFpw@mail.gmail.com>
Subject: Re: INFO: task hung in __get_super
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 4:10 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/06/19 20:53, Dmitry Vyukov wrote:
>> On Tue, Jun 19, 2018 at 1:44 PM, Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> This bug report is getting no feedback, but I guess that this bug is in
>>> block or mm or locking layer rather than fs layer.
>>>
>>> NMI backtrace for this bug tends to report that sb_bread() from fill_super()
>>>  from mount_bdev() is stalling is the cause of keep holding s_umount_key for
>>> more than 120 seconds. What is strange is that NMI backtrace for this bug tends
>>> to point at rcu_read_lock()/pagecache_get_page()/radix_tree_deref_slot()/
>>> rcu_read_unlock() which is expected not to stall.
>>>
>>> Since CONFIG_RCU_CPU_STALL_TIMEOUT is set to 120 (and actually +5 due to
>>> CONFIG_PROVE_RCU=y) which is longer than CONFIG_DEFAULT_HUNG_TASK_TIMEOUT,
>>> maybe setting CONFIG_RCU_CPU_STALL_TIMEOUT to smaller values (e.g. 25) can
>>> give us some hints...
>>
>> If an rcu stall is the true root cause of this, then I guess would see
>> "rcu stall" bug too. Rcu stall is detected after 120 seconds, but task
>> hang after 120-240 seconds. So rcu stall has much higher chances to be
>> detected. Do you see the corresponding "rcu stall" bug?
>
> RCU stall is detected after 125 seconds due to CONFIG_PROVE_RCU=y
> (e.g. https://syzkaller.appspot.com/bug?id=1fac0fd91219f3f2a03d6fa7deafc95fbed79cc2 ).
>
> I didn't find the corresponding "rcu stall" bug. But it is not required
> that one RCU stall takes longer than 120 seconds.
>
> down(); // Will take 120 seconds due to multiple RCU stalls
>   rcu_read_lock():
>   do_something();
>   rcu_read_unlock(): // Took 30 seconds for unknown reason.
>   rcu_read_lock():
>   do_something();
>   rcu_read_unlock(): // Took 30 seconds for unknown reason.
>   rcu_read_lock():
>   do_something();
>   rcu_read_unlock(): // Took 30 seconds for unknown reason.
>   rcu_read_lock():
>   do_something();
>   rcu_read_unlock(): // Took 30 seconds for unknown reason.
> up();


You think this is another false positive?
Like this one https://github.com/google/syzkaller/issues/516#issuecomment-395685629
?
