Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E38FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537E420656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oi9KAOCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfANT7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:59:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfANT7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:59:49 -0500
Received: from zn.tnic (p200300EC2BC4CA00255595821D34C4F7.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:2555:9582:1d34:c4f7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE4BF1EC027A;
        Mon, 14 Jan 2019 20:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547495987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=59V2XOtmfr+MFmz9kmc36KjHs3/FoHJRsfbhDj+coPA=;
        b=oi9KAOCpox6QdDv/RSLeV7sYkX5MFbSGJCq9nHsm7tjlEKnhQqngnMdNb36ljLEiwSyiiK
        r7BQfkueJkzJu84Ksdc136CSxlgIAo2f3gVhC4hQyUe16ipne56x1tTgGan6gv7/UVCY7R
        ixst8IfqWhoBR1cuzibJrzFGg4IDiwA=
Date:   Mon, 14 Jan 2019 20:59:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Anderson <anderson@redhat.com>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190114195940.GS2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
 <20190111123300.GE4729@zn.tnic>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
 <20190114180142.GO2773@zn.tnic>
 <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
 <20190114192144.GQ2773@zn.tnic>
 <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 02:36:47PM -0500, Dave Anderson wrote:
> There's no reading of the dumpfile's memory involved, and that being the case,
> the vmlinux file is not utilized.  That's the whole point of the crash option, i.e.,
> taking a vmcore file, and trying to determine what kernel should be used with it:
> 
>   $ man crash
>   ...
>        --osrelease dumpfile
>               Display the OSRELEASE vmcoreinfo string from a kdump dumpfile header.

I don't understand - if you have the vmcoreinfo (which I assume is part
of the vmcore, yes, no?) you can go and dig out the kernel version from
it, no?

Why should you not utilize the vmcore file?

(I'm most likely missing something.)

> Well, I just don't agree that the OSRELEASE item is "frivolous". It's
> been in place, and depended upon, for many years.

Yeah, no. The ABI argument is moot in this case as in the last couple
of months people have been persuading me that vmcoreinfo is not ABI. So
you guys need to make up your mind what is it. And if it is an ABI, it
wasn't documented anywhere.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
