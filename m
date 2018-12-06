Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6A208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjAjMDTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB6A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeLFKoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:44:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37794 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:44:16 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so361010edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbBGDc/bjaMxusFr5D0Ux7T0depHkjTCJV3JvAD04Ss=;
        b=QjAjMDTiIYBhrASPkjzies6VE1avYYTH0v7g8apbmte1AM5JzVa4l9eboHswlmtPe4
         OEqlTXmtJ8X+dku5ecIoFWiIA56/BM/r30+/8/2hEnZCDOA30nPWH8u40DaDNY8y6R/M
         nyJS4GodOBf0Q/gzBqrsIK7FRbmiraw/GrnrhOKpFs/+rNgJCVMCIZ5Lp6zdv43Jqwf6
         Kuohl+JQYaJIPl4EYhgLv8YkCXklde/3Vxc42zePIX3A6hjDgydJd8cFjws08vr68u9C
         DTsNai762ciSvCcSgmobz0fj34eGLA148mzXphBs3pLQd9gbL730ee4WKZcyFLVXN63m
         e1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbBGDc/bjaMxusFr5D0Ux7T0depHkjTCJV3JvAD04Ss=;
        b=ofeA1pYCl62vtv5iuXSItO5Zy7ABxbrfL55WOuJCe2Xa3ofVFkSFiCc0XHgJfutSul
         zB0uCARTmuoUTIiib26AU9VOyjOmJNBGeVj1ko870gHlaMLJN/HNxogQv1K4B4wgmhMm
         xmBUOejRhY3hNxRTk8wnV48C1ZsimLbcCR91d2zMtApiOtveEuIbZdicUtrLeBmf9J2X
         Ti51qAL5GydqEyTttYz+74jIsRdHJDHpt8rlSMI+BdZbbSRDv9gbWfdWaedVo4FHcIQN
         LNB8TLyZbANP4DH+qOaeWQHG2hEleDRLAUW9dyZvqb4/D77EGIK6fRaADIWLQ3MKZwpr
         FD+w==
X-Gm-Message-State: AA+aEWahBNQT311YGvUFfbFKltha5WWNiBzCZt32yxUh5ruxu0zJxZxm
        X6DrfM+a95TU3L4hExjdA4twXOFzmjtE9w+kTNKf4S8=
X-Google-Smtp-Source: AFSGD/UHn4Pg6rZCRcc+vCFuClcC2gPLLRj5g+2ePbEN3p51cKOVyShbAbbGD4LRgBb6MuGNFGs34HR8WkstcJi5Flc=
X-Received: by 2002:a17:906:a281:: with SMTP id i1-v6mr21253730ejz.86.1544093054778;
 Thu, 06 Dec 2018 02:44:14 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz> <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204085601.GC1286@dhcp22.suse.cz> <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz> <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz> <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
 <20181206082806.GB1286@dhcp22.suse.cz> <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
In-Reply-To: <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 6 Dec 2018 18:44:03 +0800
Message-ID: <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     mhocko@kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 6:03 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> [...]
> > THanks for pointing this out. It made my life easier. So It think the
> > bug is that we call init_memory_less_node from this path. I suspect
> > numa_register_memblks is the right place to do this. So I admit I
> > am not 100% sure but could you give this a try please?
> >
> Sure.
>
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 1308f5408bf7..4575ae4d5449 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -527,6 +527,19 @@ static void __init numa_clear_kernel_node_hotplug(void)
> >         }
> >  }
> >
> > +static void __init init_memory_less_node(int nid)
> > +{
> > +       unsigned long zones_size[MAX_NR_ZONES] = {0};
> > +       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> > +
> > +       free_area_init_node(nid, zones_size, 0, zholes_size);
> > +
> > +       /*
> > +        * All zonelists will be built later in start_kernel() after per cpu
> > +        * areas are initialized.
> > +        */
> > +}
> > +
> >  static int __init numa_register_memblks(struct numa_meminfo *mi)
> >  {
> >         unsigned long uninitialized_var(pfn_align);
> > @@ -592,6 +605,8 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
> >                         continue;
> >
> >                 alloc_node_data(nid);
> > +               if (!end)
> > +                       init_memory_less_node(nid);
> >         }
> >
> >         /* Dump memblock with node info and return. */
> > @@ -721,21 +736,6 @@ void __init x86_numa_init(void)
> >         numa_init(dummy_numa_init);
> >  }
> >
> > -static void __init init_memory_less_node(int nid)
> > -{
> > -       unsigned long zones_size[MAX_NR_ZONES] = {0};
> > -       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> > -
> > -       /* Allocate and initialize node data. Memory-less node is now online.*/
> > -       alloc_node_data(nid);
> > -       free_area_init_node(nid, zones_size, 0, zholes_size);
> > -
> > -       /*
> > -        * All zonelists will be built later in start_kernel() after per cpu
> > -        * areas are initialized.
> > -        */
> > -}
> > -
> >  /*
> >   * Setup early cpu_to_node.
> >   *
> > @@ -763,9 +763,6 @@ void __init init_cpu_to_node(void)
> >                 if (node == NUMA_NO_NODE)
> >                         continue;
> >
> > -               if (!node_online(node))
> > -                       init_memory_less_node(node);
> > -
> >                 numa_set_node(cpu, node);
> >         }
> >  }
> > --
> Which commit is this patch applied on? I can not apply it on latest linux tree.
>
I applied it by manual, will see the test result. I think it should
work since you instance all the node.
But there are two things worth to consider:
-1st. why x86 do not bring up all nodes by default, apparently it will
be more simple by that way
-2nd. there are other archs, do they obey the rules?

Thanks,
Pingfan
