Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1855C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC73B2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfAXSUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:20:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38220 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:20:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gmjc8-0001Pv-Fn; Thu, 24 Jan 2019 18:20:32 +0000
Date:   Thu, 24 Jan 2019 18:20:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     vrd@amazon.com
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Pernas Maradei <npernas@amazon.de>,
        Varad Gautam <vrd@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Maximilian Heyne <mheyne@amazon.de>,
        Stefan Nuernberger <snu@amazon.de>, Amit Shah <aams@amazon.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "# 4 . 9+" <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/devpts: always delete dcache dentry-s in dput()
Message-ID: <20190124182032.GE2217@ZenIV.linux.org.uk>
References: <1548334986-28667-1-git-send-email-vrd@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548334986-28667-1-git-send-email-vrd@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 02:03:06PM +0100, vrd@amazon.com wrote:

> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index c538145..553a3f3 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -455,6 +455,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
>  	s->s_blocksize_bits = 10;
>  	s->s_magic = DEVPTS_SUPER_MAGIC;
>  	s->s_op = &devpts_sops;
> +	s->s_d_op = &simple_dentry_operations;
>  	s->s_time_gran = 1;
>  
>  	error = -ENOMEM;

Applied.
