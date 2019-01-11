Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D889BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928BE2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9xpndwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfAKGZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:25:07 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:43798 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfAKGZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:25:07 -0500
Received: by mail-pg1-f177.google.com with SMTP id v28so5883520pgk.10;
        Thu, 10 Jan 2019 22:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ol//U3TDKHlVdIcTiYZgJWZueZkmNjJlUQ0lD7JH1ys=;
        b=c9xpndwqUokEmeFxh/T3M4uLYmsLIIgkrb3zMIZW/Gu6pgTE/wbXQPL3WZjpoCnL4l
         LKcqzuciCh73SEsVU+V3VdcQNwozB+6ZuBtAdwI8kfa51FYjJmHYKACTCkOjFn9HMscq
         5621hVoy3JndMnKqB1+ehN2tieUtfVf59m/3a2gWoWeLMk4k19STvMBXooMrXdghCGeY
         gqjzNkMadiOwyJBx99hbYezs0MwV0oon1W+7ERwVGRZXzB2aCfhkubro14HLMhNE9Tbn
         ydveqxPAAIXvHjk1ySyPRq0BPDvt8XA8ZWbxAnXdJfM+f8ETbahkmOM7DRWX/Qp0ClEX
         nXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ol//U3TDKHlVdIcTiYZgJWZueZkmNjJlUQ0lD7JH1ys=;
        b=ddQIXPx5g715MjKgBfpsAZ9yy5EihfQrnLiINC59SPtI0Gme6tzkziw50YA8VVz7mZ
         VWFo4cunvpJUoPd4144GRcYEHfztjzdEha7PTsNc9sNRao0IMCveI5hY4fCa9U+rJoQC
         3W0PI7Y3JnMDVJKRYElA6gtyvn+DqCAh1Jbri4B1fetABk/vYu5MjqapHkfeYwIL0Jmx
         vd85OrHPSickWQHNKWaqVUPAamEysG1PMkXnp4x7OFszlkAxqESdrWN0GfyQI4NHGxEu
         SHkfDOAMWmjqFdaGZUXQ667wnzgkOVMmgmyVrKU6unUzM0fAbKd6uo9+lyyHgvQYw0NL
         oujA==
X-Gm-Message-State: AJcUukft6ezKIVxoH89KicIF3vxruhdwdkK5iol4sFj8mlFLTnF16LX+
        OuV6A/86fhxAhh1dG3malJDgFhOI4UD61HdSPZeyNw==
X-Google-Smtp-Source: ALg8bN5ZRR8AeTqs7pD3UNwQXGIH5b0/wJCZ65nPcW+ENzdOOTtS4O3IcDCNDgfQ/Y9mC51h8Z0l5MKQJ6ZI/Dv/hE0=
X-Received: by 2002:a63:82c6:: with SMTP id w189mr12397112pgd.344.1547187905755;
 Thu, 10 Jan 2019 22:25:05 -0800 (PST)
MIME-Version: 1.0
References: <1547159098-19011-1-git-send-email-pshilov@microsoft.com> <1547159098-19011-8-git-send-email-pshilov@microsoft.com>
In-Reply-To: <1547159098-19011-8-git-send-email-pshilov@microsoft.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 11 Jan 2019 00:24:54 -0600
Message-ID: <CAH2r5mt5NinzUbxtPz2M0qaU_6+MkaaEqD-UkrO-BRM=SZZ17Q@mail.gmail.com>
Subject: Fwd: [PATCH 7/7] CIFS: Fix error paths in writeback code
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>, bfoster@redhat.com,
        Jeff Layton <jlayton@redhat.com>
Cc:     Pavel Shilovskiy <pshilov@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes in writepage and writepages for cifs remind me of
loosely related writeback changes that Jeff and Brian have done in the
VFS/MM layer, so was hopeful that others might have comments if they
see anything missing from Pavel's patch.

---------- Forwarded message ---------
From: Pavel Shilovsky <piastryyy@gmail.com>
Date: Thu, Jan 10, 2019 at 4:25 PM
Subject: [PATCH 7/7] CIFS: Fix error paths in writeback code
To: <linux-cifs@vger.kernel.org>
Cc: Steve French <smfrench@gmail.com>, Ronnie Sahlberg <lsahlber@redhat.com>


This patch aims to address writeback code problems related to error
paths. In particular it respects EINTR and related error codes and
stores the first error occured during writeback in order to return it
to a caller.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
---
 fs/cifs/cifsglob.h | 19 +++++++++++++++++++
 fs/cifs/cifssmb.c  |  7 ++++---
 fs/cifs/file.c     | 29 +++++++++++++++++++++++------
 fs/cifs/inode.c    | 10 ++++++++++
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 7709268..94dbdbe 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1575,6 +1575,25 @@ static inline void free_dfs_info_array(struct
dfs_info3_param *param,
        kfree(param);
 }

