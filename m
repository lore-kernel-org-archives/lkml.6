Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17540C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D6C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D6C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeIDLth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:49:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:40368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbeIDLth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:49:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B93ADAD90;
        Tue,  4 Sep 2018 07:25:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7D43B1E3609; Tue,  4 Sep 2018 09:25:45 +0200 (CEST)
Date:   Tue, 4 Sep 2018 09:25:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/posix_acl.c: fix kernel-doc warnings, formatting,
 and typo
Message-ID: <20180904072545.GA9444@quack2.suse.cz>
References: <722f4cf6-9b51-f7c9-e645-ca1f79dc7a67@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722f4cf6-9b51-f7c9-e645-ca1f79dc7a67@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-09-18 15:40:34, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings in fs/posic_acl.c.
> Also fix one typo (setgit -> setgid).
> 
> ../fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
> ../fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
> ../fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
> 
> Fixes: 073931017b49d ("posix_acl: Clear SGID bit when setting file permissions")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Acked-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> v2: change *acl to *@acl
> 
>  fs/posix_acl.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- lnx-419-rc2.orig/fs/posix_acl.c
> +++ lnx-419-rc2/fs/posix_acl.c
> @@ -630,12 +630,15 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
>  
>  /**
>   * posix_acl_update_mode  -  update mode in set_acl
> + * @inode: target inode
> + * @mode_p: mode (pointer) for update
> + * @acl: acl pointer
>   *
>   * Update the file mode when setting an ACL: compute the new file permission
>   * bits based on the ACL.  In addition, if the ACL is equivalent to the new
> - * file mode, set *acl to NULL to indicate that no ACL should be set.
> + * file mode, set *@acl to NULL to indicate that no ACL should be set.
>   *
> - * As with chmod, clear the setgit bit if the caller is not in the owning group
> + * As with chmod, clear the setgid bit if the caller is not in the owning group
>   * or capable of CAP_FSETID (see inode_change_ok).
>   *
>   * Called from set_acl inode operations.
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
