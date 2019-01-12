Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99E9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887C206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfALT22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:28:28 -0500
Received: from hall.aurel32.net ([163.172.24.10]:49498 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfALT22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:28:28 -0500
X-Greylist: delayed 1271 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jan 2019 14:28:27 EST
Received: from [2a01:e35:2e4c:a861:655e:aef3:f589:b897] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aurelien@aurel32.net>)
        id 1giOck-0002jM-Pr; Sat, 12 Jan 2019 20:07:14 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.91)
        (envelope-from <aurelien@aurel32.net>)
        id 1giOcj-0005bb-WB; Sat, 12 Jan 2019 20:07:14 +0100
Date:   Sat, 12 Jan 2019 20:07:13 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H . J . Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH] vfs: fix preadv64v2 and pwritev64v2 compat syscalls with
 offset == -1
Message-ID: <20190112190713.GA21480@aurel32.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H . J . Lu" <hjl.tools@gmail.com>
References: <20181206190534.16246-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206190534.16246-1-aurelien@aurel32.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-06 20:05, Aurelien Jarno wrote:
> The preadv2 and pwritev2 syscalls are supposed to emulate the readv and
> writev syscalls when offset == -1. Therefore the compat code should
> check for offset before calling do_compat_preadv64 and
> do_compat_pwritev64. This is the case for the preadv2 and pwritev2
> syscalls, but handling of offset == -1 is missing in their 64-bit
> equivalent.
> 
> This patch fixes that, calling do_compat_readv and do_compat_writev when
> offset == -1. This fixes the following glibc tests on x32:
>  - misc/tst-preadvwritev2
>  - misc/tst-preadvwritev64v2
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  fs/read_write.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Any news about this patch?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
