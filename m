Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926B6214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926B6214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbeKVEde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:33:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:51708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731412AbeKVEde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:33:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 381F6ACB8;
        Wed, 21 Nov 2018 17:58:10 +0000 (UTC)
Date:   Wed, 21 Nov 2018 18:58:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 1/3] mm, proc: be more verbose about unstable VMA
 flags in /proc/<pid>/smaps
Message-ID: <20181121175809.GT12932@dhcp22.suse.cz>
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-2-mhocko@kernel.org>
 <20181121175427.GB5704@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121175427.GB5704@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-11-18 18:54:28, Mike Rapoport wrote:
> On Tue, Nov 20, 2018 at 11:35:13AM +0100, Michal Hocko wrote:
[...]
> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> > index 12a5e6e693b6..b1fda309f067 100644
> > --- a/Documentation/filesystems/proc.txt
> > +++ b/Documentation/filesystems/proc.txt
> > @@ -496,7 +496,9 @@ flags associated with the particular virtual memory area in two letter encoded
> > 
> >  Note that there is no guarantee that every flag and associated mnemonic will
> >  be present in all further kernel releases. Things get changed, the flags may
> > -be vanished or the reverse -- new added.
> > +be vanished or the reverse -- new added. Interpretatation of their meaning
> > +might change in future as well. So each consumnent of these flags have to
> 
>                                            consumer?                 has

fixed. Thanks!

-- 
Michal Hocko
SUSE Labs
