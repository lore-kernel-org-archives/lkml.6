Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeBWWqj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:46:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751907AbeBWWqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:46:38 -0500
Subject: Re: [PATCH] x86/kvm: Make parse_no_xxx __init for kvm
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org
Cc: rkrcmar@redhat.com, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        x86@kernel.org
References: <20180117034654.26840-1-douly.fnst@cn.fujitsu.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50bb8832-a532-f0f8-ae96-b93cbbe42b2a@redhat.com>
Date: Fri, 23 Feb 2018 23:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180117034654.26840-1-douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2018 04:46, Dou Liyang wrote:
> The early_param() is only called during kernel initialization, So Linux
> marks the functions of it with __init macro to save memory.
> 
> But it forgot to mark the parse_no_kvmapf/stealacc/kvmclock_vsyscall,
> So, Make them __init as well.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: rkrcmar@redhat.com
> Cc: kvm@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  arch/x86/kernel/kvm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index b40ffbf156c1..06801b0069db 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -49,7 +49,7 @@
>  
>  static int kvmapf = 1;
>  
> -static int parse_no_kvmapf(char *arg)
> +static int __init parse_no_kvmapf(char *arg)
>  {
>          kvmapf = 0;
>          return 0;
> @@ -58,7 +58,7 @@ static int parse_no_kvmapf(char *arg)
>  early_param("no-kvmapf", parse_no_kvmapf);
>  
>  static int steal_acc = 1;
> -static int parse_no_stealacc(char *arg)
> +static int __init parse_no_stealacc(char *arg)
>  {
>          steal_acc = 0;
>          return 0;
> @@ -67,7 +67,7 @@ static int parse_no_stealacc(char *arg)
>  early_param("no-steal-acc", parse_no_stealacc);
>  
>  static int kvmclock_vsyscall = 1;
> -static int parse_no_kvmclock_vsyscall(char *arg)
> +static int __init parse_no_kvmclock_vsyscall(char *arg)
>  {
>          kvmclock_vsyscall = 0;
>          return 0;
> 

Queued, thanks.

Paolo
