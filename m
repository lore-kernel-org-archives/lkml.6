Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188E1C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75772147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Uj+REvV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfBHHP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:15:28 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36430 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBHHP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:15:28 -0500
Received: by mail-wr1-f42.google.com with SMTP id z3so2433930wrv.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 23:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X0L4g3VUuayFs/6/ha69STEWrslF9n1Poh3M7az5XkM=;
        b=Uj+REvV9Y234NA//xQL2cORScAXgdV/YXcqF/M/ulxfHSGvKhQC/l/uvHu/uRV1z8A
         Af5NPD1Hk816Hrq2jcKil71bR4rwuUMjUn30QZQu9QpV6UbiD153jpdAfQWJSUS0Eo+y
         ErB9kfV2vT3rX/GINSKA+gt3dlum9HPcn7HQwuny3EnyK5+jhmwVoMThu8hcuCJSCnHb
         m6cnV+LsYRJ47wZIWxXcqexBLFWgRrddfcVdGHlE8Byr2e5el0xOfoZf8uwBKooQ5VXn
         ew2J8sVQwzjW+XA9+aWy59jXDT1BHWoBxbdArjCeaFA7wrG3J8RDkXkaAICkafvVc+Ac
         Mtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X0L4g3VUuayFs/6/ha69STEWrslF9n1Poh3M7az5XkM=;
        b=j/weNFtPJqlA1SSY0/lFbOsBKs3CuGOXigcFDwhlSkIoFgjoYbsyEU94w1mpZF14OI
         oAsKJNMIjW1Az1tK8eQ8NNgJRSoKncga/nHfeQk/BkL/Kg+kBciCJXWYhRFW5y68Lkew
         qJpHXfV6cxLH1Qa8h4eTurnhyRp80NS4ExRUUODVGPvIcCycDqVWFVLUUPXTTLvlz5Pr
         CFDAl/opoI5lbV+t/x08Tl+X0yfATtxYazrHTMgQlODUoHH0mYDpuCHSZRcqq9EedCwH
         RtoCbuQ2T+IOV9ZI4ALzodHxBM4XUEuuUW094tnUX9UDdo6HpV/zd+egOmc1ifHlZh0v
         p4WA==
X-Gm-Message-State: AHQUAuY9BXXCEVa0J47M07a7Ly2bz3reN/ZFmamq3xOaK3vL1fbi+gZE
        FJgmeDMODxw2BmKpye+O4FjJdA==
X-Google-Smtp-Source: AHgI3IZCjGKj4VarqeqX8xUf6q9OJ6oKxJTmlEaY7MkcO8i1nOMcA0/1U6/U237+frvaXXXgloHIPg==
X-Received: by 2002:a5d:4349:: with SMTP id u9mr15906539wrr.223.1549610126089;
        Thu, 07 Feb 2019 23:15:26 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id r12sm1740662wrt.76.2019.02.07.23.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 23:15:25 -0800 (PST)
Date:   Fri, 8 Feb 2019 08:06:12 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: Use struct_size() in
 kzalloc()
Message-ID: <20190208070612.GB2353@nanopsycho>
References: <20190208034241.GA11858@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208034241.GA11858@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 08, 2019 at 04:42:41AM CET, gustavo@embeddedor.com wrote:
>One of the more common cases of allocation size calculations is finding
>the size of a structure that has a zero-sized array at the end, along
>with memory for some number of elements for that array. For example:
>
>struct foo {
>    int stuff;
>    struct boo entry[];
>};
>
>size = sizeof(struct foo) + count * sizeof(struct boo);
>instance = kzalloc(size, GFP_KERNEL)
>
>Instead of leaving these open-coded and prone to type mistakes, we can
>now use the new struct_size() helper:
>
>instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)
>
>Notice that, in this case, variable alloc_size is not necessary, hence
>it is removed.
>
>This code was detected with the help of Coccinelle.
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
