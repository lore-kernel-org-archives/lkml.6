Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF60C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5935320877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5935320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbeGKNmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:42:03 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43889 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbeGKNmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:42:03 -0400
Received: by mail-wr1-f41.google.com with SMTP id b15-v6so18243654wrv.10;
        Wed, 11 Jul 2018 06:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DurwruT8Y8P1fGWFSgQlIP/kkh9aa1E2nKZHimU5RxQ=;
        b=PCdvu9u/nZAlGsFyqaru8ognZaRVj4fMGTz06eHZ49ULq73ul17H45sEf9K7oz2PKO
         M/koH716+wjwRnlLGf8EHXnh47GyQJ2a4rZo517Nknuk6s5ZIWVnS/Zw0l/DPW3c3g8x
         IwkELHkPIxO2wQoH+WohVroXqwQvSVGd4CP00+lUK/18nqzaSzo3pJr8WxaSaPKMZuEh
         x6ykPiWvN0j4lYSBaE8v2beG2udc55jt0VeZazubgYeAl/Oz4nxfOFXY0oHtkjLxUwo9
         lfMYYJCMA51AfWV7gkLkrDQLVbSypTRjeY4ZsAlPSOMRmgcgzQ32kqfWtCo9b6aaOvsr
         /alA==
X-Gm-Message-State: APt69E1cYpobwuC58JWZsjRuvR2zXlXPI3kGEMO4u3/oOdm3vCyYpADn
        10PxCuoR0DuxihWoS9svCNc=
X-Google-Smtp-Source: AAOMgpdgUzOUfyya/Iu0+ydNYoebRtijSq0vM4aN0iJPDGGY0sfYOVWeq/oUrpsivm3/3BiYb/9Ilw==
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr20540063wri.199.1531316259023;
        Wed, 11 Jul 2018 06:37:39 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id k3-v6sm2221386wme.44.2018.07.11.06.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:37:38 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 7FFE4123DCD; Wed, 11 Jul 2018 15:37:37 +0200 (CEST)
Date:   Wed, 11 Jul 2018 15:37:37 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        pasha.tatashin@oracle.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: Boot failures with "mm/sparse: Remove
 CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was Re: mmotm
 2018-07-10-16-50 uploaded)
Message-ID: <20180711133737.GA29573@techadventures.net>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
 <87lgai9bt5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgai9bt5.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:49:58PM +1000, Michael Ellerman wrote:
> akpm@linux-foundation.org writes:
> > The mm-of-the-moment snapshot 2018-07-10-16-50 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> ...
> 
> > * mm-sparse-add-a-static-variable-nr_present_sections.patch
> > * mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
> > * mm-sparsemem-defer-the-ms-section_mem_map-clearing-fix.patch
> > * mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
> > * mm-sparse-optimize-memmap-allocation-during-sparse_init.patch
> > * mm-sparse-optimize-memmap-allocation-during-sparse_init-checkpatch-fixes.patch
> 
> > * mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch
> 
> This seems to be breaking my powerpc pseries qemu boots.
> 
> The boot log with some extra debug shows eg:
> 
>   $ make pseries_le_defconfig

Could you please share the config?
I was not able to find such config in the kernel tree.
-- 
Oscar Salvador
SUSE L3
