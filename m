Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9956C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D51120862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D51120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeGaO6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:58:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54618 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbeGaO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:58:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so3033882wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 06:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQanTt4+ddHuPodgPPZH+CVQYDRU+bebT2qesJNJkXo=;
        b=IgOBSd42XSjsanmG5fOu2g+7lCIsygAhWHTxrClJHWt3EE8ifpu36Q6e4Hp0L4FJza
         Sdu9xI8zvav66myAxFGGmCsuw7iSxuKmw3VHEqM9l4umRwLypIkyQ/LPm4SUyyuV53ci
         V3H9hqFs+hAvE+uyWRI49URce5obX8M7m/piYgfmhpg6FwoGjdffbMCwc5lt4bPIWB1n
         ZqUs9eXhSgPff/FERi+3DVS/qBsKugPddpwxmjssdwd6gjfzwyXPqdXwpWCqkIfFhqwT
         MdLcDvLjpu07En5OV2JNVPOSQZ7kfPE8DZxbOYwjXNf4xCdcnSEuaO7lA5+BEnxgMeAF
         rKKQ==
X-Gm-Message-State: AOUpUlFO3bG6A0oKivLp2XmIXshMo9NdzSLf5R8Bltwi9FVs5xaxvhUl
        bbaGXTijCXvLlI20+qG0YKQZ7xi9bMU=
X-Google-Smtp-Source: AAOMgpfPmTSG3W3RljerMkSqZGJmfjfrQVrb5N+TE2G86IwgfeKrbpX8zvGlGi7cnkMIdrqX2lNoog==
X-Received: by 2002:a1c:207:: with SMTP id 7-v6mr2326987wmc.146.1533043064285;
        Tue, 31 Jul 2018 06:17:44 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id b11-v6sm14054822wrv.82.2018.07.31.06.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:17:43 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 7B7881244E0; Tue, 31 Jul 2018 15:17:42 +0200 (CEST)
Date:   Tue, 31 Jul 2018 15:17:42 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
Message-ID: <20180731131742.GB473@techadventures.net>
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731130434.GL4557@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731130434.GL4557@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 03:04:34PM +0200, Michal Hocko wrote:
> On Tue 31-07-18 08:49:11, Pavel Tatashin wrote:
> > Hi Oscar,
> > 
> > Have you looked into replacing __paginginit via __meminit ? What is
> > the reason to keep both?
> 
> All these init variants make my head spin so reducing their number is
> certainly a desirable thing to do. b5a0e01132943 has added this variant
> so it might give a clue about the dependencies.

Looking at b5a0e011329431b90d315eaf6ca5fdb41df7a117, I cannot really see why
this was not done in init.h
Maybe the comitter did not want to hack directly into __meminit.

I think that __paginginit was a way to abstract the whole thing without having
to modify init.h directly.

I guess we could get rid of it and so something like:

#ifdef CONFIG_MEMORY_HOTPLUG
 #define __meminit        __section(.meminit.text) __cold notrace \
                                                  __latent_entropy
#else
#define __meminit       __init
#endif

And then we would have to replace __paginginit with __meminit.

But honestly, puting an #ifdef in init.h feels a bit wierd to me,
although I do not really have a strong opinion here.

Thanks
-- 
Oscar Salvador
SUSE L3
