Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB7CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C031E21884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecq8f/sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C031E21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbeHGRSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:18:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39114 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbeHGRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:18:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so8728393pff.6;
        Tue, 07 Aug 2018 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IspYKn8aA7Wwm3ENxk/LZ3X9RRVT+aS3yIBl8lxrmmA=;
        b=Ecq8f/snc8PvPyCVOTOrlfCPrkPq/RToknbTx5CP9tLN6IvdZB6wUR3oisgAoFYX4D
         XewHul8pmSqIoQWO2Wl0BNunW37iePkFPEAJWOBwVR9jtSmI9g4xAErUs42xzUt46t2j
         WgUGgesWReLL4i4eeFyVZA7hWOP2iUqQIr4qHRGgF3TxrNNZzry3HqzwCdHqHaAbVlz0
         rn4w3bw13CVdpkEyJrGFZtXDa5J3cu/Ssb+mv6o6sLdmT9K5vXsScSrVvHozuRg2ELJo
         2ZfBorX8xBoIMaBSXRafdSvQT7abvCkOieoK/bpverX4D8QU7Z851XaN3jeBGj30VgYF
         A0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IspYKn8aA7Wwm3ENxk/LZ3X9RRVT+aS3yIBl8lxrmmA=;
        b=Pu/4YWEPexc9bYGhHwzf6Zy1Pc9wSGyL2sxZxC2/U7BxgN7AHr8pJKHFkmwDmW/322
         VQxXSCe802K7cCUQrDkKlWO/M1xsLJTM0XvE9a7WZP44ip+i1biHV8t012MKbiOwJfkt
         /BCvat2AHiF4J8FhePiFghm1ljSVr7qVniuRagYvkubVkMRZ1LvRA+CqIl0GRDISaECp
         C3+DUXiLohluHVLrkXXkoQK5xsLOLnsliBdtjOZtUBG0AhUkTyAAqVNY2kIQKIcR8Wn9
         +EJFjIlCq9OX8G+5T+FOsY4c7nLste5K4JiOnK09uwSbaucRIoyDzaB43P/PT4vg66Vd
         8Srw==
X-Gm-Message-State: AOUpUlG0imNGg3ZXuA3Uc/HX+euiTm7pYpejYSXiD/TtxYizFrLLToYe
        Ka0SK6ZX63O7+AddBZBOGHA=
X-Google-Smtp-Source: AAOMgpel2Vn8fsTGhqYDMIeY+NlFUz3QA1pQY4iy7SHKo9I5wHLYypjL1nz4SUFqfcyIybo9KmerBw==
X-Received: by 2002:a65:5cc5:: with SMTP id b5-v6mr18752706pgt.425.1533654212143;
        Tue, 07 Aug 2018 08:03:32 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:e25])
        by smtp.gmail.com with ESMTPSA id d81-v6sm3891035pfj.122.2018.08.07.08.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 08:03:31 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:03:16 -0700
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        kernel-team@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] proc: add percpu populated pages count to meminfo
Message-ID: <20180807150315.GA59704@dennisz-mbp.dhcp.thefacebook.com>
References: <20180807005607.53950-1-dennisszhou@gmail.com>
 <3b792413-184b-20b1-9d90-9e69f0df8cc4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b792413-184b-20b1-9d90-9e69f0df8cc4@suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

On Tue, Aug 07, 2018 at 03:18:31PM +0200, Vlastimil Babka wrote:
> 
> Documentation/filesystems/proc.txt should be updated as well
> 

Will do.

> >  
> > +/*
> > + * The number of populated pages in use by the allocator, protected by
> > + * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> > + * allocated/deallocated, it is allocated/deallocated in all units of a chunk
> > + * and increments/decrements this count by 1).
> > + */
> > +static int pcpu_nr_populated;
> 
> It better be unsigned long, to match others.
> 

Yeah that makes sense. I've changed this for v2.

> > +/*
> > + * pcpu_nr_populated_pages - calculate total number of populated backing pages
> > + *
> > + * This reflects the number of pages populated to back the chunks.
> > + * Metadata is excluded in the number exposed in meminfo as the number of
> > + * backing pages scales with the number of cpus and can quickly outweigh the
> > + * memory used for metadata.  It also keeps this calculation nice and simple.
> > + *
> > + * RETURNS:
> > + * Total number of populated backing pages in use by the allocator.
> > + */
> > +int pcpu_nr_populated_pages(void)
> 
> Also unsigned long please.
> 

Changed for v2.

Thanks,
Dennis
