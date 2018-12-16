Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6DBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79439217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fj9j1T3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeLPLMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:12:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbeLPLMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:12:34 -0500
Received: from zn.tnic (p200300EC2BE55900ADD97DAFC8659476.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:5900:add9:7daf:c865:9476])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 322E91EC0B86;
        Sun, 16 Dec 2018 12:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544958751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLl7Z2RPNaHQT4UGOcpi8DPgJRuiogxJlHdEteQ+wxQ=;
        b=Fj9j1T3a9gdTUaVUlAAaDgwOB+kUvsBKM6scVLmzwxlnF+dWOW4NnaAwvGAojOj39KiX2v
        /d0B3e4MYAIgr5sR/+ngbGISWxVoW4Bqmqm0NlA3sJ/TGcblPZsCh+qJD/Z87R0kBRaJw+
        cddKgcxMln5AOE/qfT8N5ljsJcYNdqI=
Date:   Sun, 16 Dec 2018 12:12:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with late AMD microcode reload/feedback
Message-ID: <20181216111228.GE815@zn.tnic>
References: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
 <20181216000510.GC6693@zn.tnic>
 <bac495ca-ccfd-3551-97ca-1444a391fa40@gmail.com>
 <20181216100645.GB815@zn.tnic>
 <CACna6rynZtBC8YiGOD_YkwobvUsYxRqzsqwG0fNjs-LL+K2Oig@mail.gmail.com>
 <20181216104453.GD815@zn.tnic>
 <CACna6ryc2QacKUeSBH5ZVGazOR0-jTeNi7fhm9hGpaXtRJLD+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6ryc2QacKUeSBH5ZVGazOR0-jTeNi7fhm9hGpaXtRJLD+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 12:02:49PM +0100, Rafał Miłecki wrote:
> OK, if you say so, I'll try not to panic seeing those errors repeating
> over and over.

Yes, patience is the key :-)

> I know such issues may take months or years to get fixed, so I was
> trying to do some hacking on my own. I'll try some patience :)

Well, if you wanna hack on stuff, there's a lot more you can do which is
100% safe.

Like getting rid of -Wmissing-prototypes warnings, for example, so that
we can enable this option per default. If you're interested, see here:

https://marc.info/?l=kernel-janitors&m=154178546220848&w=2

It is not hardcore stuff but if you're looking for doing some work on
the kernel, that would be one thing to do.

And of course there's the ever-so-helpful testing of linux-next kernels
on old/spare hardware and trying to fix any issues there. Or reviewing
patches on lkml.

It all depends on what kind of "hacking" you wanna do.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
