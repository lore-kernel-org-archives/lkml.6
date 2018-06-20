Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BAAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECD020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T95wC/9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECD020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbeFTA54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:57:56 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:35432 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeFTA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:57:55 -0400
Received: by mail-vk0-f73.google.com with SMTP id d134-v6so654700vkf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=vusjwvFHQOM6gAdNEBDP2ae6BamSV1B6bqavFx0bnlU=;
        b=T95wC/9cHxacf3o6ladPWZwJGGduZ0KKikWuRZ82tdzzCkJDzjaq0wVJUSTmuYinKH
         jFNY3nDsLdNtcNL67EV9d6M4piXRVt7FOPvS6L7+OKWQ6dQAsTC2lJeD4mtrttoTedRZ
         zkm7qsONbMmE7AuLyIf+jRmz7G/QWRPwVOC6xpn/RrMOy1NrlLmozsDyEQ/CRy++41za
         p/fvCdeCi/oM810JqrFEPkaLFnuXlhJZ9ro3NTR0+8qU1wBJxA+/2FS4acoXxMWjsyP7
         jQO6whuMJ0X0GCDoRf1Fiz0RsiI/hZqvF0EgaM39NTN2+bt5xMnGvj7vhokvArb1y5CO
         jWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=vusjwvFHQOM6gAdNEBDP2ae6BamSV1B6bqavFx0bnlU=;
        b=lsLNTvYHC4VzCqzczLOS+4liUKDfjdrAGNGqX2DV/Xl8HbCt/L0IISPi2TC+KbEB9G
         eCxhbDgvOIe5Spco+rFa7m/DY3TsO3fomkI2FUM2UOdqAppMZ3MgKD/PJ/pb9pQsWS0N
         7D91PJaauYJmuE5D1jTYAuztFMMaXy8OChvkJsxa/hhNa8Zdp1KFx3y8IgWgEtyzJhUh
         2msxipkUp81y1oK9/SDn3e8ruq2UsA5wGBEywGWipjgBrep7ti2ryNkN75PJBFzZsjAy
         dRMMhoDQH6risa9/4FJ8fSobzrbe8VKM674iiFO2F6cSixmc5Nw5B2KtKmPJHt0bR8mp
         zF6w==
X-Gm-Message-State: APt69E0B4igFaLWBxfvqKzEGBjKg8tLMibyTSXfzH23Y5bxyjscrje5V
        QRO/tmPalf49JuIkYg6phY6+W/m3QcEVpTddmMNjDO5dh8vBs0S7EUiDGwi9frDxtEowbSzBXlq
        rVUO76P7Kz+SGprTP/kS1hg4gKvB385gOU52r2BbZjtajVFlSJ43BYB176DP5GHnGMhEKML2s1G
        XWwg==
X-Google-Smtp-Source: ADUXVKIDn2BKttFKm/aPN9VbadLA4AbWWjPZ3UnhHHTziru2AJPfFxiuywP0S/uIl0+wTnii2W79+x8tE2VDWbY=
X-Received: by 2002:ab0:31d6:: with SMTP id e22-v6mr8342977uan.19.1529456274109;
 Tue, 19 Jun 2018 17:57:54 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:57:34 -0700
