Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2738277-1520031219-2-2320527782933865481
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
    t=1520031218; b=pSotGOjkBTUyHOSP06fNcOvXHw3EbEuy9OLpTd2hPi0mwtS
    pCHVDyLu5iDi1IqqhL0mNo5W6f5xt4A0edbLyguXVqZf2Jw2IXSpDWqEWxnH8m3a
    zC5SGh9k4Xod0w15vlIx1+keS3QON4OM3dxreClw90uWgOWOif0QFjxsa6fkSm5Z
    JBVVDguuZQEW8VlSPw71ToCFGwVLA8wkmvksKNVFNfLbGnlhDl5EIgZkWtQn2M2Y
    UaXh+OIisUoCxlKapfM2X5S3jjK1BWFSxfe6Skr51N/I6ft8pdLKBfKByUNTJ1K/
    0E/ZVNENbwg+2BWIiQ/YpZSSFhJCD7BZkwaNgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520031218; bh=8CpxzIGCKw5dMoaTf7kjD0C35j
    RExspITjyWDraWvF8=; b=ZCIj5YbSmH852gdbogWTuPDsqbE8GCr6Sf0Q+DFTCC
    hpVHyi+Bhc44XkrzOSjeM4bmZ+byve9rQNEkUsAaza89ng7emIQkU72PhN/0FrAz
    tBR4vT1mQ9DXgoQC2poEJEjIXnVal+2bbb+gkITXtAuSzeWcdNvTfbV3p7Hkpr3m
    PoQEjR9JUPwyeD2rXfLA0oQ56YaG1fH8VnY1Egasb3YL/dgivFxMr9WDwf3OjSo0
    tcp4Vzlfqi4P3mXvFSX+4rVv/Dozm90kvNkb1dzjg7dPFzJveApHUKRscHrZhRTL
    xEQj8V3dwQyi46iDReCT0UOz8qUiQWRAQ8i3bNajDSEA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933904AbeCBWxT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 17:53:19 -0500
Received: from verein.lst.de ([213.95.11.211]:38343 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933561AbeCBWxS (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 17:53:18 -0500
Date: Fri, 2 Mar 2018 23:53:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/12] dax: introduce IS_DEVDAX() and IS_FSDAX()
Message-ID: <20180302225316.GC31240@lst.de>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com> <151996282448.28483.10415125852182473579.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151996282448.28483.10415125852182473579.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> +static inline bool IS_DEVDAX(struct inode *inode)
> +{
> +	if (!IS_ENABLED(CONFIG_DEV_DAX))
> +		return false;
> +	if ((inode->i_flags & S_DAX) == 0)
> +		return false;
> +	if (!S_ISCHR(inode->i_mode))
> +		return false;
> +	return true;
> +}
> +
> +static inline bool IS_FSDAX(struct inode *inode)
> +{
> +	if (!IS_ENABLED(CONFIG_FS_DAX))
> +		return false;
> +	if ((inode->i_flags & S_DAX) == 0)
> +		return false;
> +	if (S_ISCHR(inode->i_mode))
> +		return false;
> +	return true;

Encoding the is char device or not thing here is just nasty.  I think
this is going entirely in the wrong direction.
