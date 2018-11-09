Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1996B20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1996B20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeKIUfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:35:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55404 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeKIUfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:35:51 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sGylahfVADgx; Fri,  9 Nov 2018 11:55:46 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D38BD1EC00E8;
        Fri,  9 Nov 2018 11:55:45 +0100 (CET)
Date:   Fri, 9 Nov 2018 11:55:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     wang.yi59@zte.com.cn, Greg KH <gregkh@linuxfoundation.org>
Cc:     matz@suse.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] x86/cpu: fix prototype warning
Message-ID: <20181109105538.GA21243@zn.tnic>
References: <20181108172225.GH7543@zn.tnic>
 <201811090843126464658@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201811090843126464658@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:43:12AM +0800, wang.yi59@zte.com.cn wrote:
> Yeah, so that is. However, I suppose we should not enable this by default
> before we fix ALL of these warning,

Yeah, the build is really noisy now.

> which is really a  hard work. :)

Yeah, I wonder if adding this to a kernel janitors TODO list or somesuch
would help speeding up the process.

Maybe Greg knows.

Greg, the question is whether we can get people to help out with

  -Wmissing-prototypes

fixes around the tree. Currently, there are ~1400 warnings and we want
to have 0 and then add that option to the main Makefile.

It is very easy to do: you simply build the kernel with W=1, choose one
-Wmissing-prototypes warning and fix it by adding a function prototype
or declaring the function static.

It should be a pretty easy for newbies to get involved...

> Aha, I will try my best to to work on this, and as you said, that's a long
> road to go, so maybe I would only work on modules which I am familiar with. ;-)

Sounds good.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
