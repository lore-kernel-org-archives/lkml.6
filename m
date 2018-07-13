Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28915ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAA22087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAA22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeGMMSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:18:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39863 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeGMMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:18:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so9095917wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e4wuU5mUCJTmF/aYG58gMJ6gyvVmfswDfBfFL+RSOWg=;
        b=IOhApWIQfpQjXtg8Fvxwl7Q/c4l7nKTf1Pof9ckPn66BcH/ZDsvunoy/2r+OhgJlxY
         wK5ku5Tv8zeSt1RnAHUtbH3x0YzUbuMsscVQ3L3ZcQEttGdKXkRSN930uZHyPyYpggkb
         dUaMYeDMEaMLYS31scSEIwBSVDScfak3xkM6hOmFNhhpJIFreOPyDyrFpPAbmSyHiUIC
         YMnON7XHtu2jYKLzF7GD0oAvlE5PADoInewXjqPIlLAksz7+6wlXEsd3VqJyrC8XFU4h
         2EpWVYY4acyp+WbGuQcgaS23W/thuTxKUtabTv5BfTBOo5XrO09iEhc8HVGoP0kQ7kZC
         KwHg==
X-Gm-Message-State: AOUpUlEuy7gC1NniuRvRSZIP2uglIdbuhbZ8E8uFp9CEjE4ia/+NyPJ/
        63Ean54dtcofDasTSbzPU9VOCAUa
X-Google-Smtp-Source: AAOMgpeVGy4meoZREWxOxZXLRLuSGD/3+a7F6C5Qw0npGKH3v2UaVQ7xGSsfNAz4YZLj6cXFeUntuw==
X-Received: by 2002:a1c:3e92:: with SMTP id l140-v6mr3677717wma.134.1531483421876;
        Fri, 13 Jul 2018 05:03:41 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 6-v6sm9248746wmi.26.2018.07.13.05.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 05:03:41 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 8C45B123EC7; Fri, 13 Jul 2018 14:03:40 +0200 (CEST)
Date:   Fri, 13 Jul 2018 14:03:40 +0200
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
Subject: Re: [PATCH v5 4/5] mm/sparse: add new sparse_init_nid() and
 sparse_init()
Message-ID: <20180713120340.GA16552@techadventures.net>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
 <20180712203730.8703-5-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712203730.8703-5-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:37:29PM -0400, Pavel Tatashin wrote:
> sparse_init() requires to temporary allocate two large buffers:
> usemap_map and map_map. Baoquan He has identified that these buffers are so
> large that Linux is not bootable on small memory machines, such as a kdump
> boot. The buffers are especially large when CONFIG_X86_5LEVEL is set, as
> they are scaled to the maximum physical memory size.
> 
> Baoquan provided a fix, which reduces these sizes of these buffers, but it
> is much better to get rid of them entirely.
> 
> Add a new way to initialize sparse memory: sparse_init_nid(), which only
> operates within one memory node, and thus allocates memory either in large
> contiguous block or allocates section by section. This eliminates the need
> for use of temporary buffers.
> 
> For simplified bisecting and review temporarly call sparse_init()
> new_sparse_init(), the new interface is going to be enabled as well as old
> code removed in the next patch.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Looks good to me, and it will make the code much shorter/easier.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks
-- 
Oscar Salvador
SUSE L3
