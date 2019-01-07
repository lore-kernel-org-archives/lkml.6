Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DE62070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfAGWuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:50:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45161 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfAGWue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:50:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so775351pgc.12;
        Mon, 07 Jan 2019 14:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNK7NOu/PN58Z8t4JHV0DK5QWwyBc1oRWHAU1Z/mFk0=;
        b=O30jkTQea1bX7XXQrGoBd/WREC2npB9VOpRaiJwGMfqxpIebGW4keM88FiuJanJ21M
         xuZGm7TVKURsXWRfDyhi8QuxHZHIRq5/qBeBqZ/X8zgqJNs8qA+1vQ79/5kB44ouVWp2
         LRm2AIkMElBKUhr9z0HbFEcFsGaFSGsEwpG++g6Fvjkjbmgp0uuX6WhP5JM26xpskSJu
         JhaoBpov8oQUT3cvxZxepVuANByLXyoMMvbbk2p7Tmu8azpo8YOeXCBCV2jWG08cNIKg
         xob0dRyQGYrkxOLoGS4DAHCtnheo5dT5Jtn0ZPYrmdni/SX2M6hLYqkCFqqfxOnaP711
         IqdA==
X-Gm-Message-State: AA+aEWaHEnUkpfMqCXZhzr3TKFYstqKr6nUVF3qj9cUyfdUzUjGGsOS2
        XNs1LxE/8k/FuG0ylWty370=
X-Google-Smtp-Source: AFSGD/WTHcPNqbkSCBo3aYb2syWdXYJmW+v8I/V1iwdSBRaBYRw7bZC2P/e28rHb8J3cn9EBqwfK2w==
X-Received: by 2002:a62:f907:: with SMTP id o7mr63604086pfh.244.1546901433220;
        Mon, 07 Jan 2019 14:50:33 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e65sm120085589pfc.74.2019.01.07.14.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 14:50:32 -0800 (PST)
Message-ID: <1546901430.83374.28.camel@acm.org>
Subject: Re: [PATCH v3] coding-style: Clarify the expectations around bool
From:   Bart Van Assche <bvanassche@acm.org>
To:     Joe Perches <joe@perches.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>
Cc:     Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Date:   Mon, 07 Jan 2019 14:50:30 -0800
In-Reply-To: <8ec3603317f477fe9923b87499a33da7a2cf81ff.camel@perches.com>
References: <20190107211117.GA24142@ziepe.ca>
         <8ec3603317f477fe9923b87499a33da7a2cf81ff.camel@perches.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 14:10 -0800, Joe Perches wrote:
+AD4 On Mon, 2019-01-07 at 14:11 -0700, Jason Gunthorpe wrote:
+AD4 +AD4 There has been some confusion since checkpatch started warning about bool
+AD4 +AD4 use in structures, and people have been avoiding using it.
+AD4 +AD4 
+AD4 +AD4 Many people feel there is still a legitimate place for bool in structures,
+AD4 +AD4 so provide some guidance on bool usage derived from the entire thread that
+AD4 +AD4 spawned the checkpatch warning.
+AD4 
+AD4 Thanks Jason.
+AD4 
+AD4 It'd be nice to combine this with some better
+AD4 checkpatch warning or even a removal of that
+AD4 misleading warning from checkpatch altogether.
+AD4 
+AD4 With a couple minor nits below and and Ack if
+AD4 you want one:
+AD4 
+AD4 Acked-by: Joe Perches +ADw-joe+AEA-perches.com+AD4
+AD4 
+AD4 +AD4 diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
+AD4 
+AD4 +AFsAXQ
+AD4 +AD4 +AEAAQA -921,7 +-921,37 +AEAAQA result.  Typical examples would be functions that return pointers+ADs they use
+AD4 +AD4  NULL or the ERR+AF8-PTR mechanism to report failure.
+AD4 +AD4  
+AD4 +AD4  
+AD4 +AD4 -17) Don't re-invent the kernel macros
+AD4 +AD4 +-17) Using bool
+AD4 +AD4 +---------------
+AD4 +AD4 +-
+AD4 +AD4 +-The Linux kernel uses the C99 standard for the bool type. bool values can only
+AD4 
+AD4 Maybe
+AD4 
+AD4 The Linux kernel bool type is the C99 +AF8-Bool type.

Or maybe +ACI-The Linux kernel bool type is an alias for the C99 +AF8-Bool type.+ACI

+AD4 +AD4 +-evaluate to 0 or 1, and implicit or explicit conversion to bool automatically
+AD4 +AD4 +-converts the value to true or false. When using bool types the +ACEAIQ construction
+AD4 +AD4 +-is not needed, which eliminates a class of bugs.
+AD4 +AD4 +-
+AD4 +AD4 +-When working with bool values the true and false labels should be used instead
+AD4 
+AD4 true and false are not labels but +ACM-defines

With these refinements, feel free to add:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

