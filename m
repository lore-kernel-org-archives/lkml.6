Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE32C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F26F2170F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F26F2170F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeHNPXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:23:12 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35373 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeHNPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:23:11 -0400
Received: by mail-wr1-f42.google.com with SMTP id g1-v6so17089730wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 05:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8WDokrEzVV94taYOs21Dw1KPWrVPeb4ax43lLbkA+UQ=;
        b=Avt04Z1I+fvm3K8OIo9RhEbtfk9q2qpg3R2yD4QjM+28m3xhJqMA9J+NVX/ntHmF7B
         qE2wIqLxo5QnXkkToUJlUnFWAyu+1G+abINVeoKCE1ODl88UpRxozBKIHP5Gf8Fzk7Ui
         J7//oK4bp8yhACM9HlpGEaukexNn87E6dJzHLH76IPen/QFPVE0aUz+Y/FDXlBSN7Epv
         bDNVjUYe+RE0Azb8duByAYcbnKsTXo/cFT/mDM6eWJuEACbroEo1Bofi32ajyy5ACNRa
         B/pL0xB5oHUmXiFCUdofub/INOMy0CXX3FGS3IUOY2gYY9Lv50rtzRrrpYmA3ql8o2qe
         6OmA==
X-Gm-Message-State: AOUpUlHzlLRjAz8JiiJuz7EgEVoDRdE9ExSkE5i8s42SAw//vSY5JGP5
        xyN3cTCdgAIz3BsueU1r2Z8=
X-Google-Smtp-Source: AA+uWPxnJOcmgcn/6UmRH5HbAPqQxew3IN9hqHFXsIPOcINM1V1CNRkFZCfQd7Mu9wRfp3n012zXGA==
X-Received: by 2002:a5d:46d1:: with SMTP id g17-v6mr13682305wrs.76.1534250171409;
        Tue, 14 Aug 2018 05:36:11 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id m200-v6sm16529758wma.32.2018.08.14.05.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 05:36:10 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 2B05F124880; Tue, 14 Aug 2018 14:36:10 +0200 (CEST)
Date:   Tue, 14 Aug 2018 14:36:10 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, jglisse@redhat.com, rafael@kernel.org,
        yasu.isimatu@gmail.com, logang@deltatee.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Drop mem_blk check from
 unregister_mem_sect_under_nodes
Message-ID: <20180814123610.GA7437@techadventures.net>
References: <20180813154639.19454-1-osalvador@techadventures.net>
 <20180813154639.19454-3-osalvador@techadventures.net>
 <82148bc6-672d-6610-757f-d910a17d23c6@redhat.com>
 <20180814093652.GA6878@techadventures.net>
 <39454952-f8c9-4ded-acb5-02192e889de0@redhat.com>
 <20180814100644.GB6979@techadventures.net>
 <292e9b31-b043-d140-77da-03082025fa1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292e9b31-b043-d140-77da-03082025fa1b@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:09:14PM +0200, David Hildenbrand wrote:
> 
> Whatever you think is best. I have no idea what the general rules in MM
> code are. Maybe dropping this check is totally fine.

Well, if you ask me, callers should care for validating mem_blk before calling in.
But a WARN_ON is not harmful either.

Let us just wait to hear more from others.
 
Thanks
-- 
Oscar Salvador
SUSE L3
