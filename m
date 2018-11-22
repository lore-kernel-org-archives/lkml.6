Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03B0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8333206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7uPMlf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8333206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbeKVNEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:04:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45021 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbeKVNEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:04:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so8131571plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YV+ChlavE1QLyyBY5kNZjpAtat0aYc/ZGSq2+CHYRpA=;
        b=N7uPMlf9jCd5KgD4SbilYmGVdkx88YYaza8jhcx/7d+HEqjZAEzbjkSvg2dFS2YkHN
         4+Ip7kQ8riqxFxf90n5qvBdO5HPNd8u609w/D3+fCkgu5DZSAdaA2Q/MYVAmKdtcpV56
         RidOcmU/iJkSXuC6veK9q8FD/QyCWzG956zUuJj0WRfXIhsjKlB0QsugeIEp5q1kdlB/
         J/2nyStrWG0eSKwrP4gq6wKcEIiOk3t6/iZfkmnbWt9yRGGHzlD0vxkQLBdSH9p1mE8D
         Mq66V7tIBZP5fcXH01L2UkNMhm8PQa73jxBJPzMsVk4b+TGK6ibVhPiZ+C25RDc++ecX
         IGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YV+ChlavE1QLyyBY5kNZjpAtat0aYc/ZGSq2+CHYRpA=;
        b=N5nd0F69eB1A527Os+QkjngGLlYAnhvrta40ZDJO9o/mYjCje7HgOV4h+tbNbMFJcz
         ycZ012z61/KDSuoagFC9urPOkee/2g3d+O+pQRv0PCFCai/YOpKD9e8FCv2ZEPt5b86h
         AVx0M8b/1rVA730flwlnCvwD1yJvkX2kXEHL2L+JqK+kViG1zZY2lMQSeGxcB04dY5Cu
         JQjq2CdJ+QdAFyYmflFYIVoYb3j/Yj2bf2lNvrpznGTYlveM8g/eEXWVPdhM2Yj85uIH
         6/8fOexETL4+V31l5GYPPdLvO79gbEDdgdwWpzO/4AlXS9boLUXeggyGb6VZ+ard6g1i
         FvMQ==
X-Gm-Message-State: AA+aEWYge/DDCfBn16R96dGC7sMu5SGUPyFcCp2xvBAVPA8o7idzyODe
        rem3V8LYq4ALKOSv2RcAuS2RyszdRiQ=
X-Google-Smtp-Source: AFSGD/WXGiU2eKRYKXB655s5FXF8Jb5illhGs6swhMvT9fYglNiDS4P+B7JwZtaJZB7T3eyHIvOA6g==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr8320755plc.288.1542853633187;
        Wed, 21 Nov 2018 18:27:13 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id z186sm6939811pfz.119.2018.11.21.18.27.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 18:27:12 -0800 (PST)
Date:   Wed, 21 Nov 2018 18:27:11 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Michal Hocko <mhocko@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
In-Reply-To: <20181121071132.GD12932@dhcp22.suse.cz>
Message-ID: <alpine.LSU.2.11.1811211757070.5557@eggly.anvils>
References: <20181120134323.13007-1-mhocko@kernel.org> <20181120134323.13007-4-mhocko@kernel.org> <alpine.LSU.2.11.1811201721470.2061@eggly.anvils> <20181121071132.GD12932@dhcp22.suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Michal Hocko wrote:
> On Tue 20-11-18 17:47:21, Hugh Dickins wrote:
> > On Tue, 20 Nov 2018, Michal Hocko wrote:
> > 
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > filemap_map_pages takes a speculative reference to each page in the
> > > range before it tries to lock that page. While this is correct it
> > > also can influence page migration which will bail out when seeing
> > > an elevated reference count. The faultaround code would bail on
> > > seeing a locked page so we can pro-actively check the PageLocked
> > > bit before page_cache_get_speculative and prevent from pointless
> > > reference count churn.
> > > 
> > > Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > 
> > Acked-by: Hugh Dickins <hughd@google.com>
> 
> Thanks!
> 
> > though I think this patch is more useful to the avoid atomic ops,
> > and unnecessary dirtying of the cacheline, than to avoid the very
> > transient elevation of refcount, which will not affect page migration
> > very much.
> 
> Are you sure it would really be transient? In other words is it possible
> that the fault around can block migration repeatedly under refault heavy
> workload? I just couldn't convince myself, to be honest.

I don't deny that it is possible: I expect that, using fork() (which does
not copy the ptes in a shared file vma), you can construct a test case
where each child faults one or another page near a page of no interest,
and that page of no interest is a target of migration perpetually
frustrated by filemap_map_pages()'s briefly raised refcount.

But I suggest that's a third-order effect: well worth fixing because
it's easily and uncontroversially dealt with, as you have; but not of
great importance.

The first-order effect is migration conspiring to defeat itself: that's
what my put_and_wait_on_page_locked() patch, in other thread, is about.

The second order effect is when a page that is really wanted is waited
on - the target of a fault, for which page refcount is raised maybe
long before it finally gets into the page table (whereupon it becomes
visible to try_to_unmap(), and its mapcount matches refcount so that
migration can fully account for the page).  One class of that can be
well dealt with by using put_and_wait_on_page_locked_killable() in
lock_page_or_retry(), but I was keeping that as a future instalment.

But I shouldn't denigrate the transient case by referring so lightly
to migrate_pages()' 10 attempts: each of those failed attempts can
be very expensive, unmapping and TLB flushing (including IPIs) and
remapping. It may well be that 2 or 3 would be a more cost-effective
number of attempts, at least when the page is mapped.

Hugh
