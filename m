Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84008C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3633825606
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sNJLmh01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3633825606
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbeGBTCo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:02:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53753 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbeGBTCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:02:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so10135337wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vVgqrqj3WRFTqYm+MpnoZPNEqzTaFl3kRh36rkTTJ6I=;
        b=sNJLmh01oBdiEEcxl8pNMjtxoLVa0a3bDYVa4dzDaq8YtgF1VIAPo7nTPlERezqADk
         wuJ2gB1bac+9FVor4CwkWnOA4l7wCL6EKqxtrT8Xyl5d89mUhOZFjCdusmH/sfFOPmlS
         BbCPGXx5/Exl7ZZhsbIjzp60/RgLxmeXyFPYQN1pelF/MNPrMOvLvj43+gAvywmilooU
         hVQZhQSwsZDreoPeYgeZuoe5TMAQuI/wET+eljbLLTv3DPsFKCkwLCPq0536cd92NKMp
         HXPRqmj2RKV4WDyZzdoI0xxdTxoyyylWOFGmwh1is5prWyl2CMmnUWZ1VF7gC18ZZjza
         SYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vVgqrqj3WRFTqYm+MpnoZPNEqzTaFl3kRh36rkTTJ6I=;
        b=dv50zo3ocVMzbLwcofOUl3pTsfeVkfROpN6fDke7ZvUjSwwFQys0zNw9MCB91Coy3K
         WRUGT3JNzdIOlB4r8w9dZ78/6d+HBkz/LEGTK3OYZfANeTj9jnH8ntbZqWCxvLuczvCf
         YXP9KNfIuYSeUfAFDJUvAcENphK7mu9FbqgUxrPPv9IPGqwdghlhfznOM5ezcIwS/Qy7
         xxP6xeuDOrjwoDGzh6W0eWc2FIcNM98R200BbnSm4ka485G5n05t+uzLBrMBJDJ0AuRu
         iwYhYu/2vLHlFvWMtCAWs2fiNFkGpst1EdyvB7XUEGxJeSurjC01dnSnydhHFqpwCT/z
         eyRw==
X-Gm-Message-State: APt69E3/wKUsfSVLjanXSlpageyO0t5kVVidvevdIrIAfiNVpGtKdWI8
        wlX+TdtiTm876seq0TicjJwy9d0XldayxsBFThGo1Q==
X-Google-Smtp-Source: AAOMgpcWh0js5jWN+yDYgufongg4cXQhBzVWc7prRmuTAVZUXkMXakNPBqD/RQySw38HSBVzx6aTRwUWvs6UssPUG6A=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr6872531wmd.46.1530558159637;
 Mon, 02 Jul 2018 12:02:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 12:02:18 -0700 (PDT)
In-Reply-To: <84003252.10754.1530558015813.JavaMail.zimbra@efficios.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com>
 <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com>
 <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com>
 <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com>
 <CALCETrXqjrCoHX1KyL0iKGBaAZSGJb1cVdNN1gNigJ8DW9LF8w@mail.gmail.com>
 <1527399163.10673.1530541966296.JavaMail.zimbra@efficios.com>
 <CALCETrVeu_V-3K8OfKv9QixrWBJs+q866yb=e96sC76SS4hxYg@mail.gmail.com> <84003252.10754.1530558015813.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 2 Jul 2018 12:02:18 -0700
Message-ID: <CALCETrVMhU8SrZBXOXxJerrZpQ71A_f_cRBCU=Lmj_KPV0+rRA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 12:00 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- On Jul 2, 2018, at 1:11 PM, Andy Lutomirski luto@amacapital.net wrote:
>>
>> But I think that the limited solution of changing
>> instruction_pointer_set() really is a sufficient
>> architecture-dependent change to fully solve your problem.
>
> So let me recap with the changes I gather for 4.18 and 4.19:
>
> 4.18:
>
> * Change struct rseq_cs field types from LINUX_FIELD_u32_u64() to __u64 in
>   uapi/linux/rseq.h,
> * Compare rseq->rseq_cs->abort_ip with TASK_SIZE before using it. Kill offending
>   process if its value is over TASK_SIZE,
> * Explicitly check that padding of rseq->rseq_cs is zero on 32-bit kernels
>   (#ifndef __LP64__).
>
> 4.19:
>
> * Introduce instruction_pointer_set() with input validation, use it when setting
>   IP to abort_ip in rseq. This replaces the comparison of abort_ip with TASK_SIZE.
>
> Is that consistent with what you have in mind ?
>

Works for me.  Linus, any objection?
