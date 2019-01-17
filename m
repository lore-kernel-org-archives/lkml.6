Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536F8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C3D20651
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6q+xNzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfAQBBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:01:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46442 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfAQBBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:01:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so9034119wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 17:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N2zoRjaojyvjJj2TpWeK3g17xvej+ksqx+lVKWPjLjQ=;
        b=Y6q+xNzRyKk7dPnTYp1Mwqn+F2zFHSBWSzACq48hjQuZXwNI0AohbKKVW0RR798trE
         /lRv4zPrdtXmZGFhq2Y5KrQ17n5pqnXMA+YzOlPYkCp5+08fNVbfzZ4Z0l4v8oyWMY7W
         isevw5ec4uGYvnNSIQd0LolAUttLVPZFIvpHgc4iW92VZyTH4KtQo82+lGRnBJJzkWEW
         ixDN1alNmeoM5jujXw2lQ81fbpIW7M47L4c/zLI2jSfHjZaAZVW+/6nvoIq29vBbE8Dc
         AzjZOihptYlrevvkzDMAMXBLjqrK8Qcvn4gNoX2l7rtV6UIS7+Mt5MoGZ0Kl4+E2fU9z
         CnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N2zoRjaojyvjJj2TpWeK3g17xvej+ksqx+lVKWPjLjQ=;
        b=VUFmqNo7OaQydupJzKuQi4CcUu8o0iCM4/5EpcLFdTDzvglBy66bIQi8PwU2lsR6Bc
         VpTbLgpDKBxZn93POtRGpqYIQ3GfOgkThnPa45Rs07P7N5g5ANVjS7MFTd/hVptIpAlC
         VATcm4CtTTAuG+oQmsLtJvBK9wmYnh3yDNfVH7/3S+JI0TCULuTqUEYxtiHhozFfrNoA
         pnWyPPtRGykOHxzvsIan5aiJZBpVCsxH6SH1dJom0fDt5swzvRkOJBWfFf4PSex1AFp5
         BNwRQj6f4acA4yNPSYprUXSNSgU5BGlGM82ScRTeBG/5FKLN4jUkITj5Fb6MdAM4d2Oe
         du5Q==
X-Gm-Message-State: AJcUukdn2wfh8TModDUDFIviDJk8o2IHb4ATxVMyoBqj+vOVYA9U/0YA
        nP9jfNRyhXKS/PSAoFbkfaM=
X-Google-Smtp-Source: ALg8bN6rQP377JXas8WQypMmgporqOMu5MDbkVv9qyn6ihTuWky9DD5gy3Pj1bpbqcVfhOckdQeiUQ==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr9201880wre.41.1547686911746;
        Wed, 16 Jan 2019 17:01:51 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x186sm41293630wmg.41.2019.01.16.17.01.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 16 Jan 2019 17:01:50 -0800 (PST)
Date:   Wed, 16 Jan 2019 18:01:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] x86/pgtable: Always inline p4d_index
Message-ID: <20190117010148.GA14152@flashbox>
References: <20181210234538.5405-1-natechancellor@gmail.com>
 <20190116134158.344-1-natechancellor@gmail.com>
 <alpine.DEB.2.21.1901161848560.1642@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901161848560.1642@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:54:25PM +0100, Thomas Gleixner wrote:
> On Wed, 16 Jan 2019, Nathan Chancellor wrote:
> 
> > When building an allyesconfig build with Clang, the kernel fails to link
> > arch/x86/platform/efi/efi_64.o because of a failed BUILD_BUG_ON:
> > 
> > ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> > (.text+0x8e5): undefined reference to `__compiletime_assert_277'
> > 
> > Since there are several BUILD_BUG_ONs in efi_64.c, I isolated it down to
> > the following:
> > 
> >     BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> > 
> > After some research, it turns out that there is a new config option
> > called NO_AUTO_INLINE, which adds '-fno-inline-functions' to
> > KBUILD_CFLAGS so that the compiler does not auto inline small functions,
> > which causes this BUILD_BUG_ON to fail because p4d_index is no longer an
> > integer constant expression.
> 
> There is no tree where this config option exists.
> 

Hmmm, appears that Linus rejected the pull that would have added
this option, which sat in -next for a month and a half.

https://lore.kernel.org/lkml/CAHk-=wiLt3rgeyM3BWAd5VJrKcnxxuHybwoQiDGMgyspo6oXDg@mail.gmail.com/

It is no longer in -next or the kbuild tree so I guess it was scrapped.

> > According to the help text of the config, functions explicitly marked
> > inline should still be inlined. As it turns out, GCC and Clang both
> > support '-fno-inline-functions' but Clang only inlines functions when
> > they are marked with an always inline annotation[1].
> > 
> > Since it's expected that p4d_index should always be inlined so that its
> > value can be evaluated at build time, mark it as __always_inline.
> 
> Sorry no, that's just papering over the problem.
> 
> The point is that NO_AUTO_INLINE is/was meant to prevent the compiler from
> automatically inlining functions, which are NOT marked inline in any form
> in order to expand the traceability.
> 
> With GCC this makes sense, because it still inlines functions which are
> solely marked inline and even if it decides not to inline them it will
> evaluate them if they expand to a build time constant expression.
> 
> Now Clang decided to give -fno-inline-functions a different meaning,
> i.e. the same as GCC has for -fno-inline, which prevents inlining for
> everything except functions which are marked __always_inline.
> 
> So just "fixing" the build wreckage by duct taping one single instance of
> inline functions is really a bad idea. The resulting kernel will be
> bloatware because all regular inlines and we have tons of them will turn
> into function calls even if the function overhead is larger than the
> resulting inline code. Not to talk about the performance impact.
> 

Far points. I don't disagree that this is a band aid patch but I was
more concerned about the build error than the runtime impact since this
was uncovered with an allyesconfig build, which we aren't booting
anyways.

> Anyway, as this option is found to be nowhere there is no point to apply
> this patch.
> 

Indeed. If the config reappears, it should probably 'depends on CC_IS_GCC'.

> Thanks,
> 
> 	tglx
> 

Thank you for the reply and review!
Nathan
> 
> 
> 
