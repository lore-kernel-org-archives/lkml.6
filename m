Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4391DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DACE206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545049697;
	bh=Iz/pRMRlmedXNyjBv4ilc8A94MvxOmE8nvRi+j/k9aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bo3gRRhzkf+uSaFffEs/Kz06eddJa9zo8LAYInMmJxZ2irHa/QcpgJ0KRZ6y4NUpL
	 olkbGu15k6EnG0WZGls+01E/3q2BjrS5B8+SSsu7A+tuaa67ZVU1Ddylj7JGszZwZR
	 HjOM758YZo9So+TTTCeQYmedqxrftOm0vjcT6V54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbeLQM2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:28:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:60974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726938AbeLQM2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:28:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B6CFACA4;
        Mon, 17 Dec 2018 12:28:13 +0000 (UTC)
Date:   Mon, 17 Dec 2018 13:28:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
Message-ID: <20181217122812.GJ30879@dhcp22.suse.cz>
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
 <20181212172712.34019-2-zaslonko@linux.ibm.com>
 <476a80cb-5524-16c1-6dd5-da5febbd6139@redhat.com>
 <bcd0c49c-e417-ef8b-996f-99ecef540d9c@redhat.com>
 <20181214202315.1c685f1e@thinkpad>
 <cffab731-81e0-b80c-665e-c9a62faed4ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cffab731-81e0-b80c-665e-c9a62faed4ec@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-12-18 10:38:32, David Hildenbrand wrote:
[...]
> I am wondering if we should fix this on the memblock level instead than.
> Something like, before handing memory over to the page allocator, add
> memory as reserved up to the last section boundary. Or even when setting
> the physical memory limit (mem= scenario).

Memory initialization is spread over several places and that makes it
really hard to grasp and maintain. I do not really see why we should
make memblock even more special. We do intialize the section worth of
memory here so it sounds like a proper place to quirk for incomplete
sections.
-- 
Michal Hocko
SUSE Labs
