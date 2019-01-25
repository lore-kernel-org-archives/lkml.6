Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F965C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66438218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfAYTI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:08:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfAYTI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:08:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4EE4CF633;
        Fri, 25 Jan 2019 19:08:28 +0000 (UTC)
Received: from redhat.com (ovpn-122-28.rdu2.redhat.com [10.10.122.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18037604CC;
        Fri, 25 Jan 2019 19:08:24 +0000 (UTC)
Date:   Fri, 25 Jan 2019 14:08:22 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com,
        thomas.lendacky@amd.com, akpm@linux-foundation.org,
        mhocko@suse.com, linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com, bp@suse.de,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de
Subject: Re: [PATCH 0/5] [v4] Allow persistent memory to be used like normal
 RAM
Message-ID: <20190125190820.GC3237@redhat.com>
References: <20190124231441.37A4A305@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124231441.37A4A305@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 25 Jan 2019 19:08:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:14:41PM -0800, Dave Hansen wrote:
> v3 spurred a bunch of really good discussion.  Thanks to everybody
> that made comments and suggestions!
> 
> I would still love some Acks on this from the folks on cc, even if it
> is on just the patch touching your area.
> 
> Note: these are based on commit d2f33c19644 in:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
> 
> Changes since v3:
>  * Move HMM-related resource warning instead of removing it
>  * Use __request_resource() directly instead of devm.
>  * Create a separate DAX_PMEM Kconfig option, complete with help text
>  * Update patch descriptions and cover letter to give a better
>    overview of use-cases and hardware where this might be useful.

This one looks good to me, i will give it a go on monday to
test against nouveau and HMM.

Cheers,
Jérôme
