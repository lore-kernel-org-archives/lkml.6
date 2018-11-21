Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AC3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CF021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CF021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeKURkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:40:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:58358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbeKURkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:40:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A023ACB4;
        Wed, 21 Nov 2018 07:07:27 +0000 (UTC)
Date:   Wed, 21 Nov 2018 08:07:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
Message-ID: <20181121070726.GC12932@dhcp22.suse.cz>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-4-mhocko@kernel.org>
 <20181120140715.mouc7okin3ht5krr@kshutemo-mobl1>
 <20181120141207.GK22247@dhcp22.suse.cz>
 <29F15A96-D6EB-450E-B54B-A4CB460ED9B3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29F15A96-D6EB-450E-B54B-A4CB460ED9B3@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 21:51:39, William Kucharski wrote:
> 
> 
> > On Nov 20, 2018, at 7:12 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > +		/*
> > +		 * Check the locked pages before taking a reference to not
> > +		 * go in the way of migration.
> > +		 */
> 
> Could you make this a tiny bit more explanative, something like:
> 
> +		/*
> +		 * Check for a locked page first, as a speculative
> +		 * reference may adversely influence page migration.
> +		 */

sure

> 
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Thanks!

-- 
Michal Hocko
SUSE Labs
