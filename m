Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2628879-1519770569-3-4816267075998155430
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519770568; b=erh345KEzqju2zyJru5yuIGLYLWLfxAGZKKYJioHKM6VX+C
    8TEqjXjYZgwfCqcY6vjh1B3qHqIyJY9jbvEndBXNKUm27J1ziq7fkYh/k36Ydfst
    Eflww52AmMmuW9m1zpc2F717gpfke4XtwokdewkrVRO/agQ+Rnh3fd3coyAsthfc
    EWIK17c8YgaWhqoZ3AtobqB3KpY4zH5amhhVjvQvnwWPQIGRshTZF/8lEEA2p4K2
    G35nMbCO5coJYUpKV4MB3a0Lv7KqSrFdKZivlQNEGLYtPsp933IHQtPGbmnS8o3i
    Jp6tNmsKOJX7XPN5gKCNAGxTmxqYxt5EYrmNv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519770568; bh=e1EAe+zxOJluBWJlTowtaZLKMZ
    GPJ6cVZUHiwa9ZE5w=; b=qxNDM5kowqrEEqsdc4EkgVeBumVoqT+ooNvahdyEtc
    lElr0lpGAy2EccMldJlP+HupBqB58utBRabGNkHHduhILXM+cZQuUSet2j23Tc3K
    atMUwH1MdeOxUxr4pheftHbqzEIKMrlhUtEhWbP0nHXywZycVZspcfBUVUjLynIK
    kFXsK01TIc+14eO26e1Gt/E+7gWDrAKr79aCX049eNF5SrdkSZw9Yn106Sa2IboS
    FrNQZ7X/VKY62nbbG+Thl+cyH9v74tBsxSa9qRFUa1Zn6yl4VIqxOj/dUNxJ0Y+V
    YHlkDK74VXNFc3sNe8ZDH6fkZol6hik+exAs/BDLb0dw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fromorbit.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fromorbit.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeB0W24 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:28:56 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:22964 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752314AbeB0W2x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 17:28:53 -0500
Date: Wed, 28 Feb 2018 09:23:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Jane Chu <jane.chu@oracle.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        kvm@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "supporter:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        linux-mm@kvack.org, Alex Williamson <alex.williamson@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 00/12] vfio, dax: prevent long term filesystem-dax
 pins and other fixes
Message-ID: <20180227222345.GK30854@dastard>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 08:19:54PM -0800, Dan Williams wrote:
> The following series implements...
> Changes since v3 [1]:
> 
> * Kill IS_DAX() in favor of explicit IS_FSDAX() and IS_DEVDAX() helpers.
>   Jan noted, "having IS_DAX() and IS_FSDAX() doing almost the same, just
>   not exactly the same, is IMHO a recipe for confusion", and I agree. A
>   nice side effect of this elimination is a cleanup to remove occasions of
>   "#ifdef CONFIG_FS_DAX" in C files, it is all moved to header files
>   now. (Jan)

Dan, can you please stop sending random patches in a patch set to
random lists?  Your patchsets are hitting 4 or 5 different procmail
filters here and so it gets split across several different mailing
list buckets. It's really annoying to have to go reconstruct every
patch set you send back into a single series in a single bucket....

Can you please fix up your patch set sending again?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
