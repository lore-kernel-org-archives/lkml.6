Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174121-2-8261587803459001943
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174121; b=cGJNmfYAO3WHFy0r95ipH+a8AWDzK9IlcxYPep+Z6PnTUob
    AtQLtK9UfUvIe8+K9nqogdYL2rLz+gxNoFG5OXQ0dw7cSfdln2QgH5edNSZ3PpYs
    hCif7xOGUCoaikuDW2v81k4/nKPDiQCoWbcoM/K4BChZD1vkeDTXn1OPUWPGsKbx
    KdQAgSGZqKX+q4KJFsBEz5ft26h1nK01Ku8wIlC/O6UHG24pEgTNLM/XC0kJ+8Oz
    nNr0E3tnFeVGg19AluXBzczEybCsezoJ+QqqQK0dtoMtJJOxOnfyvrbLzzvWGnMD
    QbfPgRrFlbcBmCsMWrJh9l950KlKerFr6xyir5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174121; bh=tbnW3oftQClMxtFVidroh86tEg
    9FWvSrNAlMfmz1oXw=; b=sXgeHgU810Ir80HYBChbzfMxchYrdBSamkXa0XYuC0
    TXxTMXlWScPJlzjgqOVq6bNiYOr6huxwJmuuwihHH2giC23Tymdl6cAO1PFDj3Qj
    8UET/qtFaVFFzoXUOqFPrAm40CS+0D9MFbhgHV1rGhwHtPRrvGXqPfM31XkIajUh
    Op819FeeA1oVdwiL+HOWAgwx8BKCm6go7DI6c0piGQtS/Vb3AKtWFDDKu6HJPYNB
    LGxF7wRTh4k/3gccgkrz7wCXlGtNeA1/xnLQSkwvtji1Wz9A9VyVhvv77XET02vP
    asblMPn8qxPXSh+gu92Xjep6KZYYIwt04bxHAvuccj5A==
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
X-CM-Envelope: MS4wfPz8c/emh72r6BuSSBt9Xh0gk1vNItnfGlgXmU/91a5jGQH8NlLPtlPZJeHaygsFeBCxeehVu7dwrewAw6ZeK7ojZL2XLWq5MiuUvp5o6npD8+etHrzn
    WA0xyb5NDzObAU3j9AJuovVbXN13Q59RcG2TRpG6L24K+BmL9Bq6LvILkozeH+MDZZw0o55m9LbF0ofcxrN4xh9JEHiJ64JXiS5JtlaZFmyE+eF/0mbwOabE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=ag1SF4gXAAAA:8 a=6WQS3RXxAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8
    a=2C6YHBdLAAAA:8 a=xPqBywL6NozG0pjcgwAA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=sc750Qogk8UJouid_ZiS:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Vxmtnl_E_bksehYqCbjh:22 a=yxGMNg53M24zlVSZdvMH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeC0Q3W (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:29:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeC0Q3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eyal Itkin <eyalit@checkpoint.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.4 24/43] drm: udl: Properly check framebuffer mmap offsets
Date: Tue, 27 Mar 2018 18:27:28 +0200
Message-Id: <20180327162717.780955346@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 3b82a4db8eaccce735dffd50b4d4e1578099b8e8 upstream.

The memmap options sent to the udl framebuffer driver were not being
checked for all sets of possible crazy values.  Fix this up by properly
bounding the allowed values.

Reported-by: Eyal Itkin <eyalit@checkpoint.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180321154553.GA18454@kroah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/udl/udl_fb.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -256,10 +256,15 @@ static int udl_fb_mmap(struct fb_info *i
 {
 	unsigned long start = vma->vm_start;
 	unsigned long size = vma->vm_end - vma->vm_start;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long offset;
 	unsigned long page, pos;
 
-	if (offset + size > info->fix.smem_len)
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+
+	offset = vma->vm_pgoff << PAGE_SHIFT;
+
+	if (offset > info->fix.smem_len || size > info->fix.smem_len - offset)
 		return -EINVAL;
 
 	pos = (unsigned long)info->fix.smem_start + offset;
