Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD77C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AED21763
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M16qRQJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AED21763
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbeHDUZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:25:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36710 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:25:15 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so3942807plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bCwe84L7p9AwTasKI4cVE0v5oPhE5ctCQBIpeDuk1N8=;
        b=M16qRQJAEdku+HjQgS3mukQo1x8APQFNStaWoDB8OlU3EeAOimC55zQE7tp3EbN2mO
         UvyuRwiwpeEigR8YNDMaIvAmEXtqp7Adtzw3AzckXOo6JosWb8fLmWjaiO+yIZ1KBYw2
         /hIil+DUytD/ya4yzVCjKVi4ArFv+kCKdEt1nJssbuyLwvtVMZcknJYaEnIbnl5dX2rO
         TWOqGWyH6qFOWi0nDauzzZl884uQqJ/OUm4QEfy5ycmggryb6Gbe9PLhVvy5/gi3cakL
         ykcM61S3PzaSVwdkJx3y5s1B0QA4SlRxuEqQM4Ha5drFcxq4vQAL72KMdaH08wVB/gaR
         1yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bCwe84L7p9AwTasKI4cVE0v5oPhE5ctCQBIpeDuk1N8=;
        b=Ah+/jfeiRUCoAnwNt7XXOcwHHgrYMWsqNbvj2QaS/OAAFyZU2e2r7/BZeBz3mL7Inm
         Rpu2LuEvPDvFsMXT2RA8dBwZSauSQomNS7cufUBjexKaVZ4USJt53oQl/GTvLvgGb+CU
         KqU2dL0n3wbJRJ22F66Z9tnIDbxmiKh415uNTM4vNUiDgsgFnegejcMWciZxBhFZ99Fc
         nTWsmY7EJjSNqkMzfzxtn9FREoEvaIeAneddOaXVHHRgSCVTL8z1CGt1ETA4IL4g9TUw
         QkCUojGcdCC+egjV5Hpb6ZXHpiOr5hLjVkB/sskd98jyUs61eBw1UZBX0+7V6VbuUK02
         OKTA==
X-Gm-Message-State: AOUpUlEfFav/nVYxfimxoW4eIhMIFeWLW8fNbe3nYqChgktYKE2VQCB5
        I9IYez+mAVsQvdkNzJFT8WlwIg==
X-Google-Smtp-Source: AAOMgpdr/hlQrn6xNY3uqEEzKpmP4IORE//TP4E2DEm2tydoGGMgpAN1CpuhVGU5am+H/SUHlfIwYg==
X-Received: by 2002:a17:902:6193:: with SMTP id u19-v6mr8016733plj.133.1533407023630;
        Sat, 04 Aug 2018 11:23:43 -0700 (PDT)
Received: from [100.112.67.156] ([104.133.9.108])
        by smtp.gmail.com with ESMTPSA id r83-v6sm17451965pgr.8.2018.08.04.11.23.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 11:23:41 -0700 (PDT)
Date:   Sat, 4 Aug 2018 11:23:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/7] x86/mm/init: pass unconverted symbol addresses to
 free_init_pages()
In-Reply-To: <CA+55aFzd-F65GVBq8a-vTaU4G5UwddDcOdcd3SV9YVdB6qDGdg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1808041112260.1860@eggly.anvils>
References: <20180802225823.4711C55B@viggo.jf.intel.com> <20180802225828.89B2D0E2@viggo.jf.intel.com> <alpine.LSU.2.11.1808031650050.4436@eggly.anvils> <CA+55aFzd-F65GVBq8a-vTaU4G5UwddDcOdcd3SV9YVdB6qDGdg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2018, Linus Torvalds wrote:
> On Fri, Aug 3, 2018 at 5:19 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I thought that virt_to_page() only works on virtual addresses
> > in the direct map
> 
> You're right that virt_to_page() does not work on any _actual_ virtual
> mappings (ie no user pages, and no vmalloc() pages etc). It does not
> follow page tables at all.
> 
> And on 32-bit, it literally ends up doing (see __phys_addr_nodebug()) a simple
> 
>     #define __phys_addr_nodebug(x)  ((x) - PAGE_OFFSET)
> 
> However, on x86-64, we have *two* cases of direct mappings: we have
> the one at __START_KERNEL_map, and we have the one at PAGE_OFFSET.
> 
> And virt_to_page() handles both of those direct mappings.
> 
> Annoying? Yes. And it has caused bugs in the past. And I entirely
> forget why we needed it on x86-64.
> 
> [ Goes around and rummages ]
> 
> Oh, never mind, looking around reminded me why: we want to map the
> kernel text in the top 31 bits, so that we can use the faster
> -mcmodel=kernel because all symbols fit in sign-extended 32 bits.
> 
> Maybe there was some other reason too, but I think that's it.

Thanks a lot for writing that up. You shamed me into grepping
a little harder than I did yesterday, when all I could find were
"- PAGE_OFFSET" conversions (maybe I got lost in 32-bit-land).
I had missed __phys_addr_nodebug(), where the __START_KERNEL_map
alternative is handled.

Hugh
