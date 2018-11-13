Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4EDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C8E2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C8E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeKMU07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:26:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:58488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731276AbeKMU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:26:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C85B6B6CE;
        Tue, 13 Nov 2018 10:29:29 +0000 (UTC)
Date:   Tue, 13 Nov 2018 11:29:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20181113102929.GO15120@dhcp22.suse.cz>
References: <20181112160931.GA28463@redhat.com>
 <20181112160956.GA28472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160956.GA28472@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-11-18 17:09:56, Oleg Nesterov wrote:
> Large enterprise clients often times run applications out of networked
> file systems where the IT mandated layout of project volumes can end up
> leading to paths that are longer than 128 characters. Bumping this up to
> the next order of two solves this problem in all but the most egregious
> case while still fitting into a 512b slab.
> 
> Reported-by: Ben Woodard <woodard@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Increasing it to a larger value wouldn't hurt but I wouldn't bind it to
the page size because the layout might change and result in higher order
request.

> ---
>  include/uapi/linux/binfmts.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> index 4abad03..689025d 100644
> --- a/include/uapi/linux/binfmts.h
> +++ b/include/uapi/linux/binfmts.h
> @@ -16,6 +16,6 @@ struct pt_regs;
>  #define MAX_ARG_STRINGS 0x7FFFFFFF
>  
>  /* sizeof(linux_binprm->buf) */
> -#define BINPRM_BUF_SIZE 128
> +#define BINPRM_BUF_SIZE 256
>  
>  #endif /* _UAPI_LINUX_BINFMTS_H */
> -- 
> 2.5.0
> 
> 

-- 
Michal Hocko
SUSE Labs
