Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61743C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1051B21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ukk55n5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1051B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeLFXtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:49:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36805 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLFXtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:49:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so964654pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tvrXZnrlCcV4QOoUhS1S4SiZidGNghL5IzoCk6ExYiE=;
        b=Ukk55n5S3eOjrEZePwVRkSBt16ZGCAveeyjpN+UZFTZ4BOWmGPasuAU325r/COePgi
         H4bPxfDFp1kn/aSvAv5EXSrRZW4DjWDJdTFo1/5hVyMuMwy/7ygIKrjsqiZkigPH5ZvI
         RRLf9+yFY8bLBHLkt1+BvyC1SXIkd2DRefKkry4InRtDGrXYTAlSiA3urPz7I6a6fgje
         mg1uOMrk223xNk0nn818ZPMeWiJhEnIlO2xz0x8p2kH16FaIUEfFr4mtOGXoAXWPn5yK
         bMMmm6DYw59Jm0pvdohoWf78VeW1X2b4qmAU9aXqSdkClQVmucs2DbxkUcSlD2r1LhPL
         sSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tvrXZnrlCcV4QOoUhS1S4SiZidGNghL5IzoCk6ExYiE=;
        b=YGs11KZHJk20bf9Yyqi1ajKh80ZCDk6qm6pHzyxb16remKdMshG/oQkFx8/MfmvINA
         6WbhIlmLYlynzSa3x+Ne9/6pdBdAWhNG9HZJIh/HWmMlHGuUtswztUlzRQS8o3cry4tL
         zX2BBWYHMvl/60mALq3Y972DTWcCuh8aPy5W/roudlnE6DYZ8HHAVtvU2a/EA0qInUxv
         iDT4hk4Bi6pyfmc/+7rc1S1YdOS39CSzzpUeCf8xAJXjXa45VTaudMiNJ+qL8WGVojPz
         3JrN+YfzHGiaAAr5OATnqvG6QQX3K9X2VB5W/9mdQ4I+jgqv2xTfMhZt8WnT14eQgd5I
         8+Sg==
X-Gm-Message-State: AA+aEWZ9ya1Je3rCGOMaR83g8iWD/PJByDhrFpi0DRA4pG/DL17lyuH8
        2KcCxyuJFl3nyFGM2Wt/H2dMew==
X-Google-Smtp-Source: AFSGD/X//XQbaKk1Hvl2UDEoigLCtqg92HDmjUMH0cOldVkk5HwpCSWan1tVTOSCK/7/nQZoJETmzg==
X-Received: by 2002:a62:2702:: with SMTP id n2mr31385986pfn.29.1544140146212;
        Thu, 06 Dec 2018 15:49:06 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w5sm1936375pfn.89.2018.12.06.15.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 15:49:05 -0800 (PST)
Date:   Thu, 6 Dec 2018 15:49:04 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: MADV_HUGEPAGE vs. NUMA semantic (was: Re: [LKP] [mm] ac5b2c1891:
 vm-scalability.throughput -61.3% regression)
In-Reply-To: <20181206091405.GD1286@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812061544360.162675@chino.kir.corp.google.com>
References: <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com> <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com> <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com> <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com> <20181205233632.GE11899@redhat.com> <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com> <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <20181206091405.GD1286@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018, Michal Hocko wrote:

> MADV_HUGEPAGE changes the picture because the caller expressed a need
> for THP and is willing to go extra mile to get it. That involves
> allocation latency and as of now also a potential remote access. We do
> not have complete agreement on the later but the prevailing argument is
> that any strong NUMA locality is just reinventing node-reclaim story
> again or makes THP success rate down the toilet (to quote Mel). I agree
> that we do not want to fallback to a remote node overeagerly. I believe
> that something like the below would be sensible
> 	1) THP on a local node with compaction not giving up too early
> 	2) THP on a remote node in NOWAIT mode - so no direct
> 	   compaction/reclaim (trigger kswapd/kcompactd only for
> 	   defrag=defer+madvise)
> 	3) fallback to the base page allocation
> 

I disagree that MADV_HUGEPAGE should take on any new semantic that 
overrides the preference of node local memory for a hugepage, which is the 
nearly four year behavior.  The order of MADV_HUGEPAGE preferences listed 
above would cause current users to regress who rely on local small page 
fallback rather than remote hugepages because the access latency is much 
better.  I think the preference of remote hugepages over local small pages 
needs to be expressed differently to prevent regression.
