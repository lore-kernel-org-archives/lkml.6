Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/bYDGnJHUAWDYJMDnz3MbcxN9UXQv2xbno7gVZ/l7S+f0sm9xLGUdRNjQe4Y1J02qIL45t
ARC-Seal: i=1; a=rsa-sha256; t=1523618454; cv=none;
        d=google.com; s=arc-20160816;
        b=tjafvz+oxX4W5AhCzXCUvxvM68lIOjpN5+9fnGvDKtCw7OJNfRuknUbXrLOgcDHzvU
         RsypncPOy5zXnzn56hfSclK/N++gxaXGI4/2Sfr5bVLxty0IXUMGg22XFKdV46Qq8jD6
         L9dpcXIch5TswD8x0M24br+p1J6gHaX0DIWJL14F+OoaooUPCbH0yTeVMADNl8YVu/fr
         az3hWm89r/zzHVOBULTwetvFu6YqIAS3o6VaJI95YgV3jZ7OcTsKfZ1beJQKGjvxMuEb
         1SwsyPQTZzZ1w+tsbgDcs2YSzFkhv6TuY7fwz7lyd29Qus1A+bhNq4URO97WrrXDt/le
         XEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=pzPJfLw9XpcrDuu7UPNhLCdHwFZW4pKuQBi8RIQB73I=;
        b=NzOR3ggUTc9Pa2y9cIaXd+32HF6VOG1QU1SFNVLkIWm/oBE1i6DaMNBX+QA4Tdpb56
         ngVk6pxvYiQEuAA1z2dEju0K7fWJmn5thWjDuD63KvY1Jq9t8Kb6vKeSb7CXF1PU8Jb1
         x+zLo6ir4lSdPDuVAI4qwkf/pe6R7YCTjthDfi4DxbY2msmdt+qsLNgpxoFvM73bZT6l
         UU22cL5rbh5RoBM54Ruk50zqW8GyygWETVKVgVAKONk3YiPxSvmeyecDf/Gcokvsicmb
         sfHAc+yJEZBJ+Dj9nOmpAPjoZztWTNYGUsCextIBtxw67luOkNG7h9pCuUaqWtBp/Rlk
         pOJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeDMLUp (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 13 Apr 2018 07:20:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:38647 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbeDMLUm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Apr 2018 07:20:42 -0400
Date: Fri, 13 Apr 2018 13:20:40 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        =?ISO-8859-2?Q?Libor_Pech=E1=E8ek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
In-Reply-To: <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1804131118080.17969@pobox.suse.cz>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com> <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1597629744054555698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, 12 Apr 2018, Joe Lawrence wrote:

> Add a few livepatch modules and simple target modules that the included
> regression suite can run tests against.

Could you include a brief description which features are tested?
 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---

> diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
> new file mode 100644
> index 000000000000..18c75b21cb9e
> --- /dev/null
> +++ b/lib/livepatch/test_klp_shadow_vars.c
>
> +/*
> + * Shadow variable wrapper functions that echo the function and arguments
> + * to the kernel log for testing verification.  Don't display raw pointers,
> + * but use the ptr_id() value instead.
> + */
> +void *shadow_get(void *obj, unsigned long id)
> +{
> +	void *ret = klp_shadow_get(obj, id);
> +
> +	pr_info("klp_%s(obj=PTR%d, id=0x%lx) = PTR%d\n",
> +		__func__, ptr_id(obj), id, ptr_id(ret));
> +
> +	return ret;
> +}

> +void shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor)
> +{
> +	klp_shadow_free(obj, id, dtor);
> +	pr_info("klp_%s(obj=PTR%d, id=0x%lx, dtor=PTR%d)\n",
> +		__func__, ptr_id(obj), id, ptr_id(dtor));
> +}

Sparse (make C=1) would be happier with those two being static.

Otherwise it works as expected. Good job!

Miroslav
