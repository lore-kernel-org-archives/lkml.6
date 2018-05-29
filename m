Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527605506-2-1605466331188542629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605505; b=AxsIezGKv3WCC/wrDRwT3OXVpNkho6q/OvbLJnZ0H+M4x7ZbF1
    qVBquAoil3nfQuHfqi+VvqbFxFoVq5w4v/682KtUG5mlS5jw0Y5vwlt19Dovj05E
    UBLOwgwIJCV7Vx82Zm93CUTGCL/2mXby76vN31xYqhXp9i5PGvzgQWZfHtKdWC5q
    0d6EjgXv26Nj1l3bEolwFI+pF7q37CY6Kx+x6kznijnmOttquKPFXAJWU+1maQsP
    6uC5u3qGA73jZoCXtf+oa5KX7FkLQuftO3QOQJpOmEY6+bDSxqwnIYjJnSoGygIZ
    3cuCXD4FFmWOfGCCsr/VXu61Vm6/rryiGiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605505; bh=
    /Fw//Sdq+J+5UztSoktKaLs/Y8gwivnNzbPrztp8Ieg=; b=ml7c5kspHlw2kZYS
    Cm5aqA20IAqmwZuF2HgdGDBv7tRhGO9CbPA9UEtwJbZ3lYnZLqbtFVKNOKga/94r
    lUksPFqXRHPWJ9FYSYubMX5BpyIM3RTQ0d0o5J0zqtddDeb/k5Nx9x2sXXT3anCS
    bPwQzNQHZN3NjzZILz3jw19SjqIC4B8kAiOA7cCfAd/Kp1J2u81UcnFxGc9WNEAX
    6ZJdy1UOt8eCayXcNcDyPNnyl9xYqEvSMCCLVAMMdwGIEJV7BgOn8lUcHgyMgQVH
    6mMUkZuGUFx7ZGAmVduDWJ8fzED/IsIBatFpiDVo3j7m9oPY3jtVHbBQN5NLM3GM
    cn11Ow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=mjrMQrAl;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=mjrMQrAl;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGbpmZkPy8me4uj+yT/KfSyMFGoZAcmmCCasF924eMW0YIzCdbg8LHfVUPrTjEZxXALBj8D2hosPN5YUGGCWW8IL6H7I7wc5BGKTs/9KEsw1DXgXOm1b
    3nS1uyDVAlOXT9qnZPWkyLeJo1qYA//+XSV/2Qhc+XR58F9K0bcN5aFr33B4NQ+/cFuegA28N1yJjIRjpEPsbiszemdWbBGVXpw0st47YQM6/hY7QyGFS9Qi
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=67XtW7C37lToyMof3sIA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936616AbeE2Ovk (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:51:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42500 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936620AbeE2Oqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:35 -0400
X-Google-Smtp-Source: ADUXVKKgaQ4gCgKmgrG6Ch6eheyINoEXO5S6l0snIko6DnAqibIauxbsxyrosnrLgDlebrHxYlXQlQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/28] ovl: Do not expose metacopy only dentry from d_real()
Date: Tue, 29 May 2018 16:46:00 +0200
Message-Id: <20180529144612.16675-17-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vivek Goyal <vgoyal@redhat.com>

Metacopy dentry/inode is internal to overlay and is never exposed outside
of it.  Exception is metacopy upper file used for fsync().  Modify d_real()
to look for dentries/inode which have data, but also allow matching upper
inode without data for the fsync case.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e0326a686f45..6687d547ec6b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -101,10 +101,13 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	}
 
 	real = ovl_dentry_upper(dentry);
-	if (real && (!inode || inode == d_inode(real)))
+	if (real && (inode == d_inode(real)))
 		return real;
 
-	real = ovl_dentry_lower(dentry);
+	if (real && !inode && ovl_has_upperdata(d_inode(dentry)))
+		return real;
+
+	real = ovl_dentry_lowerdata(dentry);
 	if (!real)
 		goto bug;
 
-- 
2.14.3
