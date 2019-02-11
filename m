Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A6AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ED021874
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JK4F+MBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbfBKUVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:21:51 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37204 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfBKUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:21:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id s16so151602vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsotGWam83+pwMucnYe+5AiK6zsm+1kCKwE6SJ7mFzU=;
        b=JK4F+MBla5UiP3fMATgw6ybQ1CXBIieSu3GFEdLJSrDLeMHroE7vlfjVg//Gidmr36
         o033rG358QIvUo0y9eqzIEDAognfWUxFM0MxeZ3LhjzKwkpf3ErQtOT+D3fwNyXd01nX
         P9GywDiQKXS1ZrPflO99J8fFDGM6c7cNyWBZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsotGWam83+pwMucnYe+5AiK6zsm+1kCKwE6SJ7mFzU=;
        b=ZUzdXfFUNpSQTWQbPTNWFj0RdRkhG6BLx/J0NpIvHJMsuOw19kXuGmlBynSXRMXYmn
         lonkjptl9YFqkRNndXk6fBi3g+5M6Fgnp2I2OTerYG2n/qqGf+sFsp3CnmnEqwnidNkn
         P7ypCwOuwITl486rSnaa10tP7ecGJLRkV9ahlghK3LH9/GuwGzDEPsacX2NAjTv7+OD6
         Y3mOM9I1GuaJM2TKz63W4B3KdVTdiggqIrPB8UtxGCJ6MY8UGNh0sVxMSYqDPHzxE3Pl
         8jr+UKBgFJEoW4upqaIUiK6lVYjROpeeLurKypl8MVSai1Nx9jiYT2hMc3HJDMpgn5nV
         ik8A==
X-Gm-Message-State: AHQUAuY4fzg6CJcuhcOAgZMvbHKgOK+siNwB1/0ZHnNOc89JmkWI7e/B
        +ePIbMk+gVjwonhUhiIKlHjKtc9Ais4=
X-Google-Smtp-Source: AHgI3IbIyNbptY2M1VYr+9MVvk/zU/LwTrxqKw+j5kj30+0qlZTCgj5sQvmIMm0RN+oM+DDmQoOxcA==
X-Received: by 2002:a67:1505:: with SMTP id 5mr31604vsv.20.1549916508793;
        Mon, 11 Feb 2019 12:21:48 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id d141sm2757328vkf.43.2019.02.11.12.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 12:21:46 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id y14so49849vky.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:21:45 -0800 (PST)
X-Received: by 2002:a1f:8e49:: with SMTP id q70mr23930vkd.40.1549916504745;
 Mon, 11 Feb 2019 12:21:44 -0800 (PST)
MIME-Version: 1.0
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
 <20190201172150.GA1853@linux.vnet.ibm.com> <2236FBA76BA1254E88B949DDB74E612BA4BA0C70@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4BA0C70@IRSMSX102.ger.corp.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 12:21:32 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJdeQ5DOZj_nPkWWBn8y0fRg2UEUGhd_seHL=KmKJey2g@mail.gmail.com>
Message-ID: <CAGXu5jJdeQ5DOZj_nPkWWBn8y0fRg2UEUGhd_seHL=KmKJey2g@mail.gmail.com>
Subject: Re: [PATCH] uprobes: convert uprobe.ref to refcount_t
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 10:51 PM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>
> > * Elena Reshetova <elena.reshetova@intel.com> [2019-01-16 13:20:27]:
> >
> > > atomic_t variables are currently used to implement reference
> > > counters with the following properties:
> > >  - counter is initialized to 1 using atomic_set()
> > >  - a resource is freed upon counter reaching zero
> > >  - once counter reaches zero, its further
> > >    increments aren't allowed
> > >  - counter schema uses basic atomic operations
> > >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > >
> > > Such atomic variables should be converted to a newly provided
> > > refcount_t type and API that prevents accidental counter overflows
> > > and underflows. This is important since overflows and underflows
> > > can lead to use-after-free situation and be exploitable.
> > >
> > > The variable uprobe.ref is used as pure reference counter.
> > > Convert it to refcount_t and fix up the operations.
> > >
> > > **Important note for maintainers:
> > >
> > > Some functions from refcount_t API defined in lib/refcount.c
> > > have different memory ordering guarantees than their atomic
> > > counterparts.
> > > The full comparison can be seen in
> > > https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> > > in state to be merged to the documentation tree.
> > > Normally the differences should not matter since refcount_t provides
> > > enough guarantees to satisfy the refcounting use cases, but in
> > > some rare cases it might matter.
> > > Please double check that you don't have some undocumented
> > > memory guarantees for this variable usage.
> > >
> > > For the uprobe.ref it might make a difference
> > > in following places:
> > >  - put_uprobe(): decrement in refcount_dec_and_test() only
> > >    provides RELEASE ordering and control dependency on success
> > >    vs. fully ordered atomic counterpart
> > >
> > > Suggested-by: Kees Cook <keescook@chromium.org>
> > > Reviewed-by: David Windsor <dwindsor@gmail.com>
> > > Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> > > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > > ---
> > >  kernel/events/uprobes.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> >
> > Looks good to me.
> >
> > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>
> Thank you very much Srikar!
> Would you be able to take this patch to integration?

Steve can you pick this up with Srikar's Reviewed-by?

-- 
Kees Cook
