Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D46C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847A1205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847A1205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeGZJGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:06:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36378 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeGZJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:06:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so704809wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m0LWwD+fpkZ3MtaooraDcrejtHKdRKH1gnD9yu+06V8=;
        b=KqM8Fg3/OtqedtuGWMCkHQZa7khUc8nRyxTsuLVfVQrMGMO/QABj9auR7cizKT4qHv
         KCekG4a6DX3C3CU3JCJKpSTCYMG08cNaZenDmFYqtXnLCLdg7up6ZDXM8l0KLQK+fvVI
         kF6t23KJh7w3BT2aDkvfI4R93tnTuZDgXok90NW5QcXzOkbb/20qrg1DIbyDwvXqEF19
         IlZD6mnCpVE6BcuoA114Ymv7uBiHe4OOIEHD/Sz1NA3IWpVsDeSOxM+HoDV5Nxescdix
         E1CesG5bvyu79aqk5y5m8qHbiJGbvP5f1asCqrp3+HxLJpGg/F+TVxlMKDixpeXred4N
         S1Yg==
X-Gm-Message-State: AOUpUlFuqKR44ShRW0ROhraCt6NRT1h5xYI58m30NmWrTASbQnmjlxhR
        v2tjA6qhcY7F2ZwApGaOTns=
X-Google-Smtp-Source: AAOMgpc3OFTgI9u9Ftm4Su4eYMZrSMiMIpJN0ibz5vcPIK3gHWsEr69z3Q+jJ33OMIxVXnuUlYUujQ==
X-Received: by 2002:a5d:48c7:: with SMTP id p7-v6mr732565wrs.0.1532591441210;
        Thu, 26 Jul 2018 00:50:41 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l14-v6sm883112wrw.65.2018.07.26.00.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:50:40 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 1CC65124384; Thu, 26 Jul 2018 09:50:40 +0200 (CEST)
Date:   Thu, 26 Jul 2018 09:50:40 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH 1/3] mm: make memmap_init a proper function
Message-ID: <20180726075040.GB22028@techadventures.net>
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
 <20180724235520.10200-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724235520.10200-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 07:55:18PM -0400, Pavel Tatashin wrote:
> memmap_init is sometimes a macro sometimes a function based on
> __HAVE_ARCH_MEMMAP_INIT. It is only a function on ia64. Make
> memmap_init a weak function instead, and let ia64 redefine it.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Looks good, and it is easier to read.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks
-- 
Oscar Salvador
SUSE L3
