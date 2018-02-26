Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2498165-1519638684-5-17209475414325645859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519638684; b=eQnQhstfGlmK9bZwa443C4IorSIqeGb/ertW+riVTn1mKwr
    JQsXL2lYtJjLUBg4LFM2DMX5TVsB9FZzDbqxsN80W8oPNGYGBbqgxFnWXstFc4jB
    KTlJtLa2dPquINT5yza1njUOVUO45dIRecTSsEqs4E5ZZmVxzB/U1x70L0AloX8X
    Qs9soQR6c4IGKK/hAZdFipiae4V13Tt9VPLzGlaNGCGRub1yGV0iOmfO9vwtuVuC
    BuxXpFNsflxd8YNRNCA4eXgrKcz66rXGV1DhUt6vOoaWGWr1WEY/npKWxljMr+G9
    2UxD8xO/rF9hoVvHEFkwwmJ07wHFgR/rGM/FPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519638684; bh=wq/2MwtOddRJeE98o9WtpoBQ9M
    SIguk5dEEVFCN11cI=; b=ekokQUPg+vI4BuKBBeFzIgLqKOluw9qDndDVgdJvIt
    H4BCEUCbIKPMRWYD4e1iKmoUksiynvFvMgm+v810S29U5qlcSTgDT0Qqz2+A6Jxj
    qVxNUPzWKB3oSYBhuFhJuothJ8LQ9uxvp1rghNdDqbWGk6hd3i54vx+HDliq6XI5
    3L8+J38+58Rs5eWBYg5qIOrj3wJy7wOz3wiGqS7rF22rSvquDLRbhBA0vdxSZuFM
    TjxHuWSrqAezeCrlIaUQ8gRol0UEJSnkvUwD9HIW8ayGMkUKP+/cGavK6RonBgj9
    qoNE+OasuzBv0fI+EQurDb5NJEK5EUe5zMr/o6QHGJgw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeBZJvF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 04:51:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:51940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbeBZJvC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 04:51:02 -0500
Date: Mon, 26 Feb 2018 10:51:00 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Jane Chu <jane.chu@oracle.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Gerd Rausch <gerd.rausch@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dax: fix vma_is_fsdax() helper
Message-ID: <20180226095100.j7dpeeto6wh6hncw@quack2.suse.cz>
References: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151943299140.29249.1858877799010776925.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151943299140.29249.1858877799010776925.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 23-02-18 16:43:11, Dan Williams wrote:
> Gerd reports that ->i_mode may contain other bits besides S_IFCHR. Use
> S_ISCHR() instead. Otherwise, get_user_pages_longterm() may fail on
> device-dax instances when those are meant to be explicitly allowed.
> 
> Fixes: 2bb6d2837083 ("mm: introduce get_user_pages_longterm")
> Cc: <stable@vger.kernel.org>
> Reported-by: Gerd Rausch <gerd.rausch@oracle.com>
> Acked-by: Jane Chu <jane.chu@oracle.com>
> Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I wonder how I didn't notice this when reading the original patch. Anyway
the fix looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2a815560fda0..79c413985305 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3198,7 +3198,7 @@ static inline bool vma_is_fsdax(struct vm_area_struct *vma)
>  	if (!vma_is_dax(vma))
>  		return false;
>  	inode = file_inode(vma->vm_file);
> -	if (inode->i_mode == S_IFCHR)
> +	if (S_ISCHR(inode->i_mode))
>  		return false; /* device-dax */
>  	return true;
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
