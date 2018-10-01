Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73E9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8743520C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8743520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeJAVWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:22:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42395 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbeJAVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:22:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id z8-v6so14189321qto.9;
        Mon, 01 Oct 2018 07:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4QMG1sB8NQlpoY7YveKE8A+ZWPS205GN5CyCDz95rk=;
        b=nAz6lyqP7lwdX66i+nKxga2wRZZU281aSvFM8IFFuLRYHIT3CVIL6M4THGl4LZPiuQ
         8ebUxO6zauQWWEf0oXJ7+Cmcue6d1YzjheLIMDgl12UFkrnzCCz8E14ZNX2paD7vAuKF
         hHPTgam9252UZhF9pvfohCy0BYxJCdgLp5xcmn2Iy3rEiuxJEYhae4qu8lLmHSPj5lBo
         9JmuTw6BYNxLiF/N+hwZlXR374nGdM6gZIEsUIhdwPzirojM0ttQFlIFLV3uNcMItN8N
         kjbRaJT8KgeoNCncZlWdYuouYmlboxryz+HHfWTLz/KmsSgBcsIonQ5TmBQYcucu66M+
         fTeQ==
X-Gm-Message-State: ABuFfog020pUwmDv/2ZFzCqEtLbkl8yUDQGG9f6QayqztmHapPTH7CMk
        4IDBRHmjocw0pcYPOHXtHqM+s3QoFHIEYGZD+kQ=
X-Google-Smtp-Source: ACcGV63y60WFGg20CoITxY7CQXxwxP+1VIOsWD2VFx3WgClNUGxaoxuJJvz6GZgCmZoizQ3YCYvpxl65UUXLeetbxx0=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr8732495qtf.185.1538405074737;
 Mon, 01 Oct 2018 07:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
 <1538057720-3392-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a3zhVOymM4--mJ5dfbee3buhp2vw4uxQHgxVoDCDTuR2w@mail.gmail.com>
 <CALxhOnjiKpnON7rGnf5a4Enbj3cTagD4DgvTyt-3XFxXk-Ps+A@mail.gmail.com>
In-Reply-To: <CALxhOnjiKpnON7rGnf5a4Enbj3cTagD4DgvTyt-3XFxXk-Ps+A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 16:44:16 +0200
Message-ID: <CAK8P3a3wLjX2fOpow78O4jNif-2zQvzdDuf_Gz02gxkWZRO4aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] ia64: add __NR_old_getpagesize macro
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 4:18 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Hi Arnd,
>
> On Fri, 28 Sep 2018 at 17:41, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Sep 27, 2018 at 4:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> > >
> > > Add __NR_old_getpagesize in order to not break old user space
> > > as it is reserved for backwards compatibility with old __NR_
> > > getpagesize.
> >
> > That description doesn't really make sense here.
>
> Sure I'll some more details. But rest of the patch looks good?
> This is some I was bit confused! In header there is no entry, but
> in system call table has the entry for the system call.

I think adding some macro for it makes sense, and the
__NR_old_getpagesize name you picked is fine for that.

I think generally speaking we want the unistd.h macros to
match up with the system call entry points, and there are
currently multiple ways they diverge:

- System calls have been removed from the kernels, and the
  macros in unistd.h are still there on some architectures but not
  others. This is something we should clean up /after/ you are
  done.

- System calls have a number but are not implemented on all
  architectures because they don't make sense (e.g. pk pkey_add).
  These should probably have an entry in kernel/sys_ni.c if they
  don't already have one.

- System calls have an entry but no macro, like the ia64
  old_getpagesize. I think if you encounter one of these,
  we need to fix them up before your series so we can
  complete the conversion to generated tables.

        Arnd
