Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BAC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD7821733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD7821733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeHNMXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:23:18 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33103 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeHNMXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:23:17 -0400
Received: by mail-wm0-f51.google.com with SMTP id i134-v6so2665938wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJtxAni6BsDJxwCt1IddpSnCcl7acPMQ69MR3c5zfhA=;
        b=L8gZWGyTuBYURmKSfXAa8VICjgo8Lw2l9NCFvFCW5/P06oUWyPxy1xfjC4sSI9VPB6
         uVCmOFASnYe8ZzIs6mvDk0Z/z6iPYO2/4Eny6oGF/yIbyqDtpa3jxedNb2oEeUh3F6JX
         IC15apvNstISE7Y9slQlmCPfmBA3rLX+KkETF8CHWUeqSa1nYsyDM7Ty+EQBYhAESszo
         aj2wIQ0Yp/sXOdc8udfUmuoETETN0Yqsb1V7oEyyjg6U10US8vAbHmDMjzWgU9gEcL9x
         9nbYuZX4EBDJEhob7cC3OI19h748aTX7hlgT0QEWYWUV0/rnHiY55/duWe6ua4gDdRMK
         g/fw==
X-Gm-Message-State: AOUpUlF2ylkQlz5qxJpQfNhCgUBK7of8v1ti6jpRXxEMOwEDxVlXPgbn
        jyPch6uJ69rM+L+gCOpIVhCJ/25HoMs=
X-Google-Smtp-Source: AA+uWPyHnfsodp8FkqO6w4W6KyrqMVrCJJB0ai6vMqT1Xv9YSPsx23ddKCyzfcEcoGrhIwONKwHVew==
X-Received: by 2002:a1c:c7c1:: with SMTP id x184-v6mr10097345wmf.134.1534239413528;
        Tue, 14 Aug 2018 02:36:53 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e133-v6sm28577243wma.33.2018.08.14.02.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 02:36:52 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 38E6E12486C; Tue, 14 Aug 2018 11:36:52 +0200 (CEST)
Date:   Tue, 14 Aug 2018 11:36:52 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, jglisse@redhat.com, rafael@kernel.org,
        yasu.isimatu@gmail.com, logang@deltatee.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Drop mem_blk check from
 unregister_mem_sect_under_nodes
Message-ID: <20180814093652.GA6878@techadventures.net>
References: <20180813154639.19454-1-osalvador@techadventures.net>
 <20180813154639.19454-3-osalvador@techadventures.net>
 <82148bc6-672d-6610-757f-d910a17d23c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82148bc6-672d-6610-757f-d910a17d23c6@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:30:51AM +0200, David Hildenbrand wrote:

> 
> While it is correct in current code, I wonder if this sanity check
> should stay. I would completely agree if it would be a static function.

Hi David,

Well, unregister_mem_sect_under_nodes() __only__ gets called from remove_memory_section().
But remove_memory_section() only calls unregister_mem_sect_under_nodes() IFF mem_blk
is not NULL:

static int remove_memory_section
{
	...
	mem = find_memory_block(section);
	if (!mem)
		goto out_unlock;

	unregister_mem_sect_under_nodes(mem, __section_nr(section));
	...
}

So, to me keeping the check is redundant, as we already check for it before calling in.

Thanks
-- 
Oscar Salvador
SUSE L3
