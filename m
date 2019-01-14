Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A2AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E152086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwN3PaR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfANJOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:14:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43687 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfANJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:14:01 -0500
Received: by mail-io1-f65.google.com with SMTP id b23so17029430ios.10;
        Mon, 14 Jan 2019 01:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIxlYDDgPHqQ9CK9up+5xb8otdBsHFZQrcLiqj227qI=;
        b=MwN3PaR8w30I5kdZvUms5ZTH3nwICZq9dTAN4QjnKrcqsCkNJLnDKbNjS8MsmPGBlr
         fgEOK+TxlotTOZ9inRI1NPpRxl1l3crjyFrCy2my731zsyJDvGGbmh4hFPRpHDnRC/bD
         dJpwonPJCy0Q10vAMOwfU+H5JdqqqjyR399pkR9ou5+kD0l9CDnmsDbb17ldt0WmteV3
         FzCCM9kxKBavP7qHHBQQ///e/gIXcKLw8t9eVRv6BU8jrhdXprIMz+x4GjkVMYH+GOL8
         gQuYR1NmR3hSoCN9HX20xuXu3ROaPLlHn3sYcVd4+4d4qTDeZF3gCFDcrQCIlGIsV8u/
         aebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIxlYDDgPHqQ9CK9up+5xb8otdBsHFZQrcLiqj227qI=;
        b=tU7oqz9iYzU5NsMLSzv7bYfQDgo5B/28rFKJkxkYk8OEndAI0+9FWVvPBrnLKuJclM
         7XURwt6wFvzq9H3liSkjAZZns3ochbIdKednlPzO8EpL8qekhnwo4ssvFi1ypacwmF9h
         m4H8dHLIXummheIqVIyrZBINRrvvwM+yCa8lBEv6+fn9FrKKy6eA3p0NYFA65ce1y7a1
         vqlh4ii8bf7T9koujOE8jyOjbF8QzNIgy/27ivgzEDOqw2uCRzkzlSFSvv2Gz4L2qF/R
         Vzv4BemdVSZjB/eIu7Jq3KbcRvwHrAnFapXZrBX07yxsEzATKU+7rzT2/z0g/wN+Uz7p
         H/wA==
X-Gm-Message-State: AJcUukcbyMWjaHSJSJfCDN1P+cMWC+/0Ztl1CySMZmEhyHTxTBejwbPm
        sEqGVCKjLgCbDUBrrCdigsuwLDTo+RyrVm6BKg==
X-Google-Smtp-Source: ALg8bN4Y4wLB7NmE9fU3NzatGqFg3PqsV2WiWgzvw22LG+vbKmq8sNOClWoHbRl8jCvp8sUF7FehuWDdsVfejKw45Dg=
X-Received: by 2002:a5e:de01:: with SMTP id e1mr15764932iok.137.1547457239825;
 Mon, 14 Jan 2019 01:13:59 -0800 (PST)
MIME-Version: 1.0
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
 <1547183577-20309-4-git-send-email-kernelfans@gmail.com> <20190114075113.GB1973@rapoport-lnx>
 <CAFgQCTtN4CGFz5xf+uci1ow032oQMB5pExHG01EtgrOpqXrJKA@mail.gmail.com> <20190114085037.GC1973@rapoport-lnx>
In-Reply-To: <20190114085037.GC1973@rapoport-lnx>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 14 Jan 2019 17:13:48 +0800
Message-ID: <CAFgQCTtKO445m9rq+cxuX2PqBW4uTNh=62ETFt7zVQGCZ4RaXA@mail.gmail.com>
Subject: Re: [PATCHv2 3/7] mm/memblock: introduce allocation boundary for
 tracing purpose
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 4:50 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Jan 14, 2019 at 04:33:50PM +0800, Pingfan Liu wrote:
> > On Mon, Jan 14, 2019 at 3:51 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > Hi Pingfan,
> > >
> > > On Fri, Jan 11, 2019 at 01:12:53PM +0800, Pingfan Liu wrote:
> > > > During boot time, there is requirement to tell whether a series of func
> > > > call will consume memory or not. For some reason, a temporary memory
> > > > resource can be loan to those func through memblock allocator, but at a
> > > > check point, all of the loan memory should be turned back.
> > > > A typical using style:
> > > >  -1. find a usable range by memblock_find_in_range(), said, [A,B]
> > > >  -2. before calling a series of func, memblock_set_current_limit(A,B,true)
> > > >  -3. call funcs
> > > >  -4. memblock_find_in_range(A,B,B-A,1), if failed, then some memory is not
> > > >      turned back.
> > > >  -5. reset the original limit
> > > >
> > > > E.g. in the case of hotmovable memory, some acpi routines should be called,
> > > > and they are not allowed to own some movable memory. Although at present
> > > > these functions do not consume memory, but later, if changed without
> > > > awareness, they may do. With the above method, the allocation can be
> > > > detected, and pr_warn() to ask people to resolve it.
> > >
> > > To ensure there were that a sequence of function calls didn't create new
> > > memblock allocations you can simply check the number of the reserved
> > > regions before and after that sequence.
> > >
> > Yes, thank you point out it.
> >
> > > Still, I'm not sure it would be practical to try tracking what code that's called
> > > from x86::setup_arch() did memory allocation.
> > > Probably a better approach is to verify no memory ended up in the movable
> > > areas after their extents are known.
> > >
> > It is a probability problem whether allocated memory sit on hotmovable
> > memory or not. And if warning based on the verification, then it is
> > also a probability problem and maybe we will miss it.
>
> I'm not sure I'm following you here.
>
> After the hotmovable memory configuration is detected it is possible to
> traverse reserved memblock areas and warn if some of them reside in the
> hotmovable memory.
>
Oh, sorry that I did not explain it accurately. Let use say a machine
with nodeA/B/C from low to high memory address. With top-down
allocation by default, at this point, memory will always be allocated
from nodeC. But it depends on machine whether nodeC is hotmovable or
not. The verification can pass on a machine with unmovable nodeC , but
fails on a machine with movable nodeC. It will be a probability issue.

Thanks

[...]
