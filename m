Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C83C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8305E20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JvexyyjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8305E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLCUrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:47:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42867 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeLCUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:47:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so2252824plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uMYcZ/yHyLxb8sXKBeu7P2IaJAOP8ih0z7jySus8ss=;
        b=JvexyyjIXOx6c/GqIBfaZTmsSLKAKwmfGckRXShraClYfpzNhcSjh0BO4vTWrZ8une
         PB5ZOnqKu6xtr+/fQ+zfZK2Fic8xuavf5HDDmVcuWrL/xG9DShYwVIwOXh1DWNKrpKNK
         CUPjuSZkzFmL4wrvkv8jU9z8rqnULaJ8Yxbz2kGJRN8VEMbkFCxx0D5lH33zxWOBJerm
         ThVy/n4Il+iustw1JNH9gxVgOhXznOfeULHOeE/ssrG2diOdptIOJ7VqvJmqwljjuXOl
         BOOLDf3KfNNHsOt+Sp/Oed0KbKEPibcWbFlMwz7iOm2/2+K7eVMcyQGCjWvA5Q3H3r9a
         mBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uMYcZ/yHyLxb8sXKBeu7P2IaJAOP8ih0z7jySus8ss=;
        b=oP60z+p6Cz0xWoaOg30COPmewlvXzp+HJMPR462+hPyvTeWNkt6+79UYIFgmc6GPbk
         r3jXzjZ9+JQ9yZcV1UMk1uBmy3m8ISIgF6sNEQqhYPukouWfqGLvx6QmaYM6aP3M3lUm
         lkJqBLNoh7dNgWI0EiNohDHWw171z5nuXXlW+kZ2Y8VwqHNYkINbmoziK5ee5H7ccztn
         pZYj4JKB5RIaMAMFs3Yr7vIqcEL5UAfFPCr/cYzR+Ext0tjjd9jtcR70UFMFxuLk7BE4
         Vzqsl33QK1SAv1LAIkn+YrBbPcQP2heQQ8wWd/NN3NdluwSk6ptYciwpD0OR2nyOlSj/
         laeQ==
X-Gm-Message-State: AA+aEWZmSftmAbpgHlKqO8C8v3q5xjQ4MBjVK3YY4FPKQ196JngKBzMw
        am5e28JAfXpSTPyKtTmdY5Y8lA==
X-Google-Smtp-Source: AFSGD/Wytn2ZdgQ/zULypKiMOCMO1RPyrdBKwFjaLhcMHEBq4xri95CB/DtDnslshCcWe+7CFJK69A==
X-Received: by 2002:a17:902:1122:: with SMTP id d31-v6mr17583199pla.259.1543870028822;
        Mon, 03 Dec 2018 12:47:08 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id w5sm18287767pfn.89.2018.12.03.12.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:47:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gTv7R-0006Vv-Ht; Mon, 03 Dec 2018 13:47:05 -0700
Date:   Mon, 3 Dec 2018 13:47:05 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: fix ptr_ret.cocci warnings
Message-ID: <20181203204705.GE12237@ziepe.ca>
References: <201811280723.DnTk8AXL%fengguang.wu@intel.com>
 <20181127232130.GA28456@sof-kbuild01>
 <20181129233721.GA11172@ziepe.ca>
 <51cb9d8e7b107d37447b9e0d218bb12d8cf49ebb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cb9d8e7b107d37447b9e0d218bb12d8cf49ebb.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:23:35PM -0500, Doug Ledford wrote:
> On Thu, 2018-11-29 at 16:37 -0700, Jason Gunthorpe wrote:
> > On Wed, Nov 28, 2018 at 07:21:30AM +0800, kbuild test robot wrote:
> > > From: kbuild test robot <fengguang.wu@intel.com>
> > > 
> > > drivers/infiniband/core/uverbs_cmd.c:1095:1-3: WARNING: PTR_ERR_OR_ZERO can be used
> > > 
> > > 
> > >  Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> > > 
> > > Generated by: scripts/coccinelle/api/ptr_ret.cocci
> > > 
> > > Fixes: 7106a9769715 ("RDMA/uverbs: Make write() handlers return 0 on success")
> > > Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> > 
> > applied to for-next, thanks
> > 
> > Jason
> 
> This caused a conflict with your make write() handlers use a consistent
> flow series, which I fixed up during git am run.  Just FYI in case you
> want to check out the conflict spot as a double check (but it was a
> simple fixup).

Looks OK to me thanks

Jason
