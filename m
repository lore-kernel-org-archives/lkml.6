Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B3CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E40A214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRrQtghy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfAJGDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:03:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38731 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:03:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so4836949pfi.5;
        Wed, 09 Jan 2019 22:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=982cPaGh6qoCDS7JmKmkGypc9iou4pqbU2baxd2RFO8=;
        b=KRrQtghyp6oLwI8dabFLAnLVufOEU762ze9GTtnsEfWAzljQGC8hSCuST9+qH1AAHx
         UqRzu7Qrt432Z7kWl+zgoqsOUwAKDtNMiEQvEaHYpxiXgw3drt/VlKZgTXtTofnD4uVQ
         DL8/s6q5DbxXq3GsyNV+lezhXuE0rp/GJgQgrTdL+uYKZh3rnAKQmBT0n2rDAuYj6hE0
         N+PEXYma28V4GgQsZC2ugi690DyrHwohHa98c5/+8oW4mYyYVUPQdjXsx1mxKUuPaJ3L
         ZLhjkW4XSQu57isFcDsWXrh0H4EpYrWFDdUU540zLuD6gyG4lGXKoP7RTRhEYOgp2YSy
         IYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=982cPaGh6qoCDS7JmKmkGypc9iou4pqbU2baxd2RFO8=;
        b=azQVtgOKpvwLRXQIfwe8sih/89b+I6VPw64JW9WiIqsJIVYk44NYloqDNqX8nqSjWN
         M0d4sBAucV0v9q6Ow7aLOEOUJ0iz8ILaMR+O3IywDjVAa50iJa37N2DYNav641VDe/F+
         hZ+YNSeHDeZrsQTbRyrEqgKuPfh2EhpQLbjljoUsINzec7Db776NzGsxEY2erma60tD/
         yXTEntapudWvcsKpK8jOGM1e4tTNJY1tqnVcgKNx7yi/0a3QwID4DqXLzY2Ukbnathrw
         dbnDBncYiIEBIXTZCQDzCWs9tzFUFka9mJvGyoNDDdjaM5F0VXS1zE4KdYOtySICI2Zz
         c3rQ==
X-Gm-Message-State: AJcUukc0cPUFjuNXuA0iWmrI78c5suq0y0HHY/hfHYCKq+rVfCHuniVD
        PhSYziXQWl/u3scL55bn0jc=
X-Google-Smtp-Source: ALg8bN6Zmhm59un7O0qnfw/8ClZE69uluTfzPwUJTPfHxSGyrjwC+pAlLPhUwU0bw7FMw06oDe8uTA==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr9042325pfc.209.1547100208826;
        Wed, 09 Jan 2019 22:03:28 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id 5sm140301201pfz.149.2019.01.09.22.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 22:03:28 -0800 (PST)
Date:   Wed, 9 Jan 2019 22:03:25 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: Rollback source IP address if failing to
 acquire device
Message-ID: <20190110060324.GA25523@myunghoj-Precision-5530>
References: <20190104064537.GA352@myunghoj-Precision-5530>
 <VI1PR0501MB2271AA04707AE880E8362933D18B0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0501MB2271AA04707AE880E8362933D18B0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:28:34PM +0000, Parav Pandit wrote:
> 
> 
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Myungho Jung
> > Sent: Friday, January 4, 2019 12:46 AM
> > To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] RDMA/cma: Rollback source IP address if failing to acquire
> > device
> > 
> > If cma_acquire_dev_by_src_ip() returns error in addr_handler(), the device
> > state changes back to RDMA_CM_ADDR_BOUND but the resolved source IP
> > address is still left. After that, if rdma_destroy_id() is called after
> > rdma_listen(), the device is freed without removed from listen_any_list in
> > cma_cancel_operation(). Revert to the previous IP address if acquiring device
> > fails.
> > 
> > Reported-by: syzbot+f3ce716af730c8f96637@syzkaller.appspotmail.com
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> >  drivers/infiniband/core/cma.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 63a7cc00bae0..d27c3b154e71 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -2963,13 +2963,17 @@ static void addr_handler(int status, struct
> > sockaddr *src_addr,  {
> >  	struct rdma_id_private *id_priv = context;
> >  	struct rdma_cm_event event = {};
> > +	struct sockaddr *addr;
> > +	struct sockaddr_storage old_addr;
> > 
> >  	mutex_lock(&id_priv->handler_mutex);
> >  	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY,
> >  			   RDMA_CM_ADDR_RESOLVED))
> >  		goto out;
> > 
> > -	memcpy(cma_src_addr(id_priv), src_addr,
> > rdma_addr_size(src_addr));
> > +	addr = cma_src_addr(id_priv);
> > +	memcpy(&old_addr, addr, rdma_addr_size(addr));
> Please add a comment here in the patch, why we need to store the old src address and restore back.
> /*
>   * Store the previous src address, so that if we fail to acquire matching rdma device,
>   * old address can be restored back, which helps to cancel the cma listen operation
>   * correctly.
>   */
> > +	memcpy(addr, src_addr, rdma_addr_size(src_addr));
> >  	if (!status && !id_priv->cma_dev) {
> >  		status = cma_acquire_dev_by_src_ip(id_priv);
> >  		if (status)
> > @@ -2980,6 +2984,8 @@ static void addr_handler(int status, struct sockaddr
> > *src_addr,
> >  	}
> > 
> >  	if (status) {
> > +		memcpy(addr, &old_addr,
> > +		       rdma_addr_size((struct sockaddr *)&old_addr));
> >  		if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED,
> >  				   RDMA_CM_ADDR_BOUND))
> >  			goto out;
> > --
> > 2.17.1
> 
> Reviewed-by: Parav Pandit <parav@mellanox.com>

Hi Parav,

Thanks for review. Let me update and resubmit patch.

Thanks,
Myungho
