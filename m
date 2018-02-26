Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2432626-1519638240-2-6549205968713827876
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
    t=1519638240; b=xDiO6euaRim4FrvG1LJC7/Y3s1XuMuYDE/zN2PWzjsH9hJD
    499xCs71E2QtJ1GwfiqxLEzbjKTtO3yMV4zIErUux5SutyJ4ZJoD20lbhysEBVYm
    tHw/px0uGDQzUON4xEUhi3U4Ho1nalub+IEtBo8n3AMjkCtmq+NiihjVMwUxy028
    6DSCsb6jkILUvmQN8sso0F8tulj3OfL9wCh6gomFEl6mkOlPcFtZ7C2zcDXc18t2
    CJ7TEv70sipmS2c3BsCJxhU4M/5frkUd/Ieemlc4TT5IQJE5kVS+x4NFue4VfUh6
    /WzCnO9dwMM8aNVyIUZhNPnuiDnx8Bb2bW5upHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519638240; bh=y/qOASqA7EglFOeaSvUIsvqxgF
    nPgK/sLOhvbzc1+0M=; b=pBjBf5iAY7/g15UNqS3j+4kQxQXVybxz7KYYDMZZrq
    ut0cZjHk4b03+jy55i4Mmu3RSTFWn9OOEpiDSe4YzgAP9Eh5EjAg0oImvx+0aHvd
    xoh1gQ3yd8xBuVbeb/Z/piiR8AmlzzoMXQrcCBU/Y/ivCKKSWiuC+JYgcOY5DIkt
    31k6Tcx0uwluwmd4/4WHeO4EotslKFK99gzJvJ+jEDxAhs15XIYw+ZNu6T5DDQq5
    UjEb6VdZ+RzbrpgSfs55vx8m0LaiVhSx8k3Jeqq+ucRH/YA5gsnSFfnEtMeOFMVx
    MGqOPrpRFSI8Dq/R4iVP/zusyC/z5ZzBt8iCvvtq3tLw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBZJn5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 04:43:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:51360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeBZJn4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 04:43:56 -0500
Date: Mon, 26 Feb 2018 10:43:54 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/5] dax: fix S_DAX definition
Message-ID: <20180226094354.puos4owvd5s5pxtv@quack2.suse.cz>
References: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151937027614.18973.7636331271085629639.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151937027614.18973.7636331271085629639.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 22-02-18 23:17:56, Dan Williams wrote:
> Make sure S_DAX is defined in the CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y
> case. Otherwise vma_is_dax() may incorrectly return false in the
> Device-DAX case.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 79c413985305..b2fa9b4c1e51 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1859,7 +1859,7 @@ struct super_operations {
>  #define S_IMA		1024	/* Inode has an associated IMA struct */
>  #define S_AUTOMOUNT	2048	/* Automount/referral quasi-directory */
>  #define S_NOSEC		4096	/* no suid or xattr security attributes */
> -#ifdef CONFIG_FS_DAX
> +#if IS_ENABLED(CONFIG_FS_DAX) || IS_ENABLED(CONFIG_DEV_DAX)
>  #define S_DAX		8192	/* Direct Access, avoiding the page cache */
>  #else
>  #define S_DAX		0	/* Make all the DAX code disappear */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
