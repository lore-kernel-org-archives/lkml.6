Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeBZKIj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:08:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:53670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752402AbeBZKIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:08:34 -0500
Date: Mon, 26 Feb 2018 11:08:32 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 5/6] dax: short circuit vma_is_fsdax() in the
 CONFIG_FS_DAX=n case
Message-ID: <20180226100832.xidetsf3eoagumqd@quack2.suse.cz>
References: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151943301788.29249.13371602951635567379.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151943301788.29249.13371602951635567379.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-02-18 16:43:37, Dan Williams wrote:
> Do not bother looking up the file type in the case when Filesystem-DAX
> is disabled at build time.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7418341578a3..c97fc4dbaae1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3197,6 +3197,8 @@ static inline bool vma_is_fsdax(struct vm_area_struct *vma)
>  
>  	if (!vma->vm_file)
>  		return false;
> +	if (!IS_ENABLED(CONFIG_FS_DAX))
> +		return false;
>  	if (!vma_is_dax(vma))
>  		return false;
>  	inode = file_inode(vma->vm_file);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
