Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9ECC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3354E208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OtyFblFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3354E208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbeG0Rbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:31:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46823 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388701AbeG0Rbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:31:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so1877699pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rcs1ph1JBTcruxynrsjMBhzHt4iFHwCm0YhtVoUGM+8=;
        b=OtyFblFSiMwSHJM3U4mR1DM+5Nufw7RXWK4h+f7uAmRxmzhDcZ3qrXzvCujf98C8M6
         gHxdgbx43rI3Ja60ot0N8Q1a6yGA23jQunQ5EDl2vT5QGMlF5QYzP4j7G0PqoLamwTSU
         yGljN/sevtHTvNZovIe0blyuKktACqDx5QpC3sB3nVoy8LTO+RRecM/A8vG+g7cZrayK
         qtKUhd91ffBoHm8hKSuni/woe2cSSBdODPcreEooNziAr5xrifTR+k7cp+JEPYKFMpVB
         8xLVogPRGY0Cu5uhr4qGVz4/ULDXFmNDk1k7OkO8izqj8tOgdv4lO4u/mnejHUqM91Nx
         GaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcs1ph1JBTcruxynrsjMBhzHt4iFHwCm0YhtVoUGM+8=;
        b=hTsJTy3q4uI52hNXItO6djTMYk/diphVMCaX/xa0bnAPgaunJDGGG8GxJL+5ka0JE0
         Q5oWjijKyvtLgRQViLBrBqo84672eZcW4vRnP+O9tz0Zg+hK7DPH+XhTQjXRMRDd8jha
         aE5BYi7x204uTGsBPbRzYaFoJmn6YNp0JWFkATzf/OwdT0v9AMkjgQUFfu4a8veO+bq5
         INlR+LbQ0yXZorg7dOOxb6aLg4ZOrjJI0Kpk1A6OXm2Vqcfs92WIjvNVenvG16AaBVse
         53fyl07138ttXhN3/+NgYoQsGeULs5Rl+LIzGOA9GVZeUD3MO8EBOZrtRWxy6sGlN20R
         rUww==
X-Gm-Message-State: AOUpUlF0KcqqWCsVdLrBYMTas4fUn2u9lb6S13t8+AVnquy8TNtpW9Ci
        KYj9l6nlX3E2mm7YeDF7dlmVjA==
X-Google-Smtp-Source: AAOMgpeV5ZxEeuwxFTJsQ5mTsddx8ErPGAiQFkeXoojj2GVfOSrSUcqeK6pAfc+WgqsS7tx4gAkZxQ==
X-Received: by 2002:a62:df82:: with SMTP id d2-v6mr7261624pfl.189.1532707746400;
        Fri, 27 Jul 2018 09:09:06 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 77-v6sm5763575pga.40.2018.07.27.09.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:09:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fj5Ie-0004DE-Sc; Fri, 27 Jul 2018 10:09:04 -0600
Date:   Fri, 27 Jul 2018 10:09:04 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
Message-ID: <20180727160904.GE9497@ziepe.ca>
References: <20180727155402.GA15253@ziepe.ca>
 <VI1PR0502MB3008B0D78AB418E263819EE7D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0502MB3008B0D78AB418E263819EE7D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 04:04:33PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe
> > Sent: Friday, July 27, 2018 10:54 AM
> > To: linux-rdma@vger.kernel.org; Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: David Miller <davem@davemloft.net>; Networking
> > <netdev@vger.kernel.org>; Doug Ledford <dledford@redhat.com>; Linux-Next
> > Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Parav Pandit <parav@mellanox.com>; Ursula Braun
> > <ubraun@linux.ibm.com>; Leon Romanovsky <leonro@mellanox.com>; linux-
> > rdma@vger.kernel.org
> > Subject: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
> > 
> > Code changes in smc have become so complicated this cycle that the RDMA
> > patches to remove ib_query_gid in smc create too complex merge conflicts.
> > Allow those conflicts to be resolved by using the net/smc hunks by providing a
> > compatibility wrapper. During the second phase of the merge window this
> > wrapper will be deleted and smc updated to use the new API.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  include/rdma/ib_cache.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > The resolution Stephen had to make is too complicated, I think we should go this
> > way instead. Parav can send a patch to DaveM during the 2nd half of the merge
> > window to safely update SMC and delete this wrapper.
> > 
> Last night Stephen send the changes, if Ursula can test it, its
> preferred but if that is not possible, I am with below approach too.

Thing is one of us has to explain to Linus how to handle this
conflict, as Stephen's resolutions do not automatically go him.

Given how much new code the resolution introduces, I prefer to not
send it to Linus..

> > Parav, can you check this?
> > 
> > Ursula, this is only for SMC, are you able to test SMC with it? You will need to
> > apply it to the RDMA tree here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next
> > 
> > Thanks,
> > Jason
> > 
> > diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h index
> > 1108d422027696..c7e9b42b96e5b8 100644
> > +++ b/include/rdma/ib_cache.h
> > @@ -132,4 +132,28 @@ const struct ib_gid_attr *rdma_get_gid_attr(struct
> > ib_device *device,
> >  					    u8 port_num, int index);
> >  void rdma_put_gid_attr(const struct ib_gid_attr *attr);  void
> > rdma_hold_gid_attr(const struct ib_gid_attr *attr);
> > +
> > +/*
> > + * This is to be removed. It only exists to make merging rdma and smc simpler.
> > + */
> > +static inline __deprecated int ib_query_gid(struct ib_device *device,
> > +					    u8 port_num, int index,
> > +					    union ib_gid *gid,
> > +					    struct ib_gid_attr *attr_out)
> > +{
> > +	const struct ib_gid_attr *attr;
> > +
> > +	attr = rdma_get_gid_attr(device,port_num,index);
> White space after each variable is needed to avoid warnings.

Woops, no problem.

> > +	if (IS_ERR(attr))
> > +		return PTR_ERR(attr);
> > +
> > +	if (attr->ndev)
> > +		dev_hold(attr->ndev);
> > +	*attr_out = *attr;
> > +
> > +	rdma_put_gid_attr(attr);
> > +
> > +	return 0;
> > +}
> > +
> >  #endif /* _IB_CACHE_H */
> 
> Rest looks fine.
> RB: parav@mellanox.com

In future please spell out the Reviewed-by - patchworks will automate
collecting the tags and add it to the patch, otherwise maintainers
have to do it by hand.

Thanks,
Jason
