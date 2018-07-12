Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F7020BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F7020BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeGLJ6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:58:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42392 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeGLJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:58:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so1462620wrs.9;
        Thu, 12 Jul 2018 02:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8GlHenUVTblrxABr9RjxKpfsFx9IgUhTyykMzPVZAE=;
        b=qZm5m7sYs6RfxjqOsEi4fS39PlmsZoAA5sVolgg4HT4AjCA9n2h2XdweC8bgxJPEZj
         QceNKtFBy2RBpyR7hv6XalZzOMrD+8rWNuSmUQ3idEHvibwZhuxs0uE0nuZBDDOgigFq
         ZHShWMEn5jjCVbhYquLsVYuZPEAnYj3k+tugV9Ys3Icpal8PZZSQczrift7skp1s/J6K
         C8BxyUPoy6El0AiMhlridE9WGrUID+2o5u7OB2q2k/zbWVVwSvNdaRi+X0khcp1nhAKa
         0/XKBGBLG8U+OJJbJ7teLZXX0kuE/ntVCQiBumldMvuEpyQIPP9c/CL9MvOq442aNS9a
         FkOQ==
X-Gm-Message-State: AOUpUlHgOHbSklE9x2rEvflzSDkpOe93k5/9wW5Jy9bkkdYixIAAleDH
        RXkNCKCRfzHdKzKfe1mxFsA=
X-Google-Smtp-Source: AAOMgpcdAQBr+Wq/BNpm+/GBFpbd7SjAXdE+6UGx5LBIYbxZbupWWiKZvIy0jxoS6pRSDH8wr1Olsg==
X-Received: by 2002:adf:d142:: with SMTP id b2-v6mr1151387wri.17.1531389003976;
        Thu, 12 Jul 2018 02:50:03 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h1-v6sm28996544wri.90.2018.07.12.02.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 02:50:03 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 91C47123E38; Thu, 12 Jul 2018 11:50:02 +0200 (CEST)
Date:   Thu, 12 Jul 2018 11:50:02 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oscar Salvador <osalvador.vilardaga@gmail.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        aneesh.kumar@linux.ibm.com, khandual@linux.vnet.ibm.com
Subject: Re: Boot failures with "mm/sparse: Remove
 CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was Re: mmotm
 2018-07-10-16-50 uploaded)
Message-ID: <20180712095002.GA5342@techadventures.net>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
 <87lgai9bt5.fsf@concordia.ellerman.id.au>
 <20180711133737.GA29573@techadventures.net>
 <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
 <CAOXBz7ixEK85S-029XrM4+g4fxtSY6_tke0gcQ-hOXFCb7wcZg@mail.gmail.com>
 <87efg981rd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efg981rd.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I just roughly check, but if I checked the right place,
> > vmemmap_populated() checks for the section to contain the flags we are
> > setting in sparse_init_one_section().
> 
> Yes.
> 
> > But with this patch, we populate first everything, and then we call
> > sparse_init_one_section() in sparse_init().
> > As I said I could be mistaken because I just checked the surface.
> 
> Yeah I think that's correct.
> 
> This might just be a bug in our code, let me look at it a bit.

I wonder if something like this could make the trick:

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 51ce091914f9..e281651f50cd 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -177,6 +177,8 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
        vmemmap_list = vmem_back;
 }
 
+static unsigned long last_addr_populated = 0;
+
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
                struct vmem_altmap *altmap)
 {
@@ -191,7 +193,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
                void *p;
                int rc;
 
-               if (vmemmap_populated(start, page_size))
+               if (start + page_size <= last_addr_populated)
                        continue;
 
                if (altmap)
@@ -212,6 +214,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
                                __func__, rc);
                        return -EFAULT;
                }
+               last_addr_populated = start + page_size;
        }

I know it looks hacky, and chances are that are wrong, but could you give it a try?
I will try to grab a ppc server and try it out too.
 
Thanks
-- 
Oscar Salvador
SUSE L3
