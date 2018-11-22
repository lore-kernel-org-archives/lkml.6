Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1AEC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A0B20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vF/rVIqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A0B20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406810AbeKWHfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:35:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46345 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbeKWHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:35:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so10410735wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWk5Q2KMhxFtebTCYvLWJNAVtksZ74uiL41lCD1gibo=;
        b=vF/rVIqaMPhwF9p+EBeHZmWm+gX9jSVviiwtAHK0ybpRFkWf7AQ5/t54m580ItKGSf
         p3KPht5N1pxnRP28k69UlX3YkEFw//lyfq4GE7Zq6XpKJYelvHVkn9YrYgRHowh3abbQ
         kdDL113OtEXzSW/241DIghIiTHxHXx1SQa26a04SFCtb6VcOhf6+h6LhItMIHuEgX2Ln
         2Y9I2ZIW5fneanOKSdpJq73n21JeHbZwQzleS+srTHZ3no/8HJSue1cACZgJamu3tkvK
         QrNl03CkNjUnsyC6KgivOAI+mUlA5YvJdnIzyYXbq4rSrAzIkBQtU8QQx6j9bbtGHu0K
         NAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWk5Q2KMhxFtebTCYvLWJNAVtksZ74uiL41lCD1gibo=;
        b=TlRAqaJsHSgotxbVkJSAvSNiDK36ZJR9CIgFD//sE5tNNKNKkU2Rr+e4EkfzFUtdn/
         ILw/jqeJ6vX3JtDp9YU2g1TyECQdOZD1EVHpaVMnAfkfssiWdKbP25DbCbUbJDYq8xu1
         bnMCmeqY/1on/qkvvu8x6f8C9O86yRjeUNXfUu9QKU9t/m4723MAGQzqfPDP1wEerOz4
         Q4nA3CpLbo4cgeFzHeBMd6hK4JmBh6QKDPeIHgrM9CLYxf3RETG2kWp8RCdwCPdvZPJd
         20Jh5NS6Krizo1nR3S7AoL1UFZBGK2OnBCHJjyoSyK5DbyRL3s4yV93anX60/UPDzw0w
         +Euw==
X-Gm-Message-State: AA+aEWbIEk9g0aD5FMixWci5j1nUcbhAWC2yPVFEHA2qi56gV42FL9lQ
        uIbNp4/98qAyBdYVygurD0lxNLNgINug0+yEjlmrkg==
X-Google-Smtp-Source: AFSGD/UNdYaStKbo/7oDTpht9hcx83ywYAoB2YA/js5oR5hMMtCENW6Uphl+52hDJRvdwm/GpSu1LjW2T5jdjUM0jYM=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr10927772wrm.309.1542920045656;
 Thu, 22 Nov 2018 12:54:05 -0800 (PST)
MIME-Version: 1.0
References: <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com> <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com> <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com>
 <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
 <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com> <3BB9DE07-E0AE-43E2-99F1-E4AA774CD462@amacapital.net>
 <5e10c8e4-aa71-1eea-b1ce-50d7d0a60e8c@gmail.com> <20181122200416.GS3065@bombadil.infradead.org>
In-Reply-To: <20181122200416.GS3065@bombadil.infradead.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 22 Nov 2018 12:53:52 -0800
Message-ID: <CALCETrXB34QBcYk=k5DT1t4h7EezaPxbxM2S_h2nYk5Nv1c4_Q@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:04 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 22, 2018 at 09:27:02PM +0200, Igor Stoppa wrote:
> > I have studied the code involved with Nadav's patchset.
> > I am perplexed about these sentences you wrote.
> >
> > More to the point (to the best of my understanding):
> >
> > poking_init()
> > -------------
> >   1. it gets one random poking address and ensures to have at least 2
> >      consecutive PTEs from the same PMD
> >   2. it then proceeds to map/unmap an address from the first of the 2
> >      consecutive PTEs, so that, later on, there will be no need to
> >      allocate pages, which might fail, if poking from atomic context.
> >   3. at this point, the page tables are populated, for the address that
> >      was obtained at point 1, and this is ok, because the address is fixed
> >
> > write_rare
> > ----------
> >   4. it can happen on any available core / thread at any time, therefore
> >      each of them needs a different address
>
> No?  Each CPU has its own CR3 (eg each CPU might be running a different
> user task).  If you have _one_ address for each allocation, it may or
> may not be mapped on other CPUs at the same time -- you simply don't care.
>
> The writable address can even be a simple formula to calculate from
> the read-only address, you don't have to allocate an address in the
> writable mapping space.
>

Agreed.  I suggest the formula:

writable_address = readable_address - rare_write_offset.  For
starters, rare_write_offset can just be a constant.  If we want to get
fancy later on, it can be randomized.

If we do it like this, then we don't need to modify any pagetables at
all when we do a rare write.  Instead we can set up the mapping at
boot or when we allocate the rare write space, and the actual rare
write code can just switch mms and do the write.
