Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DA5208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DA5208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbeGaQWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:22:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51695 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732260AbeGaQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:22:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so3393425wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RbJ+aGLGSMCac7Wgu0IMv/i9lR0PcwraTmiIm3WpZIA=;
        b=UojGpvreb+uqaImsp5lKQtyCIdoyqcR1bHVgWfvmbZPy9f7V4QnOle/QezkQrCjLwQ
         72jnIJJWlZAJ9QSdVql3G/T/fwtohCBZM51Pf9bx/2DV3aqPCT2gr2v//GFwGjDsRmjG
         Pae29c2o46ZEk8J4DEqT6/QQEtrmBlOlYO3xGPLDW3BDMUlLUIBxgVK03gzYcCd2mxxj
         WhyWrMwka/dqjCfDAxWwKUfjBasK5vUvBeNOM/JddHHk3EzFvB8hDxktwnSsXTO5lfRM
         ggNo8yF3Xkugyy1vFkCIRKBf71aAWRtSemb8M/ozFNEtoEA6zo060jpDFC782YdVo7iB
         CpCw==
X-Gm-Message-State: AOUpUlGMlrwSJEUuv8eXGGLOoy3rnkpgixlNx7OM74Eh9xHZ8ceWdN1x
        E/B58gEzKOoZmlxpXSNtoQQ=
X-Google-Smtp-Source: AAOMgpfvutgNVKDRnkb81OG5ET8R0RN3ANg06uiXtvSYM2pc4vJGw5UHPrVgkYONx1n5cYkqTublDg==
X-Received: by 2002:a1c:f611:: with SMTP id w17-v6mr2351498wmc.143.1533048118912;
        Tue, 31 Jul 2018 07:41:58 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v5-v6sm14703283wru.60.2018.07.31.07.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:41:58 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 842F01244E9; Tue, 31 Jul 2018 16:41:57 +0200 (CEST)
Date:   Tue, 31 Jul 2018 16:41:57 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
Message-ID: <20180731144157.GA1499@techadventures.net>
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 08:49:11AM -0400, Pavel Tatashin wrote:
> Hi Oscar,
> 
> Have you looked into replacing __paginginit via __meminit ? What is
> the reason to keep both?
Hi Pavel,

Actually, thinking a bit more about this, it might make sense to remove
__paginginit altogether and keep only __meminit.
Looking at the original commit, I think that it was put as a way to abstract it.

After the patchset [1] has been applied, only two functions marked as __paginginit
remain, so it will be less hassle to replace that with __meminit.

I will send a v2 tomorrow to be applied on top of [1].

[1] https://patchwork.kernel.org/patch/10548861/

Thanks
-- 
Oscar Salvador
SUSE L3
