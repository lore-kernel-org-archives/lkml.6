Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934756AbeBLPEh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:04:37 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48457 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932240AbeBLPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:04:35 -0500
Date: Mon, 12 Feb 2018 16:04:37 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: longman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4 v6] lib: debugobjects: export max loops counter
In-Reply-To: <1517872708-24207-2-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1802121555100.1158@nanos.tec.linutronix.de>
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com> <1517872708-24207-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Yang Shi wrote:
> @@ -720,7 +721,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
>  	enum debug_obj_state state;
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
> -	int cnt;
> +	int cnt, max_loops = 0;
>  
>  	saddr = (unsigned long) address;
>  	eaddr = saddr + size;
> @@ -765,7 +766,12 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
>  
>  		if (cnt > debug_objects_maxchain)
>  			debug_objects_maxchain = cnt;
> +
> +		max_loops += cnt;

I don't think max_loops is the proper name for this. It's not counting
loops. It's counting the aggregate number of objects inspected for a single
invocation of __debug_check_no_obj_freed() while max_chain records the
chain length in a hash bucket corresponding to a single memory chunk. I'll
fix that up myself. No need to resend.

Thanks,

	tglx
