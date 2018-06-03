Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbeFCT4A (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 15:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeFCTz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 15:55:58 -0400
Date: Sun, 3 Jun 2018 21:55:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Banman <abanman@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/platform/uv/BAU: gracefully disable BAU during panic
Message-ID: <20180603195535.GB7941@kroah.com>
References: <1528044152-148686-1-git-send-email-abanman@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528044152-148686-1-git-send-email-abanman@hpe.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 11:42:32AM -0500, Andrew Banman wrote:
> When panic happens while BAU is active there is a chance that
> outstanding broadcasts tie up BAU resources enough to cause timeouts in
> the UV ASIC. These timeouts are hardware errors that immediately bring
> down the system, preventing kdump from completing.
> 
> Add uv_bau_crash_shutdown() to bring BAU to quiescence during panic before
> continuing with the native crash shutdown. Assign uv_bau_crash_shutdown
> to machine_ops during init.
> 
> Signed-off-by: Andrew Banman <abanman@hpe.com>
> ---
>  arch/x86/platform/uv/tlb_uv.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
