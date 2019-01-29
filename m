Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3174CC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79B02087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nhfcvP2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfA2REJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:04:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35207 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfA2REJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:04:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so9002908pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VV29xB00rXAvBPnOigrMJNqshqo3bC1j9EeEF+HMUno=;
        b=nhfcvP2TxdnZN9xbwSrI15JOAP/kbT54fpb0kysxy1Ck6JcaCOMnXa3XG15L8LW4Yt
         rg+A9YZLOttrpv6lotsweo7NS7Mpg0XA8UAPg1BvZFCJpmMZf8tyntT9yE2z8ijvKmOD
         YjD9/NvOmJzAQiEorJ115Nq29NtG0hpSa3ZKDqwahfC/BNHes9xmIX+1v28uM4eg1Fyo
         pz5++Lf/EyXLG9VzoDQkvpiQZiCWScHse7aQmivAwAp+rs0RcvwnXFUVIMIScN3aLhTn
         PvM5gibVPP5/5p8miAiCyjG77abUcfqTwd5qHOgxfH/Z25eqZEvWJs6H9fOmGfZ0lI/i
         ZISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VV29xB00rXAvBPnOigrMJNqshqo3bC1j9EeEF+HMUno=;
        b=CPH1RWk8A31QP22qz+FZbNLGO/sCDKUSSZcwaFJvVvfAWk1FJgZCB8KilMQxmFkh2X
         wo4CKAk7lT9Vf49GUtcYmZl/JoP3SwraZu+XgxMNw2NVVgljpxZdXI2KUILPagO9vQub
         loUXFzhiPM3tu5nj07oyM9WgPTEVHhL21LRg2Uj3ywDGrcXTMzDxbsyri3i1ghKiXwt1
         7zM5vemQmQp5UQJh3W9OTLskL8RBvCa/Uw65jyEyKiqKCZg6CrPeAFkN22az/RdvWugF
         xXq0omoeNKaOK0u4s4zrUY93/sx8vHELU+NizRt9LmSpz4vfceRG/81ohZ7y8wx1oHwy
         tDpg==
X-Gm-Message-State: AJcUukdKCwciIicolFlholNgDhTES2G6tGKjeXu7MOgH20n5HBejxESk
        dz4jQizbmp5Rda3VFAMajKFpqg==
X-Google-Smtp-Source: ALg8bN7AxF3xoqsuG/93xSoZ+cRG7a8tyhRZlL24OqrBTYhU6jme9FBFjiBzWS6Haq2KiW/HN/k8Rw==
X-Received: by 2002:a63:34c3:: with SMTP id b186mr23539295pga.184.1548781447762;
        Tue, 29 Jan 2019 09:04:07 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id c67sm67656941pfg.170.2019.01.29.09.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 09:04:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1goWnu-0003HW-72; Tue, 29 Jan 2019 10:04:06 -0700
Date:   Tue, 29 Jan 2019 10:04:06 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] RDMA/uverbs: add UVERBS_METHOD_REG_REMOTE_MR
Message-ID: <20190129170406.GD10094@ziepe.ca>
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
 <1548768386-28289-6-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548768386-28289-6-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:26:26PM +0200, Joel Nider wrote:
