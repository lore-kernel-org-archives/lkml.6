Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D00AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607C12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfBRVvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:51:55 -0500
Received: from mail12.gandi.net ([217.70.182.73]:35049 "EHLO gandi.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbfBRVvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:51:55 -0500
Received: from khany.gandi.net (fob.gandi.net [217.70.181.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandi.net (Postfix) with ESMTPSA id 4ED4A160348;
        Mon, 18 Feb 2019 21:51:53 +0000 (UTC)
Received: by khany.gandi.net (Postfix, from userid 1000)
        id 1D663DD164B; Mon, 18 Feb 2019 21:51:51 +0000 (GMT)
Date:   Mon, 18 Feb 2019 21:51:50 +0000
From:   Arthur Gautier <baloo@gandi.net>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20190218215150.xklqbfckwmbtdm3t@khany>
References: <20190215235901.23541-1-baloo@gandi.net>
 <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
 <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
 <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany>
 <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:15:44AM -0800, Andy Lutomirski wrote:
> This seems like it's just papering over the underlying problem: with
> Jann's new checks in place, strncpy_from_user() is simply buggy.  Does
> the patch below look decent?  It's only compile-tested, but it's
> conceptually straightforward.  I was hoping I could get rid of the
> check-maximum-address stuff, but it's needed for architectures where
> the user range is adjacent to the kernel range (i.e. not x86_64).

I'm unable to trigger the BUG I had with my initramfs with this patch
applied. Thanks!

-- 
\o/ Arthur
 G  Gandi.net
