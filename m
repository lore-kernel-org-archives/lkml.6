Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2273583-1527606880-2-3906326770867810331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527606880; b=farbfnJw5YQODCrO+Q6YZvPyEhEyDSVY20T63M8IoDPmsqzV/7
    /4QB3c2BLlRS8Q52H/4UNa/A8PrLeifk3c7AKplwb9ogkIcWQQmdU2BxvQA+IQ2L
    EjF+ZZ/TylQcyMjSXYNNnlrOhW1vbJqJq4UhaYv67d7JpdW8cu9IxiIrdCNCUxaX
    9fKk03szpsdHH5aR0d8kIKuRql2QUPxiq8hXM7J3I5uPuVrmiOw3yZZdRRfyCEnj
    HJdBR2PyT7DIG31NTp4MXvSK4xXwK0zLyvuYVyWhTBzJT2gWV5lpm8/E6rz8Sm0i
    zxkzN2SE10DCkC4HDT+owYtBVVNGHnp2gDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527606880; bh=
    neX9krispjP/8cHkLbwcM+GDHx2mCIZyMpSm8yIAbOw=; b=btrhB2ldM3kjsYuw
    g64DZFdcx6+XDvx6E7+uHBbPHjBBWhd995y6Znt5wIalap2zGq0xqy/T2A3sgiyT
    tWNryaTkw2vY0lCuLVaZ+Rq5m6Pc3pmnFMpMtTXLWBlbemZRA8gYI1POzAIP55H0
    WWPLD8V6YSENqXtJNtNv7z2VEXA2P+CbnKUpT7d3CAChKFHtYOvBspnBPBxnfduc
    2vUeGs13cRJiHcYlu7u+jCVRqRuaox2LcgMaVYEpUS3TrcHp/baMish1m9gsNi3G
    Tv3faIpjqscm3PhBm+MSZqQWxXL2CrivACG3lgk/OQgZNdImBK3tqt+AW7EdJ02W
    pfM6iw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=RqQ+ASe6;
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
      header.i=@1e100.net header.b=RqQ+ASe6;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCudyvL6KLCyOxxunu7mHHg6VpOztiA35CprwbFiXP8/NPPNTINJMkkUYATfzOE4d9KYJew7am4f/BULKNqF5Id/ezk6Mo6eRmQxCp1srZfR2AA4CEpr
    0hNGhAfMbGhIkGZFEUYr2+V/0QS4PaM44OcIcjLwTPMyMpUnHZTzLnRQPzHB2c8JAEjF3Ix1LXVYrB40nlJFok606voE91V6Psqi6HgQ9rHxf1JLdEg6kVR9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=W_PZsZtNsLPxSaH7cQQA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935287AbeE2POf (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:14:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34635 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935596AbeE2On5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:43:57 -0400
X-Google-Smtp-Source: ADUXVKJlJ5XIbA5giP28FrR4qUjBdZapoaXQXFP5youWW5OWcGuWZlf/gGxRAhU83TB3Jre/wRXQKg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/39] ovl: deal with overlay files in ovl_d_real()
Date: Tue, 29 May 2018 16:43:13 +0200
Message-Id: <20180529144339.16538-14-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 704b37311467..211975921a90 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -97,6 +97,10 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	struct dentry *real;
 	int err;
 
+	/* It's an overlay file */
+	if (inode && d_inode(dentry) == inode)
+		return dentry;
+
 	if (flags & D_REAL_UPPER)
 		return ovl_dentry_upper(dentry);
 
-- 
2.14.3
