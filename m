Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563BBC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AC7204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AC7204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeKBUeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:34:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49754 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeKBUeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:34:25 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cGmVktbqz_wv; Fri,  2 Nov 2018 12:27:33 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD3B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:3b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1551C1EC01CF;
        Fri,  2 Nov 2018 12:27:33 +0100 (CET)
Date:   Fri, 2 Nov 2018 12:27:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Changbin Du <changbin.du@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
Message-ID: <20181102112728.GC14602@zn.tnic>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-2-changbin.du@gmail.com>
 <20181028140911.21d49629@vmware.local.home>
 <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:04:46PM +0900, Masahiro Yamada wrote:
> On Mon, Oct 29, 2018 at 3:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Sun, 28 Oct 2018 13:09:42 +0000
> > Changbin Du <changbin.du@gmail.com> wrote:
> >
> > > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> > > So declare check_la57_support() as inline to make sure the code
> > > referring to level4_kernel_pgt is optimized out. This is a preparation
> > > for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> > >
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> > -- Steve
> >
> 
> Applied to linux-kbuild.

Next time, before you route a patch through your tree, please get an x86
maintainer's ACK first.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
