Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA52C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FA820879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAZ1NTRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FA820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeLKVn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:43:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40616 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:43:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so7755826pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dWgfMDWV1IUCMHNHRgEPbsME14kniNDDzpoHAd7Dhkk=;
        b=HAZ1NTRgLsatAIqShWvARw64fB2+VYIMs+BQ+PEFXkskK86U/e0+FoqgpTzrl5vs1M
         /E4kRFwXFFnvdeLNnJ/6tNQAag0JlaYSHQ9xXLlU+hog/q3DXkpsYafRY7cJ/v+cKnA8
         MWwqdK/00FON2Ei5AwaFtW0jqcvodJvUMlrv5p5qHsPyz3qezGoTLeNl619UjHTQFPev
         Cw8Clj64p2HC6BeVaZGIDJGbfCwudfAfTumMd5jvV/T9mij2mK27quRlkV4WVIYaMWvA
         w1R3MXqPI+73SjLAGQZIY/nFVeRGjhquq/pkQscCs22/vgR0c10pOiJnCZM7T3jNQIQp
         t8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dWgfMDWV1IUCMHNHRgEPbsME14kniNDDzpoHAd7Dhkk=;
        b=K/7n70bjn9dJckA57/Xz+0mof5boRg8Kxy5uL+9//WVWCn77K+0nY4S4VEKTfaV128
         XHhIqLgZTajOGj3gJzDFRc/HFDhhH4OKMeTup8jxhYDejfvdkZm5eZZnwM7ujqQYXgBF
         DZnBpxsNKb86ipJUNCeAhKT5j/+UoWzIrH1CxtXiTqqHG+Q5F6B+4L+eDi4p1XGzP8+A
         780nX8ABw3iBNXWoTDmV3DmW0bcWubD2pd9si8M30fPWfYcj4/y1B4Y/Bm9usPc+Vw+C
         S+jcNHF0XNAnxgNCbRf3wfcozBxDEg4ksBBqz8NZmfR/CPUXXboUpoaFqsZJ046j8ICk
         A30g==
X-Gm-Message-State: AA+aEWZx1YqH5My1AGUgWzYPYWfczCCarrrH4qYPSuZ3k+H4S7VFKHSj
        3I2kwveP2N/HsvHOThpR92foDq8fpmD/jg==
X-Google-Smtp-Source: AFSGD/UBX9E44dAHTiG2fvLFpZ+/H3JiMsIgdVd16FOpCdtcIA0K1gxMaf598driO1q4AorCVuN7kw==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr16267142pgj.410.1544564606260;
        Tue, 11 Dec 2018 13:43:26 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 79sm20001923pge.66.2018.12.11.13.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:43:25 -0800 (PST)
Date:   Tue, 11 Dec 2018 13:43:24 -0800 (PST)
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
In-Reply-To: <20181211213636.GB6478@redhat.com>
Message-ID: <alpine.DEB.2.21.1812111341280.97190@chino.kir.corp.google.com>
References: <20181211200526.3868586-1-arnd@arndb.de> <20181211201909.GA6478@redhat.com> <alpine.DEB.2.21.1812111310320.87855@chino.kir.corp.google.com> <20181211213636.GB6478@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Jerome Glisse wrote:

> > > > The macro version of mmu_notifier_range_init() for CONFIG_MMU_NOTIFIER=n
> > > > does not evaluate all its arguments, leading to a warning in one case:
> > > > 
> > > > mm/migrate.c: In function 'migrate_vma_pages':
> > > > mm/migrate.c:2711:20: error: unused variable 'mm' [-Werror=unused-variable]
> > > >   struct mm_struct *mm = vma->vm_mm;
> > > > 
> > > > Pass down the 'mm' as into the inline function as well so gcc can
> > > > see why the variable exists.
> > > > 
> > > > Fixes: 137d92bd73b1 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
> > > 
> > > What about changing migrate.c (i actualy tried to do that everywhere in
> > > the patchset but i missed that spot) So we avoid one useless variable on
> > > such configuration:
> > > 
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index f02bb4b22c1a..883fce631f47 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -2701,7 +2701,6 @@ static void migrate_vma_pages(struct migrate_vma *migrate)
> > >  	const unsigned long npages = migrate->npages;
> > >  	const unsigned long start = migrate->start;
> > >  	struct vm_area_struct *vma = migrate->vma;
> > > -	struct mm_struct *mm = vma->vm_mm;
> > >  	struct mmu_notifier_range range;
> > >  	unsigned long addr, i;
> > >  	bool notified = false;
> > > @@ -2724,8 +2723,8 @@ static void migrate_vma_pages(struct migrate_vma *migrate)
> > >  			if (!notified) {
> > >  				notified = true;
> > >  
> > > -				mmu_notifier_range_init(&range, mm, addr,
> > > -							migrate->end,
> > > +				mmu_notifier_range_init(&range, vma->vm_mm,
> > > +							addr, migrate->end,
> > >  							MMU_NOTIFY_CLEAR);
> > >  				mmu_notifier_invalidate_range_start(&range);
> > >  			}
> > 
> > Wouldn't it be better to just declare mmu_notifier_range_init() as a 
> > static inline function rather than a #define to avoid this warning?
> 
> The define trick is use to drop the event parameter so that we do not
> need to define the event value for CONFIG_MMU_NOTIFIER=n case.
> 

Hmm, strange that Arnd's build failure is only reporting about an unused 
variable instead of MMU_NOTIFY_CLEAR being undefined :/

I think this should be done so that anybody using 
mmu_notifier_range_init() doesn't need to worry about the implications of 
*any* unused formal parameter as a result of how the #define is formed:

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -10,21 +10,6 @@
 struct mmu_notifier;
 struct mmu_notifier_ops;
 
-#ifdef CONFIG_MMU_NOTIFIER
-
-/*
- * The mmu notifier_mm structure is allocated and installed in
- * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
- * critical section and it's released only when mm_count reaches zero
- * in mmdrop().
- */
-struct mmu_notifier_mm {
-	/* all mmu notifiers registerd in this mm are queued in this list */
-	struct hlist_head list;
-	/* to serialize the list modifications and hlist_unhashed */
-	spinlock_t lock;
-};
-
 /**
  * enum mmu_notifier_event - reason for the mmu notifier callback
  * @MMU_NOTIFY_UNMAP: either munmap() that unmap the range or a mremap() that
@@ -53,6 +38,21 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_SOFT_DIRTY,
 };
 
+#ifdef CONFIG_MMU_NOTIFIER
+
+/*
+ * The mmu notifier_mm structure is allocated and installed in
+ * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
+ * critical section and it's released only when mm_count reaches zero
+ * in mmdrop().
+ */
+struct mmu_notifier_mm {
+	/* all mmu notifiers registerd in this mm are queued in this list */
+	struct hlist_head list;
+	/* to serialize the list modifications and hlist_unhashed */
+	spinlock_t lock;
+};
+
 struct mmu_notifier_range {
 	struct mm_struct *mm;
 	unsigned long start;
@@ -483,9 +483,14 @@ static inline void _mmu_notifier_range_init(struct mmu_notifier_range *range,
 	range->end = end;
 }
 
-#define mmu_notifier_range_init(range, mm, start, end, event) \
-	_mmu_notifier_range_init(range, start, end)
-
+static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
+					   struct mm_struct *mm,
+					   unsigned long start,
+					   unsigned long end,
+					   enum mmu_notifier_event event)
+{
+	_mmu_notifier_range_init(range, start, end);
+}
 
 static inline int mm_has_notifiers(struct mm_struct *mm)
 {
