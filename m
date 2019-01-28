Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AC6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55AD2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl8Nz5pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbfA1REn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:04:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36550 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbfA1REj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:04:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so9804114qkf.3;
        Mon, 28 Jan 2019 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YqFgBFVXsqvHD2BsDExYLYwgCVPZcR0DTqRCICkXj7w=;
        b=dl8Nz5pbvbf/HRr+O2Y8nfKZ8ulNq9wa79uGnBMsrdK2IEkw8eMhmspnXSlAMCJtET
         l3ueDFW0ZYNKlVmbCQYu2w0gTZmfZYtf1yODfzd+bwc2v9rsDZPLvhfKRJ1beEARWft1
         WZBRK83UB2yLkZDUKKKnUBxCiub21hGeqzotYgvpRchFG/0KpaL5Jn22R4KapVy04kCA
         5OzsszwBo1tjyzYTYHmtvTdafJ68U8zPYaEU4ombmtO5ZJ2F2Ic+UbCKg8nyAgLM3z1O
         msWR5AWT6yWTyNpFRLcayLFYKi49iS6m9j7SeJmlnX0kKmJNLWS384+yV25lXqmYC2J7
         19fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YqFgBFVXsqvHD2BsDExYLYwgCVPZcR0DTqRCICkXj7w=;
        b=ZtDoX1kWLVULVLJkhkQaWAEVMRVE2aZr3Sb2RyWft7FDEowYqRxtYTN7sqtEkI+JDg
         +MYRuxgsk1yoPGgmZiruzzcJ1kdf+ZRLVyBVGkwdb0oy+91yoHFrFnPlo4x72dEdc2tD
         YpYidC7PsXPU7ZJ2+vWBWiILIHxKzHoe9d8/vOJc9dpZSvvXcY+zY2KscnwWPYKKXGl/
         NkJSLiApcLClmpSTeZ+Atw/yWNQXz0Jm5KJU/r/+qbGVTp+ks/rvugt73gkVRvuKLWyS
         fPIoWRAONefL6MCXm0C4RDn09p7M4//7xxn+N2E/GLylCF9vCt/dvYDZc8rpj71evscr
         JjMw==
X-Gm-Message-State: AJcUukfI97NEsiVTs7DHWoL2RslprD7vwBwZgUci3NxAiLYb2zS+BZbv
        NxCTvjeEGn/u8SIecnraIpA=
X-Google-Smtp-Source: ALg8bN7G6CVKRq6hQnYxw3MWljiE1fObulkPydNj8tvxdU0TVlQV33iPN7CeE3G2jq499XI2GND14Q==
X-Received: by 2002:a37:b201:: with SMTP id b1mr19602375qkf.306.1548695078186;
        Mon, 28 Jan 2019 09:04:38 -0800 (PST)
Received: from localhost.localdomain ([168.194.160.129])
        by smtp.gmail.com with ESMTPSA id q184sm59119244qkb.23.2019.01.28.09.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 09:04:37 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id CFE9B180CE3; Mon, 28 Jan 2019 15:04:34 -0200 (-02)
Date:   Mon, 28 Jan 2019 15:04:34 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 034/258] sctp: Fix SKB list traversal in
 sctp_intl_store_reasm().
Message-ID: <20190128170434.GA10665@localhost.localdomain>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-34-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128155924.51521-34-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:55:40AM -0500, Sasha Levin wrote:
> From: "David S. Miller" <davem@davemloft.net>
> 
> [ Upstream commit 348bbc25c40844c5efa083a3842c7f53d70a815e ]
> 
> To be fully correct, an iterator has an undefined value when something
> like skb_queue_walk() naturally terminates.
> 
> This will actually matter when SKB queues are converted over to
> list_head.
> 
> Formalize what this code ends up doing with the current
> implementation.

I don't think this patch is really needed for -stable without the SKB
queue convertion, but okay.

  Marcelo
