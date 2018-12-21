Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC47C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6859421903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XxVl2hsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbeLUQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:13:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55814 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeLUQNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:13:01 -0500
Received: from zn.tnic (p200300EC2BD1800085E495616F32D17F.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8000:85e4:9561:6f32:d17f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9982A1EC0980;
        Fri, 21 Dec 2018 17:13:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545408780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Svq6/fgzmeLokrW/KjAf3UpDO+H3IAqw0Yo5pBQ2Iwg=;
        b=XxVl2hsICvYXIXxcYdbM3q4dDzh3dhD25Y++faIlpS7P7wHuzJhjz1PJBsDs0XY47kSLvL
        k9qHBLdXwwdez1gZW6KJ7Ni6wIzy7OMJzSVZyad0KIAYqCQcCnzcSOolIMxGe+KZOvfUq2
        ETrmAGgbR/l5C5ImQmTkh6ns+eErudk=
Date:   Fri, 21 Dec 2018 17:12:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] x86/cpu: sort cpuinfo flags
Message-ID: <20181221161255.GF1325@zn.tnic>
References: <20181219195014.A0962820@viggo.jf.intel.com>
 <20181220120240.ermrc3hnixkin2yg@black.fi.intel.com>
 <20181220160411.GC31403@zn.tnic>
 <20181221124037.s57lt567pgzbz7z3@black.fi.intel.com>
 <20181221130403.GD1325@zn.tnic>
 <dfd39410-7b02-c478-7228-820ab737d4a1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfd39410-7b02-c478-7228-820ab737d4a1@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 07:19:06AM -0800, Dave Hansen wrote:
> /proc/cpuinfo is supposed to be human-readable.  But, the flags field,
> as it stands, is not.  You've further proved my point by having to
> machine post-process it to make it usable by humans. :)

No, it is usable now as it is. *You* claimed it isn't and I showed you
that you can sort this thing without adding code to the kernel, so that
you can have it sorted too, without the need to add more useless code to
the kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
