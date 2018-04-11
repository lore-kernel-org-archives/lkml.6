Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479801-2-14699066195248038327
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479800; b=bReTFGbQ3QwubFIHGI9Cr07iZosoUfhRdV/TR9mqKCbKaQUMpO
    331rU9xHFGFB+S/0HZoa6nXob8oXZCMawkxt0IVNFkiX70asKCt2uYeZbaG8MhSp
    60Sk+HChdz6ud17piDGZcavz4L4n2OJp0N6TP0TSXgYP9fkBKw6UraV07SmAqpfn
    uTqUyssDRjaCSGdQnoIUmcBQf/pYDYvYMnioXa6RL3D57c/0LKZKe3NXyVlFIznj
    LAajDMtOpJEPR6aN/FRv/JG1b+xTQuXN86JP1OUeGAWemS5e1GnzievJ/OwjPijD
    h++hFz+oGhXDd/G3GRHct7Vx5Woqx4suhLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479800; bh=EGXbu1ja+JsXItS7CScRIBk4XlSiS5
    armWZPse1OTj4=; b=oPql5+JTDcLiCGKfYLk7fkLYgQIWilX5pOlpg3vYttCBH1
    56DUuXnX7FhoYHX5K4MtrdKbbOrsh8J08x9trXWdedey9WiS+lwkz3PSUXv6cKwY
    C4QlTGZwSDYGgSW4WSn/mXwjLXRa4HSl1Mt1gT4cikPI1rF0PhJq8OyaryZhOBzr
    Uf62l/ps1I+I+YmpstBUvP9rTh2fKZYL0yfzHnNt7KgW6lLKdQOltb7hGq9AV1k5
    oU1DVTbpXR3xq7rMJBepgzXPF9hcDz5ChMkdbIVmVKT2XQfP0NeDUDGIcL8uA5xs
    wMrp0Wb4a6Oh0dUxSGThDvxY3QPvyJwevSMEHysA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMfwRLgiTi3c+1EctVU2JpSomU5J8OGyyaircc9yuM0VkVATC/GFlaoorzNKiEfTLcDCShIAGHirM/cakVjzE3kqu5ri4Vy0YNDM7ucSqQe0ZNuXZm//
    TSlrskrvJAeiPKRlMc2/j+UXgW5oZrEKzIrKo3A0yQak1/ItpTj3m7Q6aKEVcUFLnw7VBwWvCTSaP8VO3DyIFxgVHaBZZ14iD8Tyin6DWoMEP7YzuzPdCmcc
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=6R7veym_AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=TzSSPSBs-8d7BCXhjvwA:9
    a=3UJq2FBqhoS4Y7oa:21 a=j5_r-uixslqC3hKP:21 a=QEXdDO2ut3YA:10
    a=ILCOIF4F_8SzUMnO7jNM:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756004AbeDKUtl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:49:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755644AbeDKSp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Theodore Tso <tytso@mit.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 057/190] ext4: handle the rest of ext4_mb_load_buddy() ENOMEM errors
Date: Wed, 11 Apr 2018 20:35:03 +0200
Message-Id: <20180411183553.676042433@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>


[ Upstream commit 9651e6b2e20648d04d5e1fe6479a3056047e8781 ]

I've got another report about breaking ext4 by ENOMEM error returned from
ext4_mb_load_buddy() caused by memory shortage in memory cgroup.
This time inside ext4_discard_preallocations().

This patch replaces ext4_error() with ext4_warning() where errors returned
from ext4_mb_load_buddy() are not fatal and handled by caller:
* ext4_mb_discard_group_preallocations() - called before generating ENOSPC,
  we'll try to discard other group or return ENOSPC into user-space.
* ext4_trim_all_free() - just stop trimming and return ENOMEM from ioctl.

Some callers cannot handle errors, thus __GFP_NOFAIL is used for them:
* ext4_discard_preallocations()
* ext4_mb_discard_lg_preallocations()

Fixes: adb7ef600cc9 ("ext4: use __GFP_NOFAIL in ext4_free_blocks()")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3874,7 +3874,8 @@ ext4_mb_discard_group_preallocations(str
 
 	err = ext4_mb_load_buddy(sb, group, &e4b);
 	if (err) {
-		ext4_error(sb, "Error loading buddy information for %u", group);
+		ext4_warning(sb, "Error %d loading buddy information for %u",
+			     err, group);
 		put_bh(bitmap_bh);
 		return 0;
 	}
@@ -4031,10 +4032,11 @@ repeat:
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
 
-		err = ext4_mb_load_buddy(sb, group, &e4b);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
+					     GFP_NOFS|__GFP_NOFAIL);
 		if (err) {
-			ext4_error(sb, "Error loading buddy information for %u",
-					group);
+			ext4_error(sb, "Error %d loading buddy information for %u",
+				   err, group);
 			continue;
 		}
 
@@ -4290,11 +4292,14 @@ ext4_mb_discard_lg_preallocations(struct
 	spin_unlock(&lg->lg_prealloc_lock);
 
 	list_for_each_entry_safe(pa, tmp, &discard_list, u.pa_tmp_list) {
+		int err;
 
 		group = ext4_get_group_number(sb, pa->pa_pstart);
-		if (ext4_mb_load_buddy(sb, group, &e4b)) {
-			ext4_error(sb, "Error loading buddy information for %u",
-					group);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
+					     GFP_NOFS|__GFP_NOFAIL);
+		if (err) {
+			ext4_error(sb, "Error %d loading buddy information for %u",
+				   err, group);
 			continue;
 		}
 		ext4_lock_group(sb, group);
@@ -5116,8 +5121,8 @@ ext4_trim_all_free(struct super_block *s
 
 	ret = ext4_mb_load_buddy(sb, group, &e4b);
 	if (ret) {
-		ext4_error(sb, "Error in loading buddy "
-				"information for %u", group);
+		ext4_warning(sb, "Error %d loading buddy information for %u",
+			     ret, group);
 		return ret;
 	}
 	bitmap = e4b.bd_bitmap;
