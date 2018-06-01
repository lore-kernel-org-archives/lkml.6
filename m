Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeFAP4S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:56:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752960AbeFAP4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:56:15 -0400
Date: Fri, 1 Jun 2018 17:56:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 03/17] signal: make may_ptrace_stop() return bool
Message-ID: <20180601155612.GB1058@redhat.com>
References: <20180601132239.4421-1-christian@brauner.io>
 <20180601132239.4421-4-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601132239.4421-4-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Christian Brauner wrote:
>
> may_ptrace_stop() already behaves like a boolean function. Let's actually
> declare it as such too.

OK. Then probably this patch should only make it return bool and do nothing else?

> -	if (unlikely(current->mm->core_state) &&
> -	    unlikely(current->mm == current->parent->mm))
> -		return 0;
> +	if (likely(!current->mm->core_state ||
> +		   current->mm != current->parent->mm))
> +		return false;

this is wrong.

Oleg.
