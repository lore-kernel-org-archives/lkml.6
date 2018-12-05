Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01980C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B604B2146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YB/J577i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B604B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeLEWMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:12:39 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:46816 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLEWMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:12:38 -0500
Received: by mail-pg1-f172.google.com with SMTP id w7so9635703pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bOkGwvP31kN5Ew8Q2svXxO1KvIXHlO3WMJDaHlzXfSA=;
        b=YB/J577iuGoIZlODm/GS0Rj4Q6e73Bm4BEih9Grjxh4Z/jS0AxcMOlzYXsKZb91eHb
         ZF7qSO6niAW98DIi90tZXzkv/snSyxnhfMgab5dCKMMIyPOBQxRPaf++Ui14fqcn93ia
         Re5+OzRjXq2h34NayVKCS0B7EbHf5XVtPDKgR6dq/7p5bMxAfcU6JkpduShDNinBs4lm
         AzlPZa5XmrczD9W+o09GGCukaqUYHpd9WB+pPkIk1J7Y+8YENH2SgatFfadNdJiX02fs
         YO+I9JuJc/8dn/+oZ7B/8eZVq+jw9cTR1MEXc4+z8qGBKP3ndrhfNRKkuYKPTqp+9E39
         GLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bOkGwvP31kN5Ew8Q2svXxO1KvIXHlO3WMJDaHlzXfSA=;
        b=t5r1HT3JxkBJMMyr3hm9cSL1WFm543e5mKFdpWEyeZjSQ3wqti89J0kB2A3maRIjGi
         tX6fyue71zxVLfpwqZ5NrCpRNHgh3APfZlCg9F7BG5SvqlsrF5PtSwHO8hQEmejdiwDz
         hZwjO0P5OZovYowqOPWsDRJH3IU54YrcSp9PgmJ3JgGd+E90IDQfIKnHd6nXlQFLM245
         svuEElbftbdsSODzffeRhbq65MhuEHHb4Wq4HmWAiWytI+dkM9oOnLeH5szjyHb+PMNO
         LvOM/0xgpAYhuplP1ucjltWC3SPfXe2VKmMbWcPOiAjoY/TckEamgFuk72oIrjZuLArO
         MpXg==
X-Gm-Message-State: AA+aEWb62++r9C14PEnEwgAVg2UWVLv7+9XAs4Ej6YnNXbEaPvShTfjo
        tcCoVYPp2oZu0vBB59vb1//v5Q==
X-Google-Smtp-Source: AFSGD/XbL3/CYP5q39VKca14xIUA8syMwb/JZAsRwacBdzOm2HkGc/vSXyeP/onEluPhJQjvuhBfKg==
X-Received: by 2002:a62:345:: with SMTP id 66mr25932095pfd.189.1544047957983;
        Wed, 05 Dec 2018 14:12:37 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s2sm35207261pfa.167.2018.12.05.14.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:12:37 -0800 (PST)
Date:   Wed, 5 Dec 2018 14:12:35 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812051411210.9633@chino.kir.corp.google.com>
References: <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com> <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com> <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net> <20181205204034.GB11899@redhat.com> <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Linus Torvalds wrote:

> > So ultimately we decided that the saner behavior that gives the least
> > risk of regression for the short term, until we can do something
> > better, was the one that is already applied upstream.
> 
> You're ignoring the fact that people *did* report things regressed.
> 
> That's the part I find unacceptable. You're saying "we picked
> something that minimized regressions".
> 
> No it didn't. The regression is present and real, and is on a real
> load, not a benchmark.
> 
> So that argument is clearly bogus.
> 
> I'm going to revert the commit since people apparently seem to be
> ignoring this fundamental issue.
> 
> Real workloads regressed.  The regressions got reported. Ignoring that
> isn't acceptable.
> 

Please allow me to prepare my v2 because it's not a clean revert due to 
the follow-up 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into 
alloc_hugepage_direct_gfpmask") and will incorporate the feedback from 
Michal to not change anything outside of the thp fault path.
