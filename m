Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A731EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ABB2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ABB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeJRXDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:03:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46492 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJRXDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:03:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id n11-v6so33993340wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hoPY4ztjIqBsbqumoG4UlgaaLpS0201b9e96aLNElWg=;
        b=S7KAGZJlpbRtAnH13U7gWuwkgFn4h56MtmhdVvFPrTBzGueltNZD8wOKqf4ZCFyjBX
         f2BQ9udf+py3EirQOkmMK2khv0EROKMz+lnSg6GOA6fL3DcSbQnrCyXQPDk39Om2mWIo
         BXMwHAhVZ4DyG8wWTagpq9oBUAfTi7TnSde25B/1D+BKB9XGaTQHDibIphNzwg2lc/sp
         lUHyjrUFD+6ogkQA6LqKgFyaqayzV4CorRtULyKjL9ADXrMVUXUxfEdtAMX44HD8SuAw
         s20xlckFxuFHqGA7sQd7O3AKGMiTzKmCw1Ke5WLowKGLQKRdEhsc+TMHem3K4121I02O
         mJfA==
X-Gm-Message-State: ABuFfogBpooT+r7YfF64D/TU7Plm9R5iOM9BkQHOKhwNw0Il1A4pAuIE
        iEvi5eHX0iMBYxFYk4DqSGY=
X-Google-Smtp-Source: ACcGV60UEgqU0wEWeytGaZQuL3lTosxxrWYBEbkyo/jRnFVfK4l4izqeTFAeo8VRRANF4dKR7FRM1w==
X-Received: by 2002:adf:e70f:: with SMTP id c15-v6mr30992559wrm.165.1539874943418;
        Thu, 18 Oct 2018 08:02:23 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l125-v6sm3690759wmb.1.2018.10.18.08.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 08:02:22 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id ECEB6125B0A; Thu, 18 Oct 2018 17:02:21 +0200 (CEST)
Date:   Thu, 18 Oct 2018 17:02:21 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, rafael@kernel.org, david@redhat.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>, linuxarm@huawei.com
Subject: Re: [PATCH 5/5] mm/memory-hotplug: Rework
 unregister_mem_sect_under_nodes
Message-ID: <20181018150221.GA31605@techadventures.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
 <20181015153034.32203-6-osalvador@techadventures.net>
 <20181018152434.00001845@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018152434.00001845@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 03:24:34PM +0100, Jonathan Cameron wrote:
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks a lot Jonathan for having tested it!

Did you test the whole serie or only this patch?
Since you have caught some bugs testing the memory-hotplug code
on ARM64, I wonder if you could test it with the whole serie
applied (if you got some free time, of course).


thanks again!
-- 
Oscar Salvador
SUSE L3
