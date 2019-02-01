Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BEEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E936218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="boDy7RRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfBAKgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:36:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35396 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfBAKgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:36:55 -0500
Received: from zn.tnic (p200300EC2BCC5000604F5F4DB2DDD4A2.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5000:604f:5f4d:b2dd:d4a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B630C1EC0573;
        Fri,  1 Feb 2019 11:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549017413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y6dgqNGKxjLVRYOisp7fL90L39ooug1/p3ypu3O30MQ=;
        b=boDy7RRj/ptX4ISb4KsXYOLbz1J1dXZYI0isv4LQkDBPFIM9+Zg79N3tlYiZjlZ1y4HRow
        o/6Qb4SX4H/TF1hP9NtMZKFIBBPTSrlo51VeFi6ivXwl0qEmwG3nmDa9fazkxJKpmjO7dn
        Az0pRBrUsdInQtbsqTO+erA0QYxSFMs=
Date:   Fri, 1 Feb 2019 11:36:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
Message-ID: <20190201103648.GF31854@zn.tnic>
References: <20190121095338.8565-1-bp@alien8.de>
 <20190131115820.GF6749@zn.tnic>
 <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
 <20190201094217.GB31854@zn.tnic>
 <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201103038.GE31854@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:30:38AM +0100, Borislav Petkov wrote:
> This can't be a full kernel build.

So I did this:

$(obj)/%.s: $(src)/%.c FORCE
        @echo "HERE\n"
        $(call if_changed_dep,cc_s_c)

and did a full kernel build with my .config. I got exactly *three*
"HERE"s in the build log.

So pls explain in more detail how you're measuring that slowdown.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
