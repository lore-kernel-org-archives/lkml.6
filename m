Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68427C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107B520BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xmjB3UQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107B520BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeGKKS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeGKKSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:18:25 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4503F208FA;
        Wed, 11 Jul 2018 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531304089;
        bh=Bp+yl/3OlWMuPBIsBBZQv8OYym8i7sttwmB3YyU0u4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xmjB3UQl5vBYCOMqPRFz5wFIwNv3DskbuQCDzzKN8037kbjM1b77vSJACAecCgvHr
         y36Q/B7KkMUGY5/GpYvNIE3S05xPba2OuxMzeAyNl9kT9gMk9AbtAQgcWE6P91Ejtv
         VMX/JLsouC2/pRsH2iEfsssmorbxTzf2W5jWeNTQ=
Date:   Wed, 11 Jul 2018 13:14:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180711101447.GU3014@mtr-leonro.mtl.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <20180627074421.GF32348@dhcp22.suse.cz>
 <20180709122908.GJ22049@dhcp22.suse.cz>
 <20180710134040.GG3014@mtr-leonro.mtl.com>
 <20180710141410.GP14284@dhcp22.suse.cz>
 <20180710162020.GJ3014@mtr-leonro.mtl.com>
 <20180711090353.GD20050@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bzuizT9vlVVqWfw+"
Content-Disposition: inline
In-Reply-To: <20180711090353.GD20050@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bzuizT9vlVVqWfw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2018 at 11:03:53AM +0200, Michal Hocko wrote:
> On Tue 10-07-18 19:20:20, Leon Romanovsky wrote:
> > On Tue, Jul 10, 2018 at 04:14:10PM +0200, Michal Hocko wrote:
> > > On Tue 10-07-18 16:40:40, Leon Romanovsky wrote:
> > > > On Mon, Jul 09, 2018 at 02:29:08PM +0200, Michal Hocko wrote:
> > > > > On Wed 27-06-18 09:44:21, Michal Hocko wrote:
> > > > > > This is the v2 of RFC based on the feedback I've received so far. The
> > > > > > code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
> > > > > > because I have no idea how.
> > > > > >
> > > > > > Any further feedback is highly appreciated of course.
> > > > >
> > > > > Any other feedback before I post this as non-RFC?
> > > >
> > > > From mlx5 perspective, who is primary user of umem_odp.c your change looks ok.
> > >
> > > Can I assume your Acked-by?
> >
> > I didn't have a chance to test it because it applies on our rdma-next, but
> > fails to compile.
>
> What is the compilation problem? Is it caused by the patch or some other
> unrelated changed?

Thanks for pushing me to take a look on it.
Your patch needs the following hunk to properly compile at least on my system.

I'll take it to our regression.

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 369867501bed..1f364a157097 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -155,9 +155,9 @@ struct mmu_notifier_ops {
 	 * cannot block, mmu_notifier_ops.flags should have
 	 * MMU_INVALIDATE_DOES_NOT_BLOCK set.
 	 */
-	void (*invalidate_range_start)(struct mmu_notifier *mn,
+	int (*invalidate_range_start)(struct mmu_notifier *mn,
 				       struct mm_struct *mm,
-				       unsigned long start, unsigned long end);
+				       unsigned long start, unsigned long end, bool blockable);
 	void (*invalidate_range_end)(struct mmu_notifier *mn,
 				     struct mm_struct *mm,
 				     unsigned long start, unsigned long end);
@@ -229,7 +229,7 @@ extern int __mmu_notifier_test_young(struct mm_struct *mm,
 				     unsigned long address);
 extern void __mmu_notifier_change_pte(struct mm_struct *mm,
 				      unsigned long address, pte_t pte);
-extern void __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
+extern int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 				  unsigned long start, unsigned long end,
 				  bool blockable);
 extern void __mmu_notifier_invalidate_range_end(struct mm_struct *mm,
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 6adac113e96d..92f70e4c6252 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -95,7 +95,7 @@ static inline int check_stable_address_space(struct mm_struct *mm)
 	return 0;
 }

-void __oom_reap_task_mm(struct mm_struct *mm);
+bool __oom_reap_task_mm(struct mm_struct *mm);

 extern unsigned long oom_badness(struct task_struct *p,
 		struct mem_cgroup *memcg, const nodemask_t *nodemask,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 7e0c6e78ae5c..7c7bd6f3298e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1,6 +1,6 @@
 /*
  *  linux/mm/oom_kill.c
- *
+ *
  *  Copyright (C)  1998,2000  Rik van Riel
  *	Thanks go out to Claus Fischer for some serious inspiration and
  *	for goading me into coding this file...
@@ -569,7 +569,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	if (!__oom_reap_task_mm(mm)) {
 		up_read(&mm->mmap_sem);
 		ret = false;
-		goto out_unlock;
+		goto unlock_oom;
 	}

 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",

Thanks

> --
> Michal Hocko
> SUSE Labs

--bzuizT9vlVVqWfw+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbRdiXAAoJEORje4g2clinNPQP/jvfP8MeILcz9WT7kxNVX7c/
XpnkJcPys8ZjDS653gbzrRzw+nFz3sfqbSrvKb6MgCGfAGdanoHWjQsNbYz+Ci0m
jr68xil3AoZsR30dolMGlCjHnsTq3CyJgNPfjm90VkuBV3huxGx52vSLuKBVVYuv
qp+D/DwaxHKp9iUa4b5y8aXQYNCV++L3sNWgeUCXzaDvFm8WORW5PX/BxJ5a4M3r
AFyJf0XIHfByd3mBDWJlo4c3mgAxV1hltesZHFCySPs4oLKRuHFiEap1BGNZsn8j
m61eIRFoH5WVacvq1xHKs/oF9inuoaB9IzQsaeZan4YgOwthfcAibPxcdbcta29p
IxYQUgjY+e3feJSOiHqFtujW8A3HpsuFUSPC7PHuJFJWqwCIcESxL3qeikBi2goA
l5HIP6MMdKXv9PgXEsEFlPQJCS+ZsFk52pUOfneLve8t4MBWcuRXZpk0G0qfVLwq
/2p9ES6m7Lroq7a0RkFZyWMmIdgBk9WjFbxm1ogXkMTWv7cQbmB94t0ut3fF6RCR
lQfcHf16xm2IM4gNpzahFy4zsXWNWAdj/oVGDQjx3lu5LzvEriYptJZhKOx+lSdO
lRO+pA/gzHWnbtA32swGX+MaHUNRAuVV8x1lbgRUq/aKwedg8BCpJXokrcpAasTt
+En8/fnNQqxwKFdJw8j+
=6e5O
-----END PGP SIGNATURE-----

--bzuizT9vlVVqWfw+--
