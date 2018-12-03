Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E2EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA72C20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q36ZJtc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA72C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLCQQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:16:45 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35460 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeLCQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:16:45 -0500
Received: by mail-yw1-f67.google.com with SMTP id h32so5611242ywk.2;
        Mon, 03 Dec 2018 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zyej+P76eFYO88X75IO3hiKMFBZsjaA/oPu+bdOeXog=;
        b=Q36ZJtc9jhXRNvwwyFmz6XweAG5R2x3fD/KaHvyNiLRebwVBuouKSjNnxlmjuo0e87
         hYroaWLAjaEShMoVApHVKCmbVUjoBeJMvW5cOFr8D9Ej02Nb1j2hpZmlrafP3EOo9j/d
         +0dAdq+CUrd0JklJv4RY2NmXbAKGiqBFlLv4qAcmvknOtGPtAZsskAEy2ln3GzHyQFNK
         SYyslHdtdcfzX5HqGbPSZp4JFaUk5RcUAXdE1i33JhnEITRTFoJF64rzwIndP+nw9dLU
         f+w4w6sXrZI9UbKlnFgzfk4L+TaRX+qyOede0iiOLQbvUZnEadMOu6S/HNXCNBOrB3ZI
         NXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zyej+P76eFYO88X75IO3hiKMFBZsjaA/oPu+bdOeXog=;
        b=hgBYoMo/ac7zuIwa/0wdvBgiBt83n8DYkUZuw1UkXdW6PSHRonxL6+Gk4RuNuefXXZ
         PTdwn86uyCkZ+z6P9waDmbUAFCC9i2VTLxgV9+Hq9u7YARbG9Lopf7oQriZYL7U3skv4
         WRlXgyrV93l0Eazj1liVwV3p8kNmYn8hwf2Fc0M4XAc6oioW0chBl1D5Ems54RNjq8UA
         RxSI71O9j03MopgwcEcrucjjX0nnGeAgnn9fnRBzyE5RcS/Dq3bLXMcgEwBYNbWrCYkW
         soHzl+Yk2/eCXdvehtPgHWyBP3orxOrTqpXbGqP9HTgpN6+FDGNqamKnv4IM/tnR/v0f
         Hsxw==
X-Gm-Message-State: AA+aEWa+qxJMVPpBsuZX5mI95DsDKyOVkUGulJWKX1y6Yu97ZgvKwF/m
        zFt2hH0Crtwyh36JMZCBgCs=
X-Google-Smtp-Source: AFSGD/WDhW6Tkie0JLjKRTkPTLbiDCCnzJoZTzmHxZo4+koB/r/mpbqawg6suWa97v1xtwWYNK8xLg==
X-Received: by 2002:a81:3194:: with SMTP id x142mr15441540ywx.92.1543853796911;
        Mon, 03 Dec 2018 08:16:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:20d7])
        by smtp.gmail.com with ESMTPSA id w1sm4365697ywd.49.2018.12.03.08.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 08:16:35 -0800 (PST)
Date:   Mon, 3 Dec 2018 08:16:33 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vbabka@suse.cz, peterz@infradead.org,
        dhaval.giani@oracle.com
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181203161633.GK2509588@devbig004.ftw2.facebook.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181130191819.GJ2509588@devbig004.ftw2.facebook.com>
 <20181201001307.wmb6o4fuysnl7vcz@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201001307.wmb6o4fuysnl7vcz@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 30, 2018 at 04:13:07PM -0800, Daniel Jordan wrote:
> On Fri, Nov 30, 2018 at 11:18:19AM -0800, Tejun Heo wrote:
> > Hello,
> > 
> > On Mon, Nov 05, 2018 at 11:55:45AM -0500, Daniel Jordan wrote:
> > > Michal, you mentioned that ktask should be sensitive to CPU utilization[1].
> > > ktask threads now run at the lowest priority on the system to avoid disturbing
> > > busy CPUs (more details in patches 4 and 5).  Does this address your concern?
> > > The plan to address your other comments is explained below.
> > 
> > Have you tested what kind of impact this has on bandwidth of a system
> > in addition to latency?  The thing is while this would make a better
> > use of a system which has idle capacity, it does so by doing more
> > total work.  It'd be really interesting to see how this affects
> > bandwidth of a system too.
> 
> I guess you mean something like comparing aggregate CPU time across threads to
> the base single thread time for some job or set of jobs?  Then no, I haven't
> measured that, but I can for next time.

Yeah, I'm primarily curious how expensive this is on an already loaded
system, so sth like loading up the system with a workload which can
saturate the system and comparing the bw impacts of serial and
parallel page clearings at the same frequency.

Thanks.

-- 
tejun
