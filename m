Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341A820866
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbeLULHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:07:20 -0500
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:37728 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLULHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:07:17 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 06:07:16 EST
Received: from localhost (unknown [124.65.100.10])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id 917F55C18BA;
        Fri, 21 Dec 2018 19:00:05 +0800 (CST)
Date:   Fri, 21 Dec 2018 19:00:05 +0800
From:   WANG Chao <chao.wang@ucloud.cn>
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH] treewide: replace RETPOLINE with CONFIG_RETPOLINE
Message-ID: <20181221110005.GA39267@WANG-Chaos-MacBook-Pro.local>
References: <20181210163725.95977-1-chao.wang@ucloud.cn>
 <20181221093347.GA88654@WANG-Chaos-MacBook-Pro.local>
 <20181221104705.GA4750@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221104705.GA4750@zn.tnic>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-HM-Spam-Status: e1kIGBQJHllBS1VLV1koWUFJQjdXWS1ZQUlXWQkOFx4IWUFZMjUtOjcyP0
        FLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46GSo4IzkDNz4OQkILMCxM
        GSEwCTRVSlVKTk9OSEJLS0tOTUJMVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZEgtZQVlK
        SU9VTU5VSktLVUpLWVdZCAFZQUhJSU83Bg++
X-HM-Tid: 0a67d06c1d6a2087kuqy917f55c18ba
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 at 11:47P, Borislav Petkov wrote:
> On Fri, Dec 21, 2018 at 05:33:47PM +0800, WANG Chao wrote:
> > On 12/11/18 at 12:37P, WANG Chao wrote:
> > > Since commit 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend
> > > on compiler support"), RETPOLINE has been replaced by CONFIG_RETPOLINE.
> > > 
> > > Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> > > Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
> > 
> > ping ...
> 
> This one somehow slipped through the cracks... :-\
> 
> Ok, let's see: this could be relevant for the case when a module built
> with a compiler which doesn't support retpolines, gets loaded on a
> system which is built with retpolines.

You're right.

> 
> Which is pretty seldom as the majority of setups out there should have
> a retpoline-enabled compiler. And should not allow loading external
> modules anyway, but that's a different story.
> 
> So, this close to the merge window, I'm inclined to delay this one after
> it and have it take the x86/urgent fixes path. Unless someone screams
> and says that patch breaks his system. I haven't seen any reports about
> it so far so...

OK. Thanks.

WANG Chao
