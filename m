Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97B7C4646A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E09C2178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGY6DCr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E09C2178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeHCXVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:21:00 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39808 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeHCXU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:20:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id m1-v6so3081626plt.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sa9nRDr+KZmYiB4Q4AxYE2odyaq1ujZfd7MiDXmrgzo=;
        b=DGY6DCr4/XZPHyFEuVH1JPs69RGFD2wZVnY3uVZmgkcNOwm2w0S9f9AkC9hjwJiKMY
         gP8ASLh3ij6NauvFeQB9EKvsFi1t3Vdn5CfB8XghCoUqb/M3sRpdZkkYnw9xYuAAyy94
         OEIzmC9/SO5XGXPXpcxlrSc/p+/Bu/wfs0VMnRftxbcVOJ9hn3hV9/EpiE19M7R5xnHk
         ziBZXHRbioOBEWcuFiNGoZXchBQS6Jwi/Q6IdC2rmI07aS6tORzxFy58OeRCIFCw7n9K
         X6M8UAKSpxFD/AAHTIHcBbwoKX04yZOyp0zy7dIDSbTGql4v83od/gQlvP4bqHifuK+h
         sUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sa9nRDr+KZmYiB4Q4AxYE2odyaq1ujZfd7MiDXmrgzo=;
        b=ScWvZD8G/gx5g5QQO6lHyOiiLOZGWADV3LLyxB4WKAf/pwqmzuOYQmmAWuDGqMvdSs
         TOYUGIWCQJHQTvl8BMYgd+2/oc9JTwSBXEwwEeZyGYFzHM/eMZA1295PLbD/VCr7todM
         paDfCXD7D8kdDrmeFcF6h9FBkWZzLqFuGiM+6wf9kwQEdzj56qVUDrJLQLsrLfQ+Uv8b
         tO/zlTmctSHH7lXdHriMwifAtOrzlFgC/D0dQm2qMlw1oCfg7bmflUsfDFi7QIh/K3tA
         dRDvdxo8tRayh5EoO+FATEsXO3B2v3L14sgMAFtz28k/hPNopsOysLxwPLcvgD3aWvqr
         2gdw==
X-Gm-Message-State: AOUpUlE50D3XN6YnYH0hDj+lBbCJ4hXxGmQTlsRP/FCiZ0RbteQ1nRT3
        ghWVqyeBPFmxfNDL1Cd6XtM=
X-Google-Smtp-Source: AAOMgpdIVX1PL+jLr7Qj3n15cPAT+m4YoeRUJZU6t7DepnzPrwyctjZ4uRo1lM8wdbd9rbrC4WSojQ==
X-Received: by 2002:a17:902:6b:: with SMTP id 98-v6mr4979359pla.68.1533331379454;
        Fri, 03 Aug 2018 14:22:59 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y3-v6sm13959449pfi.24.2018.08.03.14.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 14:22:58 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:22:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v3 2/2] slab: __GFP_ZERO is incompatible with a
 constructor
Message-ID: <20180803212257.GA5922@roeck-us.net>
References: <20180411060320.14458-1-willy@infradead.org>
 <20180411060320.14458-3-willy@infradead.org>
 <alpine.DEB.2.20.1804110842560.3788@nuc-kabylake>
 <20180411192448.GD22494@bombadil.infradead.org>
 <alpine.DEB.2.20.1804111601090.7458@nuc-kabylake>
 <20180411235652.GA28279@bombadil.infradead.org>
 <alpine.DEB.2.20.1804120907100.11220@nuc-kabylake>
 <20180412142718.GA20398@bombadil.infradead.org>
 <20180412191322.GA21205@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412191322.GA21205@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 12, 2018 at 12:13:22PM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> __GFP_ZERO requests that the object be initialised to all-zeroes,
> while the purpose of a constructor is to initialise an object to a
> particular pattern.  We cannot do both.  Add a warning to catch any
> users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> a constructor.
> 
> Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Michal Hocko <mhocko@suse.com>

Seen with v4.18-rc7-139-gef46808 and v4.18-rc7-178-g0b5b1f9a78b5 when
booting sh4 images in qemu:

ata1: PATA max PIO0 mmio cmd 0xb4001000 ctl 0xb400080c irq 107
physmap platform flash device: 02000001 at 00000000
WARNING: CPU: 0 PID: 926 at mm/slab.c:2666 cache_alloc_refill+0x8a/0x594
Modules linked in:

CPU: 0 PID: 926 Comm: kworker/u2:2 Not tainted 4.18.0-rc7-00139-gef46808 #1
PC is at cache_alloc_refill+0x8a/0x594
PR is at kmem_cache_alloc+0x72/0xac
PC  : 8c0b1e06 SP  : 8fad5ed8 SR  : 400080f0 
TEA : c0087fe0
R0  : 00008000 R1  : 006080c0 R2  : 006080c0 R3  : 8c01e110
R4  : 8f801a00 R5  : 00000000 R6  : 00000000 R7  : 00000000
R8  : 0000000c R9  : 006080c0 R10 : 8c48302c R11 : 8fae8e60
R12 : 8f802540 R13 : 8f801a00 R14 : 8c4f22e8
MACH: 00000085 MACL: 00000e00 GBR : 00000000 PR  : 8c0b244e

Call trace:
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] kmem_cache_alloc+0x72/0xac
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] mm_init.isra.7+0xb4/0x104
 [<(ptrval)>] __do_execve_file+0x1f8/0x5b4
 [<(ptrval)>] do_execve+0x16/0x24
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] call_usermodehelper_exec_async+0xe0/0x124
 [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
 [<(ptrval)>] schedule_tail+0x0/0x54
 [<(ptrval)>] call_usermodehelper_exec_async+0x0/0x124

---[ end trace 10ff75dd606d4222 ]---

This is not a a new trace; I had missed it because the "cut here" line
is missing from the log.

qemu command line:

qemu-system-sh4 -M r2d -kernel ./arch/sh/boot/zImage \
	-initrd rootfs.cpio \
	-append 'rdinit=/sbin/init console=ttySC1,115200 noiotrap' \
	-serial null -serial stdio -net nic,model=rtl8139 \
	-net user -nographic -monitor null

Guenter
