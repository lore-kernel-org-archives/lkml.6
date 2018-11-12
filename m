Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8BCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E2822419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E2822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeKLWDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:03:04 -0500
Received: from cheddar.halon.org.uk ([93.93.131.118]:52274 "EHLO
        cheddar.halon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbeKLWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:03:04 -0500
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 17:03:03 EST
Received: from bsmtp by cheddar.halon.org.uk with local-bsmtp (Exim 4.89)
        (envelope-from <93sam@debian.org>)
        id 1gMAiN-0002yv-8N; Mon, 12 Nov 2018 11:49:11 +0000
Received: from steve by tack.einval.org with local (Exim 4.89)
        (envelope-from <93sam@debian.org>)
        id 1gMAiH-00019k-4j; Mon, 12 Nov 2018 11:49:05 +0000
Date:   Mon, 12 Nov 2018 11:49:05 +0000
From:   Steve McIntyre <93sam@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 087/361] signal: Introduce COMPAT_SIGMINSTKSZ for
 use in compat_sys_sigaltstack
Message-ID: <20181112114857.2aidwlw2podpzytb@tack.einval.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221632.025807083@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111221632.025807083@linuxfoundation.org>
X-attached: none
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 02:17:14PM -0800, Greg Kroah-Hartman wrote:
>4.19-stable review patch.  If anyone has any objections, please let me know.
>
>------------------
>
>From: Will Deacon <will.deacon@arm.com>
>
>[ Upstream commit 22839869f21ab3850fbbac9b425ccc4c0023926f ]
>
>The sigaltstack(2) system call fails with -ENOMEM if the new alternative
>signal stack is found to be smaller than SIGMINSTKSZ. On architectures
>such as arm64, where the native value for SIGMINSTKSZ is larger than
>the compat value, this can result in an unexpected error being reported
>to a compat task. See, for example:
>
>  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=904385

...

Thanks Greg! If it's not too much effort, could you also take this for
4.9-stable as well please? That would get it into our next Debian
stable update too. :-)

Thanks,

Steve

-- 
Steve McIntyre, Cambridge, UK.                                steve@einval.com
"I suspect most samba developers are already technically insane... Of
 course, since many of them are Australians, you can't tell." -- Linus Torvalds

