Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62288C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3031520880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtzSOKv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBUI4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:56:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33342 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUI4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:56:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so414039pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfKdvQKNjhi7GLOZO2B6g+shK7xwZm6nI7j0UxgbSvM=;
        b=UtzSOKv/Xh1sDFxxAUXHybgPjqXRzpCOAITL9VzkE581nWD6aM9fjNiyr1SAsHTuRd
         +JXVtMVOSGbagP5TvHwGp/KyKZr/SiMJKpMQkAYT2x4eTtfyRU+urXUn0UbUAEKO+j1r
         MGEdc1mxhzA/q86wVU5/BMdRHefQAK7meLBrqJxv3unkeekGYgkTo8fIPJkpHI+YyezD
         XZDd3i3S1W4CurtkHOxonlMjN3kDnF6ZeboH8KRPc94Zg9tpscAMzN+yIuK/GaMLKoK1
         FyONS6ubj+UxhFssXAxponQXH2cutYksp3PtYtRzFsx1ZsEV/aFJ5ifC229jU41aD5uz
         00CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfKdvQKNjhi7GLOZO2B6g+shK7xwZm6nI7j0UxgbSvM=;
        b=Lajyv75IZZW9uQf3ra5Sg+C2Kdvc696caLimysJM17pwNDlR5vTonHExnm4ETszhef
         PgCNNE16AKM5lLl4SZHkaueRzzw3slvVYsREQB91nKIXfRU7iYH7aQNx9YvlLll56CoR
         k0XxCZTOwQQcfvap7NzPYfWR6HRy6nCyN1E9IhBWOHCE9RfKvIfMrDV4EjDBpB6FFJh4
         5/eqi7JfjVo4aH8F1mPJQfquCvYUM9KSQD6YAB97RdIx+CQ+/qcZXn+Ya4qbh027Lxb+
         e3Wf+d7RztBZdBnq/BdAbDK2HkpdVQHKMAhDqYqCuE6eVfvYDYJOSqYO8Nlnn2IInv+n
         VbFQ==
X-Gm-Message-State: AHQUAub/+e8uGx15cDongTj/S5fsVs+Ratextbiby3FQpwXPip6nZUto
        FB8LwcPLRAGoG47pRpR45Ak=
X-Google-Smtp-Source: AHgI3IbL6FYTY9it2Tkuw/g665IHFia0w3wT+NuMNIwzlbsbqePmwVRN1pFGs7hBrEwccnrPokCPBg==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr39513394pfn.196.1550739413958;
        Thu, 21 Feb 2019 00:56:53 -0800 (PST)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id o2sm30314231pgq.29.2019.02.21.00.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 00:56:53 -0800 (PST)
Date:   Thu, 21 Feb 2019 16:56:42 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, rientjes@google.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm/cma_debug: Check for null tmp in
 cma_debugfs_add_one()
Message-ID: <20190221165642.00005d86.zbestahu@gmail.com>
In-Reply-To: <20190221082309.GG4525@dhcp22.suse.cz>
References: <20190221040130.8940-1-zbestahu@gmail.com>
        <20190221040130.8940-2-zbestahu@gmail.com>
        <20190221082309.GG4525@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 09:23:09 +0100
Michal Hocko <mhocko@kernel.org> wrote:

> On Thu 21-02-19 12:01:30, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > If debugfs_create_dir() failed, the following debugfs_create_file()
> > will be meanless since it depends on non-NULL tmp dentry and it will
> > only waste CPU resource.  
> 
> The file will be created in the debugfs root. But, more importantly.
> Greg (CCed now) is working on removing the failure paths because he
> believes they do not really matter for debugfs and they make code more
> ugly. More importantly a check for NULL is not correct because you
> get ERR_PTR after recent changes IIRC.

Same check logic in cma_debugfs_init(), i'm just finding they do not stay
the same.

> 
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  mm/cma_debug.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> > index 2c2c869..3e9d984 100644
> > --- a/mm/cma_debug.c
> > +++ b/mm/cma_debug.c
> > @@ -169,6 +169,8 @@ static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
> >  	scnprintf(name, sizeof(name), "cma-%s", cma->name);
> >  
> >  	tmp = debugfs_create_dir(name, root_dentry);
> > +	if (!tmp)
> > +		return;
> >  
> >  	debugfs_create_file("alloc", 0200, tmp, cma, &cma_alloc_fops);
> >  	debugfs_create_file("free", 0200, tmp, cma, &cma_free_fops);
> > -- 
> > 1.9.1
> >   
> 

