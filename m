Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2980787-1525372588-2-15363854087738919667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525372587; b=Q5NVk1C61IpFIn4v1ezcYO4Eln5NNu408sQjipmWwMpdp3lLSD
    daqN4Z+4MkupsEELx/NTu7YyP1t7nemv8H5Hb+sLIo0ogj8ngho0D8uzvw/Va+Bt
    3HC75P0EzCBzLecTztZ8LEYJPFo0GyDpysUob9upvuged54EgAkOh3DABKDH0Vhu
    l8ICiXjkqybzAIKxcLKTd7sGBI/LeRimteafXenERs45xLryfF4Yb7ue9EsBeivL
    1jSadg8C/YFSf3vg6rv5oxObU1ZS8wmpj93CuiQ0ovmgT8JRxfup2vS8+rzAV5vo
    kOMk6lB+uz5sEBnXQXbmj9I0ysYJVa9TbiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1525372587; bh=GngF6QEzDTQEPOBl500Ddmsw2AsqhA
    ISdoqVCGeoBZg=; b=YAwVEhQDyGwi1ew1k53tdahNPx5fIb74vAQLPNarHN5wrA
    df4L0vxdAhKd+IdRGMs4tCfVtf568nyg5lFJwkF/DOyzVpo3Gujis7hODShUVeID
    l/Aub3KBDs3LPQI46Qx4JZwBmbOcNNu3UxEQfc4zDFj/JyUlp9E1MnfJs7V8iVcU
    J4t1a9kdybVFSf1eQQBBq/1VYMyN2ca/QWF/QGjIh1rj8nGr+vKVuFzzn6YeYN/e
    /JyhRynkBe04v7gB+hCu9qjMpbjWQDBJiPsZmPyctS7nP4foW/B0mt/pZrq5yelf
    F0svXu0yYM0aiK5Sp0TgqRiYmoQ/pS+AOgn6+RnQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC84qF8WCMdCmgwVc5V0lwYr0VcTdl2g/CFm/WHWI7YrPO4HGvwycypEdHjeluPxc17jAF5hcje+SIJ0uEc0w/lm0eHloCmse8Wf2nT45EjrlX0pRIyr
    mJ+54LgT8E0mOooHko+D3QHoInUWQWSDkYLhiA+uSPPY1J81WVPIITRzhu69akc9Id9/86Y4yABI1u+X3xDkuTCdvLMETRwHPt8akwoRnu8fQq9IAeXieUAq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=-fskoiAwk-1lv5KNdMcA:9 a=sHJpmtqPaPkA:10
    a=x8gzFH9gYPwA:10 a=xVlTc564ipvMDusKsbsT:22 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeECSgS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:36:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750969AbeECSgR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 May 2018 14:36:17 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: Add aio iopriority support for block_dev
References: <20180503182114.2797-1-adam.manzanares@wdc.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Thu, 03 May 2018 14:36:15 -0400
In-Reply-To: <20180503182114.2797-1-adam.manzanares@wdc.com> (adam
        manzanares's message of "Thu, 3 May 2018 11:21:14 -0700")
Message-ID: <x49po2cr3hc.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Adam,

adam.manzanares@wdc.com writes:

> From: Adam Manzanares <adam.manzanares@wdc.com>
>
> This is the per-I/O equivalent of the ioprio_set system call.
>
> When IOCB_FLAG_IOPRIO is set on the iocb aio_flags field, then we set the
> newly added kiocb ki_ioprio field to the value in the iocb aio_reqprio field.
>
> When a bio is created for an aio request by the block dev we set the priority
> value of the bio to the user supplied value.
>
> See the following link for performance implications on a SATA HDD:
> https://lkml.org/lkml/2016/12/6/495
>
> Given that WRR support for NVME devices has patches floating around and it was
> discussed at LSFMM, we may soon have a lower latency storage device that can 
> make use of iopriorities. A per command iopriority interface seems timely 
> given these developments. 
>
> If we want to avoid bloating struct kiocb, I suggest we turn the private field 
> into a union of the private and ki_ioprio field. It seems like the users of 
> the private field all use it at a point where we can yank the priority from 
> the kiocb before the private field is used. Comments and suggestions welcome.

The ioprio_set system call requires CAP_SYS_ADMIN for setting
IOPRIO_CLASS_RT.  I think we need similar checks here.

-Jeff

>
> v2: merge patches
>     use IOCB_FLAG_IOPRIO
>     validate intended use with IOCB_IOPRIO
>     add linux-api and linux-block to cc
>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> ---
>  fs/aio.c                     | 10 ++++++++++
>  fs/block_dev.c               |  2 ++
>  include/linux/fs.h           |  2 ++
>  include/uapi/linux/aio_abi.h |  1 +
>  4 files changed, 15 insertions(+)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 88d7927ffbc6..f36636d8ff2c 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1597,6 +1597,16 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		req->common.ki_flags |= IOCB_EVENTFD;
>  	}
>  
> +	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
> +		/*
> +		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
> +		 * aio_reqprio is interpreted as an I/O scheduling
> +		 * class and priority.
> +		 */
> +		req->common.ki_ioprio = iocb->aio_reqprio;
> +		req->common.ki_flags |= IOCB_IOPRIO;
> +	}
> +
>  	ret = kiocb_set_rw_flags(&req->common, iocb->aio_rw_flags);
>  	if (unlikely(ret)) {
>  		pr_debug("EINVAL: aio_rw_flags\n");
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 7ec920e27065..970bef79caa6 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -355,6 +355,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		bio->bi_write_hint = iocb->ki_hint;
>  		bio->bi_private = dio;
>  		bio->bi_end_io = blkdev_bio_end_io;
> +		if (iocb->ki_flags & IOCB_IOPRIO)
> +			bio->bi_ioprio = iocb->ki_ioprio;
>  
>  		ret = bio_iov_iter_get_pages(bio, iter);
>  		if (unlikely(ret)) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 760d8da1b6c7..ab63ce720305 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -292,6 +292,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  #define IOCB_NOWAIT		(1 << 7)
> +#define IOCB_IOPRIO		(1 << 8)
>  
>  struct kiocb {
>  	struct file		*ki_filp;
> @@ -300,6 +301,7 @@ struct kiocb {
>  	void			*private;
>  	int			ki_flags;
>  	enum rw_hint		ki_hint;
> +	u16			ki_ioprio; /* See linux/ioprio.h */
>  } __randomize_layout;
>  
>  static inline bool is_sync_kiocb(struct kiocb *kiocb)
> diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
> index a04adbc70ddf..d4593a6062ef 100644
> --- a/include/uapi/linux/aio_abi.h
> +++ b/include/uapi/linux/aio_abi.h
> @@ -54,6 +54,7 @@ enum {
>   *                   is valid.
>   */
>  #define IOCB_FLAG_RESFD		(1 << 0)
> +#define IOCB_FLAG_IOPRIO	(1 << 1)
>  
>  /* read() from /dev/aio returns these structures. */
>  struct io_event {
