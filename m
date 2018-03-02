Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2667167-1520028642-2-9413127492653734514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520028641; b=JKKtcwfBGTYO4tRbJq/mpglAfpwpMbi1mxpUNYfNk61qyim
    ec6KA7ld/j29QdLj4KPsmEZ7poqvD51WP+y47t3wvqkxzvw9+JNacepAsyfckRWZ
    ZOHHpVYwSqfLyERWV+vdy0wP1ijnTe7pO0XQOSBlBS7r+B/o8cY/rvk/vJAKVvPy
    1cqBTxVsms5vjrvcUjb/bqBvVfBHvSzuCvrZGgxWD0d60t/2qtRT7/2ejhv2KY8v
    qQRMVD63tHTDyuiJ55McwH/Dc4NNTX0jtN8Ca0Qeroe60/TOzZhLWj6BttJiqSLP
    gwfF3/EVsE8nuvdLbiDUob2ucwFMuw8WvGHPRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520028641; bh=xOWlEpdFCZ6TFEHam/qm0jtcfd
    g7enJblunQBAAGuC0=; b=OfbDpSeiVznypitNM9KkcfbSf0zPoVawqYRhJ7R1kp
    57KmD3vPZ8O6tn+iz3C2A3QKz+GEAXTBP1anJY68p/HHLIR8/PoVJeFyIWQ93sXT
    HV8l2fk+brNxtRddIZWQjVnX2Dc9sPGacEbyJxMy0aimgsFrHf0tHlyNN5YfcNOR
    jjMZM8COcBORdkcM/lPcfE0g1ubT0iPy18H9PVFlLMmGkOuktSPkwxTgSZnYH/bL
    EvxttWbYFhcCOg6VdMtHhB5zEM14FnQMFdn/sixMlUr2sxky9erLKe2Wp1H4ETME
    +vKhsDT8E9kEIPWjn8KIWBONWW0TULcpuwWPO96ksmyg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeCBWKZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 17:10:25 -0500
Received: from verein.lst.de ([213.95.11.211]:38217 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932197AbeCBWKX (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 17:10:23 -0500
Date: Fri, 2 Mar 2018 23:10:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>, kvm@vger.kernel.org,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Gerd Rausch <gerd.rausch@oracle.com>, stable@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Christoph Hellwig <hch@lst.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-fsdevel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] vfio, dax: prevent long term filesystem-dax
        pins and other fixes
Message-ID: <20180302221020.GA30722@lst.de>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I really don't like these IS_DEVDAX and IS_FSDAX flags.  We should
stop pretending DAX is a global per-inode choice and get rid of these
magic flags entirely.  So please convert the instances inside the
various file systems to checking the file system mount options instead.

For the core ones we'll need to differentiate:

 - the checks in generic_file_read_iter and __generic_file_write_iter
   seem to not be needed anymore at all since we stopped abusing the
   direct I/O code for DAX, so they should probably be removed.
 - io_is_direct is a weird check and should probably just go away,
   as there is not point in always setting IOCB_DIRECT for DAX I/O
 - fadvise should either become a file op, or a flag on the inode that
   fadvice is supported instead of the nasty noop_backing_dev_info or
   DAX check.
 - Ditto for madvise
 - vma_is_dax should probably be replaced with a VMA flag.
 - thp_get_unmapped_area I don't really understand why we have a dax
   check there.
 - dax_mapping will be much harder to sort out.

But all these DAX flags certainly look like a major hodge podge to me.
