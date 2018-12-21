Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F41C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E871218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbeLUKrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:47:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:51882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731433AbeLUKrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:47:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3BA5AFA4;
        Fri, 21 Dec 2018 10:47:13 +0000 (UTC)
Date:   Fri, 21 Dec 2018 11:47:05 +0100
From:   Borislav Petkov <bp@suse.de>
To:     WANG Chao <chao.wang@ucloud.cn>
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
Message-ID: <20181221104705.GA4750@zn.tnic>
References: <20181210163725.95977-1-chao.wang@ucloud.cn>
 <20181221093347.GA88654@WANG-Chaos-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221093347.GA88654@WANG-Chaos-MacBook-Pro.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 05:33:47PM +0800, WANG Chao wrote:
> On 12/11/18 at 12:37P, WANG Chao wrote:
> > Since commit 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend
> > on compiler support"), RETPOLINE has been replaced by CONFIG_RETPOLINE.
> > 
> > Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> > Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
> 
> ping ...

This one somehow slipped through the cracks... :-\

Ok, let's see: this could be relevant for the case when a module built
with a compiler which doesn't support retpolines, gets loaded on a
system which is built with retpolines.

Which is pretty seldom as the majority of setups out there should have
a retpoline-enabled compiler. And should not allow loading external
modules anyway, but that's a different story.

So, this close to the merge window, I'm inclined to delay this one after
it and have it take the x86/urgent fixes path. Unless someone screams
and says that patch breaks his system. I haven't seen any reports about
it so far so...

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
