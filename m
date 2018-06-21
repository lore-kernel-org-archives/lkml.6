Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B5920846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B5920846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFUHdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:33:38 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41564 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeFUHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:33:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so2004699wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tgzv4dn2xzs2jO6Ym1jqErwLPovKyBxVvzxa74qL+ck=;
        b=jxLYS0u7kQ1q43zPQ/9Zo/UdKdi33s+24S2q72mKEodLLq76v/4wPXIUBfEXPUpQKF
         FOM3W4J3vRlxCNWqQAp1PPOdLGsnIg2dmL1zON16raS/+NI4CAvGWReeH4QqZbBrxwfA
         cQCbs2QvaPldoMabqaITWRAiZHS6IfPOhe0vCHoFdgcdN7id5pCC+4TJUO9d5iQRYT9o
         SxCs5dieIiJUQvjkNTsZoG4dg5phs6JFsnba6wlBIprhFB38B/CEZ8srPBMVroVIwVeo
         FzCnipX/VcxADTR+RHAQwUzz2XC8osI49jV++d9yWerK2pNmHJJH1+xicjW7Xo0mRxoh
         ofyg==
X-Gm-Message-State: APt69E0uaUX+MiXBVZFfrB83HUAIc2BkEltUlvnOpPjVyCDkDDOKtDLP
        k2zKY3iNwtaFLd5CQXnJ/0A=
X-Google-Smtp-Source: ADUXVKKGVO8YnksJ9LfvInX1v62RVHRpJvSCEUqvTOPiewKoSdMEOAWtesvJB6B3yxcECE+0Hje0ZA==
X-Received: by 2002:adf:a6b8:: with SMTP id t53-v6mr21819421wrc.45.1529566415826;
        Thu, 21 Jun 2018 00:33:35 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v10-v6sm5559477wrn.97.2018.06.21.00.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 00:33:35 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 70FA11236FF; Thu, 21 Jun 2018 09:33:34 +0200 (CEST)
Date:   Thu, 21 Jun 2018 09:33:34 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Make add_memory_resource use
 __try_online_node
Message-ID: <20180621073334.GA11407@techadventures.net>
References: <20180601125321.30652-1-osalvador@techadventures.net>
 <20180601125321.30652-2-osalvador@techadventures.net>
 <20180620151819.3f39226998bd80f7161fcea5@linux-foundation.org>
 <CAGM2reYgrpBrfhcw0O7K+sMU-qE-U_+2MzJWsG=7gSbU8n-=kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reYgrpBrfhcw0O7K+sMU-qE-U_+2MzJWsG=7gSbU8n-=kA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:41:35PM -0400, Pavel Tatashin wrote:
> > I don't think __try_online_node() will ever return a value greater than
> > zero.  I assume what was meant was
> 
> Hi Andrew and Oscar,
> 
> Actually, the new __try_online_node()  returns:
> 1 -> a new node was allocated
> 0 -> node is already online
> -error -> an error encountered.
> 
> The function simply missing the return comment at the beginning.
> 
> Oscar, please check it via ./scripts/checkpatch.pl
> 
> Add comment explaining the return values.
> 
> And change:
>         ret = __try_online_node (nid, start, false);
>         new_node = !!(ret > 0);
>         if (ret < 0)
>                 goto error;
> To:
>         ret = __try_online_node (nid, start, false);
>         if (ret < 0)
>                 goto error;
>         new_node = ret;
> 
> Other than that the patch looks good to me, it simplifies the code.
> So, if the above is addressed:
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Hi Pavel,

I'll do so, thanks!

> 
> Thank you,
> Pavel
> 
> >
> >         new_node = !!(ret >= 0);
> >
> > which may as well be
> >
> >         new_node = (ret >= 0);
> >
> > since both sides have bool type.
> >
> > The fact that testing didn't detect this is worrisome....
> >
> > > +     if (ret < 0)
> > > +             goto error;
> > > +
> > >
> > >       /* call arch's memory hotadd */
> > >       ret = arch_add_memory(nid, start, size, NULL, true);
> > > -
> > >       if (ret < 0)
> > >               goto error;
> > >
> > >
> > > ...
> > >
> >
> 

-- 
Oscar Salvador
SUSE L3
