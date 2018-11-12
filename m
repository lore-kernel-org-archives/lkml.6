Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4081C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CAD2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="W2oVTOFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CAD2241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbeKMHXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:23:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40526 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:23:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so15980600qki.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 13:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B/Ov/P3T1u+NNoS05+vJ1sNT/9WKdMexDi3/827BXps=;
        b=W2oVTOFCluWJuedRp3jt2QUEqdFaLKlpD3HbLcsmemjtnT5gJkby/k1x+luGaF0Dco
         zpeJUA1BLinaHuL2HVb8OXB/9fdqIK/41fkNnV+jT7oA+vAzYdtHurUeQ2pXRsGBe9lP
         nAoO4xxspnpD1xPxzHm48AufECY5w22KIu5FFZYLmBn9W7gNUqEypxccmgr7aTVBPFRZ
         ew+u4YJs6DHVcGefB5tVrhR+DbJw/beX8ge6wBYABgEvSMZBx8JnLaDbD+dQlaLr/guA
         A8MZA7cTmmRhIoFi0UMHT2/YIFFa0WsCWKW8PbCmLKjHv+TVb26Uls+i4KORvaYXw76X
         ffcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B/Ov/P3T1u+NNoS05+vJ1sNT/9WKdMexDi3/827BXps=;
        b=gARVOw9tK8KVkygWzxIAG2GT9IoEMd+FLlBdnYJ19HSCmLeVR59N5OoBoUOlBHsoA0
         w4ATNDY+0n6gAoR12b8Fw3GtUXRfAOuQ3JpW/nXyUDz6vmlQDwpjRhXKHUd/FZ2/8O0O
         6DOPPsuUbaQ2t5cNYJ1TPH9nPe+ejAfIlM7+PtHvcXNuMSDPtPHxQoiGB7IF7Y7JzfXQ
         kZ10vZ75GHgAA+ZGz+p22UQEqAmzAQ5y9Ql8izFWwu3k2mdjmEOKvgbzJ5gAHoU9p8TU
         JsHhfRp/czOL2TDsgDj1HhjK3B2iN6ATDIdwjqEpqyL5oc2fpSj0FCm+KFqxIpdiitun
         zOiQ==
X-Gm-Message-State: AGRZ1gKiGK1jxZY08PbG3c+mZjbSifFPje+PR6oHDCWe5puMKUHnfAA0
        J0HCOTq7P0ktamxn7KUYq9GCAw==
X-Google-Smtp-Source: AJdET5d1PCdzXyWJ6teWubPTeTQhlbA/iiPrdagHGKtsHDDpMXRydqu0zHGaGjJ5yXs9yOsPnWsG4Q==
X-Received: by 2002:ac8:2353:: with SMTP id b19mr2521199qtb.187.1542058122697;
        Mon, 12 Nov 2018 13:28:42 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id i73sm493744qke.80.2018.11.12.13.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 13:28:41 -0800 (PST)
Date:   Mon, 12 Nov 2018 21:28:39 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     osalvador@techadventures.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Yasuaki Ishimatsu <yasu.isimatu@gmail.com>,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jonathan.Cameron@huawei.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        alexander.h.duyck@linux.intel.com, osalvador@suse.de
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Create add/del_device_memory
 functions
Message-ID: <20181112212839.ut4owdqfuibzuhvz@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
 <20181015153034.32203-3-osalvador@techadventures.net>
 <CAPcyv4jM-EJCmOwFkPqXhtgR54UueNtHjfCUbnnJqFLmgj7Jvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jM-EJCmOwFkPqXhtgR54UueNtHjfCUbnnJqFLmgj7Jvw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> This collides with the refactoring of hmm, to be done in terms of
> devm_memremap_pages(). I'd rather not introduce another common
> function *beneath* hmm and devm_memremap_pages() and rather make
> devm_memremap_pages() the common function.
> 
> I plan to resubmit that cleanup after Plumbers. So, unless I'm
> misunderstanding some other benefit a nak from me on this patch as it
> stands currently.
> 

Ok, Dan, I will wait for your new refactoring series before continuing
reviewing this series.

Thank you,
Pasha
