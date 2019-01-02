Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B340C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDE62070D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iy3vRKeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfABXGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:06:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44961 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfABXGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:06:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so15161817pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 15:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNYKJYb2dVRZr4Dc7WIRqIAN4rWp2oy17gQulywCfMk=;
        b=iy3vRKeCdQp5mNuSMRXAoWISUfrXUJHyM/HNpZSQJMSbvZPtrDqIqpR3TxtYNr831d
         EmgsQ9PUx2ZIlCot+zJfIt1OdEIIH4hIJJIgT95PC56Tt1YO/t41S2UW6AsQQKv6I1xY
         gZI1VSfQ54ZHUQ9HkLb2weDCIr0YTfKJPGPTI14mw2ch/Vz17ranECfrLEjrrLI6pcIw
         s5qOdWxEqVwB0ot1Fh3n6V+Bc8UOrnmwLMIZ0kqupLN1CgUxKz+Owr96yPUUCm93xq/V
         LRpYpIOmpthQT3ouKGF4cxhoOwiMAwdlRrq2dmemJj4DgtdlFGQOEDSn7BRGrG4WVHSk
         ipSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNYKJYb2dVRZr4Dc7WIRqIAN4rWp2oy17gQulywCfMk=;
        b=GuLczyo84/ENkZyPkmnWwTG8LmEbDT/hiqz+Sqg5ntPok/uQGyFzdD3ZtyYb7QrGGp
         f0VLNus8Ah3Ow2IVDa4h22N/PNc6q7hp6gYc3RXVBjnmBRLjL378+Msm0qBfs55qfgE0
         rZoGg8iUFYwJVW4i/y28Bq6hJdS9CTvBrCyKhDhNypAuWXQxQEWsYqPu9toRXG/H3OH+
         SjC2eee+DMaVoMNpVKVnvpEENXT9whPwR4lud2nkurK29BN3g3rUxsDcSbHtKrDdKPTH
         CtetSx0z2a9iDCk/SXt9lKhzg46kVxUYd5JMD9CUsldQHUGwJ8+/53apvBnzFAK/PYUB
         Pgew==
X-Gm-Message-State: AJcUukezsx0P18cRXCsb0XzOMuCflb/yim9wXzLixyFnWEQwUELbckM6
        wjBBYXmmK8H+s3Y2i9mjx2oMTg==
X-Google-Smtp-Source: ALg8bN6xMoTdSCJHamHUGgq7sOSuQWkU81B87KouikQDXOGjLN0SayDi0mSMJ0u3OOoxu5UGqq1AeQ==
X-Received: by 2002:a63:6704:: with SMTP id b4mr15117684pgc.100.1546470374073;
        Wed, 02 Jan 2019 15:06:14 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v9sm78419777pfg.144.2019.01.02.15.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 15:06:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gepaW-0007c3-Hp; Wed, 02 Jan 2019 16:06:12 -0700
Date:   Wed, 2 Jan 2019 16:06:12 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: bnxt_re: qplib: Check the return value of
 send_message
Message-ID: <20190102230612.GA29239@ziepe.ca>
References: <20181226185623.9324-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226185623.9324-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:56:22PM -0600, Aditya Pakki wrote:
> In bnxt_qplib_map_tc2cos(), bnxt_qplib_rcfw_send_message() can return
> an error value. The fix returns the error from the latter function
> upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> Acked-By: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-next

Jason
