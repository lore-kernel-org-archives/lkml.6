Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CDA206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547652993;
	bh=KdsThY4gR3RLw4XPE0cdrJD1sE04JGQwMQgMonFoW7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eOVFyNhuxZYm9cJlx2DBwhIY176+cUWJoPzQl/cw7dA6/TylOE8bAgrijv+yGMNQq
	 bUBByEig5Q1NGwoxYkF1xQT4zAAVdmh+Ni8b6e2TMYd3WZGRc4ohJiTUyrfHZ11ePo
	 GQcWSbVESaCLXAq+FounmIm4KLxnYujmlKkVqlk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404971AbfAPPgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391355AbfAPPgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:36:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0AD20675;
        Wed, 16 Jan 2019 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547652991;
        bh=KdsThY4gR3RLw4XPE0cdrJD1sE04JGQwMQgMonFoW7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRlK5cdPYRFXVSPZIE38P7lfgVezlVCKq1SQQxnIJWLeNyH6fmK+hhBL64OEbLMFP
         GgJnBgNgb+U69A7zDoGAJEikm90AfphEKouHPGF1+t5gcZwwseKBupJOSpSbghV2qs
         exFbVffmvLRlDwQ0S1Ji5YKPvbajzKLhBFbnCfnI=
Date:   Wed, 16 Jan 2019 16:36:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [patch 1/2] LICENSES: Add GCC runtime library exception text
Message-ID: <20190116153628.GA871@kroah.com>
References: <20190116102651.489113812@linutronix.de>
 <20190116104127.590053479@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116104127.590053479@linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:26:52AM +0100, Thomas Gleixner wrote:
> A recent commit added SPDX identifiers to the SuperH low level library code
> which originates from GCC. This code is licensed under the GPL 2.0 or later
> with the GCC runtime library exception.
> 
> Unfortunately the authors did not bother to add the exception text to the
> LICENSES directory so spdxcheck fails with:
> 
>  arch/sh/lib/ashiftrt.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  arch/sh/lib/ashlsi3.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  arch/sh/lib/ashrsi3.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  arch/sh/lib/lshrsi3.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  arch/sh/lib/movmem.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  arch/sh/lib/udiv_qrnnd.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  arch/sh/lib/udivsi3.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  arch/sh/lib/udivsi3_i4i-Os.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  arch/sh/lib/udivsi3_i4i.S: 1:42 Invalid Exception ID: GCC-exception-2.0
> 
> Add the exception text along with the required tags which allow automated
> checking.
> 
> Fixes: 4494ce4fb4ff ("sh: lib: convert to SPDX identifiers")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  LICENSES/exceptions/GCC-exception-2.0 |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
