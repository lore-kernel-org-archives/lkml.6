Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeFAQRE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:17:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751932AbeFAQRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:17:01 -0400
Date: Fri, 1 Jun 2018 18:16:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 10/17] signal: make has_pending_signals() return bool
Message-ID: <20180601161657.GD1058@redhat.com>
References: <20180601132239.4421-1-christian@brauner.io>
 <20180601132239.4421-11-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601132239.4421-11-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Christian Brauner wrote:
>
> has_pending_signals() already behaves like a boolean function. Let's
> actually declare it as such too.

But this patch does more.

> -	case 4: ready  = signal->sig[3] &~ blocked->sig[3];
> -		ready |= signal->sig[2] &~ blocked->sig[2];
> -		ready |= signal->sig[1] &~ blocked->sig[1];
> -		ready |= signal->sig[0] &~ blocked->sig[0];
> +	case 4:
> +		ready = signal->sig[3] & ~blocked->sig[3];
> +		ready |= signal->sig[2] & ~blocked->sig[2];
> +		ready |= signal->sig[1] & ~blocked->sig[1];
> +		ready |= signal->sig[0] & ~blocked->sig[0];
>  		break;

Again, personally I do not care at all. But why do you think the code looks
better after re-formatting? This is subjective, but to me it does not.

In particular, note the extra space before "=" removed by this patch. I guess
it was added on purpose, and to me

	ready  = signal->sig[3] &~ blocked->sig[3];
	ready |= signal->sig[2] &~ blocked->sig[2];

actually looks better thab

	ready = signal->sig[3] &~ blocked->sig[3];
	ready |= signal->sig[2] &~ blocked->sig[2];

after your patch.

Oleg.
