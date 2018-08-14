Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE497C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A4521765
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A4521765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeHNMxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:53:15 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35610 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:53:15 -0400
Received: by mail-wr1-f42.google.com with SMTP id g1-v6so16710669wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 03:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TzH6Kf+FRwLaMpwvtt0fBxYoP+1YGHFoRJLhnsA9uSI=;
        b=m/i5ecE+QUWGDbOEukcJtYdOwJdrb3PsjZoEEyq038DJo5lDap17sACIjXy6jErSxo
         h/RqIm8miAf5cFofP0bC26TJA58ntnWm1CQBqWHecLFNdFGDxVu4sBkK7SNJRkki3D0T
         sOgvtjyaSpTZr1xPanYEwxPpRKmIH32MajPaROkbrIE/LnQ66BVCV/l9SBpLjPfzLZWI
         T0quvnIRP6wyHtrjOZzDbxIn9KobHaONq4uTq5PW6zDMhY4nunZ1FbXotMG3hfuBinJO
         R2yIfnhYhakMnx1Y62SoSp0hd4j49zq+LT9GVGHdphkJPmow6AKbxDg4EcfY8BZGOsyB
         f4Zw==
X-Gm-Message-State: AOUpUlGQ/EP3VcH/6TfV/3R/AKncKXijDcxpHyNL3gWYdIdjdCwqw0/D
        CfwY1bN0XWPZOD6xKzWrZMU=
X-Google-Smtp-Source: AA+uWPxHeDkcTdNHdwcsKO5FkgYCwE+j+zXqJlaCJfKa31wlNlCfJKbtL1QXBMJGC1ut+pkKLjyFpA==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr12625563wrd.218.1534241206155;
        Tue, 14 Aug 2018 03:06:46 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id x14-v6sm22457920wrv.21.2018.08.14.03.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 03:06:45 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id C5478124878; Tue, 14 Aug 2018 12:06:44 +0200 (CEST)
Date:   Tue, 14 Aug 2018 12:06:44 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, jglisse@redhat.com, rafael@kernel.org,
        yasu.isimatu@gmail.com, logang@deltatee.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Drop mem_blk check from
 unregister_mem_sect_under_nodes
Message-ID: <20180814100644.GB6979@techadventures.net>
References: <20180813154639.19454-1-osalvador@techadventures.net>
 <20180813154639.19454-3-osalvador@techadventures.net>
 <82148bc6-672d-6610-757f-d910a17d23c6@redhat.com>
 <20180814093652.GA6878@techadventures.net>
 <39454952-f8c9-4ded-acb5-02192e889de0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39454952-f8c9-4ded-acb5-02192e889de0@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:44:50AM +0200, David Hildenbrand wrote:
> 
> Yes I know, as I said, if it would be local to a file I would not care.
> Making this functions never return an error is nice, though (and as you
> noted, the return value is never checked).
> 
> I am a friend of stating which conditions a function expects to hold if
> a function can be called from other parts of the system. Usually I
> prefer to use BUG_ONs for that (whoever decides to call it can directly
> see what he as to check before calling) or comments. But comments tend
> to become obsolete.

Uhm, I think a BUG_ON is too much here.
We could replace the check with a WARN_ON, just in case
a new function decides to call unregister_mem_sect_under_nodes() in the future.

Something like:

WARN_ON(!mem_blk)
	return;

In that case, we should get a nice splat in the logs that should tell us
who is calling it with an invalid mem_blk.

-- 
Oscar Salvador
SUSE L3
