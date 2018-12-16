Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9242CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE7B2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544976443;
	bh=lyKRg9/b1wVrj+meWpJmMuuoqXajiGQfejjwx4lpltU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w2a2aJ4ANLMb8qfYDNjI3smYb/NSIAo2G9/Qdes4TJP2Vp7g8cS+Gxq42BXOFcg4B
	 2hwUfIRU7U5D+KsVEW1DFhLsqESXakDo1N3rhYsAIPtHT6HGO5I7GRpP3MlW//m/ok
	 1TR8w+PMWE9vIC69rzTWSRt+QnM2mXMjV02ZoA5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbeLPQHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:07:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbeLPQHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 11:07:21 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CFF52082F;
        Sun, 16 Dec 2018 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544976441;
        bh=lyKRg9/b1wVrj+meWpJmMuuoqXajiGQfejjwx4lpltU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LA8ksHNI0EZF9yM2082dz85x9zysSJPJqNF4gppxU3x52WHwZ+s5vxnidwvXD4uyD
         41aqXNhfZu7FREosjwZOoNmo1fR22LGsgM/8IG4T2sfqrd/OwOro+WRDoTI2P68j3D
         8pYp7QQrNJPK0EofJx4RS63vKN41O73452pyUTew=
Date:   Mon, 17 Dec 2018 01:07:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt
 functions
Message-Id: <20181217010716.34552c2f21f3dfa5e07ff1b5@kernel.org>
In-Reply-To: <20181208070922.GB2237@Dell>
References: <20181206095648.GA8249@Dell>
        <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
        <20181208010120.c3eda9042912068aecc68317@kernel.org>
        <20181207175805.GA1369@Dell>
        <20181208124859.7318e32abfab4cc6dc2da3a8@kernel.org>
        <20181208070922.GB2237@Dell>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 08:09:22 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Sat, Dec 08, 2018 at 12:48:59PM +0900, Masami Hiramatsu wrote:
> > On Fri, 7 Dec 2018 18:58:05 +0100
> > Andrea Righi <righi.andrea@gmail.com> wrote:
> > 
> > > On Sat, Dec 08, 2018 at 01:01:20AM +0900, Masami Hiramatsu wrote:
> > > > Hi Andrea and Ingo,
> > > > 
> > > > Here is the patch what I meant. I just ran it on qemu-x86, and seemed working.
> > > > After introducing this patch, I will start adding arch_populate_kprobe_blacklist()
> > > > to some arches.
> > > > 
> > > > Thank you,
> > > > 
> > > > [RFC] kprobes: x86/kprobes: Blacklist symbols in arch-defined prohibited area
> > > > 
> > > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > > 
> > > > Blacklist symbols in arch-defined probe-prohibited areas.
> > > > With this change, user can see all symbols which are prohibited
> > > > to probe in debugfs.
> > > > 
> > > > All archtectures which have custom prohibit areas should define
> > > > its own arch_populate_kprobe_blacklist() function, but unless that,
> > > > all symbols marked __kprobes are blacklisted.
> > > 
> > > What about iterating all symbols and use arch_within_kprobe_blacklist()
> > > to check if we need to blacklist them or not.
> > 
> > Sorry, I don't want to iterate all ksyms since it may take a long time
> > (especially embedded small devices.)
> > 
> > > 
> > > In this way we don't have to introduce an
> > > arch_populate_kprobe_blacklist() for each architecture.
> > 
> > Hmm, I had a same idea, but there are some arch which prohibit probing
> > extable entries (e.g. arm64.) For correctness of the blacklist, I think
> > it should be listed (not entire the function body).

Aah, my bad memory. I remember that the extable should not be in blacklist,
since it is a kind of "unsupported instruction to be probed" on some arch.
I'll move that in arch_prepare_kprobe() on arm64.

> > I also rather like to remove arch_within_kprobe_blacklist() instead.

Anyway, this is true. If I could make a complete list, I will remove
this function.

Thank you,

> 
> OK. Thanks.
> 
> -Andrea


-- 
Masami Hiramatsu <mhiramat@kernel.org>
