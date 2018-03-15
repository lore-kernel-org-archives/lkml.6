Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeCOJj2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:39:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52913 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:39:27 -0400
Date: Thu, 15 Mar 2018 10:39:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: vdso: eliminate some redundant loads in
 update_vsyscall
In-Reply-To: <20180314233408.30083-1-linux@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.21.1803151037150.1525@nanos.tec.linutronix.de>
References: <20180314233408.30083-1-linux@rasmusvillemoes.dk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Rasmus Villemoes wrote:
> diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
> index e1216dd95c04..550447a43a50 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
> @@ -31,6 +31,7 @@ void update_vsyscall(struct timekeeper *tk)
>  {
>  	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
>  	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
> +	int shift;

Not that it is a big issue, but the shift value in the timekeeper is
unsigned. So please use an unsigned here as well.

Thanks,

	tglx
