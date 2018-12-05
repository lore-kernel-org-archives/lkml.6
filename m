Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71719C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F620989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363F620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeLEX1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:27:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeLEX1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:27:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A869C30026D9;
        Wed,  5 Dec 2018 23:27:14 +0000 (UTC)
Received: from redhat.com (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CB316109E;
        Wed,  5 Dec 2018 23:27:12 +0000 (UTC)
Date:   Wed, 5 Dec 2018 18:27:10 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>, balbirs@au1.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, Philip.Yang@amd.com,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Blinzer, Paul" <Paul.Blinzer@amd.com>,
        John Hubbard <jhubbard@nvidia.com>, rcampbell@nvidia.com
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
Message-ID: <20181205232710.GP3536@redhat.com>
References: <20181205180756.GI3536@redhat.com>
 <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
 <20181205183314.GJ3536@redhat.com>
 <0ddb2620-ecbd-4b7b-aeb7-3f4ae7746e83@deltatee.com>
 <20181205185550.GK3536@redhat.com>
 <7ab26ea6-d16d-8d71-78ca-4266a864f8d3@deltatee.com>
 <20181205225828.GL3536@redhat.com>
 <a0240f08-68ab-5167-c2c7-2f930aa0a54b@deltatee.com>
 <20181205232028.GO3536@redhat.com>
 <af781c8a-1990-c091-0471-5b2d873ee526@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af781c8a-1990-c091-0471-5b2d873ee526@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 05 Dec 2018 23:27:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:23:42PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-05 4:20 p.m., Jerome Glisse wrote:
> > And my proposal is under /sys/bus and have symlink to all existing
> > device it agregate in there.
> 
> That's so not the point. Use the existing buses don't invent some
> virtual tree. I don't know how many times I have to say this or in how
> many ways. I'm not responding anymore.

And how do i express interaction with different buses because i just
do not see how to do that in the existing scheme. It would be like
teaching to each bus about all the other bus versus having each bus
register itself under a common framework and have all the interaction
between bus mediated through that common framework avoiding code
duplication accross buses.

> 
> > So you agree with my proposal ? A sysfs directory in which all the
> > bus and how they are connected to each other and what is connected
> > to each of them (device, CPU, memory).
> 
> I'm fine with the motivation. What I'm arguing against is the
> implementation and the fact you have to create a whole grand new
> userspace API and hierarchy to accomplish it.
> 
> Logan
