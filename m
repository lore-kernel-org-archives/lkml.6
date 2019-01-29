Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245E72175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdT4NTn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfA2FZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:25:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39261 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2FZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:25:58 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so2222283itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoG5zwFwz/zugmlvlLSPlZlHaXhenbG7kxD8d9Gdc6I=;
        b=sdT4NTn3UEoDcjYdl88c/v54HrLEA/aFP28q2P7yNEKSpqwThNGVk7TB0Uxrr+4y2/
         A3Ub4yetGLKWHyBtjYPI7xVl/Lkp+O7lHsnjHqKQ+YIZPUqpfL6Z1hQsQzuE0sJnlIGC
         KCmHsCSOQV4VfOabrFeq2rQHMkZQGExU1ZnqwjimLT+yKF3EiGHm7TlMl8FzidsdIXiy
         XTl7Z1f03clEVei+6oUGnIpDCJj7HOeT9PJvgY0zhIBhDNR0sFNhCqW0xmG6rVCS6M4B
         tRmCvrGmISKHHkMK31LlEyQicEuYRuVjDOP54v79cr54DRCdOG3k14KcWCikPkoFy07b
         UsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoG5zwFwz/zugmlvlLSPlZlHaXhenbG7kxD8d9Gdc6I=;
        b=Kn3Xpb9TCSvTs+jYB2JPGZkwZEme/pj/ycjIOWAG1Q0+qgb8hDZ/NdqMM1MM0I5iEi
         7vGT95nCL0WKnkIUcCvtgVHlY5+FibHCIX2g9qJehZr8TIG560uwEPB9L8r7Z5h3lKcB
         BbDURvHV46JHcDA6mtA49ukEISCP6iKDXCjJpBYOokWjF11FG6rXxsVj2sEi29eSAYlw
         wCjkKKaAmk7uruaMZkegXr7a0+EERRMUdzorNHyr6ns+mZ4MKuF6b22GDM2pffETwlon
         cisPPDrO+H/R6t8qtC0kz6ymC0N7jyfQ/HtXqollz5f5fwIlPl6MJ8PHMmTVj3wH+sBc
         83ug==
X-Gm-Message-State: AJcUukfSasNlW9KxvbRmrOfMwejnUZZLSxtxtu2jI+Sd5vidn4GqLKTH
        RB8FpTkf2GZsgBEyCgF15+GFx0qcTzeViWaBqw==
X-Google-Smtp-Source: ALg8bN6uTIzeMHCllwA/WgMqJO9wmgVvumRuxHlvOCZbLPvD0wfLXx1+kTh6xK0NmGHayz96N5OA2Iqx+f2N3m9mX88=
X-Received: by 2002:a24:5608:: with SMTP id o8mr11575917itb.35.1548739556984;
 Mon, 28 Jan 2019 21:25:56 -0800 (PST)
MIME-Version: 1.0
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic> <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
In-Reply-To: <20190125140823.GC27998@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 29 Jan 2019 13:25:45 +0800
Message-ID: <CAFgQCTsuuOSSLKXOaF7jchDRevegZkzZVNiTgB6D+S4=dpc5Xg@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:08 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 25, 2019 at 09:45:18PM +0800, Dave Young wrote:
> > AFAIK, some people prefer to explictly reserve crash memory at high
> > region even if it is possible to reserve at low area.  May because
> > <4G memory is limited on large server, they want to leave this for other
> > use.
> >
> > Yinghai or Vivek should know more about the history, probably they can
> > recall some initial reason.
>
Go through the git log, and I found the initial introduction of
crashkernel_high option. Refer to
commit 55a20ee7804ab64ac90bcdd4e2868a42829e2784
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Mon Apr 15 22:23:47 2013 -0700

    x86, kdump: Retore crashkernel= to allocate under 896M

    Vivek found old kexec-tools does not work new kernel anymore.

    So change back crashkernel= back to old behavoir, and add crashkernel_high=
    to let user decide if buffer could be above 4G, and also new
kexec-tools will
    be needed.

But kexec-tools-2.0.3, released at 2012, can run 4.20 kernel with
crashkernel=256M@5G, so I think only very old kexec-tools requires
memory under 896M. Due to -1.few people running latest kernel with
very old kexec-tools to date, -2. crashkernel=X is more popular than
crashkernel=X.high, it should be time to eliminate this limit of
crashkernel=X parameter, otherwise we will run into this bug.
As for crashkernel=,high, I think it is a more professional option for
who cares about the DMA32. On high-end machine, big reserved region is
used for crashkernel(e.g. in this case 384M), which make the crowed
situation under under 4GB memory worse.

> Yes, just "prefer" is not good enough. There should be a technical
> reason why that's there.
>
> Also, if the user doesn't care, then the code should be free to force
> "high" and thus probe a different range for allocation.
>
Do you suggest to remove crashkernel=X,high parameter?

Thanks,
Pingfan
> > Good question, still it may be some historical reason, but it is good to
> > make them clear and rethink about it after long time.
> >
> > I also want to understand, need dig the log more.
>
> Good idea. That would be a very nice cleanup. :-)
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
