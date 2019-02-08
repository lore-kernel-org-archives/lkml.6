Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669F3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B6F21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YqSkI+3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBHVwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:52:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48894 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBHVwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:52:45 -0500
Received: from zn.tnic (p200300EC2BC9F900B830E0BCFC6FF2AB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:f900:b830:e0bc:fc6f:f2ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C6211EC097D;
        Fri,  8 Feb 2019 22:52:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549662762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8TAE6Q5k0LWdVJHO58ethYalirt4HvstAbRz34K3oYY=;
        b=YqSkI+3j4tuU5lwMKDG4x5TorT5uZlY1FSjy2JrqnJyAz/JK1rdsdY9wncrnKukYtOxBGE
        KeJqNgBs0qd1Z9A83gEk4eYRaSMvifUyuuJshL0dD8IfEeYszbT1blW5nOg/EK+u+bz0EY
        ekTdg8qXoE7RMD9NQTykv/ijuSVmrHc=
Date:   Fri, 8 Feb 2019 22:52:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
Message-ID: <20190208215232.GN674@zn.tnic>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com>
 <20190208154239.GI674@zn.tnic>
 <20190208164206-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208164206-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:43:37PM -0500, Michael S. Tsirkin wrote:
> Coding style violation: if a linux/foo.h exists then it must
> be included in preference to asm/foo.h
> 
> And the specific issue is that a follow-up patch moves code from
> asm/mman.h to linux/mman.h so if any one was indirectly using
> this header it will now miss the symbols that are being moved.

Ok, so first of all, this should be your commit message - not what you
have there now.

Then, please send full patchsets to recipients - I have only this patch
in my mbox and have no clue what the whole patchset is addressing.

Further, do you want an ACK only or should I pick this up?

Finally, this whole file is going away:

https://lkml.kernel.org/r/7de5232f-4bc1-5c85-00d5-cb646462577f@intel.com

so your patch might become obsolete by then. Depends on what goes first.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