Message-Id: <20180620005735.219840-1-astrachan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH 1/2] staging: android: ashmem: Remove use of unlikely()
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Strachan <astrachan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no speed difference, and it makes the code harder to read.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: Joel Fernandes <joel@joelfernandes.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 drivers/staging/android/ashmem.c | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ash=
mem.c
index a1a0025b59e0..c6386e4f5c9b 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -178,7 +178,7 @@ static int range_alloc(struct ashmem_area *asma,
 	struct ashmem_range *range;
=20
 	range =3D kmem_cache_zalloc(ashmem_range_cachep, GFP_KERNEL);
-	if (unlikely(!range))
+	if (!range)
 		return -ENOMEM;
=20
 	range->asma =3D asma;
@@ -246,11 +246,11 @@ static int ashmem_open(struct inode *inode, struct fi=
le *file)
 	int ret;
=20
 	ret =3D generic_file_open(inode, file);
-	if (unlikely(ret))
+	if (ret)
 		return ret;
=20
 	asma =3D kmem_cache_zalloc(ashmem_area_cachep, GFP_KERNEL);
-	if (unlikely(!asma))
+	if (!asma)
 		return -ENOMEM;
=20
 	INIT_LIST_HEAD(&asma->unpinned_list);
@@ -361,14 +361,14 @@ static int ashmem_mmap(struct file *file, struct vm_a=
rea_struct *vma)
 	mutex_lock(&ashmem_mutex);
=20
 	/* user needs to SET_SIZE before mapping */
-	if (unlikely(!asma->size)) {
+	if (!asma->size) {
 		ret =3D -EINVAL;
 		goto out;
 	}
=20
 	/* requested protection bits must match our allowed protection mask */
-	if (unlikely((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask, 0)) &
-		     calc_vm_prot_bits(PROT_MASK, 0))) {
+	if ((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask, 0)) &
+	    calc_vm_prot_bits(PROT_MASK, 0)) {
 		ret =3D -EPERM;
 		goto out;
 	}
@@ -486,7 +486,7 @@ static int set_prot_mask(struct ashmem_area *asma, unsi=
gned long prot)
 	mutex_lock(&ashmem_mutex);
=20
 	/* the user can only remove, not add, protection bits */
-	if (unlikely((asma->prot_mask & prot) !=3D prot)) {
+	if ((asma->prot_mask & prot) !=3D prot) {
 		ret =3D -EINVAL;
 		goto out;
 	}
@@ -524,7 +524,7 @@ static int set_name(struct ashmem_area *asma, void __us=
er *name)
 		local_name[ASHMEM_NAME_LEN - 1] =3D '\0';
 	mutex_lock(&ashmem_mutex);
 	/* cannot change an existing mapping's name */
-	if (unlikely(asma->file))
+	if (asma->file)
 		ret =3D -EINVAL;
 	else
 		strcpy(asma->name + ASHMEM_NAME_PREFIX_LEN, local_name);
@@ -563,7 +563,7 @@ static int get_name(struct ashmem_area *asma, void __us=
er *name)
 	 * Now we are just copying from the stack variable to userland
 	 * No lock held
 	 */
-	if (unlikely(copy_to_user(name, local_name, len)))
+	if (copy_to_user(name, local_name, len))
 		ret =3D -EFAULT;
 	return ret;
 }
@@ -701,25 +701,25 @@ static int ashmem_pin_unpin(struct ashmem_area *asma,=
 unsigned long cmd,
 	size_t pgstart, pgend;
 	int ret =3D -EINVAL;
=20
-	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
+	if (copy_from_user(&pin, p, sizeof(pin)))
 		return -EFAULT;
=20
 	mutex_lock(&ashmem_mutex);
=20
-	if (unlikely(!asma->file))
+	if (!asma->file)
 		goto out_unlock;
=20
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len =3D PAGE_ALIGN(asma->size) - pin.offset;
=20
-	if (unlikely((pin.offset | pin.len) & ~PAGE_MASK))
+	if ((pin.offset | pin.len) & ~PAGE_MASK)
 		goto out_unlock;
=20
-	if (unlikely(((__u32)-1) - pin.offset < pin.len))
+	if (((__u32)-1) - pin.offset < pin.len)
 		goto out_unlock;
=20
-	if (unlikely(PAGE_ALIGN(asma->size) < pin.offset + pin.len))
+	if (PAGE_ALIGN(asma->size) < pin.offset + pin.len)
 		goto out_unlock;
=20
 	pgstart =3D pin.offset / PAGE_SIZE;
@@ -856,7 +856,7 @@ static int __init ashmem_init(void)
 	ashmem_area_cachep =3D kmem_cache_create("ashmem_area_cache",
 					       sizeof(struct ashmem_area),
 					       0, 0, NULL);
-	if (unlikely(!ashmem_area_cachep)) {
+	if (!ashmem_area_cachep) {
 		pr_err("failed to create slab cache\n");
 		goto out;
 	}
@@ -864,13 +864,13 @@ static int __init ashmem_init(void)
 	ashmem_range_cachep =3D kmem_cache_create("ashmem_range_cache",
 						sizeof(struct ashmem_range),
 						0, 0, NULL);
-	if (unlikely(!ashmem_range_cachep)) {
+	if (!ashmem_range_cachep) {
 		pr_err("failed to create slab cache\n");
 		goto out_free1;
 	}
=20
 	ret =3D misc_register(&ashmem_misc);
-	if (unlikely(ret)) {
+	if (ret) {
 		pr_err("failed to register misc device!\n");
 		goto out_free2;
 	}
