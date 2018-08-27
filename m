Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D417C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19A0208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19A0208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeH0W7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:59:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726823AbeH0W7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:59:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FC728A9F1;
        Mon, 27 Aug 2018 19:11:26 +0000 (UTC)
Received: from treble (ovpn-120-34.rdu2.redhat.com [10.10.120.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 482A92026E18;
        Mon, 27 Aug 2018 19:11:25 +0000 (UTC)
Date:   Mon, 27 Aug 2018 14:11:23 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] objtool: remove workaround for unreachable warnings from
 old GCC
Message-ID: <20180827191123.meeqzru5y2kwnd47@treble>
References: <1535341183-19994-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1535341183-19994-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 27 Aug 2018 19:11:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 27 Aug 2018 19:11:26 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:39:43PM +0900, Masahiro Yamada wrote:
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> bumped the minimum GCC version to 4.6 for all architectures.
> 
> This effectively reverts commit da541b20021c ("objtool: Skip
> unreachable warnings for GCC 4.4 and older"), which was a workaround
> for GCC 4.4 or older.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

> ---
> 
>  scripts/Makefile.build | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 1c48572..5a2d1c9 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -246,8 +246,6 @@ objtool_args += --no-fp
>  endif
>  ifdef CONFIG_GCOV_KERNEL
>  objtool_args += --no-unreachable
> -else
> -objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
>  endif
>  ifdef CONFIG_RETPOLINE
>  ifneq ($(RETPOLINE_CFLAGS),)
> -- 
> 2.7.4
> 

-- 
Josh
