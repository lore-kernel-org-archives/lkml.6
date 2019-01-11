Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04549C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E712177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNX4uAlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfAKKHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:07:08 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42564 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfAKKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:07:08 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so11759677ioa.9;
        Fri, 11 Jan 2019 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tV770gtlc+wsy+UJoYxGMN9qBxuKgWLEh7SlyYwABc=;
        b=cNX4uAlETZADN8aGRufMP3D/4vQLNg3X69OiSMjhjWYl7auJI9j39DuE573wzYBGPB
         Z54d5fPFgjAi6qVJ+oWkKC2s4Q8LQXwrsMqf/Xqe5JAX+Ih3hgn/w1hVd1LMrQ2RwSxm
         DLjcGH7rmc6U9CbplCjwBYbbNR1zJ3hBsKXnndGo291m4QEMvTkV2e+IiaOyqrAvm3l8
         sop06tgie9xWkc+XMY4MO8IzM3AiwyEGYDE02eCIDXqlt467X05ipHMqhcdd+jbMOH08
         +xEvlP6cymto4k/R9yxie0s814znsJDeXyjjXz5Zr4zPOaoYl0WaPUQVEZR3pA6WlABt
         4tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tV770gtlc+wsy+UJoYxGMN9qBxuKgWLEh7SlyYwABc=;
        b=XePnYf2BrUfVbZQFD9qB2MvcNH003046fAKoSnVyiEVAZQlzd5xoTIYyythWzYkvh2
         +P/e3MhFh0L4euDvhz8dkkRZb5g1vRnXG4wfPJcA6sypsmOiGiG8uJ1wuNBrtUw/D/TK
         dKUkRrtMAjpQrQw+EUlpmJI5j8qCQezRhsmo88e6FW+lwGSDdjxg34dI1F2ZNkteLXN7
         2sV3er89jdWIYmTSl8kp5jdhx+Hx2029j16V1SmlexdUBENAgHuwpmoIeuhT33nRRFvc
         rQGftEzcxC8SD4ckWTEEr5DdTWhY9v5maV20K3NofhO45uzQY1oj3D3Gr4y8bWZf2mbR
         tLwg==
X-Gm-Message-State: AJcUukebX908oomLV3tG2SJV9zSJNdRsmFdc1tzc+r7j+XITKc0ht46z
        Ov3epLKV87y/F0UoZKbGPPNTykGPyRlJEbUQM07w2eLtbQ==
X-Google-Smtp-Source: ALg8bN5Xzg+bZMposKlY51+EUlou7mGmeHx/TDH2StE42hULTAMczRfTbyGp2nwSeReF6n6voVc0KWtaO+hN0ViqkcQ=
X-Received: by 2002:a5e:de01:: with SMTP id e1mr9201968iok.137.1547201226390;
 Fri, 11 Jan 2019 02:07:06 -0800 (PST)
MIME-Version: 1.0
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
 <1547183577-20309-2-git-send-email-kernelfans@gmail.com> <20190111061221.GB13263@localhost.localdomain>
In-Reply-To: <20190111061221.GB13263@localhost.localdomain>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 11 Jan 2019 18:06:55 +0800
Message-ID: <CAFgQCTvhcNK_-b-eVFZY8Ua2C+GbOVM+h4kB1us2vNvvyNPCYg@mail.gmail.com>
Subject: Re: [PATCHv2 1/7] x86/mm: concentrate the code to memblock allocator enabled
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Baoquan He <bhe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 2:13 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Fri, Jan 11, 2019 at 01:12:51PM +0800, Pingfan Liu wrote:
> >This patch identifies the point where memblock alloc start. It has no
> >functional.
> [...]
> >+#ifdef CONFIG_MEMORY_HOTPLUG
> >+      /*
> >+       * Memory used by the kernel cannot be hot-removed because Linux
> >+       * cannot migrate the kernel pages. When memory hotplug is
> >+       * enabled, we should prevent memblock from allocating memory
> >+       * for the kernel.
> >+       *
> >+       * ACPI SRAT records all hotpluggable memory ranges. But before
> >+       * SRAT is parsed, we don't know about it.
> >+       *
> >+       * The kernel image is loaded into memory at very early time. We
> >+       * cannot prevent this anyway. So on NUMA system, we set any
> >+       * node the kernel resides in as un-hotpluggable.
> >+       *
> >+       * Since on modern servers, one node could have double-digit
> >+       * gigabytes memory, we can assume the memory around the kernel
> >+       * image is also un-hotpluggable. So before SRAT is parsed, just
> >+       * allocate memory near the kernel image to try the best to keep
> >+       * the kernel away from hotpluggable memory.
> >+       */
> >+      if (movable_node_is_enabled())
> >+              memblock_set_bottom_up(true);
>
> Hi Pingfan,
>
> In my understanding, 'movable_node' is based on the that memory near
> kernel is considered as in the same node as kernel in high possibility.
>
> If SRAT has been parsed early, do we still need the kernel parameter
> 'movable_node'? Since you have got the memory information about hot-remove,
> so I wonder if it's OK to drop 'movable_node', and if memory-hotremove is
> enabled, change memblock allocation according to SRAT.
>
x86_32 still need this logic. Maybe it can be doable later.

Thanks,
Pingfan
> If there is something wrong in my understanding, please let me know.
>
> Thanks,
> Chao Fan
>
> >+#endif
> >       init_mem_mapping();
> >+      memblock_set_current_limit(get_max_mapped());
> >
> >       idt_setup_early_pf();
> >
> >@@ -1145,8 +1145,6 @@ void __init setup_arch(char **cmdline_p)
> >        */
> >       mmu_cr4_features = __read_cr4() & ~X86_CR4_PCIDE;
> >
> >-      memblock_set_current_limit(get_max_mapped());
> >-
> >       /*
> >        * NOTE: On x86-32, only from this point on, fixmaps are ready for use.
> >        */
> >--
> >2.7.4
> >
> >
> >
>
>
