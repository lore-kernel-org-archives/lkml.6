Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeFDTE3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:04:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751213AbeFDTE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:04:27 -0400
Date: Mon, 4 Jun 2018 14:04:25 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Nadav Amit <namit@vmware.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 2/9] x86: objtool: use asm macro for better compiler
 decisions
Message-ID: <20180604190425.iam6ik5zrjf4wk6v@treble>
References: <20180604112131.59100-1-namit@vmware.com>
 <20180604112131.59100-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604112131.59100-3-namit@vmware.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:21:24AM -0700, Nadav Amit wrote:
> +#ifdef CONFIG_STACK_VALIDATION
> +.macro ANNOTATE_UNREACHABLE counter:req
> +\counter:
> +	.pushsection .discard.unreachable
> +	.long \counter\()b -.
> +	.popsection
> +.endm
> +
> +.macro ANNOTATE_REACHABLE counter:req
> +\counter:
> +	.pushsection .discard.reachable
> +	.long \counter\()b -.
> +	.popsection
> +.endm
> +
> +.macro ASM_UNREACHABLE
> +999:
> +	.pushsection .discard.unreachable
> +	.long 999b - .
> +	.popsection
> +.endm
> +#else /* CONFIG_STACK_VALIDATION */
> +.macro ANNOTATE_UNREACHABLE counter:req
> +.endm
> +
> +.macro ANNOTATE_UNREACHABLE counter:req
> +.endm
> +
> +.macro ASM_UNREACHABLE
> +.endm /* CONFIG_STACK_VALIDATION */
> +#endif

The '/* CONFIG_STACK_VALIDATION */' comment is on the wrong line.

Otherwise:

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
