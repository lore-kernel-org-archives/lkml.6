Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72163C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348CB2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348CB2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeGZJ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:27:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35237 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbeGZJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:27:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so1054719wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 01:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ln9xf5fQxJD+q/HE4tUFtYwZX2rD0/6CToVKf7Exezc=;
        b=KXbHE/ss4VSowiHC0LIjUofDhhn3lqvFFjML12B7b0syfExh3X+Mev999jfvSpANK7
         nZM9w2lx+93PTJpc8XPjoFhUDSfv+yRZrZ7A4wl5c+l/fl691Ve2wuDL0ZSWhp8MjUAw
         SwMB/jZIWRSG2Ad0NfJj55/9EPGiyAWZzJiV0xkID1OZWCxT62o4KMucgALz+LdzJEhJ
         wzWoeWjQpV6S4mgfCrM/Q07cQjACCBVHBegojgH4XiyRd3cTwzM5LOSZFp8dF56UaIKN
         +3ean720uL4aIExSK2eG8dxClqNgmwJ+rXt513UHpuB4Dr902ywG7lXBIQiX54ssqs/9
         Z/HA==
X-Gm-Message-State: AOUpUlElmMg1pUFV0u4W+m6g/NXUQ/sW1oilXqnUIvrNMxlooIEnHM9+
        ZsSZYtw7zx3p+Dvc+xQgILE2NqE8Aho=
X-Google-Smtp-Source: AAOMgpeSvTGQzKjHJ6yOYgBZpZyEM9bTIkq2GwTthjNqGQIdQpqe5NGzgF2F9wlJYdwc+n1VqI5ZtQ==
X-Received: by 2002:a1c:ca0f:: with SMTP id a15-v6mr823511wmg.102.1532592736389;
        Thu, 26 Jul 2018 01:12:16 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l5-v6sm498750wrq.86.2018.07.26.01.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 01:12:15 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 4465112438C; Thu, 26 Jul 2018 10:12:15 +0200 (CEST)
Date:   Thu, 26 Jul 2018 10:12:15 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        pasha.tatashin@oracle.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 2/5] mm: access zone->node via zone_to_nid() and
 zone_set_nid()
Message-ID: <20180726081215.GC22028@techadventures.net>
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-3-osalvador@techadventures.net>
 <20180726080500.GX28386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726080500.GX28386@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:05:00AM +0200, Michal Hocko wrote:
> On Thu 26-07-18 00:01:41, osalvador@techadventures.net wrote:
> > From: Pavel Tatashin <pasha.tatashin@oracle.com>
> > 
> > zone->node is configured only when CONFIG_NUMA=y, so it is a good idea to
> > have inline functions to access this field in order to avoid ifdef's in
> > c files.
> > 
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> My previous [1] question is not addressed in the changelog but I will
> not insist. If there is any reason to resubmit this then please
> consider.

Oh, sorry, I missed that.
If I resubmit a new version, I can include the information about
opengrok, although it would be better if Pavel comments on it,
as I have no clue about the software.

If not, maybe Andrew can grab it?

Thanks
-- 
Oscar Salvador
SUSE L3
