Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D78AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4089B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkQTKI1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4089B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJ3R56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:57:58 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42461 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeJ3R55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:57:57 -0400
Received: by mail-vk1-f196.google.com with SMTP id m199-v6so2796404vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d3YLst5mplhWMnLhgzmmxsCqH/L2WlFYlnekXkYUKCI=;
        b=gkQTKI1JZmqDQ4HT9C7xcdjdCWDztG3b1bf2gX2kEXJqM2yLzo2+FjxeiIXzpBHQgJ
         DaPrbe9yxPKfi2dJ+M2qbGdNtXKgKT1WF6tXCViPCO/D8sHXthWmTsXoul8Zy1+3mxxn
         gUGXTma+NUMSayOMLUJ0m87aGwYu/CHjDzaLVk3QmJnHc0FPq75/3Z3j6Df7UqFcIPDY
         7UNoyXWoqjpkdbvVLBWcjia6ZCKeiz90KKvcO8MNyII/udoSXPNvWfbNqGHMrlFfOeBx
         os6RpzYiMKleYEXF+UcNjzd1FdnvlMtSNluTvrBd0mosGL2iWVwz2AxZHrsgW7cjx/j3
         vBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d3YLst5mplhWMnLhgzmmxsCqH/L2WlFYlnekXkYUKCI=;
        b=Xf22AOXWlST39IMaF90k3aMF6K36rbJjR8uX4vAa2Do3MNzgiA3q23KTyEOvJCt5BD
         MFHHrR6k67PhPXebyAKtUT5rox+jBi+tNBEzBgVeIstcRD3OY2tgVG3q+4B44qfNdxUa
         +WXN0pMwbkSL797J8GYt2FtGDL4G1bLW7LTsKXmu9cbWtFyivof+aoGj0nd3oAm0YyYu
         JrVoGCY3XsF6G6p588JTQog9xg91SKPViBL8xt3XdY+UfGvoDxsLeE/277YCdOkThy9l
         k99C8qE6SVmGf3W1io3V/Q++B+PuqtFLJKzG+S+hi+AAXQiALjSykncmrp+FjwCFi4iH
         8kTQ==
X-Gm-Message-State: AGRZ1gIpaklMxa+hSkD7qP5fbZ8mNl7sx/ZvlZlGyBuiA1/aFfOE6hky
        HpOtipxkJpPU0VGlJ+uCVi36h9rp6B1s7R1n32foLSjenipSZA==
X-Google-Smtp-Source: AJdET5eIfKVty/+BfWES2N21/EpxLQL7YdHbeeFbpMraM/q7oe6eRxuHSFcsaHf/FLOKQ7d4aeaUeMEMgzu8kpmxfzw=
X-Received: by 2002:a1f:1144:: with SMTP id 65mr536268vkr.54.1540890321836;
 Tue, 30 Oct 2018 02:05:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f492:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 02:05:20
 -0700 (PDT)
In-Reply-To: <20181030050012.u43lcvydy6nom3ul@yavin>
References: <20181029221037.87724-1-dancol@google.com> <20181030050012.u43lcvydy6nom3ul@yavin>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 30 Oct 2018 09:05:20 +0000
Message-ID: <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 5:00 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-10-29, Daniel Colascione <dancol@google.com> wrote:
>> Add a simple proc-based kill interface. To use /proc/pid/kill, just
>> write the signal number in base-10 ASCII to the kill file of the
>> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
>>
>> Semantically, /proc/pid/kill works like kill(2), except that the
>> process ID comes from the proc filesystem context instead of from an
>> explicit system call parameter. This way, it's possible to avoid races
>> between inspecting some aspect of a process and that process's PID
>> being reused for some other process.
>
> (Aside from any UX concerns other folks might have.)
>
> I think it would be a good idea to (at least temporarily) restrict this
> so that only processes that are in the same PID namespace as the /proc
> being resolved through may use this interface. Otherwise you might have
> cases where partial container breakouts can start sending signals to
> PIDs they wouldn't normally be able to address.

That's a good idea.

>> With /proc/pid/kill, it's possible to write a proper race-free and
>> safe pkill(1). An approximation follows. A real program might use
>> openat(2), having opened a process's /proc/pid directory explicitly,
>> with the directory file descriptor serving as a sort of "process
>> handle".
>
> I do like the idea of holding a dirfd to /proc/$pid to address
> processes, and it something I considered doing in runc.

I did think about explicit system calls to create userspace struct pid
references, independent of proc --- something like open_process(int
pid). But when we already have procfs, which is already a way of
getting struct pid references, why add a new interface? Granted, not
everyone has /proc mounted. One idea add a special PROCFS_FD constant
(say, -2) that you would supply to openat(2) as dirfd. When openat(2)
saw PROCFS_FD, it'd interpret the open as relative to procfs whether
or not /proc were actually mounted anywhere. This facility would let
you open a "proc" file from anywhere even without the right mounts set
up.

> (Unfortunately
> there are lots of things that make it a bit difficult to use /proc/$pid
> exclusively for introspection of a process -- especially in the context
> of containers.)

Tons of things already break without a working /proc. What do you have in mind?