+static inline bool is_interrupt_error(int error)
+{
+       switch (error) {
+       case -EINTR:
+       case -ERESTARTSYS:
+       case -ERESTARTNOHAND:
+       case -ERESTARTNOINTR:
+               return true;
+       }
+       return false;
+}
+
+static inline bool is_retryable_error(int error)
+{
+       if (is_interrupt_error(error) || error == -EAGAIN)
+               return true;
+       return false;
+}
+
 #define   MID_FREE 0
 #define   MID_REQUEST_ALLOCATED 1
 #define   MID_REQUEST_SUBMITTED 2
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index b1f49c1..6930cdb 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2114,7 +2114,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)

                for (j = 0; j < nr_pages; j++) {
                        unlock_page(wdata2->pages[j]);
-                       if (rc != 0 && rc != -EAGAIN) {
+                       if (rc != 0 && !is_retryable_error(rc)) {
                                SetPageError(wdata2->pages[j]);
                                end_page_writeback(wdata2->pages[j]);
                                put_page(wdata2->pages[j]);
@@ -2123,7 +2123,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)

                if (rc) {
                        kref_put(&wdata2->refcount, cifs_writedata_release);
-                       if (rc == -EAGAIN)
+                       if (is_retryable_error(rc))
                                continue;
                        break;
                }
@@ -2132,7 +2132,8 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
                i += nr_pages;
        } while (i < wdata->nr_pages);

-       mapping_set_error(inode->i_mapping, rc);
+       if (rc != 0 && !is_retryable_error(rc))
+               mapping_set_error(inode->i_mapping, rc);
        kref_put(&wdata->refcount, cifs_writedata_release);
 }

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index c23bf9d..109b1ef 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -732,7 +732,8 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)

        if (can_flush) {
                rc = filemap_write_and_wait(inode->i_mapping);
-               mapping_set_error(inode->i_mapping, rc);
+               if (!is_interrupt_error(rc))
+                       mapping_set_error(inode->i_mapping, rc);

                if (tcon->unix_ext)
                        rc = cifs_get_inode_info_unix(&inode, full_path,
@@ -2109,6 +2110,7 @@ static int cifs_writepages(struct address_space *mapping,
        pgoff_t end, index;
        struct cifs_writedata *wdata;
        int rc = 0;
+       int saved_rc = 0;
        unsigned int xid;

        /*
@@ -2137,8 +2139,10 @@ static int cifs_writepages(struct address_space *mapping,

                rc = server->ops->wait_mtu_credits(server, cifs_sb->wsize,
                                                   &wsize, &credits);
-               if (rc)
+               if (rc != 0) {
+                       done = true;
                        break;
+               }

                tofind = min((wsize / PAGE_SIZE) - 1, end - index) + 1;

@@ -2146,6 +2150,7 @@ static int cifs_writepages(struct address_space *mapping,
                                                  &found_pages);
                if (!wdata) {
                        rc = -ENOMEM;
+                       done = true;
                        add_credits_and_wake_if(server, credits, 0);
                        break;
                }
@@ -2174,7 +2179,7 @@ static int cifs_writepages(struct address_space *mapping,
                if (rc != 0) {
                        add_credits_and_wake_if(server, wdata->credits, 0);
                        for (i = 0; i < nr_pages; ++i) {
-                               if (rc == -EAGAIN)
+                               if (is_retryable_error(rc))
                                        redirty_page_for_writepage(wbc,
                                                           wdata->pages[i]);
                                else
@@ -2182,7 +2187,7 @@ static int cifs_writepages(struct address_space *mapping,
                                end_page_writeback(wdata->pages[i]);
                                put_page(wdata->pages[i]);
                        }
-                       if (rc != -EAGAIN)
+                       if (!is_retryable_error(rc))
                                mapping_set_error(mapping, rc);
                }
                kref_put(&wdata->refcount, cifs_writedata_release);
@@ -2192,6 +2197,15 @@ static int cifs_writepages(struct address_space *mapping,
                        continue;
                }

+               /* Return immediately if we received a signal during writing */
+               if (is_interrupt_error(rc)) {
+                       done = true;
+                       break;
+               }
+
+               if (rc != 0 && saved_rc == 0)
+                       saved_rc = rc;
+
                wbc->nr_to_write -= nr_pages;
                if (wbc->nr_to_write <= 0)
                        done = true;
@@ -2209,6 +2223,9 @@ static int cifs_writepages(struct address_space *mapping,
                goto retry;
        }

+       if (saved_rc != 0)
+               rc = saved_rc;
+
        if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
                mapping->writeback_index = index;

@@ -2241,8 +2258,8 @@ cifs_writepage_locked(struct page *page, struct
writeback_control *wbc)
        set_page_writeback(page);
 retry_write:
        rc = cifs_partialpagewrite(page, 0, PAGE_SIZE);
-       if (rc == -EAGAIN) {
-               if (wbc->sync_mode == WB_SYNC_ALL)
+       if (is_retryable_error(rc)) {
+               if (wbc->sync_mode == WB_SYNC_ALL && rc == -EAGAIN)
                        goto retry_write;
                redirty_page_for_writepage(wbc, page);
        } else if (rc != 0) {
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 5b883a0..ba1152b 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2260,6 +2260,11 @@ cifs_setattr_unix(struct dentry *direntry,
struct iattr *attrs)
         * the flush returns error?
         */
        rc = filemap_write_and_wait(inode->i_mapping);
+       if (is_interrupt_error(rc)) {
+               rc = -ERESTARTSYS;
+               goto out;
+       }
+
        mapping_set_error(inode->i_mapping, rc);
        rc = 0;

@@ -2403,6 +2408,11 @@ cifs_setattr_nounix(struct dentry *direntry,
struct iattr *attrs)
         * the flush returns error?
         */
        rc = filemap_write_and_wait(inode->i_mapping);
+       if (is_interrupt_error(rc)) {
+               rc = -ERESTARTSYS;
+               goto cifs_setattr_exit;
+       }
+
        mapping_set_error(inode->i_mapping, rc);
        rc = 0;

--
2.7.4



-- 
Thanks,

Steve
