Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C1FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87DC2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XoEKadqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfBWK47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:56:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50472 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfBWK46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:56:58 -0500
Received: from zn.tnic (p200300EC2BDB49004460C94D34A9E8FA.dip0.t-ipconnect.de [IPv6:2003:ec:2bdb:4900:4460:c94d:34a9:e8fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B3AC1EC0AB0;
        Sat, 23 Feb 2019 11:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550919416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bFGDb1BVrzjjFrxF9SWaWrISLDtyesRL9V7fYdumF+8=;
        b=XoEKadqU9OsicMMKsiq/gTXDWSCDMQN+Ao3hM3pApbRN9v79RhluHXUWciSP8FnPBAbGXs
        34HIkKrznrq8437r0wo+jxy/pK34WpD5l2SIPqM9p3zZd2RCtsvJ2MUoecRMe5UeZW3P1A
        SETZ9DWLCnTq8R7ikByyHhbOLrAmCR8=
Date:   Sat, 23 Feb 2019 11:56:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, konrad.wilk@oracle.com,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, puwen@hygon.cn,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, wang.yi59@zte.com.cn,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in rcu_check_gp_start_stall
Message-ID: <20190223105638.GA27239@zn.tnic>
References: <0000000000007da94e05827ea99a@google.com>
 <20190222222036.GC30766@zn.tnic>
 <CACT4Y+aq+5Hor2f-SsaO4VW3p1Xq2Xk-2OUeKhpp=aOx0XMmzg@mail.gmail.com>
 <20190223103809.GB23376@zn.tnic>
 <CACT4Y+ZaUe+_ZT4tLpXWUtfih4ocNgAsa4WdV4NRceLdK4tc4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZaUe+_ZT4tLpXWUtfih4ocNgAsa4WdV4NRceLdK4tc4Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 11:50:49AM +0100, Dmitry Vyukov wrote:
> Peter, what is the canonical location to reference for this issue
> (open bug or something)? When we get back to this report later, how
> does one know if this is fixed or not and what's the status?

bugzilla.kernel.org maybe?

> The C repro hanged the machine even faster, so it must be some other difference.
> I would expect compiler to not make difference. qemu, number of CPUs
> and maybe host kernel config (at least for interrupt granularity or
> something?) may be relevant.
> 
> But if you want to run syzkaller reproducer with syz-execprog, there
> is a docs link in the "syz repro" link.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
