Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3820C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A244E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9fXS7gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A244E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJLTma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:42:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39554 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeJLTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:42:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id l58so12148769otd.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86BX4TYqhwHqjuxERWPfJDp1u76LVIw+505PohOmZuk=;
        b=j9fXS7gk9p/+LtN4URTCz1/FzZcexL/P1i5T/HLxRY4V3oGNhQfu/KXl0P8+y001bj
         GaTYIR+2m7MLQrPCveV4CLlPjeSzzSXm8oWuCAZgHOVQvXZXTbvfR1X79e7TDhb+BPSP
         8DyL7tdcYO7kODfwhd1QexanGXKHDAFJvrhfBjM9tjm+WjZGyqL28nOtoTj1dvDofO6o
         vpLxBc+Mv8yttOAOSRBp2kVRtVmjmQW7bNHeGpdgT7c5+EfzsQ5KcsV2fumapytQ+o4m
         5Nw3doTamrhyOBQoJ7o6h1kp0ltBcZQatMnj6JAq9DH9kN95RjeT5Qc8DhiIJPxj3C45
         SFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86BX4TYqhwHqjuxERWPfJDp1u76LVIw+505PohOmZuk=;
        b=Mvxk5RAVrHD+nXJve79xl6CdLPfh9TXr3aGftZgIz0GwgjMs41B7frCaBLcJJ7Wlj9
         t+ZJj9vifPx7BPnTjT+lnbU6vANRbPVOm7ZXo0SrF398vqM/fcbN8cfbimymcnSk6yKQ
         jTyzqhakcMkXfFhSyTxUBPdRmoz2Wwu7F73ou6t5SbSU6FTKkqtIYIxe0wZKRdz8tI5P
         OKbdiCb9cppKua/kpFtKoMs5LnJOcknT7luQhMxIkJZtU5fnYDT2Wdlwm7fIksOseZYq
         PKlSIkuSbHzQpWcwBJrPUkUX/XUXjYAu8AwsJS4dsdyIMIwWqIu1ZdZ+fKWMXxQXiNCa
         fG3w==
X-Gm-Message-State: ABuFfog70UP8T2QPo2TohmSpnk+jYy4dj++p4KSwGoXMC9UCqkDdyezR
        QJPTbaHbPUQFo5wq/WZ8OJ/J5yD0xfItkEAn83yNzg==
X-Google-Smtp-Source: ACcGV63moiWqnWlJUwcrvN2pXfPYsXU/cdosRlA4DzBimthDBD0XjrivOycI0DMfTLydz0jvlZ0gkUUC2neZjedwQSY=
X-Received: by 2002:a9d:2117:: with SMTP id i23mr3501390otb.230.1539346219931;
 Fri, 12 Oct 2018 05:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181010152736.99475-1-jannh@google.com> <20181010171944.GJ5873@dhcp22.suse.cz>
 <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com> <87tvlr1n1i.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvlr1n1i.fsf@concordia.ellerman.id.au>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 14:09:52 +0200
Message-ID: <CAG48ez1gc2aKWAhmtLjXB6pSGP75JKNVbBvk_1ZcHO5OM4XhfA@mail.gmail.com>
Subject: Re: [PATCH] mm: don't clobber partially overlapping VMA with MAP_FIXED_NOREPLACE
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        abdhalee@linux.vnet.ibm.com, joel@jms.id.au,
        Kees Cook <keescook@chromium.org>,
        Jason Evans <jasone@google.com>,
        David Goldblatt <davidtgoldblatt@gmail.com>,
        =?UTF-8?Q?Edward_Tomasz_Napiera=C5=82a?= <trasz@freebsd.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Daniel Micay <danielmicay@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:23 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Jann Horn <jannh@google.com> writes:
> > On Wed, Oct 10, 2018 at 7:19 PM Michal Hocko <mhocko@suse.com> wrote:
> >> On Wed 10-10-18 17:27:36, Jann Horn wrote:
> >> > Daniel Micay reports that attempting to use MAP_FIXED_NOREPLACE in an
> >> > application causes that application to randomly crash. The existing check
> >> > for handling MAP_FIXED_NOREPLACE looks up the first VMA that either
> >> > overlaps or follows the requested region, and then bails out if that VMA
> >> > overlaps *the start* of the requested region. It does not bail out if the
> >> > VMA only overlaps another part of the requested region.
> >>
> >> I do not understand. Could you give me an example?
> >
> > Sure.
> >
> > =======
> > user@debian:~$ cat mmap_fixed_simple.c
> > #include <sys/mman.h>
> > #include <errno.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <unistd.h>
>
> ..
>
> Mind if I turn that into a selftest?

Feel free to do that. :)
