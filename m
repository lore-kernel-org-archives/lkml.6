Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20195C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC36E2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC36E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJRO46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:56:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56031 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeJRO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:56:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so4240957wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 23:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wu3atd0TLXGOQNx8SJ45TWS7tUV7tC5mUWwfFKFiRxc=;
        b=o3qRTvLRaaDGwJoy1LXH8a+qdWSV+gl6hTdurlymeBBcf/5LOXclFs9zvhjSX8HETb
         FzRxnRWo+QCQ1hrifUfgSrpgOw6Yijm3ZbetAwwv11tIWbh2Z9a9JE3eeqz2lejuPOf9
         PSPqi+nlZIzeBVtKRDMWFz+soaVTIy6Kz6uJPnZVWMPbM+C3khxLpo3R1Ph84+MyDbDX
         y9kzdweWMOZxRlIw3cOLUOF2YgcWGck8kTgBG+/C5D+3dNhuauNWMB/+ZEtfXqUFLpd6
         6esoN1ztaZTdaeQOycG/TSwcYYYFbrDQxQXS4wOIp39FVt8hxbZ8v4Qnv0zFHNWhZNnA
         /LGQ==
X-Gm-Message-State: ABuFfojIxi6axaDtKE8tZX1UEaOrFbxKwshuxDfoFxNEq8pt/bPiK9do
        sAG5x2HILCO7PXsHhMenmHM=
X-Google-Smtp-Source: ACcGV63Qbi6xauc30O9Wo+QPH6BtDnxeXoqEOFE8BeLVRBsl+YnIoX3ft72C08u9fvWO2WbE+9xCCw==
X-Received: by 2002:a1c:3e48:: with SMTP id l69-v6mr5932627wma.143.1539845844186;
        Wed, 17 Oct 2018 23:57:24 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 64-v6sm16466433wrr.64.2018.10.17.23.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 23:57:23 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id ABDCA125AEA; Thu, 18 Oct 2018 08:57:22 +0200 (CEST)
Date:   Thu, 18 Oct 2018 08:57:22 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Create add/del_device_memory
 functions
Message-ID: <20181018065722.GA29999@techadventures.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
 <20181015153034.32203-3-osalvador@techadventures.net>
 <d0a12eb5-3824-8d25-75f8-3e62f1e81994@redhat.com>
 <20181017093331.GA25724@techadventures.net>
 <883d3ab7-b2df-9b9a-7681-1019ce3b9e18@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883d3ab7-b2df-9b9a-7681-1019ce3b9e18@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:45:50AM +0200, David Hildenbrand wrote:
> Here you go ;)
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

thanks!

> I'm planning to look into the other patches as well, but I'll be busy
> with traveling and KVM forum the next 1.5 weeks.

No need to hurry, this can wait.

-- 
Oscar Salvador
SUSE L3
