Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150C0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E010F20874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfAJTUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:20:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfAJTUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:20:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 634F2C07457B;
        Thu, 10 Jan 2019 19:20:03 +0000 (UTC)
Received: from redhat.com (ovpn-123-72.rdu2.redhat.com [10.10.123.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id 15D0F1001944;
        Thu, 10 Jan 2019 19:19:59 +0000 (UTC)
Date:   Thu, 10 Jan 2019 14:19:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Ariel.Elior@cavium.com, davem@davemloft.net,
        jasowang@redhat.com, john.fastabend@gmail.com,
        parri.andrea@gmail.com, dhowells@redhat.com, ebiederm@xmission.com,
        james.morris@microsoft.com, paul@paul-moore.com,
        zohar@linux.vnet.ibm.com, mjg59@google.com,
        viro@zeniv.linux.org.uk, richard_c_haines@btinternet.com,
        sargun@sargun.me, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] include/linux: Remove duplicate header
Message-ID: <20190110141930-mutt-send-email-mst@kernel.org>
References: <20190110160114.GA5641@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110160114.GA5641@hp-pavilion-15-notebook-pc-brajeswar>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 10 Jan 2019 19:20:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:31:14PM +0530, Brajeswar Ghosh wrote:
> Remove duplicate headers which are included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  include/linux/perf_event.h | 1 -
>  include/linux/ptr_ring.h   | 1 -
>  include/linux/qed/qed_if.h | 1 -
>  include/linux/security.h   | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f0ca79..8d7a2b65514b 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -53,7 +53,6 @@ struct perf_guest_info_callbacks {
>  #include <linux/atomic.h>
>  #include <linux/sysfs.h>
>  #include <linux/perf_regs.h>
> -#include <linux/workqueue.h>
>  #include <linux/cgroup.h>
>  #include <asm/local.h>
>  
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 6894976b54e3..627b7aa067e0 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -26,7 +26,6 @@
>  #include <linux/cache.h>
>  #include <linux/types.h>
>  #include <linux/compiler.h>
> -#include <linux/cache.h>
>  #include <linux/slab.h>
>  #include <asm/errno.h>
>  #endif


Acked-by: Michael S. Tsirkin <mst@redhat.com>


Pls merge through the trivial tree or similar.


> diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
> index a47321a0d572..9ebdb60f605a 100644
> --- a/include/linux/qed/qed_if.h
> +++ b/include/linux/qed/qed_if.h
> @@ -38,7 +38,6 @@
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
>  #include <linux/skbuff.h>
> -#include <linux/types.h>
>  #include <asm/byteorder.h>
>  #include <linux/io.h>
>  #include <linux/compiler.h>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ac0ef467d25e..2915ea6a5b77 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -30,7 +30,6 @@
>  #include <linux/err.h>
>  #include <linux/string.h>
>  #include <linux/mm.h>
> -#include <linux/fs.h>
>  
>  struct linux_binprm;
>  struct cred;
> -- 
> 2.17.1
