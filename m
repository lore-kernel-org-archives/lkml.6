Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03FFC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F16221A4C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qFZh+Gyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBJMjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 07:39:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33676 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBJMjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 07:39:31 -0500
Received: from zn.tnic (p200300EC2BE58200C583E857A3A25DF2.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:8200:c583:e857:a3a2:5df2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 915B61EC096B;
        Sun, 10 Feb 2019 13:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549802369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/hqlHO3RKoHMt3ldxnJyC1UkINGbMwJ5xgn6raXzQJY=;
        b=qFZh+GylLZSxBhtn1hm8IHNRfyd1lDIFbyhQaLFUoqvzGtTuXRwoKV42Qab8gYsH2o6O+f
        JPVNQyvSJQugWYOlPJDv5SsqkOxOoBdvlj40ytJxn5We5jO2LFLFXd+M+xp7+JOQdIVSLR
        dQwqXFkxDaFpnRfaFHJZpmWLyv9LsxY=
Date:   Sun, 10 Feb 2019 13:39:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
Message-ID: <20190210123923.GA14948@zn.tnic>
References: <20190201094217.GB31854@zn.tnic>
 <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic>
 <20190201103648.GF31854@zn.tnic>
 <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
 <20190201151139.GK31854@zn.tnic>
 <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
 <20190202144227.GC27822@zn.tnic>
 <20190206104729.GC7314@zn.tnic>
 <CAK7LNAT+GhbEwP7v7NWd2kqW76qbXM1mtKhc21YXkp7BUJjzKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAT+GhbEwP7v7NWd2kqW76qbXM1mtKhc21YXkp7BUJjzKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 03:51:01PM +0900, Masahiro Yamada wrote:
> I am still wondering,
> but if this is really worth doing in upstream code,

Yes, it is very worth doing it:

make <path-to-file>.s

is one of the basic steps one does when trying to pinpoint the Code:
line in a splat back to the code gcc generated.

> I think the following is a simpler idea.

Yes, you can do it this way too but I can't apply it here to play with
it because gmail probably corrupted the diff:

checking file Makefile
Hunk #1 FAILED at 729.
1 out of 1 hunk FAILED
checking file scripts/Makefile.build
patch: **** malformed patch at line 98: $(DISABLE_LTO) -fverbose-asm -S -o $@ $<

Please attach the diff or send it from another mail server.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
