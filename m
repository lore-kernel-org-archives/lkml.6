Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B86C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3DC20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A4+DNiWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfANW2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:28:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40326 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfANW2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:28:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so280859plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4jfapddJpRZ4I2fBTw/5t1Wiz2pQ4hLm2mhluJXsUHc=;
        b=A4+DNiWhNWTJS5AwCEJPx1VGs9LQVOw8aNfJqe3JXCenLqVKyVw5kDEs+2O7g0eb7C
         qjW8gtyBzjIlNu9XsD6GPGJ2qr7/zdw6e81/Lr+gNX9h2dra7wOGvKPByRAqq7UgrQxj
         2r3iRKBN69Bm26rtFcD4KkG+WTSpSi0MyjukRUyY+jOEP4ZLQT0NQPw3vQw9+397zb8O
         5hl7n6RCJpxbuC9xqRXKj48YKa5tH20EzubykZ/Vc9XuR2L/8GVtZuR2FHJ/g9QnPNGB
         F/BOm2tHr/KYQQzvPjJP9RDWE78pzhVWQ0Bqjlv7FBt8rlIJA/0/2TCQ5nTw4Ze/0P7p
         YAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4jfapddJpRZ4I2fBTw/5t1Wiz2pQ4hLm2mhluJXsUHc=;
        b=KUs00jIz6o/DvcmdEL3clXUZ883JqKq5E8nNbB/7jjVUmXSn91cGGzPnfv3iaK9pd3
         JzLmWrr2uV5yZqEKTaVuqCnnxXIVwHER/VEaD7MOhc5w9UfuG6SHCroLYVvPULhEaS9+
         p6hJWv+tzrjbTc6/JVVz/CT7B+s1IkASYWpxRiV827R9EZcVcs1So6tdo7oO7GUfRAGu
         CWA7JD45XQkXWEoXx7FmUixh6EoaZKXo4//s2fRY7kh/oV7tldAaiDuYrnu0S9MbP9DC
         e2Mt6WM9427QCgWQq3zOMHQxuxZfR6Z/JreEVXwb0FPnj7YHlluyKMBjhdOOqG3xnndy
         gUkQ==
X-Gm-Message-State: AJcUukemIManFWd6Q9kSUTuwb/c5coqNk0wai9B4sfiygUx6mz5xv873
        FHgHHOYv9e2Rm7ScCsXZd3edeQ==
X-Google-Smtp-Source: ALg8bN4lG8d9qQgyUMPO0u7JooUy34JzwSt12Hpmp037RHkziW50yqi9aYC6bxB07O34vgPMhFXtHw==
X-Received: by 2002:a17:902:7e4f:: with SMTP id a15mr739581pln.149.1547504934367;
        Mon, 14 Jan 2019 14:28:54 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f64sm3085014pfh.0.2019.01.14.14.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:28:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gjAiy-0005so-Ol; Mon, 14 Jan 2019 15:28:52 -0700
Date:   Mon, 14 Jan 2019 15:28:52 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/cma: Rollback source IP address if failing to
 acquire device
Message-ID: <20190114222852.GA22588@ziepe.ca>
References: <20190110062727.GA25844@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110062727.GA25844@myunghoj-Precision-5530>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:27:31PM -0800, Myungho Jung wrote:
> If cma_acquire_dev_by_src_ip() returns error in addr_handler(), the
> device state changes back to RDMA_CM_ADDR_BOUND but the resolved source
> IP address is still left. After that, if rdma_destroy_id() is called
> after rdma_listen(), the device is freed without removed from
> listen_any_list in cma_cancel_operation(). Revert to the previous IP
> address if acquiring device fails.
> 
> Reported-by: syzbot+f3ce716af730c8f96637@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/infiniband/core/cma.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
