Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA7C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE382084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jYaPlbyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfAUHoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:44:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44305 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfAUHoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:44:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so9720921pfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5RFue2AglZIzu/ecngc+xlJAtxu04ONi+SoVgHwdWY=;
        b=jYaPlbyvIJRGO/lxfVwcA/wp/74soJqClA+zgvfXVrz0CjQIT7mv8n61mueOO3vgZ3
         xJdU2+G3rdyJcyBalf0nBmNaKZSZzWtSrmvQKMs4hXxeUGzjnI5DbB6FcCUQAyKBUsYR
         bS+SKxWmPBEj6+mS9gz2xk/g3tUGTLdOfS5LD9LO/1J5skV5Nm55UHPTWMH/Nqr4u4pD
         8rwIPUmDwYU5+VqJA7Wyl7bw/kBSmQFNdT5qJPWZQWVHgBXGIADS2rQ9XK7C8zdirwSK
         CHdvHvWXBx6J5yaSwXc/uUHLIARiID9ptlAvmGtowa36VFSu4KIYjKyCizO8f8uEvwxj
         P+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5RFue2AglZIzu/ecngc+xlJAtxu04ONi+SoVgHwdWY=;
        b=sV5gh7C6wdBzKIAYprc1MAMeeHg5Atewf8+fztv/UlVEbi+QOBugaVXAmALVBUAiXR
         YVnAPN2rEQpCAmBVVuLMgCfn6clX5nkYgPL9YIpHYd6a6GbdPm4AIYSh71ldSHyffXs5
         l+CV4Jt+ge2NSehysqXgL0Jbj5SWLycCa/s8Jog3QL/2tPUbLXHvg8sH6kPzT+mpsLyv
         SPpbsE1a/DBoJbIX1IfGE4uxxctHSMDctI/Ri33As91MD0kWjbaHF5RkOh0os9g0u8pW
         UEcc3uKDpC9iUTfuegjchX2kYqLbPHijYaIyf1z0X2Cl/HEkZ7P/MBQyW1cX7SAAlBYs
         YJ7Q==
X-Gm-Message-State: AJcUukfORyBtkklAx0UUJaQz8JW7X1t0/OtOrLqMz00bVnFc8LZbI7gl
        NU0Nf7hk1i5KRLZa+nD00I2baw==
X-Google-Smtp-Source: ALg8bN53jEafoZxrtoxTNQ0WpO/+fJDlFz/qrI/61dX1c00V4PK5Ht731Kx5pY9X2iXaFim1USRksQ==
X-Received: by 2002:a62:42d4:: with SMTP id h81mr28022167pfd.259.1548036342386;
        Sun, 20 Jan 2019 18:05:42 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id i2sm16085424pfi.66.2019.01.20.18.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 18:05:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1glOy4-0005mN-8w; Sun, 20 Jan 2019 19:05:40 -0700
Date:   Sun, 20 Jan 2019 19:05:40 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Raju Rangoju <rajur@chelsio.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iw_cxgb4: drop check - dead code
Message-ID: <20190121020540.GB18017@ziepe.ca>
References: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 02:27:13AM +0100, Nicholas Mc Guire wrote:

> Q:This also has an interesting dependency with no effect:
>   Depends on:... (INFINIBAND_USER_ACCESS [=n] || !INFINIBAND_USER_ACCESS [=n])
>   I assume htat INFINIBAND_USER_ACCESS=y should be required here ?

This has the effect to ensure that if USER_ACCESS is a module then so
is cxgb4, otherwise USER_ACCESS can be enabled or disabled

Jason
