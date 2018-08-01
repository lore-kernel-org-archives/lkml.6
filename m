Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E131BC46467
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CEC2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwJG+kwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CEC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbeHAUI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:08:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38449 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbeHAUIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:08:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so8278198pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxpBoIKSWG8O4gEV2nnqWWlvZEX36jaAcDxH5/rCUJw=;
        b=CwJG+kwc8zFpsebtm3B52XfPPF49sHaaw8/pYZZob6hPdgBF2Qk5DHBVmmikK+mR4T
         sMXNjq2iSi5rYKfjFGVQVhKZIWMJimCVA5/AmXgGofXOLNjowCnrfEFc3upsIsiR3Q24
         X5ti1Sn4hJXQ3vC9yDkvUxfivKl/mZeT4iMHQS8WVEN/xl5G/OaODWr+l0m+c/kwPgOM
         VLzAeStD8NpzPdQ0+LSupI4TE6WnXIShTo6X55aQMhBCRQUYz6oK/XiTip8V+Xk1lLZK
         yeomjttr7NVe+Lpkyr6J84ff+wl1tujdUW9UQNcDhaMNJmmDwN/unoZRvNts6Lec3xqq
         sXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxpBoIKSWG8O4gEV2nnqWWlvZEX36jaAcDxH5/rCUJw=;
        b=Sjc8BO8usvIJmBtTEXaHBaM8lSOsAwYIge70IqoBI5WNXZj091OpiEdpy+onlLNdfC
         rFzqSC3Acp6NXGR5MvDOnwkuUQOR3/betSrh4z7EKLxMmfrxhc39rjgfG6qyFWkw4V0Z
         qGj3e4ub753+A/tRJtBuOO6bAUrtFze1fQDbuLn1fuoNBqUO4OfB8NRVND1zVB54Fux6
         +6ZIwJofVYA+WDJ7Cl1OWhJOOLOCJgb6UuYR7djRJjL+gi6RkYybnb9yRT3vuyFiEKkd
         Z91MtDGqybjxZZedw8lFfvHfid4NmkBJiTPE21EGEXJiOjzAhfIgmsl/fODArM6dPjj9
         BMsQ==
X-Gm-Message-State: AOUpUlEP3vGL5bv4/UXSnm18fesRVO2r9R62/Zm9+qlVZuwIeOZZZuSG
        r4PsD+jxZRP7tL9x+S6mJPSlXFdxalz5jwnlEFE0eg==
X-Google-Smtp-Source: AAOMgpedV2+eIp6w3CaJD8+ePelypm+CWZf6FTSJK11oFtbT7UZEbUzPBuAUoZHn8+Qs5EFsaBK3ga2O2xP0WO8VcGg=
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr25307448pge.75.1533147685551;
 Wed, 01 Aug 2018 11:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdku_BOi6m2ugaef6=8+VH_+KAHH-Ch+uZZqMr8WAKARCw@mail.gmail.com>
 <CAKwvOdn1Ri2VP9hNfKwQ3WMzL278e7-3DGusZc1cwQZbk9H6nw@mail.gmail.com> <20180801074051.11fa62b3@mschwideX1>
In-Reply-To: <20180801074051.11fa62b3@mschwideX1>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Aug 2018 11:21:13 -0700
Message-ID: <CAKwvOdnAzsF_vXH4UQiQd9HwjUju_sU9R4523zxqJSphuut-7Q@mail.gmail.com>
Subject: Re: Getting the instruction pointer on a per arch basis
To:     schwidefsky@de.ibm.com
Cc:     heiko.carstens@de.ibm.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        tony.luck@intel.com, fenghua.yu@intel.com, msalter@redhat.com,
        jacquiot.aurelien@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Pirama Arumuga Nainar <pirama@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:41 PM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Tue, 31 Jul 2018 16:09:06 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > + More maintainers and lists for visibility
> >
> > On Tue, Jul 31, 2018 at 3:32 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > I'm currently looking into cleaning up the code duplication between
> > > current_text_addr() and _THIS_IP_, virtually every implementation of
> > > current_text_addr() and _THIS_IP_ itself are basically:
> > >
> > > #define _THIS_IP_ ({ __label__ _l; _l: &&_l; })
> > >
> > > For a few arch's, they have inline assembly instead (for
> > > current_text_addr()).  Examples:
> > > * s390
> > > * sh
> > > * ia64
> > > * x86 (um and 32b)
> > > * c6x
> > > * sparc
> > >
> > > I have a patch that cuts down on the duplication, but I don't
> > > understand why the few arch specific implementations are necessary.  I
> > > could reduce the duplication further if it's ok to just use the
> > > statement expression.
> > >
> > > Does anyone know why this is the case?
>
> For s390 it is just that we did not know about the label trick when we
> introduced the define. The inline has an advantage though, the code
> generated with the label trick is using a LARL instruction which is
> 4 bytes, the inline assembly uses a BASR which is 2 bytes.
>
> If I use the label method in current_text_addr() the size of vmlinux
> increases by a small amount:
>
> add/remove: 33/13 grow/shrink: 101/48 up/down: 11941/-8887 (3054)

Thanks for the measurements.  Was this output produced by a utility?

> This is acceptable though, I would not mind if _THIS_IP_ and
> current_text_addr use a common definition using labels.

Thank you for this feedback Martin, I appreciate it.  Patches soon.

-- 
Thanks,
~Nick Desaulniers
