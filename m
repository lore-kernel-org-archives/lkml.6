Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m20zJNhdHluqJwAAmS7hNA
	; Mon, 11 Jun 2018 11:32:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6A4BA601C3; Mon, 11 Jun 2018 11:32:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Xgbmx+wH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 65457601C3;
	Mon, 11 Jun 2018 11:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65457601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932881AbeFKLch (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:32:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34957 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932765AbeFKLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:32:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so20029711wrn.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BvosY+glcajskazeW3QKx7oNpuMskaqjo8F6Czy62cY=;
        b=Xgbmx+wHheYnG/qHNvQydbn9aGXNWE8sSNqIZBp+1ecXIf7mM/1zmq8Bl7EbFTL9HY
         lEamNfLfF+A2nK1qX0KbZdFpwQw2XvyuQRSghDm2Tp/zaIWmfYH87SKu6F77lQ2Fvhct
         v4l7bd8BJDph2nGF3Cd0jsHNx7COieWzSko/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BvosY+glcajskazeW3QKx7oNpuMskaqjo8F6Czy62cY=;
        b=XhYa0SzqBo5zE01C0lTEGHEeW5CwLXXB7lSgacePK2UOF78sOuXuGZ7k5c3GMyfsIV
         O8S8dImProX0XH1YkW6VUoU98TmOVqgo0qGOGSWufPaN+XLTijuA3nMwUg/lMGiMK4In
         c4o0pNxSj99AMG83OVSKg4fZRHsWzvAMY5Vdzo3iY0ggsEU0tbhylfk2OdxdiBQTIsNX
         NDpYs40Bmd5ylc0zhj9E7o4CQ8CuW7XhjQYG6m9UJXyccNgUK7GyYfLJadCWGn8bfapB
         AS5XPBhddAIxNeuZsfe9DGi0/jR7RBMSurYvpGuB0vLC8jXnU8C0E+U4PtOsQoOPMWKo
         /obg==
X-Gm-Message-State: APt69E2OKmWxTBEeaXxT6GcSqtm8GsMG2lHuUzpRjXlohAaNL+y7PjTE
        nfke8H0B0fvMx/VGO8WfySNbsbCC
X-Google-Smtp-Source: ADUXVKL4wnyiU9eo5YTUVQjIP9XhexkCT+BIfFouDXmmJ748vXNsIQUdS/OIW1y6PjbDxC+iuaRfsA==
X-Received: by 2002:adf:86ae:: with SMTP id 43-v6mr11580554wrx.281.1528716753810;
        Mon, 11 Jun 2018 04:32:33 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (C2B0E321.catv.pool.telekom.hu. [194.176.227.33])
        by smtp.gmail.com with ESMTPSA id z5-v6sm23300034wrh.10.2018.06.11.04.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 04:32:32 -0700 (PDT)
Date: Mon, 11 Jun 2018 13:32:30 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs: factor out inode_insert5()
Message-ID: <20180611113230.GI23785@veci.piliscsaba.redhat.com>
References: <20180529144143.16378-1-mszeredi@redhat.com>
 <20180529144143.16378-10-mszeredi@redhat.com>
 <20180610054902.GQ30522@ZenIV.linux.org.uk>
 <20180610060159.GS30522@ZenIV.linux.org.uk>
 <CAJfpegt5guR3zJeATw4-N41Ad2n9pcB5mQoLmSLOfocnEoodVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt5guR3zJeATw4-N41Ad2n9pcB5mQoLmSLOfocnEoodVg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:15:55AM +0200, Miklos Szeredi wrote:
> On Sun, Jun 10, 2018 at 8:02 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Sun, Jun 10, 2018 at 06:49:10AM +0100, Al Viro wrote:
> >> On Tue, May 29, 2018 at 04:41:41PM +0200, Miklos Szeredi wrote:
> >> > From: Miklos Szeredi <miklos@szeredi.hu>
> >> >
> >> > Split out common helper for race free insertion of an already allocated
> >> > inode into the cache.  Use this from iget5_locked() and
> >> > insert_inode_locked4().  Make iget5_locked() use new_inode()/iput() instead
> >> > of alloc_inode()/destroy_inode() directly.
> >>
> >> ... thus hitting the sucker with ->evict_inode(), in condition that is quite
> >> likely to be unfit to be seen by that.
> >>
> >> NAK.
> >
> > To clarify: objection here is against the switch to new_inode/iput.  The rest is
> > sane.  What makes new_inode() better here, anyway?
> 
> Umm, got to look into this.  The patch has already been pulled by
> Linus, but I hope it's salvageable.

Incremental follows.  I think it's cleaner to initialize i_state and i_sb_list
up front (hence the use of new_inode()), but could just as well add to sb list
afterwards.

---
diff --git a/fs/inode.c b/fs/inode.c
index 0df41bb77e0f..03c0d7c1296f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1098,8 +1098,10 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 
 		if (new) {
 			inode = inode_insert5(new, hashval, test, set, data);
-			if (unlikely(inode != new))
-				iput(new);
+			if (unlikely(inode != new)) {
+				inode_sb_list_del(inode);
+				destroy_inode(new);
+			}
 		}
 	}
 	return inode;
