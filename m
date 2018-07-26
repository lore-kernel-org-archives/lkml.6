Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480D7C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C2020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C2020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbeGZPmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:33174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729923AbeGZPmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:42:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0FE4AD26;
        Thu, 26 Jul 2018 14:25:05 +0000 (UTC)
Date:   Thu, 26 Jul 2018 16:25:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 05/19] mm/page_alloc: Handle allocation for encrypted
 memory
Message-ID: <20180726142504.GN28386@dhcp22.suse.cz>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-6-kirill.shutemov@linux.intel.com>
 <95ce19cb-332c-44f5-b3a1-6cfebd870127@intel.com>
 <20180719082724.4qvfdp6q4kuhxskn@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719082724.4qvfdp6q4kuhxskn@kshutemo-mobl1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 11:27:24, Kirill A. Shutemov wrote:
> On Wed, Jul 18, 2018 at 04:03:53PM -0700, Dave Hansen wrote:
> > I asked about this before and it still isn't covered in the description:
> > You were specifically asked (maybe in person at LSF/MM?) not to modify
> > allocator to pass the keyid around.  Please specifically mention how
> > this design addresses that feedback in the patch description.
> > 
> > You were told, "don't change the core allocator", so I think you just
> > added new functions that wrap the core allocator and called them from
> > the majority of sites that call into the core allocator.  Personally, I
> > think that misses the point of the original request.
> > 
> > Do I have a better way?  Nope, not really.
> 
> +Michal.
> 
> IIRC, Michal was not happy that I propagate the KeyID to very core
> allcoator and we've talked about wrappers around existing APIs as a better
> solution.
> 
> Michal, is it correct?

Yes that is the case. I haven't seen this series and unlikely will get
to it in upcoming days though so I cannot comment much more
unfortunately.
-- 
Michal Hocko
SUSE Labs
