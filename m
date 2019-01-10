Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C15C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E993A2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hvlOvVws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfAJOj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:39:59 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44040 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfAJOj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:39:58 -0500
Received: by mail-wr1-f47.google.com with SMTP id z5so11611838wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kzg27uxb+xEHYgPgeNc8NpEl4+SWzCqglL6SmtY7nZ4=;
        b=hvlOvVwshs3RDYCpJxCnP0L3mm6artLnXh0nKZ5t0JqDYjk5er3m1Z3Lw9vtJnGl+G
         R62BeKdqujn5YI0CaCEkoF/U+XrHZiLuDULxOXNygRSUDYCzBbu2l3DT5ODAuk0G1YQ8
         wwvLgaXyeao0F/oBL6lWuLfL/tGww8iwFQ+QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kzg27uxb+xEHYgPgeNc8NpEl4+SWzCqglL6SmtY7nZ4=;
        b=lfK3iSrVejFzNiO6TxufW5htqmXPiW7c8io5AOm7ijeXrgQvL5RSxOHPwMi5vNTvYR
         yLPCPZSMx/5eITCSNaMI2BmhiEtI/ATuH8Po61xA30CcPEYvfU3MJq04usBVESMEKkLZ
         GgoNO72rxZDgcocno2rvT5xYSQ2LRZclgrhfPCDF6VI8LpUQLm1LnJyWXyiSaSnKBg9c
         QLWpu/AEleikwzxIEw1cf4b8xChMpPdC2/Jh5ty4bHB86Nfjp/Oz1eI6ia8qKh5YY/vX
         J8p6qizwwy8GHGIZQqr7+KiqKjJ/XfQFTOnxIxEeewAH03O1rklWvro1wx3lXHtRIR6l
         BKGg==
X-Gm-Message-State: AJcUukeNxAANz1xvDcxD14Z4E8zHVuHdXl6XBfcuo13/rWN/XvqglHdX
        fNNWBaIJlZVmWYsVbgzk9xndUQ==
X-Google-Smtp-Source: ALg8bN5BfBC86yL3lLBBffO7PiikTYe8NDCcWwDqSbD66BU4gWZyubfPLVVqQgUAlu6IukQPNS6SUw==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr9955469wrq.133.1547131196945;
        Thu, 10 Jan 2019 06:39:56 -0800 (PST)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id h1sm12318406wmb.0.2019.01.10.06.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:39:55 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:39:53 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     syzbot <syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in fuse_dev_do_write
Message-ID: <20190110143953.GB23837@veci.piliscsaba.redhat.com>
References: <000000000000f7af8605773cc09f@google.com>
 <000000000000a4360105773d6c8b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a4360105773d6c8b@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git 9c6432f41365
