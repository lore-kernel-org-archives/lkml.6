Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SmMDEfcqHlsFKwAAmS7hNA
	; Mon, 11 Jun 2018 07:58:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 76B8D60792; Mon, 11 Jun 2018 07:58:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="C1GB56wE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E425F60791;
	Mon, 11 Jun 2018 07:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E425F60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeFKH6k (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:58:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53940 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754006AbeFKH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:58:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so12901930wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nG93pKzfXoZEUTyoPSaiFlSTkfwzd14JaD/JUKqtvZg=;
        b=C1GB56wEcVxTofOZtNazDgQ2P1r7OjYowCaV+Dn5KfYLo9LGLfcEd1J1p/PBYXiFBd
         l3t6nSmF10B2Xm24YR21njGGoQCTH3LjOzJ9CM4qf8TG4F964byPpmaUFmJ5KbuDEl7F
         /gQOtZO/GysnQIsS+sOBR8QngiEJKyYP3ldgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nG93pKzfXoZEUTyoPSaiFlSTkfwzd14JaD/JUKqtvZg=;
        b=Rij4oRcRnni1QLAcyFlV3I+X3kOZHip8kwDkiNZGPLUode7k026f6/sNcUMHigZb25
         kTgZv93pqO9sGJ095QG7l9oIcMFXK9f8BrHy9l4RpHOJimiC5OSOHTV/0bXxsyso/DUd
         PGasf80aWev5BCiO4+D6Gq8LWxLnmLmnmjtY5fEHHKdpRXmyhu0djGT9PNHU4Z9H0wRU
         RmSvylIHX+bnblDtJr32r1au4+CYsm7vba8MOb4UPM4/kAytyn94qcXrrogDM7g0Xvse
         M1xLziLK2A+p3vRi4NIAvuINyXA6/8BIkxugIgcdSkLwKPhA26BEqTMmskX4W2LI5HPt
         wsyg==
X-Gm-Message-State: APt69E2u5UBZ3RMLRAcw/uKa0JzdQwrwPTbzt0V3GuKnfYUM0RGsABEy
        LmOx4Mzv+1tKaSfA+2iRtRHINw==
X-Google-Smtp-Source: ADUXVKKJpKq7kNt2YLjS9Mh4ZCTgVeFXcZEdQ7lP6KDGNshCInrNPJLdjJedIFecWpaS10uj/6AMnA==
X-Received: by 2002:a1c:7401:: with SMTP id p1-v6mr7158506wmc.14.1528703916414;
        Mon, 11 Jun 2018 00:58:36 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (C2B0E321.catv.pool.telekom.hu. [194.176.227.33])
        by smtp.gmail.com with ESMTPSA id b190-v6sm13138655wma.24.2018.06.11.00.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 00:58:35 -0700 (PDT)
Date: Mon, 11 Jun 2018 09:58:32 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/39] ovl: add ovl_mmap()
Message-ID: <20180611075832.GH23785@veci.piliscsaba.redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-20-mszeredi@redhat.com>
 <20180610052447.GN30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610052447.GN30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 06:24:59AM +0100, Al Viro wrote:
> On Tue, May 29, 2018 at 04:43:19PM +0200, Miklos Szeredi wrote:
> > Implement stacked mmap.
> > 
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/file.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index 7b47dce4b072..4057bbf2e141 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -255,6 +255,33 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
> >  	return ret;
> >  }
> >  
> > +static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	struct fd real;
> > +	const struct cred *old_cred;
> > +	int ret;
> > +
> > +	ret = ovl_real_fdget(file, &real);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* transfer ref: */
> > +	fput(vma->vm_file);
> > +	vma->vm_file = get_file(real.file);
> > +	fdput(real);
> > +
> > +	if (!vma->vm_file->f_op->mmap)
> > +		return -ENODEV;
> 
> That's broken.  ->mmap() failure will fput(file), not fput(vma->vm_file).
> What's more, _here_ your "corner case" is a huge DoS - open file r/o,
> then have somebody else trigger copyup, then do tons of MAP_PRIVATE
> mmaps on the r/o descriptor.  *EACH* *OF* *THEM* will open a separate
> struct file and stash into into new vmas.
> 
> NAK with extreme prejudice, sensu PTerry...

Okay, okay, got it now.  Incremental below.  It's a step back (mmap after
copy-up will get old data), but not a regression from current state.  Obviously
need to fix properly and I think that's doable together with dealing with shared
map coherency.


diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f801e1175a0b..b5a6bcc1bcfa 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -282,26 +282,30 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct fd real;
+	struct file *realfile = file->private_data;
 	const struct cred *old_cred;
 	int ret;
 
-	ret = ovl_real_fdget(file, &real);
-	if (ret)
-		return ret;
+	if (!realfile->f_op->mmap)
+		return -ENODEV;
 
-	/* transfer ref: */
-	fput(vma->vm_file);
-	vma->vm_file = get_file(real.file);
-	fdput(real);
+	if (WARN_ON(file != vma->vm_file))
+		return -EIO;
 
-	if (!vma->vm_file->f_op->mmap)
-		return -ENODEV;
+	vma->vm_file = get_file(realfile);
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = call_mmap(vma->vm_file, vma);
 	revert_creds(old_cred);
 
+	if (ret) {
+		/* Drop reference count from new vm_file value */
+		fput(realfile);
+	} else {
+		/* Drop reference count from previous vm_file value */
+		fput(file);
+	}
+
 	ovl_file_accessed(file);
 
 	return ret;
