Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B39C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85545218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546448133;
	bh=nsg3WItb8MnLGMchxTHG4VBWqCy2pvowcKWW6wdohHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J77W7HBVodm+uaMdGzIkvH1+nlMNqxha1bVLc0XSMRPMvbTcoP+lQj1yu9pq0KWek
	 FsNKQvNgyOg+nDBgJS7s9zcSu6ip+XI75kLHAeQTlBB5Hy3NdUyFjvAIg5GR7rQWH5
	 WwnFr+lP4MI63EcO/J2gWuuhLbeIjI3TxME2+Wmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfABQzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:55:32 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:41044 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfABQzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:55:32 -0500
Received: by mail-yb1-f174.google.com with SMTP id j10so9356305ybj.8;
        Wed, 02 Jan 2019 08:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q1UdSA/joYtOsFTB+m/lzbdC32xblqmOjKAMKTyp0Hw=;
        b=u3CnmYgOnClSuo91qZ0Gs2/sdp0DFdkIeWeuhWM5YCwphhDZlVNypqm2xmScQPG8uG
         z8k8P3UTBaCTGEEeANk0iYoFE5h6oBdGmL8uLgU56vcg6mUnx1u6Ph9S/E7n5IiMC7EF
         aNU98VEfl2ozZQ9xc2pq2AtbgIFmJOoW5w3vEKh74zP5PZ2Q9uhL0mLfTgTzK1SE1EQC
         1EWc9hXOynVuwwTAERrhezzaU8KfqHVxAyrBsm6EX99YNu4gRlnxrY0iZR8JYWIfUZPV
         /47kY35lsrTr+/wqhpV6QihbwxC8FvESfp3+m+HkEJ3ndYBjhusw3ShDbUUq0KfbEBYJ
         pgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1UdSA/joYtOsFTB+m/lzbdC32xblqmOjKAMKTyp0Hw=;
        b=s91COYVh+UfpzQbA7fHS4tqMJXbPBFp8nMIZX20reDr3EQ7OdhzE1VtU92G858c1yl
         3u0seZ7TcaBMNHoDuCu+gjWhfg0EdFFpZoUrTAsN7rxP88mS5DjWUmqDAl6Wy1SmemVE
         LrrrR0ZCBYxMFKEUHXqPifCFS3wQuqDu/RDKy0E+BcH5M3I0EFiSQ8wsSW3cNH+OKNbo
         7wjP7pyM32UUFJnR53vgDcroYPT8AoC1jNK4hqUDQHqBp8AMsTJ1Vh0bEARVWUYe3Pot
         GAAdmVFP6odUBPMqAP+m5/DVhiuDdJWBROldmDRdDxUnWkExT1vllsRPby3/0liWRcfW
         LZ0g==
X-Gm-Message-State: AJcUukfE3oeEyCXZu2yrTMFoc2vD9nPSfxfgwlvFmC3c0e9aGxM8Rd/1
        4RgvKx9EhZGxDX575PVmX4w=
X-Google-Smtp-Source: AFSGD/WX6xYTHah54FHMRhtB6S6IN7sw58CcAKkPGTS+EmL9Ws0t7vjoOUT1ME4KskYcyHbWyRC5zQ==
X-Received: by 2002:a25:7dc5:: with SMTP id y188mr44401322ybc.91.1546448131258;
        Wed, 02 Jan 2019 08:55:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:f03d])
        by smtp.gmail.com with ESMTPSA id w2sm39214353ywl.10.2019.01.02.08.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 08:55:29 -0800 (PST)
Date:   Wed, 2 Jan 2019 08:55:28 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Zefan Li <lizefan@huawei.com>,
        syzbot <syzbot+87b93137e0280beaeba1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING: lock held when returning to user space in grab_super
Message-ID: <20190102165528.GT2509588@devbig004.ftw2.facebook.com>
References: <000000000000638c1b057e787822@google.com>
 <a6e8d929-3765-ad70-0f7c-942b68d7b25c@I-love.SAKURA.ne.jp>
 <20190102161640.GS2509588@devbig004.ftw2.facebook.com>
 <19260f8b-d831-9a9a-5315-1f4353dadc9b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19260f8b-d831-9a9a-5315-1f4353dadc9b@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 01:49:55AM +0900, Tetsuo Handa wrote:
> kernfs_node_dentry() calls lookup_one_len_unlocked() which involves
> memory allocation, and memory allocation fault injection made
> lookup_one_len_unlocked() fail, and thus kernfs_node_dentry() failed.
> What's strange?

So, kernfs_node_dentry() is called on the root kn, which should
trigger "if (!kn->parent) return dentry" in kernfs_node_dentry(), so
it shouldn't reach lookup_on_len_unlocked().  Oh I see.  This is the
namespaced mount path, so kn can be non-root.  Will fix it.

Thanks.

-- 
tejun
