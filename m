Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CD0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B137620821
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiVo4pqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404217AbfBOIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:23:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35150 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403860AbfBOIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:23:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id v7so6564477lfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 00:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T1tBKGN1H5lG/C+HY/K2C7ZASAqwT6X2GQqc3PODpfk=;
        b=UiVo4pqyyU9MWRu+9njOoJfq7+Wd14w2irbjvr++Dpn+fX3eqqspk9t1YadbIeSUPF
         M6m3qBHh7FJljn4m459uS/DDYJUXuJ3fcgtnZQmAfwefvk4b5WjK09KlHCX8ucgr/w6q
         sxifB/1mH5I+7O4NJbCZnNZAcThJRSNSs43KUG1jx/83ypalbe8UK8TFInZqWWlZCGCe
         uwvkTt3gDgdfqre/rfUOAk29+UxIcu+JRnxfpHzylgYQxK00xY9HHkEOVXBr7wW2/Sx9
         LRKLuEmRxS7oLuMbgExWYYXFdQMxQsvrUTcLufihb9bHt339pemBNcHG7bEVuLnaS3mM
         xWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T1tBKGN1H5lG/C+HY/K2C7ZASAqwT6X2GQqc3PODpfk=;
        b=NjkB3u9LbLinN/Xe/oL2OObeZCU8pCV4HorGK1ypz8uKlGtXFlLZe77N7OvvY66muW
         1wmaGsRr3dMx6eRret+KFzioUzICwY+vYDUj2k01QDaIKe+GcMdvHuR1XjgnmCZZdtCH
         egNlfwOYus7KaWnb/9yPKSsm3y9L7ltGGzos1EsueKhfxEs3F5TbehW7cCECwIwBsM53
         USU7SVq4fBEXP1kSrz4+9VJEMLP5RSdKl0dyaKnJPNS4R4PapZaxKZRmf1ha6d9KSG6d
         PnLiPzoi8ixfTn80wArB7XA2WmjXNEg5wWIx7d1iAYJoi6nVFDZKXwsFKazHc4xhkT5W
         Gc8w==
X-Gm-Message-State: AHQUAuZgedYV5q2QsZ7pqbiXyq2OfHpbEE4aFk4gPJtPaqRESnuTfBLk
        KsUXWeNs0lVDJI7xLp/cVk6a+4Nffik=
X-Google-Smtp-Source: AHgI3Ia6kESOeQY0pHDQ7H5z+okbcIjWyyxb3ocbLe0mG3JPV16fqDiOVnzXcNGiAwy/ukweQgJOuw==
X-Received: by 2002:ac2:5230:: with SMTP id i16mr4755388lfl.63.1550218986296;
        Fri, 15 Feb 2019 00:23:06 -0800 (PST)
Received: from jax.urgonet (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
        by smtp.gmail.com with ESMTPSA id u11sm1120708lfb.85.2019.02.15.00.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 00:23:05 -0800 (PST)
Date:   Fri, 15 Feb 2019 09:23:03 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jerome Forissier <jerome.forissier@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: optee: update optee_msg.h and optee_smc.h to dual
 license
Message-ID: <20190215082302.GA29317@jax.urgonet>
References: <1549640526-10935-1-git-send-email-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549640526-10935-1-git-send-email-jerome.forissier@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Fri, Feb 08, 2019 at 04:42:06PM +0100, Jerome Forissier wrote:
> The files optee_msg.h and optee_smc.h (under drivers/tee/optee) contain
> information originating from the OP-TEE OS project [1] [2], where the
> licensing terms are BSD 2-Clause. Therefore, apply a dual license to
> those files.
> 
> [1] https://github.com/OP-TEE/optee_os/blob/master/core/include/optee_msg.h
> [2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/include/sm/optee_smc.h
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

I'll pick this up.

I'm prefixing the two link lines with "Link:" to avoid the checkpatch
warning.

Thanks,
Jens
