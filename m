Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50557C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F9E22513
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNvAvqYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F9E22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeKBIjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:39:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45581 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeKBIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:39:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id d135so272564qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCsOkoK9O1mFqWcI9m6G2BHQPpgSD/MSas0vVvPAEL0=;
        b=tNvAvqYFFkAUQWQ2jC3PuyXWoUDFFNsPYwF18tP6uT8vt/udSAwpJWspX20YjCU5dg
         kat++mAirNzZvNBknEDZ1/lcZdGt+y+xiRbzstioEry+q7hLDuqzMhcOS9szsczk/x3n
         o3j2cHCYXhzDX77NolKe5fqIG0BWl/dPuRrWqZinZ9Bsxo+2U4z4TlIdc7qm3wf1MWxO
         uKQRnh9tUzgz5VlNIoC5nCNI03jPASSbxGu2IiHp8i5QN/gPLcEDzFpVKfekZd2rP6oy
         gaCLJy9Rsap+Qp5SSC2O6LHWVeggP5VOwfTfH6AH2gmbas0RG7U2SVanI5M3QDchBqgB
         C3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCsOkoK9O1mFqWcI9m6G2BHQPpgSD/MSas0vVvPAEL0=;
        b=ppadvjlpUNqaQx4dlUBrY1i13d6zaWj4anNpJAjMyizMO2KEQT4ZRXr+4PPQBbtlSF
         f5hiCqogRf1B4uf51LxsEklzkBmWnDkNZaTSgdiyATXj6aMsF3aAjlmefNTDbaMJcDol
         /43qbZX8ZBnP6tbqZOQMxbksgjKkxnYV40gjmrqvN1gRgeCF8tHPUKYoI+NOodpna/J3
         KDObKUuOVDCQQajkYijJQfHVXvtgi7L8HnDDlfmsevgMfdG+JODxQWqLxgdVsWTesNmt
         +aOfhNrkmYTyfLJ4/v3qdqjMCUM+TQagQ6okvX/N8M7sDhdmP2UpZ778ieP2860ft77s
         jShg==
X-Gm-Message-State: AGRZ1gIysV55RpdRO9VOvkKyJ8OWdlEQMwINTA5lSL9trEmA570DPowa
        16vgChuy+88ciBum8TYzQgFKbdklsPdXYPzVb4QTdGwHjwc=
X-Google-Smtp-Source: AJdET5fQlbBTUCnTxUKy225Ry1u6UEXu6atOtK7yCmgbVOghlxvCBd3+SIQ42g4xXrmiqhpACu0RCMX9JBVBfH7fJ3E=
X-Received: by 2002:a37:12a1:: with SMTP id 33mr8133358qks.189.1541115238356;
 Thu, 01 Nov 2018 16:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
In-Reply-To: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 1 Nov 2018 16:33:47 -0700
Message-ID: <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
Subject: Re: [diamon-discuss] [RELEASE] LTTng-modules 2.9.11, 2.10.8,
 2.11.0-rc2 (Linux kernel tracer)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:56 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hi,
>
> This is a set of bugfix releases of the LTTng modules kernel tracer.
> It covers the three currently active lttng-modules branches: the
> 2.9 and 2.10 stable branches, as well as the 2.11 branch in release
> candidate cycle.
>
> Those releases add support for kernel 4.19.
>
> One important improvement is to prevent allocation of buffers larger
> than the available memory, which can cause the OOM killer to trigger.
> Even if the OOM killer end up having to trigger, the current OOM kill
> target is set to the current thread while allocating buffers.

This is interesting. Me and Steve were looking at exactly this issue
with the ftrace ring buffer a few months ago. Turns out that even
setting the OOM kill target may not be enough to prevent all OOMs. I
don't remember the reason why not, I'll have to dig out those threads
but that's what the -mm folks said at the time. I did remember vaguely
that I tested it and the kill target doesn't always get killed.. its
possible that something *other* parallel allocation can be victimized
AFAIR, even though the culprit is the kill target.

 - Joel
