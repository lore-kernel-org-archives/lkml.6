Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409D8205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409D8205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIABEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:04:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37410 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIABEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:04:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so12318780wrr.4;
        Fri, 31 Aug 2018 13:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aqkK5DFo76IrnjE1iNa7ClWeJ8UvmBhqCpPx94luwiA=;
        b=hWbOAEJrKrxiJSEaN2XSYQyhFHy7B60kx4+Q5CeEDa4OjJtqWKZNQVIvD3WqwolJ2+
         /sbd2ZJ2crIJjMMPR+RHZh2b6kgAFehgGfaIPJcewR8JuOozGKO5bSxbVRCKiYzZdJ/7
         3I6gdU9FvsRVE4twxfSLVb7RptStGVHbUD0A40VYbrT7CHchfsWB5yilgJkLHUCVyjWw
         caqHY1NxoPeoMW+GSLhdeiU/iK2hr/7TqJSMk7J0sa6QWPliNvEq9N3fv9r0QEhR1q9v
         TaeAF7vXDpH9ycF9DdVeQxhno5rKswbVxw/4QrveJD0yvNk5CQmqTxYPn1lw0b123+D4
         5DWg==
X-Gm-Message-State: APzg51Dkd0YRpUqWmCiP7wnelJPKNQqeQLBdgB6Mwz8msRYioL9t+IiP
        0dOIfXYM814RGrHoq22YtMQ=
X-Google-Smtp-Source: ANB0VdZmOO1JXpcYmBr14xDd/IwW0cfJZxgoswQp+qlEe4+3RFaLDognMT1eyZzJ8aer3IkizxOW+w==
X-Received: by 2002:adf:9a46:: with SMTP id z64-v6mr11623267wrb.109.1535748898470;
        Fri, 31 Aug 2018 13:54:58 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id k13-v6sm6720143wrq.7.2018.08.31.13.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:54:57 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 37D5D124D4E; Fri, 31 Aug 2018 22:54:57 +0200 (CEST)
Date:   Fri, 31 Aug 2018 22:54:57 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        devel@linuxdriverproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Len Brown <lenb@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: [PATCH RFCv2 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
Message-ID: <20180831205457.GB3945@techadventures.net>
References: <20180821104418.12710-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821104418.12710-1-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 12:44:12PM +0200, David Hildenbrand wrote:
> This is the same approach as in the first RFC, but this time without
> exporting device_hotplug_lock (requested by Greg) and with some more
> details and documentation regarding locking. Tested only on x86 so far.

Hi David,

I would like to review this but I am on vacation, so I will not be able to get to it
soon.
I plan to do it once I am back.

Thanks
-- 
Oscar Salvador
SUSE L3
