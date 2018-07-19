Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31923C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E301620684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E301620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbeGSPov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:44:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35584 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730919AbeGSPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:44:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so8413731wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YHEix/TOjRxv70x/ZYn60PvTTg0MhwaXbEte3Ahg3KY=;
        b=ZBYKzzYoFPFTfMzeMM8raRppDFdzTNW6B0WnaSDqPL0LKigjTC/O+K7vfTDpgaZ2qY
         tOsDc10Ra93dC0k0j0STtOuELIfoatJwzvdHtNogBo4srBVI+4jUPMoHT/54vh3pEgkK
         TIsJRb5jv3eNRE18KI9HOR+mRDbgNQMwhwCUCY8RftLEjpR5yVYmQ24Pp0xaQLP6EeCe
         R9/BLq6Y90DYPcX0PrrrSq3Sgs6J1i1IFqnEWILiILTtq38XNOAfJUldOMFZeZsedI5W
         3/4coYJPSmSgDXuivRatGdVu+bMYDMRebMj4VYxyqdV74mnFTqr3TXccQ9xWaOkNeqme
         Lt2Q==
X-Gm-Message-State: AOUpUlHGFZHA6NWlb9qk8G7KrzgbDbL3mm5sLfo0N4nJ1r+M8SVdaVj4
        PzEOUXA74HOwFdLUsOAb4DU=
X-Google-Smtp-Source: AAOMgpej4slr11aX7wqDBvIpkuUrNFY3WazNXL+fzEIB5+z3w6J2ggkmMofX+DGtt51jw9uG3KBEMA==
X-Received: by 2002:adf:8466:: with SMTP id 93-v6mr7397000wrf.274.1532012475985;
        Thu, 19 Jul 2018 08:01:15 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id x184-v6sm5503289wmg.24.2018.07.19.08.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:01:15 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 68E69124196; Thu, 19 Jul 2018 17:01:14 +0200 (CEST)
Date:   Thu, 19 Jul 2018 17:01:14 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     mhocko@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@suse.de
Subject: Re: [PATCH v2 5/5] mm/page_alloc: Only call pgdat_set_deferred_range
 when the system boots
Message-ID: <20180719150114.GC10988@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-6-osalvador@techadventures.net>
 <20180719134622.GE7193@dhcp22.suse.cz>
 <20180719135859.GA10988@techadventures.net>
 <20180719140308.GG7193@dhcp22.suse.cz>
 <CAGM2reZ-+njLtZSnNpry11frg85KmMk4WWxGdaqk1o4BUJVO1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reZ-+njLtZSnNpry11frg85KmMk4WWxGdaqk1o4BUJVO1w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:27:44AM -0400, Pavel Tatashin wrote:
> On Thu, Jul 19, 2018 at 10:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> > I am not really sure. I am not a big fan of SYSTEM_BOOTING global
> > thingy so I would rather not spread its usage.
> 
> I agree, I do not think this patch is necessary. Calling
> pgdat_set_deferred_range() does not hurt in hotplug context, and it is
> cheap too. SYSTEM_BOOTING sometimes useful, but it is better to use it
> only where necessary, where without this "if" we will encounter some
> bugs.

Ok, let us drop it then ;-).

Thanks
-- 
Oscar Salvador
SUSE L3
