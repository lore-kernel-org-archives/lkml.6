Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6E7C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C54221470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3u3fqdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C54221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJDFlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:41:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38164 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJDFlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:41:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so2212049pgr.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UZglTBizvX/yOVqXcm55tcIE03q1zO1FIn6z28ZwCtg=;
        b=M3u3fqdw3xeAYGJOrQQy0sx5+iU2Q2EUZ34j7uf88s8J9EgX4V0+aNSamuXGcMBv6p
         mMDGtnRrO+hoYUV+rzNEXuJ9D7xcvah5aoc4KvWbUDdOLVd9VADe/txvzVl+w3/4I25w
         II12wFYMrxgmnMZl3Nya4liX2xyaV8SbB4UMT5WNw7o1HcLl1txvVx7DMOCV0O4vmR4f
         QuMNuke4d1WnA3NwcLrOfzrUaggoS6+D9a+rVgScIwiWh1ZOm7DlzFi8X91kUd8ftbhY
         ZiEkCR5AbCcwb4wbQb7E+rdM688uTBIJ1B1XG+mTxQG2jjsuJ4VF9f0Cmkb9EDl142/i
         LNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UZglTBizvX/yOVqXcm55tcIE03q1zO1FIn6z28ZwCtg=;
        b=dpwSsW2th+MIgg5/qEXVXty7avrMbjULITcprQCmCN9g+F0SGPxT4nIC9C9PxzdLDN
         ykkz9KKvJgWDwpFfvUziSOKljtJKuENGw0zeRSAlQVbbU6h5qS9sk/ReadZkCeKUKzGc
         64RFS3ixjUCbgOw2YXvKnzl9DAXX/PCcncOgNjA/Ihk7WUOc8QzWM8+AKmNAPQU452aE
         CSNbmi0+zHHy/8nTORPVQOiA6KbyPY37E49vJGGYNt1s+AA5UIUYiMm1CEcHBVboDgmH
         Q9Rsv/etsD3fLAc+Xa35j/aMik0m8UYIWEMvpKujNSltjaZ+/mYSwlgxZksfjmX24CHH
         jDVw==
X-Gm-Message-State: ABuFfoikAGctptZi9aK3ONXAoB53+am4CIyJsS+4p4kuyaDssqywuXH8
        Rn1Nj+jrwgyAPWfTiGFsp5GbZQ==
X-Google-Smtp-Source: ACcGV60jL8pRa9UpU29FNQRPBiBNoKEhppBYwrMpCdFchKk5sKdafilQAEHa+bHa8sPmn7PMUuJKtw==
X-Received: by 2002:a62:1316:: with SMTP id b22-v6mr3791278pfj.37.1538607066723;
        Wed, 03 Oct 2018 15:51:06 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e64-v6sm4602704pfe.55.2018.10.03.15.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 15:51:05 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:51:05 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
In-Reply-To: <20181003073640.GF18290@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com>
References: <20180924195603.GJ18685@dhcp22.suse.cz> <20180924200258.GK18685@dhcp22.suse.cz> <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz> <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com> <20180925202959.GY18685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com> <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org> <20180926060624.GA18685@dhcp22.suse.cz> <20181002112851.GP18290@dhcp22.suse.cz> <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com>
 <20181003073640.GF18290@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018, Michal Hocko wrote:

> > > So how about this? (not tested yet but it should be pretty
> > > straightforward)
> > 
> > Umm, prctl(PR_GET_THP_DISABLE)?
> 
> /me confused. I thought you want to query for the flag on a
> _different_ process. 

Why would we want to check three locations (system wide setting, prctl 
setting, madvise setting) to determine if a heap can be backed by thp?

If the nh flag being exported to VmFlag is to be extended beyond what my 
patch did, I suggest (1) it does it for the system wide setting as well 
and/or (2) calling a helper function to determine if the vma could be 
backed by thp in the first place regardless of any setting to determine if 
nh/hg is important.

The last thing I suggest is done is adding a third place to check.
