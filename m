Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1783691-1518334823-2-17755508640185259449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518334823; b=MaEPqebR0EQe74S/EsPkhROkiDdvW243m/DTLoJQ49LdvIK
    oc48fipgKSnFoiYnxZkUY2AaKaMwF20OjYx7vKn+BuSH8oJD4gaBnc677WYkZw+a
    Q5iAc1qZB0TcpoZcD6isYu8YE9DKX9Jn4eDr8XwbOxlTBPpXhxSMLneu0ezBKaq0
    R4+GyjBim5DIrB1ycp+0CKD82GmhyaQQ1FL5ym5HwUX4LrWuoDQYbMFvouVFqUBh
    PYOp3Q0SJT0f83D/eujKQrC6FkUOYRtcszWD6CtjgU093JkJG1UG6qykTjqdio4f
    H0VemA8bo8Vcoc8Q6w3yEkhbFHwXSSnTB5bgdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:mime-version:to:cc
    :subject:references:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518334823; bh=zFSiSUpdRm1hWkStXm7VZBd8/S7HS0Y5F0vabXL7yLY=; b=Q
    IaJDID2/LOK7ZOCLeMciZm6no3Ois/JbWkS3JuowVVAmGTzpwSAUWL1CET/5besx
    HzyTztP4i+o/okRxzw+jZe6J75u7oBymAP3o87wmc7hJbZEhbyYGHok7ChtfJ6iy
    gPlHQwtIUm/++vNZ8oT1w5uX0yXb1hYHbhCTit4R2wzKHQ1mJzAZLWf2ZI5qKU2d
    +QtlsmLD3MkmE3pwvYo/6MEw84TYLKlIxu0SSzf5390f808ngxBKMZfIT6jex8v4
    f4i88XcIUSLTkqd/dFmMLKRo+hc1GZujjODD89u+0HTjCN0s8stQOCK43daJLLE1
    G2e4+FifxwxDRlygoB1dg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeBKHkT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 02:40:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752224AbeBKHkS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 11 Feb 2018 02:40:18 -0500
Message-ID: <5A7FF337.3000705@huawei.com>
Date: Sun, 11 Feb 2018 15:39:35 +0800
From: alex chen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Ben Hutchings <ben@decadent.org.uk>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <jiangqi903@gmail.com>,
        Jun Piao <piaojun@huawei.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3.2 39/79] ocfs2: should wait dio before inode lock in
 ocfs2_setattr()
References: <lsq.1518322806.798088185@decadent.org.uk>
In-Reply-To: <lsq.1518322806.798088185@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.26.59]
X-CFilter-Loop: Reflected
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ben,

ocfs2_dio_end_io_write() was introduced in 4.6 and the problem this patch
fixes is only exist in the kernel 4.6 and above 4.6.

Thanks,
Alex

On 2018/2/11 12:20, Ben Hutchings wrote:
> 3.2.99-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: alex chen <alex.chen@huawei.com>
> 
> commit 28f5a8a7c033cbf3e32277f4cc9c6afd74f05300 upstream.
> 
> we should wait dio requests to finish before inode lock in
> ocfs2_setattr(), otherwise the following deadlock will happen:
> 
> process 1                  process 2                    process 3
> truncate file 'A'          end_io of writing file 'A'   receiving the bast messages
> ocfs2_setattr
>  ocfs2_inode_lock_tracker
>   ocfs2_inode_lock_full
>  inode_dio_wait
>   __inode_dio_wait
>   -->waiting for all dio
>   requests finish
>                                                         dlm_proxy_ast_handler
>                                                          dlm_do_local_bast
>                                                           ocfs2_blocking_ast
>                                                            ocfs2_generic_handle_bast
>                                                             set OCFS2_LOCK_BLOCKED flag
>                         dio_end_io
>                          dio_bio_end_aio
>                           dio_complete
>                            ocfs2_dio_end_io
>                             ocfs2_dio_end_io_write
>                              ocfs2_inode_lock
>                               __ocfs2_cluster_lock
>                                ocfs2_wait_for_mask
>                                -->waiting for OCFS2_LOCK_BLOCKED
>                                flag to be cleared, that is waiting
>                                for 'process 1' unlocking the inode lock
>                            inode_dio_end
>                            -->here dec the i_dio_count, but will never
>                            be called, so a deadlock happened.
> 
> Link: http://lkml.kernel.org/r/59F81636.70508@huawei.com
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> Reviewed-by: Jun Piao <piaojun@huawei.com>
> Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
> Acked-by: Changwei Ge <ge.changwei@h3c.com>
> Cc: Mark Fasheh <mfasheh@versity.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Junxiao Bi <junxiao.bi@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  fs/ocfs2/file.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1130,6 +1130,13 @@ int ocfs2_setattr(struct dentry *dentry,
>  		dquot_initialize(inode);
>  	size_change = S_ISREG(inode->i_mode) && attr->ia_valid & ATTR_SIZE;
>  	if (size_change) {
> +		/*
> +		 * Here we should wait dio to finish before inode lock
> +		 * to avoid a deadlock between ocfs2_setattr() and
> +		 * ocfs2_dio_end_io_write()
> +		 */
> +		inode_dio_wait(inode);
> +
>  		status = ocfs2_rw_lock(inode, 1);
>  		if (status < 0) {
>  			mlog_errno(status);
> @@ -1149,8 +1156,6 @@ int ocfs2_setattr(struct dentry *dentry,
>  		if (status)
>  			goto bail_unlock;
>  
> -		inode_dio_wait(inode);
> -
>  		if (i_size_read(inode) >= attr->ia_size) {
>  			if (ocfs2_should_order_data(inode)) {
>  				status = ocfs2_begin_ordered_truncate(inode,
> 
> 
> .
> 
