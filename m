Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988021-1519751166-2-14247893378982269596
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519751164; b=jl8SZX7dNC+1NPEcODH2NitZZ58GXx8ngF/Bv5ZhQcmiqfW
    g8ap5ShKl891kuCDHrP9/gpXJYhmjJDZAONZ2x5Ef28y4R15h3M/sbUL769RLIyz
    RMKfDgdhrYgUbtSet2704WE7iU+MVvllLnRmrNSb/YQmq+Zr8m2AxVzRZ7JyoM8u
    JY4FoIbF5CJ18KBO9Gc8SeDxjy/iDavxEaEXDDW3cG6e583vSi0sZ0S7QZFavLDP
    jURF3dOstGPDH0EjMeEt2gEQIQEC1Md19BH6p+CvtHjEQzRWfsWiKvFfIPrvHPca
    La3ftkbG8Qxjjo1rYf9IOWW6gXEOOoPAVvqLyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519751164; bh=m7jGbBQ9OdHSYhFWrV0OQiZNBA
    nMx0KxPt+RJryqk/Y=; b=IPDBcH0QC5LWFR/ieoD6dpoo7zEDbJlTAOLFpxJj7U
    hkuA4dv/Jsmg3lb1X5E4q40LxD2lVh2ZtXwyf8G8pIKDJ877T5yvWhwadP5WUJZc
    vJvvTtyuS1XB5lNpagb7hspYux+NtipNdcSOeAA0wxpvFvyswShV7fUH5kUmmb8W
    2vOMuWdPmwa3IdrqeG0zFE6OaCOe6xSb7Lafj/MfSKZsybGjjN2uLAbj7TEJL6ec
    ZGu5no5PH6MBtT9Xt2eQy/iE391vjRzWyIGvpYKdn8QZ1a06A2+miftlD6D9JNPo
    cud272ouaLHnaqoGnREUTrrFRJ//ZindK0iSrPPu91NA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeB0RGD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:06:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:47665 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbeB0RGB (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 12:06:01 -0500
Date: Tue, 27 Feb 2018 18:05:59 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 09/12] mm, dax: replace IS_DAX() with IS_DEVDAX() or
 IS_FSDAX()
Message-ID: <20180227170559.o2uldn4t6wypfgic@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970524289.26729.18096955322602992171.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970524289.26729.18096955322602992171.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:42, Dan Williams wrote:
> In preparation for fixing the broken definition of S_DAX in the
> CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, convert all IS_DAX() usages to
> use explicit tests for the DEVDAX and FSDAX sub-cases of DAX
> functionality.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Just one nit below. With that fixed you can add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -3208,21 +3208,19 @@ static inline bool io_is_direct(struct file *filp)
>  
>  static inline bool vma_is_dax(struct vm_area_struct *vma)
>  {
> -	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
> +	struct inode *inode;
> +
> +	if (!vma->vm_file)
> +		return false;
> +	inode = vma->vm_file->f_mapping->host;

When changing this, use file_inode() here as well?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
