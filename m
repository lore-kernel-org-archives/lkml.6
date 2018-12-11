Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B394C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182C520851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvvrhnAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182C520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeLKVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:12:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42787 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:12:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so7494530plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lPrFjhTsNHUUayrOVZ+SpfzOV4fwLjJ9piWRaxrSzko=;
        b=TvvrhnAUzDAlfjotKGhxfewuauVpZld1xXZ05uqRFJ+QMOGmLdUv6WeF2zyAq5AaPL
         ZNlsc+HPoOOGAbghz93ggz7EoS9WntxLPXsUw1t/Les2dYBlfXaqoVBmzeDtQKfdeXC2
         aEvdpjExbiN1zlAreBZBoDImLY4awKlNw9ZZ6zwvQQSRST0kAYw6bcBxDN2Or/mvFZYF
         be4MIULUFl8LeZ35OL7aOHTsZPOgmOMhGdTUT2/skioMBhOQNmhFylxWz4aPJ8XkKzBi
         6l5Z7k3RYLR/echceWFpDe45ygsiiJ2t2r3x5Tqi1Fhgk6UhiJIJVj0H8B5cU2Ys2P49
         B/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lPrFjhTsNHUUayrOVZ+SpfzOV4fwLjJ9piWRaxrSzko=;
        b=KVqVXH5TsFvvGOFGWhz9UXqgYDyyUTfWm7AV1yKv4iMXXbAdsLeoPmCXbdMjWSgcbz
         V6GjWtPtF0DWwstHpT8V73zRC9UlhU+NICsr9r8+uR+udtDR7o0Gb14F9/ueKINXmaVm
         Cd8Gt3GqddbnE179Wh7SVW5R8hotU9q1j8iQkWGHWmZySvAMPiaTyzoYvbKbZtqf9uHm
         qeYrKmk8NajTJfCaPoPTluyvZLkycSZtcTCksUdd7oyZkKqfGIA4b1iqYcMXT9YaLL8y
         ePnQtCclyO6IMqUbu8eZjy6euMO0jGkAnpXEE98FPikB2akNMrKduU/pOAiTTDv7+0bO
         utHg==
X-Gm-Message-State: AA+aEWYXE4dvODoY89VnSzGGuRkmCTwjajegwJOLzPAJ2Bv7+M4DGu3N
        Kwl9WGScR5E/3EaokxIWU5PcnQ==
X-Google-Smtp-Source: AFSGD/UJ9uaV7drFVRG56eHW2DQeRtWMmnnJ7r2kyQs6EpbfVs8o/kj92RICmAwWp7FvAr/DlwC7jg==
X-Received: by 2002:a17:902:8f97:: with SMTP id z23mr17748953plo.283.1544562775705;
        Tue, 11 Dec 2018 13:12:55 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e86sm23104576pfb.6.2018.12.11.13.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:12:54 -0800 (PST)
Date:   Tue, 11 Dec 2018 13:12:54 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Jerome Glisse <jglisse@redhat.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: fix mmu_notifier_range_init warning
In-Reply-To: <20181211201909.GA6478@redhat.com>
Message-ID: <alpine.DEB.2.21.1812111310320.87855@chino.kir.corp.google.com>
References: <20181211200526.3868586-1-arnd@arndb.de> <20181211201909.GA6478@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Jerome Glisse wrote:

> On Tue, Dec 11, 2018 at 09:04:43PM +0100, Arnd Bergmann wrote:
> > The macro version of mmu_notifier_range_init() for CONFIG_MMU_NOTIFIER=n
> > does not evaluate all its arguments, leading to a warning in one case:
> > 
> > mm/migrate.c: In function 'migrate_vma_pages':
> > mm/migrate.c:2711:20: error: unused variable 'mm' [-Werror=unused-variable]
> >   struct mm_struct *mm = vma->vm_mm;
> > 
> > Pass down the 'mm' as into the inline function as well so gcc can
> > see why the variable exists.
> > 
> > Fixes: 137d92bd73b1 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
> 
> What about changing migrate.c (i actualy tried to do that everywhere in
> the patchset but i missed that spot) So we avoid one useless variable on
> such configuration:
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f02bb4b22c1a..883fce631f47 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2701,7 +2701,6 @@ static void migrate_vma_pages(struct migrate_vma *migrate)
>  	const unsigned long npages = migrate->npages;
>  	const unsigned long start = migrate->start;
>  	struct vm_area_struct *vma = migrate->vma;
> -	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_notifier_range range;
>  	unsigned long addr, i;
>  	bool notified = false;
> @@ -2724,8 +2723,8 @@ static void migrate_vma_pages(struct migrate_vma *migrate)
>  			if (!notified) {
>  				notified = true;
>  
> -				mmu_notifier_range_init(&range, mm, addr,
> -							migrate->end,
> +				mmu_notifier_range_init(&range, vma->vm_mm,
> +							addr, migrate->end,
>  							MMU_NOTIFY_CLEAR);
>  				mmu_notifier_invalidate_range_start(&range);
>  			}

Wouldn't it be better to just declare mmu_notifier_range_init() as a 
static inline function rather than a #define to avoid this warning?
