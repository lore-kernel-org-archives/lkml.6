Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4114809-1526656976-2-16432764829340869879
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526656976; b=C6/XbViTfqPHQxwqgQA+m7/JJ87fgZCeP6Oo0qUi+7qMoAqsbJ
    zVKT9V016qZVq2H+OpXwZLOFSIS/vnZUPjhpkWDtTUHUTJvHGxdewC3RkkbUPjF0
    vkmUosz2bXh7d603Lq34Svne5xjb1MUnge/9SH99F1XEMkJCM/KbppYP4yIOZx03
    xDS8NU/IOEPaesxw46M6Ct6zYcGpoq+ydwVl7lk5e4izMogeLIp4J631o+GT8D7S
    wLB99cg1DXBL55kzeg10PrAkXH4R8Pray+ZmznmXB7i9n8o+GThIXQpUK45DtPB+
    6v8Bh+esKmK4aCeTcs9ZIEaW4BoMvHyG/4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526656976; bh=W8czAfFcIFlRWUkWuZgDMD7R0cDiO5
    SNJe2IQBYj4jI=; b=YODVmsGPyfYGUOMWU9IZMyy2Hb0igmT74jzlKxT0R57zS0
    0X5YCcngLDWKiIOvfAkpXoG+5uG+V6NU1sJFXM91huq1obzJKGQLos9fCztIegv1
    RgHEUzKWp359s9rkwJiVWcos2cbRbVWaEMTl7N6fflwwk+usenphyzyf44bQQ8Xg
    VRsg7Ln+ZfY1THn+A2WaCEJUA0rQQvwYA3WmxJ/cscDk4x6oRO5QcZVXLDgMQn2i
    ML1bllwDgvL1naEySJ9rC6pVNk4kznVUPcByH674TlMW1FW0inPGTanX20iyU0qG
    Qtraf8iUgf1o2mVUiZ+zIwlWx7UeEXwBkfbVsXPw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=RKwLzkQG
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=RKwLzkQG
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA6ZGk0PZXpzbGQC7WIY/xOCUEjoz/bFqOpe56GKmj09QjM0eOd5VqKBJpVy5m9UiutOnkWq4c7bMepDF0slpBU6suapcgoNB94Z4k6X3Dx4vEvfOphJ
    Mwc5tEG1PkIJOTV/WyYPMD66FWn/dMA/7+i2XleiAgHIPz8ctMSD0mMQE6nz9YDsKq+nZSqs05o5e1oBxmbqmiUjDlhj7LmlasGs5u7xa7B18jdYCE2VhVKR
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=dyGO2TR7MC8doRY3BYIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeERPWx (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 11:22:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeERPWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 11:22:51 -0400
Date: Fri, 18 May 2018 08:22:50 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@ZenIV.linux.org.uk, andres@anarazel.de
Subject: Re: [RFC PATCH 07/11] ext4: have sync_fs op report writeback errors
 when passed a since pointer
Message-ID: <20180518152250.GC6361@bombadil.infradead.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
 <20180518123415.28181-8-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518123415.28181-8-jlayton@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 08:34:11AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> When ext4_sync_fs gets a non-NULL since pointer, use it to report
> errors vs. the errseq_t in the super_block. This allows us to
> properly report an error to sync_fs when any inode has failed writeback
> since we last checked for it.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/ext4/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 896ddf8c3421..a5f41d31611f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4898,6 +4898,8 @@ static int ext4_sync_fs(struct super_block *sb, int wait, errseq_t *since)
>  	}
>  out:
>  	ret2 = __sync_blockdev(sb->s_bdev, wait);
> +	if (since)
> +		ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
>  	return ret ? ret : ret2;
>  }

This is inconsistent with the ext2 and xfs implementations ...

I'm worried this is too much complexity to push down to the filesystems.
When should errors get reported through the return value; when should they
be reported through the errseq_t?

Can we hide all of this?  Maybe ext4 could do:

	errseq_set(&sb->s_wb_err, __sync_blockdev(sb->s_bdev, wait));
	return ret;

(we'd need to make calling errseq_set(x, 0) be a no-op instead of an error)

and then the caller is the one who takes care of calling
errseq_check_and_advance() so we don't have to pass 'since' into each
filesystem.