> Add a new handler for new uverb reg_remote_mr. The purpose is to register
> a memory region in a different address space (i.e. process) than the
> caller.
> 
> The main use case which motivated this change is post-copy container
> migration. When a migration manager (i.e. CRIU) starts a migration, it
> must have an open connection for handling any page faults that occur
> in the container after restoration on the target machine. Even though
> CRIU establishes and maintains the connection, ultimately the memory
> is copied from the container being migrated (i.e. a remote address
> space). This container must remain passive -- meaning it cannot have
> any knowledge of the RDMA connection; therefore the migration manager
> must have the ability to register a remote memory region. This remote
> memory region will serve as the source for any memory pages that must
> be copied (on-demand or otherwise) during the migration.
> 
> Signed-off-by: Joel Nider <joeln@il.ibm.com>
>  drivers/infiniband/core/uverbs_std_types_mr.c | 129 +++++++++++++++++++++++++-
>  include/rdma/ib_verbs.h                       |   8 ++
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  13 +++
>  3 files changed, 149 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
> index 4d4be0c..bf7b4b2 100644
> +++ b/drivers/infiniband/core/uverbs_std_types_mr.c
> @@ -150,6 +150,99 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
>  	return ret;
>  }
>  
> +static int UVERBS_HANDLER(UVERBS_METHOD_REG_REMOTE_MR)(
> +	struct uverbs_attr_bundle *attrs)
> +{

I think this should just be REG_MR with an optional remote PID
argument

> +	struct pid *owner_pid;
> +	struct ib_reg_remote_mr_attr attr = {};
> +	struct ib_uobject *uobj =
> +		uverbs_attr_get_uobject(attrs,
> +					UVERBS_ATTR_REG_REMOTE_MR_HANDLE);
> +	struct ib_pd *pd =
> +		uverbs_attr_get_obj(attrs, UVERBS_ATTR_REG_REMOTE_MR_PD_HANDLE);
> +
> +	struct ib_mr *mr;
> +	int ret;
> +
> +	ret = uverbs_copy_from(&attr.start, attrs,
> +				UVERBS_ATTR_REG_REMOTE_MR_START);
> +	if (ret)
> +		return ret;
> +
> +	ret = uverbs_copy_from(&attr.length, attrs,
> +				UVERBS_ATTR_REG_REMOTE_MR_LENGTH);
> +	if (ret)
> +		return ret;
> +
> +	ret = uverbs_copy_from(&attr.hca_va, attrs,
> +				UVERBS_ATTR_REG_REMOTE_MR_HCA_VA);
> +	if (ret)
> +		return ret;
> +
> +	ret = uverbs_copy_from(&attr.owner, attrs,
> +				UVERBS_ATTR_REG_REMOTE_MR_OWNER);
> +	if (ret)
> +		return ret;

Maybe these should use the const version, it is becoming intended for
small integers, then we can do sensible things like use uintptr_t to
store pointer values, and size_t to store sizes - the code will
automatically bounds check the user input if it is done like this.

> +	ret = uverbs_get_flags32(&attr.access_flags, attrs,
> +				 UVERBS_ATTR_REG_REMOTE_MR_ACCESS_FLAGS,
> +				 IB_ACCESS_SUPPORTED);
> +	if (ret)
> +		return ret;
> +
> +	/* ensure the offsets are identical */
> +	if ((attr.start & ~PAGE_MASK) != (attr.hca_va & ~PAGE_MASK))
> +		return -EINVAL;
> +
> +	ret = ib_check_mr_access(attr.access_flags);
> +	if (ret)
> +		return ret;
> +
> +	if (attr.access_flags & IB_ACCESS_ON_DEMAND) {
> +		if (!(pd->device->attrs.device_cap_flags &
> +		      IB_DEVICE_ON_DEMAND_PAGING)) {
> +			pr_debug("ODP support not available\n");
> +			ret = -EINVAL;
> +			return ret;
> +		}
> +	}
> +
> +	/* get the owner's pid struct before something happens to it */
> +	owner_pid = find_get_pid(attr.owner);

security? Match what ptrace does?

> +	mr = pd->device->ops.reg_user_mr(pd, attr.start, attr.length,
> +		attr.hca_va, attr.access_flags, owner_pid, NULL);
> +	if (IS_ERR(mr))
> +		return PTR_ERR(mr);
> +
> +	mr->device  = pd->device;
> +	mr->pd      = pd;
> +	mr->dm	    = NULL;
> +	mr->uobject = uobj;
> +	atomic_inc(&pd->usecnt);
> +	mr->res.type = RDMA_RESTRACK_MR;
> +	mr->res.task = get_pid_task(owner_pid, PIDTYPE_PID);
> +	rdma_restrack_kadd(&mr->res);
> +
> +	uobj->object = mr;
> +
> +	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_REMOTE_MR_RESP_LKEY,
> +		   &mr->lkey, sizeof(mr->lkey));
> +	if (ret)
> +		goto err_dereg;
> +
> +	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_REMOTE_MR_RESP_RKEY,
> +			&mr->rkey, sizeof(mr->rkey));
> +	if (ret)
> +		goto err_dereg;
> +
> +	return 0;
> +
> +err_dereg:
> +	ib_dereg_mr(mr);
> +
> +	return ret;
> +}
> +
>  DECLARE_UVERBS_NAMED_METHOD(
>  	UVERBS_METHOD_ADVISE_MR,
>  	UVERBS_ATTR_IDR(UVERBS_ATTR_ADVISE_MR_PD_HANDLE,
> @@ -203,12 +296,46 @@ DECLARE_UVERBS_NAMED_METHOD_DESTROY(
>  			UVERBS_ACCESS_DESTROY,
>  			UA_MANDATORY));
>  
> +DECLARE_UVERBS_NAMED_METHOD(
> +	UVERBS_METHOD_REG_REMOTE_MR,
> +	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_REMOTE_MR_HANDLE,
> +			UVERBS_OBJECT_MR,
> +			UVERBS_ACCESS_NEW,
> +			UA_MANDATORY),
> +	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_REMOTE_MR_PD_HANDLE,
> +			UVERBS_OBJECT_PD,
> +			UVERBS_ACCESS_READ,
> +			UA_MANDATORY),
> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_REMOTE_MR_START,
> +			   UVERBS_ATTR_TYPE(u64),
> +			   UA_MANDATORY),
> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_REMOTE_MR_LENGTH,
> +			   UVERBS_ATTR_TYPE(u64),
> +			   UA_MANDATORY),
> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_REMOTE_MR_HCA_VA,
> +			   UVERBS_ATTR_TYPE(u64),
> +			   UA_MANDATORY),
> +	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_REG_REMOTE_MR_ACCESS_FLAGS,
> +			     enum ib_access_flags),
> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_REMOTE_MR_OWNER,
> +			   UVERBS_ATTR_TYPE(u32),
> +			   UA_MANDATORY),
> +	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_REMOTE_MR_RESP_LKEY,
> +			    UVERBS_ATTR_TYPE(u32),
> +			    UA_MANDATORY),
> +	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_REG_REMOTE_MR_RESP_RKEY,
> +			    UVERBS_ATTR_TYPE(u32),
> +			    UA_MANDATORY),
> +);
> +
>  DECLARE_UVERBS_NAMED_OBJECT(
>  	UVERBS_OBJECT_MR,
>  	UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
>  	&UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
>  	&UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
> -	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR));
> +	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),
> +	&UVERBS_METHOD(UVERBS_METHOD_REG_REMOTE_MR),
> +);

I'm kind of surprised this compiles with the trailing comma?

>  const struct uapi_definition uverbs_def_obj_mr[] = {
>  	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_MR,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 3432404..dcf5edc 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -334,6 +334,14 @@ struct ib_dm_alloc_attr {
>  	u32	flags;
>  };
>  
> +struct ib_reg_remote_mr_attr {
> +	u64      start;
> +	u64      length;
> +	u64      hca_va;
> +	u32      access_flags;
> +	u32      owner;
> +};

Why? Why here?

Jason
