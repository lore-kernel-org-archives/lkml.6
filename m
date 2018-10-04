Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7728521477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PalRItz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7728521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJDQIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:08:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:08:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so3069911pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pz+qjDnOSMwpXFoomShA6aeyy9jCwAHreDh5uaYSGw4=;
        b=PalRItz4CJbLU9DlF4v7lSa6nTWNoCZup+cePw6Hhe56af4GSN9heIUSyKUnXiJbXP
         DOTk6ZP7DZ378YlvFRumk6W+8Ejs817zhv2kzT6yNYbsZypespznRXwbb2mShxQQAVEJ
         bZ5GdeM1VW2B7qMp4SnpzwQUWKk7qJZmAFsVuqr7X52x253TVj/ntM4PEO9DBR4BoN5l
         O2rNLCpFHtflvQQGTuXMW/FdemPcZI1uEncCfVDyo2XHWccXufa+GiFSwV2LLUOFkhv3
         8wvlpWuLrbHY+6RiiwG2gLCj3AWb+ICTPYdumaibrkgI8hivru+1XTUJiz6Cts+MGbEj
         Vf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pz+qjDnOSMwpXFoomShA6aeyy9jCwAHreDh5uaYSGw4=;
        b=jShUnnwUACol7uw+cfN3LzJaF2oJMMp4u9kgw6kG8gROZk7J7TXJkuVuMFzW7B6Q4m
         9FJw/VXtCMSu0o0iXBOcbOtIfzUxgIS0OdApOcIpfyGuuCRWMprEdDOYHGX5Lt66KQzI
         qDpwt5csPJjDwwhyLn++6MRB6vLpTBDnkKoYPHhW1eR4/OQkvcXASKvZmTBLQpPz8Fkv
         5hxPwxoCUuLCVEB2/cNu4ZymKvRO9arvIWGsiVF77oTlX7yEaYCQdBczViHhpjbuB6ii
         JTWjXvCTpMeKk1gU5eMNlZXti6J6ZKomWc095C8ipreMcTLRQrL5Kn6mO3/LS/DDE6mc
         NWSw==
X-Gm-Message-State: ABuFfohRC/BwmaurvsGOpeHiPTIy4fckr7+D/IkPD/+YZKZn4BSrSSzJ
        BINzT5F9Y8Ux4VqJoLbpV1hCSQ==
X-Google-Smtp-Source: ACcGV61BKHVJ9WzYwjN50uloTbr9rBVmi0JVI1zE4i33LRVo3ElSukQSRDtOmhYyZK/Zuh4j8OnbBA==
X-Received: by 2002:a62:401:: with SMTP id 1-v6mr5781763pfe.236.1538644539653;
        Thu, 04 Oct 2018 02:15:39 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g5-v6sm6838979pfk.160.2018.10.04.02.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 02:15:38 -0700 (PDT)
Date:   Thu, 4 Oct 2018 02:15:38 -0700 (PDT)
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
In-Reply-To: <20181004055842.GA22173@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1810040209130.113459@chino.kir.corp.google.com>
References: <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz> <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com> <20180925202959.GY18685@dhcp22.suse.cz> <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com>
 <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org> <20180926060624.GA18685@dhcp22.suse.cz> <20181002112851.GP18290@dhcp22.suse.cz> <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com> <20181003073640.GF18290@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com> <20181004055842.GA22173@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018, Michal Hocko wrote:

> > > > > So how about this? (not tested yet but it should be pretty
> > > > > straightforward)
> > > > 
> > > > Umm, prctl(PR_GET_THP_DISABLE)?
> > > 
> > > /me confused. I thought you want to query for the flag on a
> > > _different_ process. 
> > 
> > Why would we want to check three locations (system wide setting, prctl 
> > setting, madvise setting) to determine if a heap can be backed by thp?
> 
> Because we simply have 3 different ways to control THP? Is this a real
> problem?
> 

And prior to the offending commit, there were three ways to control thp 
but two ways to determine if a mapping was eligible for thp based on the 
implementation detail of one of those ways.  If there are three ways to 
control thp, userspace is still in the dark wrt which takes precedence 
over the other: we have PR_SET_THP_DISABLE but globally sysfs has it set 
to "always", or we have MADV_HUGEPAGE set per smaps but PR_SET_THP_DISABLE 
shown in /proc/pid/status, etc.

Which one is the ultimate authority?  There's one way to specify it: in a 
single per-mapping location that reveals whether that mapping is eligible 
for thp or not.  So I think it would be a very sane extension so that 
smaps reveals if a mapping can be backed by hugepages or not depending on 
the helper function thp uses itself to determine if it can fault 
hugepages.  I don't think we should have three locations to check and then 
try to resolve which one takes precedence over the other for each 
userspace implementation (and perhaps how the kernel implementation 
evolves).
