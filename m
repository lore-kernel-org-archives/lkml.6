Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A3204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhlT9ah3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbeLNSfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:35:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34448 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbeLNSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:35:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so1859078pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yaD6HkjoIaXcmpKWOJfqe3vkXg9X3KiO8uX6yNiZ76Y=;
        b=PhlT9ah3uacjgvRdF1hCvTc+NgEfkDKwYyLUrYZKMNWjgujrlJHsc7iMF/tGPSJzX1
         K4PFGhTsmVwCtxPj9q2anTAdMlFgXEvrNP0VpfJf7CTsVBVzc1LzesTHjrplLLmJg+4o
         ScnAdDCq+m8sR/08d36kUCWZBekqbjbMd/hBk2quPCe5hn2HOb+CAgDLOzAAXC7Xg2yS
         S4ZMCd1gVmYCLqv9cQuMTKItsmyVH0CK714biZFZgWzycsihMDIhmciPgWvyrSg1ZChd
         1iTTmL02/WBgHeQVQjPRxeYg5N4iEjBrAQul6eYQsYECs+2hTCbP0h8psSGJ4NWGQQ40
         zhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yaD6HkjoIaXcmpKWOJfqe3vkXg9X3KiO8uX6yNiZ76Y=;
        b=MrDX2ICgbdMGV9A6oxLVbUOZXhZ9NAB372lhOtcpJUNaAFtgtlKgVfkrJhLhhV2z0/
         X+MeVkimh7j2FJ2hs99tfX75hvv5Br7vjWWCH7s/tLSOh9Z1IPd4lIUbO5JOrPk2flyY
         Sg/Q64QqwOfqynSAaqWlX+DOemwktXrzuIDKYARqiKPve/ogXYlTpBDXYlhT1+KYwYAh
         2i8P04qCFkRfglc+YViL13FbQTz0OQI0HQ36ZJDhRDXBDCgJbDS9NLGP+iVZy2q1qIUH
         hIZfBDuS089EHOepv2KAW/f+p53dRfE5gaw3xOFxu+JhFVNb91VufbRdeUNfBk7mvjBf
         SzMg==
X-Gm-Message-State: AA+aEWYke++fM+S1nERLOTp9MiCJdb9mKhnJIdW0vbnJE14EwER+emGO
        8FISQH640jRTp9hY4WgioG0=
X-Google-Smtp-Source: AFSGD/Ugf8/HvAhu4d9DqiEw5LJJMhE1J8QsTUq0dABb67COshTCLsy00ypZCHIPWNYldcjUWNgTfw==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr3981679pfg.183.1544812537324;
        Fri, 14 Dec 2018 10:35:37 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id e23sm8150418pfh.68.2018.12.14.10.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 10:35:36 -0800 (PST)
Date:   Sat, 15 Dec 2018 00:05:29 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
Message-ID: <20181214183529.GA20810@himanshu-Vostro-3559>
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
 <20181214161604.GA17456@himanshu-Vostro-3559>
 <8ae5c67a5c4516a783579e449313d1d59fe3a47d.camel@perches.com>
 <20181214172843.GA18703@himanshu-Vostro-3559>
 <8242597611424ecd79d7863552b2281d89ccae76.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8242597611424ecd79d7863552b2281d89ccae76.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:39:10AM -0800, Joe Perches wrote:
> On Fri, 2018-12-14 at 22:58 +0530, Himanshu Jha wrote:
> > On Fri, Dec 14, 2018 at 08:27:33AM -0800, Joe Perches wrote:
> > > Is it really important to specify things like 75% / 25%
> > > authorship crediting?
> > 
> > IDK how that ratio came up into this discussion ?
> 
> How does one tell when a co-developed-by: person
> should be notated or blamed for a defective commit?
> 
> git blame shows only 1 author.

I would Cc all those who were involved in the defective
commit log.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
