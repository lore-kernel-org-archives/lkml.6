Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1575AECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9406208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cgVufsqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9406208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbeGNSUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 14:20:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38375 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeGNSUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 14:20:33 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so15665059itb.3;
        Sat, 14 Jul 2018 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmiB/JnwIFuNa7mgE4bjGCZdq0JfDtbMQO1Q2nsDFec=;
        b=cgVufsqw3JhEppS4oQPF6i4+S/wESW7csdmRJP8JjDWwdSJnrNvJDPuuoc+wzSLTXm
         hXyEEmsc8UrMqbcbnvpXe6BJwBj2YE7RxbQ11hKrKqn//sgLbcwRYBPmdYAYx5eLpxwP
         Wzxl474UP6au8WoDlzUh+fKlZM9WQBwLxMmCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmiB/JnwIFuNa7mgE4bjGCZdq0JfDtbMQO1Q2nsDFec=;
        b=a8tucrSobqG4wyPYe8k8INaKK9k8y5rzkL30Vjx4vBTNUEskph0OOD0Nv4f/pTpgBW
         tBoLXXGfD66ymKqmhFLTlXwEX0SYlTrTVmDCVp4pckkQTs7NF15T6w5GiDbNvaPMh1fT
         hbNtg9CfPOqARu+K45oooW5HIo4qPmksHzrhXzLVoq9pRFpd1UCbI1CwsTM1738Eox3m
         RsfRDlsLvT5bFCyP44k67FYNwDpuWal94I5qgTFqpa+WrcBnBfB0wiPfG4sAmJF/jvKb
         jPN578lmT7AXY6lY0U90Swytb0nkjHUtmnUKZ6kws85N/3xgbzQ9eKNuHY+pybqjbcml
         MOaQ==
X-Gm-Message-State: AOUpUlEpAsqMiI4qz0jiUEzdvnE5+3tdoHOnjJIjfwqgOQPhToWFHPjn
        ZJ/28SegsnBepYKnnNZIU3HmBylVMJyqPgO645s=
X-Google-Smtp-Source: AAOMgpcdc+6bYuT48+V1GyHuQp8xEAqGMRbaxopkx9e5D9jTW5Xb7jQZH4lXJ1H8ewC788v4qtmuk2GGpdBUVqASiAo=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr8166162itb.16.1531591243461;
 Sat, 14 Jul 2018 11:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
 <1530570880.3179.9.camel@HansenPartnership.com> <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
 <20180703091821.oiywpdxd6rhtxl4p@quack2.suse.cz> <20180714173516.uumlhs4wgfgrlc32@devuan>
In-Reply-To: <20180714173516.uumlhs4wgfgrlc32@devuan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Jul 2018 11:00:32 -0700
Message-ID: <CA+55aFw1vrsTjJyoq4Q3jBwv1nXaTkkmSbHO6vozWZuTc7_6Kg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 10:35 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Could we allocate -ve entries from separate slab?

No, because negative dentrires don't stay negative.

Every single positive dentry starts out as a negative dentry that is
passed in to "lookup()" to maybe be made positive.

And most of the time they <i>do</i> turn positive, because most of the
time people actually open files that exist.

But then occasionally you don't, because you're just blindly opening a
filename whether it exists or not (to _check_ whether it's there).

              Linus
