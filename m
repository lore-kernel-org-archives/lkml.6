Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CB320839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="lJyCADik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CB320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeHaVHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:07:35 -0400
Received: from imap.thunk.org ([74.207.234.97]:38142 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeHaVHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nUuZ7DQjh5isKaGRTm5p/SjTOpSLEXUfQdJrLt4lFHw=; b=lJyCADikQVUYxYnBJT9BQLhiml
        G+/+3r4gXtkgMD7AqfKMX2J4EZNjyfcKhJG7TZZ7whdGkUGwSo4zmXknLc6i3LrGdEHHF5nnpIojX
        6FZN8MH+Npzi1ojdygLMjfWamd2OOW0WWZCkzg8WJISlKRl23P81Ynm0gpo+X0dZSkmM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fvml1-0005RY-7H; Fri, 31 Aug 2018 16:58:51 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6799F7A4BBE; Fri, 31 Aug 2018 12:58:44 -0400 (EDT)
Date:   Fri, 31 Aug 2018 12:58:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        konishi.ryusuke@lab.ntt.co.jp, viro@zeniv.linux.org.uk,
        adilger.kernel@dilger.ca, axboe@kernel.dk, darrick.wong@oracle.com,
        ebiggers@google.com, pombredanne@nexb.com, agruenba@redhat.com,
        gregkh@linuxfoundation.org, kemi.wang@intel.com,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
Message-ID: <20180831165844.GB3303@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        konishi.ryusuke@lab.ntt.co.jp, viro@zeniv.linux.org.uk,
        adilger.kernel@dilger.ca, axboe@kernel.dk, darrick.wong@oracle.com,
        ebiggers@google.com, pombredanne@nexb.com, agruenba@redhat.com,
        gregkh@linuxfoundation.org, kemi.wang@intel.com,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nilfs@vger.kernel.org
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
 <20180830163521.728f3ff2fd3cc93b52a5dcc0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830163521.728f3ff2fd3cc93b52a5dcc0@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:35:21PM -0700, Andrew Morton wrote:
> 
> The v1->v2 delta (below) reveals unchangelogged ext4 changes?

Souptick, please don't make unrelated changes in a vm_fault_t patch.

Especially please don't make whitespace changes that will cause
checkpatch.pl to whine about line lengths longer than 80 characters.
There's a *reason* for the original indentation.

> @@ -6239,8 +6237,7 @@ retry_alloc:
>  		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
>  	}
>  	ext4_journal_stop(handle);
> -	if (err == -ENOSPC &&
> -		ext4_should_retry_alloc(inode->i_sb, &retries))
> +	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>  		goto retry_alloc;
>  out_ret:
>  	ret = block_page_mkwrite_return(err);

The fact that this is not a non-trivials set of changes means anything
to make reviews harder is really not appreciated.


Also, the fact that the patch series involves multiple file system is
a massive pain.  It means I'm going to have to do a separate
regression test --- or preferably, I would ask *you* to run a file
system regression test[1] --- to make sure what is *not* a trivial
patch doesn't break things.  Also, it means that this patch series is
going to get more complicated to get into kernel, and we may have to
deal with patch conflicts if this goes in via some third party tree
(such as Andrew's tree).

[1] https:/thunk.org/gce-xfstests

One way to make life easier is to add the new function with the new
interface first, and then wait a release cycle, and then move file
systems over in independant patches.  

					- Ted
