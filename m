Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C798CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4C20675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Paq2VwFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfBVWUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:20:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39528 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfBVWUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:20:50 -0500
Received: from zn.tnic (p200300EC2BCB39004460C94D34A9E8FA.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:3900:4460:c94d:34a9:e8fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF60D1EC0324;
        Fri, 22 Feb 2019 23:20:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550874048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AlK/kL4/y+YHfuL3kGdAvpR3bkY8SHc/ISKko6tneDE=;
        b=Paq2VwFUMeNU3/iTOnTiT76qIiLfs4kPAL5FbQR8b6Qy6+MZRd/0Oe83WEl6FvGd7kVTso
        4NH/xsVdcAS4j/0NRncYVsWTvRsUuD+TTx/vHRLh4StpNMxSOlX5UPCG30co5FCUeS+fjB
        emd3o4/E2PuFnLeW0z5rhL0wEq+mq/g=
Date:   Fri, 22 Feb 2019 23:20:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>
Cc:     douly.fnst@cn.fujitsu.com, hpa@zytor.com, konrad.wilk@oracle.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, puwen@hygon.cn, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, wang.yi59@zte.com.cn, x86@kernel.org
Subject: Re: WARNING in rcu_check_gp_start_stall
Message-ID: <20190222222036.GC30766@zn.tnic>
References: <0000000000007da94e05827ea99a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000007da94e05827ea99a@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 09:10:04AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    8a61716ff2ab Merge tag 'ceph-for-5.0-rc8' of git://github...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1531dd3f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
> dashboard link: https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4966cc00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c492d0c00000

So I ran this for more than an hour in a guest here with the above
.config but nothing happened. The compiler I used is 8.2, dunno of that
makes the difference or I'm missing something else...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
