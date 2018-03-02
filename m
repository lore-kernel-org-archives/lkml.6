Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2738277-1520031300-2-18361503457391515971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520031299; b=X3PtbH4/U13Q6cwJ/1Lk6KrZqa+js2zB+2Ds+95uPMKC+Tn
    drTD1wJv8MtGbe5XRHvyvrGErs5Aal1g6hEj5zaNgjrXomLZmc55vpgfKBM9SJe2
    wjOh+JYYVO/60WgCV4NN87JFRru3DmAbS+MlrMkDSl4NbvOBgKrZV88PzmTSB6GS
    mVObk8JDTGk8O998CLdiMGucoQoVJ6RlGzV8b0bNCeIiZWTNnrkU1s/f6bBfrFNy
    cOMAO/nDPKc0wMY+Lz9FgrB7H1dJMGn6QsQqnJMu2NArG+cMEjayq6mbgg5Jjkwg
    8jw2MuOi45tv8apXgcCr8NBTDA/OC528BZ2lDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520031299; bh=sMSbh4Q8YGTwIWwMKxxIdF15tA
    6KiGtghD09R7VgMi0=; b=LUJOWj7j5ypIW2rEzaFSUP3VEHNneg/jgtYB5FNOLG
    rWFWuSE+nWl4WjZ2ZpL0QMMIMOlFFL/BujfmmfvHsq0eRmQYq9X/t4zedK0cU75A
    FlA5lZeqYmou7V+tDgD3Hst7B6/Y1V8pFGG8ucnV5DhTTlp8k/ugG42rG9MaILkH
    /eBigJIKnUYE8HulR3W2X2uF5RqMopAkrZUFfd24gtk5ZGdHz3qYnA0Fzzk72cy3
    NDoZ/U7zsXCl1g1tVJ0vvvBroc01ZGMNSB4BgHbAR3IIrBx2MzhIERpx9jqXTYjO
    xVUswmvO1TR0JVLE+asWb0lKwCBDJZiSOKIkzLkg4ptg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933962AbeCBWy5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 17:54:57 -0500
Received: from verein.lst.de ([213.95.11.211]:38351 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933561AbeCBWy4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 17:54:56 -0500
Date: Fri, 2 Mar 2018 23:54:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-xfs@vger.kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] mm, dax: replace IS_DAX() with IS_DEVDAX() or
        IS_FSDAX()
Message-ID: <20180302225455.GD31240@lst.de>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com> <151996286235.28483.2635632878864807577.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151996286235.28483.2635632878864807577.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 07:54:22PM -0800, Dan Williams wrote:
>  static inline bool vma_is_dax(struct vm_area_struct *vma)
>  {
> -	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
> +	struct inode *inode;
> +
> +	if (!vma->vm_file)
> +		return false;
> +	inode = file_inode(vma->vm_file);
> +	return IS_FSDAX(inode) || IS_DEVDAX(inode);

If you look at the definition of IS_FSDAX and IS_DEVDAX this
is going to evaluate into some bullshit code.
